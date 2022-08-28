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
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceContractBenefitInKind : Service<ContractBenefitInKindViewModel, ContractBenefitInKind>, IServiceContractBenefitInKind
    {
        private readonly IServicePeriod _servicePeriod;
        public ServiceContractBenefitInKind(IServicePeriod servicePeriod, IRepository<ContractBenefitInKind> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IContractBenefitInKindBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _servicePeriod = servicePeriod;
        }

        public double GetBenefitInKindValue(PayslipViewModel payslipViewModel, BenefitInKindViewModel benefitInKindViewModel, bool dependOnTimeSheet, double daysOfWork, double monthNumberOfDays, out double dayOfWorkReallyWorked)
        {
            try
            {
                double amount = default;
                DateTime firstDateOfMonth = payslipViewModel.Month.FirstDateOfMonth();
                DateTime lastDateOfMonth = payslipViewModel.Month.LastDateOfMonth();
                double numberOfDays = default;
                IList<ContractBenefitInKindViewModel> contractBenefitInKindViewModels = GetAllModelsQueryable(period => period.IdContract == payslipViewModel.IdContract && period.IdBenefitInKind == benefitInKindViewModel.Id &&
                  ((period.ValidityEndDate.HasValue &&
                  (period.ValidityStartDate.BetweenDateLimitIncluded(firstDateOfMonth, lastDateOfMonth) || period.ValidityEndDate.Value.BetweenDateLimitIncluded(firstDateOfMonth, lastDateOfMonth) ||
                  firstDateOfMonth.BetweenDateLimitIncluded(period.ValidityStartDate, period.ValidityEndDate.Value) || lastDateOfMonth.BetweenDateLimitIncluded(period.ValidityStartDate, period.ValidityEndDate.Value))) ||
                  (!period.ValidityEndDate.HasValue && period.ValidityStartDate.BeforeDateLimitIncluded(lastDateOfMonth)))).OrderByDescending(x => x.ValidityStartDate).ToList();
                if (benefitInKindViewModel.DependNumberDaysWorked)
                {
                    DateTime startDate = default;
                    DateTime endDate = default;
                    double daysInPeriod = default;
                    contractBenefitInKindViewModels.Select(x => { x.CoversWholeMonth = payslipViewModel.Month.CheckDateCoverWholeMonth(x.ValidityStartDate, x.ValidityEndDate); return x; })
                        .ToList().ForEach(contractBenefitInKind =>
                    {
                        startDate = contractBenefitInKind.ValidityStartDate.AfterDate(firstDateOfMonth) ? contractBenefitInKind.ValidityStartDate : firstDateOfMonth;
                        endDate = contractBenefitInKind.ValidityEndDate.HasValue && contractBenefitInKind.ValidityEndDate.Value.BeforeDate(lastDateOfMonth) ?
                            contractBenefitInKind.ValidityEndDate.Value : lastDateOfMonth;
                        daysInPeriod = _servicePeriod.NumberOfDaysInIntervalDates(startDate, endDate, dependOnTimeSheet);
                        if (contractBenefitInKind.CoversWholeMonth && daysOfWork != monthNumberOfDays)
                        {
                            daysInPeriod = daysInPeriod - monthNumberOfDays + daysOfWork;
                        }
                        numberOfDays += daysInPeriod;
                        amount += daysInPeriod * contractBenefitInKind.Value / daysOfWork;
                    });
                }
                else
                {
                    amount = contractBenefitInKindViewModels.Sum(x => x.Value);
                }
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
                    GetModelWithRelations(x => x.IdBenefitInKind == benefitInKindViewModel.Id, x => x.IdBenefitInKindNavigation).IdBenefitInKindNavigation.Name
                };
                throw new CustomException(CustomStatusCode.BONUS_LACK, Params);
            }
        }

        /// <summary>
        /// Update benefit in kind state
        /// </summary>
        /// <param name="contractBenefitInKinds"></param>
        /// <returns></returns>
        public IList<ContractBenefitInKind> UpdateContractsBenefitInKindState(IList<ContractBenefitInKind> contractBenefitInKinds)
        {
            contractBenefitInKinds.ToList().ForEach(contractBenefitInKind =>
            {

                if (contractBenefitInKind.ValidityStartDate.Date.AfterDate(DateTime.Today.Date))
                {
                    contractBenefitInKind.State = (int)BenefitInKindStateEnumerator.UpComing;
                }
                else if (contractBenefitInKind.ValidityEndDate.HasValue && contractBenefitInKind.ValidityEndDate.Value.BeforeDate(DateTime.Today.Date))
                {
                    contractBenefitInKind.State = (int)BenefitInKindStateEnumerator.Expired;
                }
                else
                {
                    contractBenefitInKind.State = (int)BenefitInKindStateEnumerator.InProgress;
                }
            });
            return contractBenefitInKinds;
        }
    }
}
