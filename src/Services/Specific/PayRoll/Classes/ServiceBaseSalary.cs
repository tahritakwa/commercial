using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceBaseSalary : Service<BaseSalaryViewModel, BaseSalary>, IServiceBaseSalary
    {
        private readonly IServicePeriod _servicePeriod;
        public ServiceBaseSalary(IServicePeriod servicePeriod,
            IRepository<BaseSalary> entityRepo,
           IUnitOfWork unitOfWork,
           IBaseSalaryBuilder builder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _servicePeriod = servicePeriod;
        }


        /// <summary>
        /// Get basesalary of the employee with the contract id in the month
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public double GetBaseSalary(PayslipViewModel payslipViewModel, bool dependOnTimeSheet, double daysOfWork, double monthNumberOfDays, out double dayOfWorkReallyWorked, bool forPreview = false)
        {
            try
            {
                DateTime firstDateOfMonth = payslipViewModel.Month.FirstDateOfMonth();
                DateTime lastDateOfMonth = payslipViewModel.Month.LastDateOfMonth();
                // If the payslip does not have the associated contract in navigation, add the IdContratNavigation as navigation when recovering base salaries
                List<Expression<Func<BaseSalary, object>>> relationExpression = payslipViewModel.IdContractNavigation is null ?
                    new List<Expression<Func<BaseSalary, object>>> { (c) => c.IdContractNavigation } : new List<Expression<Func<BaseSalary, object>>>();
                // Current month base salary
                IList<BaseSalaryViewModel> baseSalaryViewModels = GetAllModelsQueryable(period => period.IdContract == payslipViewModel.IdContract
                   && period.StartDate.BetweenDateLimitIncluded(firstDateOfMonth, lastDateOfMonth), relationExpression.ToArray()).ToList();
                // If there is no salary defined at the start of the month for which the payslip is generated, 
                // retrieve the last salary before the start of the month for which the payslip is generated.
                if (!baseSalaryViewModels.Any(m => m.StartDate.EqualsDate(firstDateOfMonth)))
                {
                    BaseSalaryViewModel lastSalary = GetAllModelsQueryable(period => period.IdContract == payslipViewModel.IdContract
                       && period.StartDate.BeforeDate(firstDateOfMonth), relationExpression.ToArray()).OrderByDescending(x => x.StartDate).FirstOrDefault();
                    if (lastSalary != null)
                    {
                        baseSalaryViewModels.Add(lastSalary);
                    }
                }
                if (!baseSalaryViewModels.Any())
                {
                    Dictionary<string, dynamic> Params = new Dictionary<string, dynamic>
                    {
                        [PayRollConstant.PayslipErrorMessage] = PayRollConstant.MissBaseSalaryErrorMessage
                    };
                    throw new CustomException(CustomStatusCode.BASE_SALARY_LACK, Params);
                }
                baseSalaryViewModels = baseSalaryViewModels.OrderByDescending(x => x.StartDate).ToList();
                if (payslipViewModel.IdContractNavigation is null)
                {
                    payslipViewModel.IdContractNavigation = baseSalaryViewModels.First().IdContractNavigation;
                }
                payslipViewModel.CoversWholeMonth = payslipViewModel.Month.CheckDateCoverWholeMonth(payslipViewModel.IdContractNavigation.StartDate, payslipViewModel.IdContractNavigation.EndDate);
                double amount = default;
                double numberOfDays = default;
                BaseSalaryViewModel currentIterationSalary = default;
                BaseSalaryViewModel previousIterationSalary = default;
                double daysInPeriod = default;
                baseSalaryViewModels.Select((value, index) => new { value, index }).ToList().ForEach(iteration =>
                {
                    currentIterationSalary = iteration.value;
                    if (iteration.index == NumberConstant.Zero)
                    {
                        DateTime startDate = (forPreview && baseSalaryViewModels.Count == NumberConstant.One) ? firstDateOfMonth : currentIterationSalary.StartDate.BeforeDate(firstDateOfMonth) ? firstDateOfMonth : currentIterationSalary.StartDate;
                        DateTime endDate = forPreview ? lastDateOfMonth : payslipViewModel.IdContractNavigation.EndDate.HasValue ?
                            payslipViewModel.IdContractNavigation.EndDate.Value.AfterDate(lastDateOfMonth) ? lastDateOfMonth : payslipViewModel.IdContractNavigation.EndDate.Value :
                                lastDateOfMonth;
                        // first iteration. Returns the number of days between the start date of the last salary defined for the current month and the last day of the month
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(startDate, endDate, dependOnTimeSheet);
                        if (forPreview)
                        {
                            daysInPeriod = (baseSalaryViewModels.Count == NumberConstant.One) ? daysOfWork : daysInPeriod - monthNumberOfDays + daysOfWork;
                        }
                        else if (payslipViewModel.CoversWholeMonth && daysOfWork != monthNumberOfDays)
                        {
                            daysInPeriod = daysInPeriod - monthNumberOfDays + daysOfWork;
                        }
                    }
                    else if (iteration.index == baseSalaryViewModels.Count - NumberConstant.One)
                    {
                        // last iteration.
                        DateTime startDate = forPreview ? firstDateOfMonth : currentIterationSalary.StartDate.AfterDate(firstDateOfMonth) ? currentIterationSalary.StartDate : firstDateOfMonth;
                        // last iteration. Returns the number of days between the start date of the month and the start date of validity of the last salary
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(startDate, previousIterationSalary.StartDate.PreviousDate(), dependOnTimeSheet);
                    }
                    else
                    {
                        // intermediate iteration. Returns the number of days between the start date of validity of the current salary and the start date of validity of the previous salary
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(currentIterationSalary.StartDate, previousIterationSalary.StartDate.PreviousDate(), dependOnTimeSheet);
                    }
                    numberOfDays += daysInPeriod;
                    amount += daysInPeriod * currentIterationSalary.Value / daysOfWork;
                    previousIterationSalary = currentIterationSalary;
                });
                dayOfWorkReallyWorked = numberOfDays;
                return amount;
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception)
            {
                Dictionary<string, dynamic> Params = new Dictionary<string, dynamic>
                {
                    [PayRollConstant.PayslipErrorMessage] = PayRollConstant.MissBaseSalaryErrorMessage
                };
                throw new CustomException(CustomStatusCode.BASE_SALARY_LACK, Params);
            }
        }

        /// <summary>
        /// Update base salary
        /// </summary>
        /// <param name="baseSalarys"></param>
        /// <returns></returns>
        public IList<BaseSalary> UpdateBaseSalaryState(IList<BaseSalary> baseSalarys)
        {
            DateTime sysDate = DateTime.Today;
            // Allows to order by start date 
            baseSalarys = baseSalarys.ToList().OrderBy(x => x.StartDate).ToList();
            // Allows to update the state of base salary
            baseSalarys.ToList().ForEach(baseSalary =>
            {
                BaseSalary nextBaseSalary = baseSalarys.FirstOrDefault(x => x.Id != baseSalary.Id && x.StartDate.AfterDate(baseSalary.StartDate));
                if (nextBaseSalary != null)
                {
                    if (baseSalary.StartDate.BeforeDateLimitIncluded(sysDate))
                    {
                        baseSalary.State = nextBaseSalary.StartDate.BeforeDateLimitIncluded(sysDate) ?
                        (int)BaseSalaryStateEnumerator.Expired : (int)BaseSalaryStateEnumerator.InProgress;
                    }
                    else
                    {
                        baseSalary.State = (int)BaseSalaryStateEnumerator.UpComing;
                    }
                }
                else
                {
                    baseSalary.State = baseSalary.StartDate.BeforeDateLimitIncluded(sysDate) ?
                    (int)BaseSalaryStateEnumerator.InProgress : (int)BaseSalaryStateEnumerator.UpComing;
                }
            });
            return baseSalarys;
        }
    }
}
