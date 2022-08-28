using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceBonus : Service<BonusViewModel, Bonus>, IServiceBonus
    {
        private readonly IServiceContractBonus _serviceContractBonus;
        private readonly IReducedBonusBuilder _reducedBuilder;
        private readonly IBonusValidityPeriodBuilder _bonusValidityPeriodBuilder;
        private readonly IRepository<Payslip> _repoPayslip;

        public ServiceBonus(IRepository<Bonus> entityRepo, IUnitOfWork unitOfWork,
            IRepository<Payslip> repoPayslip,
            IBonusBuilder builder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IReducedBonusBuilder reducedBuilder, IBonusValidityPeriodBuilder bonusValidityPeriodBuilder,
           IEntityAxisValuesBuilder builderEntityAxisValues, IServiceContractBonus serviceContractPremium)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceContractBonus = serviceContractPremium;
            _reducedBuilder = reducedBuilder;
            _repoPayslip = repoPayslip;
            _bonusValidityPeriodBuilder = bonusValidityPeriodBuilder;
        }


        public override object AddModelWithoutTransaction(BonusViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckBonusValidity(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(BonusViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckBonusValidity(model);
            if (model.UpdatePayslip)
            {
                UpdateBonusAssociateWithPayslip(model);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Check the uniqueness of the premium frequency
        /// </summary>
        /// <param name="model"></param>
        private void CheckBonusValidity(BonusViewModel model)
        {
            // Verify the unicity of the validity date of the bonus
            if (model.BonusValidityPeriod != null && model.BonusValidityPeriod.Where(x => !x.IsDeleted).ToList().Count >= NumberConstant.Two)
            {
                model.BonusValidityPeriod.ToList().ForEach(bonusValidityPeriod =>
                {
                    bonusValidityPeriod.StartDate = bonusValidityPeriod.StartDate.FirstDateOfMonth();
                });
                IEnumerable<DateTime> duplicatedDate = model.BonusValidityPeriod.Where(x => !x.IsDeleted).GroupBy(x => x.StartDate.Date).Where(x => x.Count() > NumberConstant.One).Select(x => x.Key);
                if (duplicatedDate != null && duplicatedDate.Count() > NumberConstant.Zero)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.START_DATE, duplicatedDate.FirstOrDefault().ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture) }
                    };
                    throw new CustomException(CustomStatusCode.DuplicatedBonusValidityException, paramtrs);
                }
            }
            if (model.IsFixe)
            {
                model.BonusValidityPeriod.Select(x => { x.StartDate = x.StartDate.FirstDateOfMonth(); return x; }).ToList();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="contract"></param>
        private void UpdateBonusAssociateWithPayslip(BonusViewModel bonusViewModel)
        {
            IList<Payslip> payslips = CheckIfBonusIsAssociatedWithAnyPayslip(bonusViewModel);
            if (payslips.Any())
            {
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(Bonus)}
                    };
                    throw new CustomException(CustomStatusCode.CantUpdateEntityBecauseAnyPayslipIsUsedInClosedSesion, errorParams);
                }
                payslips = payslips.Select(x => { x.Status = (int)PayslipStatus.Wrong; return x; }).ToList();
                _repoPayslip.BulkUpdate(payslips);
                _unitOfWork.Commit();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="contract"></param>
        /// <returns></returns>
        public IList<Payslip> CheckIfBonusIsAssociatedWithAnyPayslip(BonusViewModel bonusViewModel)
        {
            BonusViewModel bonusBeforeUpdate = GetModelAsNoTracked(x => x.Id == bonusViewModel.Id, x => x.BonusValidityPeriod);
            // A date interval collection to contain the date intervals in which the generated payslips are corrupted
            List<DateInterval> dateIntervals = new List<DateInterval>();
            List<Payslip> payslips = new List<Payslip>();
            if (bonusViewModel.IsFixe)
            {
                if (!new BonusComparer().Equals(bonusViewModel, bonusBeforeUpdate))
                {
                    DateInterval dateInterval = new DateInterval(bonusBeforeUpdate.BonusValidityPeriod.OrderBy(x => x.StartDate).FirstOrDefault().StartDate);
                    dateIntervals.Add(dateInterval);
                }
                // For new base validityPeriods added, retrieve date intervals with existing payslips
                BonusValidityPeriodChek(bonusViewModel.BonusValidityPeriod.Where(x => x.Id == NumberConstant.Zero).ToList(), bonusBeforeUpdate.BonusValidityPeriod.ToList(), dateIntervals);
                // For existing validityPeriods modified or deleted, retrieve date intervals with existing payslips
                BonusValidityPeriodChek(bonusViewModel.BonusValidityPeriod.Except(bonusBeforeUpdate.BonusValidityPeriod, new BonusValidityPeriodComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), bonusBeforeUpdate.BonusValidityPeriod.ToList(), dateIntervals);
                payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x =>
                                x.PayslipDetails.Any(d => d.IdBonus == bonusViewModel.Id) &&
                                dateIntervals.Any(d => d.EndDate.HasValue && x.Month.BetweenDateLimitIncluded(d.StartDate, d.EndDate.Value) ||
                                     !d.EndDate.HasValue && x.Month.AfterDateLimitIncluded(d.StartDate)),
                                     x => x.IdSessionNavigation, x => x.IdEmployeeNavigation).ToList();
            }
            else
            {
                if (!new BonusComparer().Equals(bonusViewModel, bonusBeforeUpdate))
                {
                    payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x => x.PayslipDetails.Any(d => d.IdBonus == bonusViewModel.Id),
                         x => x.IdSessionNavigation, x => x.IdEmployeeNavigation).ToList();
                }
            }
            if (payslips.Count > NumberConstant.Zero)
            {
                payslips.Select(x => { x.IdSessionNavigation.Payslip = null; x.IdEmployeeNavigation.Payslip = null; return x; }).ToList();
            }
            return payslips;
        }

        /// <summary>
        /// Récupère la liste des intervalle de dates des concernés par les modifications de salaire de base
        /// </summary>
        /// <param name="referencedBonusValidityPeriods"></param>
        /// <param name="bonusValidityPeriodsBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void BonusValidityPeriodChek(List<BonusValidityPeriodViewModel> referencedBonusValidityPeriods, List<BonusValidityPeriodViewModel> bonusValidityPeriodsBeforeUpdate, List<DateInterval> dateIntervals)
        {
            referencedBonusValidityPeriods.ForEach(bonusValidityPeriodAfterUpdate =>
            {
                // The existing bonusValidityPeriod defined after the bonusValidityPeriod (added or modified)
                BonusValidityPeriodViewModel bonusValidityPeriod = bonusValidityPeriodsBeforeUpdate.Where(x => x.Id != bonusValidityPeriodAfterUpdate.Id && x.StartDate.AfterDate(bonusValidityPeriodAfterUpdate.StartDate)).OrderBy(x => x.StartDate).FirstOrDefault();
                // The current bonusValidityPeriod before it's update
                BonusValidityPeriodViewModel bonusValidityPeriodBeforeUpdate = bonusValidityPeriodsBeforeUpdate.FirstOrDefault(x => x.Id == bonusValidityPeriodAfterUpdate.Id);
                // By default, the start are equal to the modified or added bonusValidityPeriod startDate
                DateTime startDate = bonusValidityPeriodAfterUpdate.StartDate;
                if (bonusValidityPeriodBeforeUpdate != null)
                {
                    startDate = bonusValidityPeriodBeforeUpdate.StartDate.BeforeDate(bonusValidityPeriodAfterUpdate.StartDate) ?
                            bonusValidityPeriodBeforeUpdate.StartDate : bonusValidityPeriodAfterUpdate.StartDate;
                }
                // The start date of the interval is the date of the bonusValidityPeriod (added or modified)
                DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth());
                // If a following bonusValidityPeriod is defined, take its start date as the end date of the interval
                if (bonusValidityPeriod != null)
                {
                    dateInterval.EndDate = bonusValidityPeriod.StartDate.LastDateOfMonth();
                }
                dateIntervals.Add(dateInterval);
            });
        }

        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Bonus> predicateFilterRelationModel)
        {
            IEnumerable<dynamic> entities;
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .Include(x => x.BonusValidityPeriod)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .Include(x => x.BonusValidityPeriod)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            }
            IList<dynamic> model = entities.Select(x => _reducedBuilder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }

        /// <summary>
        /// Return list of premium from idContract
        /// </summary>
        /// <param name="idContract"></param>
        /// <returns></returns>
        public IEnumerable<BonusViewModel> GetAvailableBonusOfContract(int idContract, DateTime month)
        {
            // Retrieve the association table list of ContractBonus that are associated with the current 
            // Contract and validitydate is great than payslipStarDate
            IList<ContractBonusViewModel> contractBonus = _serviceContractBonus.FindModelBy(cp => cp.IdContract == idContract
                 && cp.ValidityStartDate.BeforeDateLimitIncluded(month.LastDateOfMonth()) &&
                 (cp.ValidityEndDate.HasValue && cp.ValidityEndDate.Value.AfterDateLimitIncluded(month) || !cp.ValidityEndDate.HasValue)).ToList();
            // Define new List of bonus for contain the collection
            return FindModelsByNoTracked(sr => contractBonus.Any(x => x.IdBonus == sr.Id), x => x.IdCnssNavigation);
        }
    }
}
