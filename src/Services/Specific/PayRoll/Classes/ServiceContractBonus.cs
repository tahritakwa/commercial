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
    public class ServiceContractBonus : Service<ContractBonusViewModel, ContractBonus>, IServiceContractBonus
    {
        private readonly IServicePeriod _servicePeriod;
        private readonly IServiceBonusValidityPeriod _serviceBonusValidityPeriod;
        public ServiceContractBonus(IServicePeriod servicePeriod,
            IServiceBonusValidityPeriod serviceBonusValidityPeriod,
            IRepository<ContractBonus> entityRepo,
          IUnitOfWork unitOfWork,
          IContractBonusBuilder builder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _servicePeriod = servicePeriod;
            _serviceBonusValidityPeriod = serviceBonusValidityPeriod;

        }

        /// <summary>
        ///  Retrieves the value of the bonus for which specific month
        /// </summary>
        /// <param name="idContract"></param>
        /// <param name="idBonus"></param>
        /// <param name="month"></param>
        /// <param name="dependOnTimeSheet"></param>
        /// <returns></returns>
        public double GetBonusValue(PayslipViewModel payslipViewModel, BonusViewModel bonusViewModel, bool dependOnTimeSheet, double daysOfWork, double monthNumberOfDays, out double dayOfWorkReallyWorked)
        {
            try
            {
                double amount = default;
                double numberOfDays = default;
                DateTime firstDateOfMonth = payslipViewModel.Month.FirstDateOfMonth();
                DateTime lastDateOfMonth = payslipViewModel.Month.LastDateOfMonth();
                IList<ContractBonusViewModel> contractBonusViewModels = GetAllModelsQueryable(period => period.IdContract == payslipViewModel.IdContract && period.IdBonus == bonusViewModel.Id &&
                   ((period.ValidityEndDate.HasValue &&
                   (period.ValidityStartDate.BetweenDateLimitIncluded(firstDateOfMonth, lastDateOfMonth) || period.ValidityEndDate.Value.BetweenDateLimitIncluded(firstDateOfMonth, lastDateOfMonth) ||
                   firstDateOfMonth.BetweenDateLimitIncluded(period.ValidityStartDate, period.ValidityEndDate.Value) || lastDateOfMonth.BetweenDateLimitIncluded(period.ValidityStartDate, period.ValidityEndDate.Value))) ||
                   (!period.ValidityEndDate.HasValue && period.ValidityStartDate.BeforeDateLimitIncluded(lastDateOfMonth)))).OrderByDescending(x => x.ValidityStartDate).ToList()
                   .Select(x => { x.CoversWholeMonth = payslipViewModel.Month.CheckDateCoverWholeMonth(x.ValidityStartDate, x.ValidityEndDate); return x; }).ToList();
                ContractBonusViewModel currentIterationSalary = default;
                ContractBonusViewModel previousIterationSalary = default;
                DateTime startDate = default;
                DateTime endDate = default;
                double daysInPeriod = default;
                contractBonusViewModels.Select((value, index) => new { value, index }).ToList().ForEach(iteration =>
                {
                    currentIterationSalary = iteration.value;
                    if (iteration.index == NumberConstant.Zero)
                    {
                        // first iteration.
                        startDate = currentIterationSalary.ValidityStartDate.BeforeDate(firstDateOfMonth) ? firstDateOfMonth : currentIterationSalary.ValidityStartDate;
                        endDate = currentIterationSalary.ValidityEndDate.HasValue ?
                            currentIterationSalary.ValidityEndDate.Value.AfterDate(lastDateOfMonth) ? lastDateOfMonth : currentIterationSalary.ValidityEndDate.Value :
                            lastDateOfMonth;
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(startDate, endDate, dependOnTimeSheet);
                        if (currentIterationSalary.CoversWholeMonth && daysOfWork != monthNumberOfDays)
                        {
                            daysInPeriod = daysInPeriod - monthNumberOfDays + daysOfWork;
                        }
                    }
                    else if (iteration.index == contractBonusViewModels.Count - NumberConstant.One)
                    {
                        // last iteration.
                        startDate = currentIterationSalary.ValidityStartDate.AfterDate(firstDateOfMonth) ? currentIterationSalary.ValidityStartDate : firstDateOfMonth;
                        endDate = currentIterationSalary.ValidityEndDate.HasValue ?
                            currentIterationSalary.ValidityEndDate.Value.BeforeDate(previousIterationSalary.ValidityStartDate.PreviousDate()) ?
                                currentIterationSalary.ValidityEndDate.Value : previousIterationSalary.ValidityStartDate.PreviousDate() :
                            previousIterationSalary.ValidityStartDate.PreviousDate();
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(startDate, endDate, dependOnTimeSheet);
                    }
                    else
                    {
                        startDate = currentIterationSalary.ValidityStartDate;
                        // intermediate iteration.
                        endDate = currentIterationSalary.ValidityEndDate.HasValue ?
                            currentIterationSalary.ValidityEndDate.Value.BeforeDate(previousIterationSalary.ValidityStartDate.PreviousDate()) ?
                                currentIterationSalary.ValidityEndDate.Value : previousIterationSalary.ValidityStartDate.PreviousDate() :
                            previousIterationSalary.ValidityStartDate.PreviousDate();
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(startDate, endDate, dependOnTimeSheet);
                    }
                    numberOfDays += daysInPeriod;
                    double bonusValue = GetContractBonusValue(currentIterationSalary, endDate);
                    amount += bonusViewModel.DependNumberDaysWorked ? daysInPeriod * bonusValue / daysOfWork : bonusValue;
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
                    [PayRollConstant.PayslipErrorMessage] = PayRollConstant.MissBonusValueErrorMessage +
                    GetModelWithRelations(x => x.IdBonus == bonusViewModel.Id, x => x.IdBonusNavigation).IdBonusNavigation.Name
                };
                throw new CustomException(CustomStatusCode.BONUS_LACK, Params);
            }
        }

        /// <summary>
        /// If the value of the contractBonus is redefined, use this value if not the default value
        /// </summary>
        /// <param name="contractBonusViewModel"></param>
        /// <param name="date"></param>
        /// <returns></returns>
        private double GetContractBonusValue(ContractBonusViewModel contractBonusViewModel, DateTime date)
        {
            return contractBonusViewModel.Value.HasValue ? (double)contractBonusViewModel.Value :
                _serviceBonusValidityPeriod.GetAllModelsQueryable(period => period.IdBonus == contractBonusViewModel.IdBonus &&
                    period.StartDate.BeforeDateLimitIncluded(date)).OrderByDescending(x => x.StartDate).FirstOrDefault().Value;
        }

        public IList<ContractBonus> UpdateContractsBonusState(IList<ContractBonus> contractBonuses)
        {
            contractBonuses.ToList().ForEach(contractBonus =>
            {
                if (contractBonus.ValidityStartDate.Date.AfterDate(DateTime.Today.Date))
                {
                    contractBonus.State = (int)ContractBonusStateEnumerator.UpComing;
                }
                else if (contractBonus.ValidityEndDate.HasValue && contractBonus.ValidityEndDate.Value.BeforeDate(DateTime.Today.Date))
                {
                    contractBonus.State = (int)ContractBonusStateEnumerator.Expired;
                }
                else
                {
                    contractBonus.State = (int)ContractBonusStateEnumerator.InProgress;
                }
            });
            return contractBonuses;
        }
    }
}
