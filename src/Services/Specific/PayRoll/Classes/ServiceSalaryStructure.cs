using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using Settings.Exceptions.ExceptionsPayroll;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSalaryStructure
        : Service<SalaryStructureViewModel, SalaryStructure>, IServiceSalaryStructure
    {
        private readonly IRepository<Contract> _entityRepoContract;
        private readonly IServiceSalaryStructureValidityPeriod _serviceSalaryStructureValidityPeriod;
        private readonly IRepository<Payslip> _repoPayslip;

        public ServiceSalaryStructure(IRepository<SalaryStructure> entityRepo,
            IRepository<Payslip> repoPayslip,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ISalaryStructureBuilder builder,
            IRepository<Contract> entityRepoContract, IServiceSalaryStructureValidityPeriod serviceSalaryStructureValidityPeriod,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IMemoryCache memoryCache, ICompanyBuilder companyBuilder)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _entityRepoContract = entityRepoContract;
            _serviceSalaryStructureValidityPeriod = serviceSalaryStructureValidityPeriod;
            _repoPayslip = repoPayslip;
        }

        public override object AddModelWithoutTransaction(SalaryStructureViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckSalaryStructureValidity(model);
            CheckCircularInheritance(model);
            IList<SalaryStructureValidityPeriodSalaryRuleViewModel> salaryRulesToCheck = new List<SalaryStructureValidityPeriodSalaryRuleViewModel>();
            SalaryStructureValidityPeriodViewModel currentValidityPeriod = model.SalaryStructureValidityPeriod.FirstOrDefault();
            foreach (var salaryRule in currentValidityPeriod.SalaryStructureValidityPeriodSalaryRule)
            {
                if (salaryRule.Checked)
                {
                    salaryRulesToCheck.Add(salaryRule);
                }
            }
            model.SalaryStructureValidityPeriod.FirstOrDefault().SalaryStructureValidityPeriodSalaryRule = salaryRulesToCheck;
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(SalaryStructureViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckSalaryStructureValidity(model);
            CheckCircularInheritance(model);
            SalaryStructureValidityPeriodViewModel currentValidityperiod = model.SalaryStructureValidityPeriod.Where(x => x.Id == NumberConstant.Zero).FirstOrDefault();
            if (currentValidityperiod != null)
            {
                IList<SalaryStructureValidityPeriodSalaryRuleViewModel> salaryRulesToCheck = new List<SalaryStructureValidityPeriodSalaryRuleViewModel>();
                foreach (var salaryRule in currentValidityperiod.SalaryStructureValidityPeriodSalaryRule)
                {
                    if (salaryRule.Checked)
                    {
                        salaryRulesToCheck.Add(salaryRule);
                    }
                    model.SalaryStructureValidityPeriod.Where(x => x.Id == currentValidityperiod.Id).FirstOrDefault().SalaryStructureValidityPeriodSalaryRule = salaryRulesToCheck;
                }
            }
            SalaryStructureViewModel salaryStructureBeforeUpdate = _entityRepo.GetAllAsNoTracking()
                .Where(x => x.Id == model.Id)
                .Include(x => x.SalaryStructureValidityPeriod)
                .ThenInclude(x => x.SalaryStructureValidityPeriodSalaryRule)
                .Select(_builder.BuildEntity)
                .FirstOrDefault();
            UpdateSalaryStructureAssociateWithPayslip(model, salaryStructureBeforeUpdate);
            model.SalaryStructureValidityPeriod.ToList().ForEach(x =>
            {
                SalaryStructureValidityPeriodViewModel salaryStructureValidityPeriodBeforeUpdate = salaryStructureBeforeUpdate.SalaryStructureValidityPeriod.FirstOrDefault(s => s.Id == x.Id);
                if (salaryStructureValidityPeriodBeforeUpdate != null && salaryStructureValidityPeriodBeforeUpdate.SalaryStructureValidityPeriodSalaryRule != null)
                {
                    salaryStructureValidityPeriodBeforeUpdate.SalaryStructureValidityPeriodSalaryRule.Except(
                        x.SalaryStructureValidityPeriodSalaryRule,
                        new EntityComparatorDeleted<SalaryStructureValidityPeriodSalaryRuleViewModel>()).ToList().ForEach(d =>
                        {
                            d.IsDeleted = true;
                            x.SalaryStructureValidityPeriodSalaryRule.Add(d);
                        });
                }
            });
            _serviceSalaryStructureValidityPeriod.BulkUpdateModelWithoutTransaction(model.SalaryStructureValidityPeriod.ToList(), userMail);
            UpdateWithoutCollectionsWithoutTransaction(model);
            ClearStructureInCache(model.Id);
            return new CreatedDataViewModel { Id = model.Id };
        }

        private void CheckSalaryStructureValidity(SalaryStructureViewModel model)
        {
            Regex r = new Regex(@"^[a-zA-Z]+$");
            if (!r.IsMatch(model.SalaryStructureReference))
            {
                throw new CustomException(CustomStatusCode.VariableReferenceViolation);
            }
            if (model.SalaryStructureValidityPeriod.Any(x => x.SalaryStructureValidityPeriodSalaryRule.Count == NumberConstant.Zero))
            {
                throw new CustomException(CustomStatusCode.CannotAddSalaryStructureWithParentAndWithoutNewSalaryRule);
            }
            model.SalaryStructureValidityPeriod.ToList().ForEach(validityPeriod =>
            {
                validityPeriod.StartDate = validityPeriod.StartDate.FirstDateOfMonth();
            });
            if (model.SalaryStructureValidityPeriod.Any(n => !n.IsDeleted && model.SalaryStructureValidityPeriod.Any(m => !m.IsDeleted && n != m && n.StartDate.EqualsDate(m.StartDate))))
            {
                DateTime date = model.SalaryStructureValidityPeriod.FirstOrDefault(n => !n.IsDeleted
                       && model.SalaryStructureValidityPeriod.Any(m => !m.IsDeleted && n != m && n.StartDate.EqualsDate(m.StartDate))).StartDate;
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.DATE,  date.ToString("MMMM") + PayRollConstant.BlankSpace + date.Year}
                    };
                throw new CustomException(CustomStatusCode.PeriodicityStartdateMustBeUnique, paramtrs);
            }
            if (!model.IdParent.HasValue && model.SalaryStructureValidityPeriod.Any(x => !x.SalaryStructureValidityPeriodSalaryRule.Any()))
            {
                throw new CustomException(CustomStatusCode.SalarystructureMustHaveRuleOrParent);
            }
        }

        /// <summary>
        /// When circular relationship is detected between this salary structure and its parent's structure
        /// </summary>
        /// <param name="model"></param>
        private void CheckCircularInheritance(SalaryStructureViewModel model)
        {
            bool circularDependence = false;
            if (model.IdParent.HasValue)
            {
                SalaryStructure parent = _entityRepo.GetSingleNotTracked(p => p.Id == model.IdParent);
                circularDependence = parent.Id == model.Id  || parent.IdParent == model.Id ? true : false;
                while (!circularDependence && parent.IdParent.HasValue)
                {
                    parent = _entityRepo.GetSingleNotTracked(p => p.Id == parent.IdParent);
                    circularDependence = parent.Id == model.Id || parent.IdParent == model.Id ? true : false;
                }
                if (circularDependence)
                {
                    throw new CustomException(CustomStatusCode.CircularRelationshipBetweenSalarySrtructures);
                }
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="contract"></param>
        private void UpdateSalaryStructureAssociateWithPayslip(SalaryStructureViewModel salaryRuleViewModel, SalaryStructureViewModel salaryStructureBeforeUpdate)
        {
            IList<Payslip> payslips = CheckIfSalaryStructureIsAssociatedWithAnyPayslip(salaryRuleViewModel, salaryStructureBeforeUpdate);
            if (payslips.Any())
            {
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(SalaryStructure)}
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
        public IList<Payslip> CheckIfSalaryStructureIsAssociatedWithAnyPayslip(SalaryStructureViewModel salaryStructureViewModel, SalaryStructureViewModel salaryStructureBeforeUpdate = null)
        {
            if (salaryStructureBeforeUpdate is null)
            {
                salaryStructureBeforeUpdate = _entityRepo.GetAllAsNoTracking()
                    .Where(x => x.Id == salaryStructureViewModel.Id)
                    .Include(x => x.SalaryStructureValidityPeriod)
                    .ThenInclude(x => x.SalaryStructureValidityPeriodSalaryRule)
                    .Select(_builder.BuildEntity)
                    .FirstOrDefault();
            }
            // A date interval collection to contain the date intervals in which the generated payslips are corrupted
            List<DateInterval> dateIntervals = new List<DateInterval>();
            List<Payslip> payslips = new List<Payslip>();
            if (salaryStructureViewModel.SalaryStructureValidityPeriod.Any())
            {
                if (!new SalaryStructureComparer().Equals(salaryStructureViewModel, salaryStructureBeforeUpdate))
                {
                    DateInterval dateInterval = new DateInterval(salaryStructureBeforeUpdate.SalaryStructureValidityPeriod.OrderBy(x => x.StartDate).FirstOrDefault().StartDate);
                    dateIntervals.Add(dateInterval);
                }
                // For new base validityPeriods added, retrieve date intervals with existing payslips
                SalaryStructureValidityPeriodChek(salaryStructureViewModel.SalaryStructureValidityPeriod.Where(x => x.Id == NumberConstant.Zero).ToList(), salaryStructureBeforeUpdate.SalaryStructureValidityPeriod.ToList(), dateIntervals);
                // For existing validityPeriods modified or deleted, retrieve date intervals with existing payslips
                SalaryStructureValidityPeriodChek(salaryStructureViewModel.SalaryStructureValidityPeriod.Except(salaryStructureBeforeUpdate.SalaryStructureValidityPeriod, new SalaryStructureValidityPeriodComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), salaryStructureBeforeUpdate.SalaryStructureValidityPeriod.ToList(), dateIntervals);
                // Get corruped paysips
                payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x =>
                                x.IdContractNavigation.IdSalaryStructure == salaryStructureViewModel.Id &&
                                dateIntervals.Any(d => d.EndDate.HasValue && x.Month.BetweenDateLimitIncluded(d.StartDate, d.EndDate.Value) ||
                                     !d.EndDate.HasValue && x.Month.AfterDateLimitIncluded(d.StartDate)),
                                     x => x.IdSessionNavigation).ToList();
            }
            else
            {
                if (!new SalaryStructureComparer().Equals(salaryStructureViewModel, salaryStructureBeforeUpdate))
                {
                    payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x => x.IdContractNavigation.IdSalaryStructure == salaryStructureViewModel.Id,
                         x => x.IdSessionNavigation).ToList();
                }
            }
            return payslips;
        }


        /// <summary>
        /// Retrieves the list of date intervals of those affected by the changes to the salary rule
        /// </summary>
        /// <param name="referencedSalaryStructureValidityPeriods"></param>
        /// <param name="salaryStructureValidityPeriodsBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void SalaryStructureValidityPeriodChek(List<SalaryStructureValidityPeriodViewModel> referencedSalaryStructureValidityPeriods, List<SalaryStructureValidityPeriodViewModel> salaryStructureValidityPeriodsBeforeUpdate, List<DateInterval> dateIntervals)
        {
            referencedSalaryStructureValidityPeriods.ForEach(salaryStructureValidityPeriodAfterUpdate =>
            {
                // The existing salaryStructureValidityPeriod defined after the salaryStructureValidityPeriod (added or modified)
                SalaryStructureValidityPeriodViewModel salaryStructureValidityPeriod = salaryStructureValidityPeriodsBeforeUpdate.Where(x => x.Id != salaryStructureValidityPeriodAfterUpdate.Id && x.StartDate.AfterDate(salaryStructureValidityPeriodAfterUpdate.StartDate)).OrderBy(x => x.StartDate).FirstOrDefault();
                // The current salaryStructureValidityPeriod before it's update
                SalaryStructureValidityPeriodViewModel salaryStructureValidityPeriodBeforeUpdate = salaryStructureValidityPeriodsBeforeUpdate.FirstOrDefault(x => x.Id == salaryStructureValidityPeriodAfterUpdate.Id);
                // By default, the start date are equal to the modified or added salaryStructureValidityPeriod startDate
                DateTime startDate = salaryStructureValidityPeriodAfterUpdate.StartDate;
                if (salaryStructureValidityPeriodBeforeUpdate != null)
                {
                    startDate = salaryStructureValidityPeriodBeforeUpdate.StartDate.BeforeDate(salaryStructureValidityPeriodAfterUpdate.StartDate) ?
                            salaryStructureValidityPeriodBeforeUpdate.StartDate : salaryStructureValidityPeriodAfterUpdate.StartDate;
                }
                // The start date of the interval is the date of the salaryStructureValidityPeriod (added or modified)
                DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth());
                // If a following salaryStructureValidityPeriod is defined, take its start date as the end date of the interval
                if (salaryStructureValidityPeriod != null)
                {
                    dateInterval.EndDate = salaryStructureValidityPeriod.StartDate.LastDateOfMonth();
                }
                dateIntervals.Add(dateInterval);
            });
        }


        /// <summary>
        /// Delete from memoryCache all salary structures referencing the rule that has just been modified
        /// </summary>
        /// <param name="idSalaryStructure"></param>
        private void ClearStructureInCache(int idSalaryStructure)
        {
            //Here we will recuperate the elements of the memory cache
            //We iterate through them to find keys and remove them
            List<SalaryStructure> salaryStructures = _entityRepo.GetAllAsNoTracking()
                .Where(x => x.Id == idSalaryStructure || x.IdParent == idSalaryStructure || x.IdParentNavigation.IdParent == idSalaryStructure)
                .Include(x => x.SalaryStructureValidityPeriod)
                .ThenInclude(x => x.SalaryStructureValidityPeriodSalaryRule).ToList();

            PropertyInfo field = typeof(MemoryCache).GetProperty("EntriesCollection", BindingFlags.NonPublic | BindingFlags.Instance);
            if (field.GetValue(_cache) is ICollection memoryCollection)
            {
                foreach (var item in memoryCollection)
                {
                    var value = item.GetType().GetProperty("Key").GetValue(item);
                    if (salaryStructures.Any(x =>
                        value.ToString().Contains(string.Concat(GetCurrentCompany().Code, PayRollConstant.Separator, x.SalaryStructureReference, PayRollConstant.Separator))))
                    {
                        _cache.Remove(value.ToString());
                    }
                }
            }
        }



        /// <summary>
        /// That method return the salarystructure of contract in parameter
        /// </summary>
        /// <param name="IdContract"></param>
        /// <returns></returns>
        public SalaryStructureViewModel GetStructureSalaryByIdContract(int idContract)
        {
            //Recuparate the contract
            Contract contract = _entityRepoContract.GetSingleNotTracked(p => p.Id == idContract);
            if (contract == null)
            {
                throw new InvalidContractIdException();
            }
            //get salaryStructure associeted to contract
            SalaryStructure salaryStructure = _entityRepo.GetSingleWithRelationsNotTracked(s => s.Id == contract.IdSalaryStructure, y => y.SalaryStructureValidityPeriod);
            IList<SalaryStructureValidityPeriodViewModel> salaryStructureValidityPeriods = new List<SalaryStructureValidityPeriodViewModel>();
            SalaryStructureViewModel salaryStructureViewModel = _builder.BuildEntity(salaryStructure);
            foreach (SalaryStructureValidityPeriod salaryStructureValidityPeriod in salaryStructure.SalaryStructureValidityPeriod)
            {
                SalaryStructureValidityPeriodViewModel validityPeriod = _serviceSalaryStructureValidityPeriod.GetModelWithRelationsAsNoTracked(validity =>
                 validity.Id == salaryStructureValidityPeriod.Id, y => y.SalaryStructureValidityPeriodSalaryRule, x => x.IdSalaryStructureNavigation);
                salaryStructureViewModel.SalaryStructureValidityPeriod.Add(validityPeriod);
            }
            return salaryStructureViewModel;
        }

        /// <summary>
        /// Get Salary structure with SaalryStructureValidityPeriod and SaalryStructureValidityPeriodSalaryRule collections
        /// </summary>
        /// <param name="idSalaryStructure"></param>
        /// <returns></returns>
        public SalaryStructureViewModel GetSalaryStructureWithSalaryRules(int idSalaryStructure)
        {
            SalaryStructure salaryStructure = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == idSalaryStructure)
                .Include(x => x.SalaryStructureValidityPeriod)
                .ThenInclude(x => x.SalaryStructureValidityPeriodSalaryRule)
                .FirstOrDefault();
            return _builder.BuildEntity(salaryStructure);
        }
    }
}
