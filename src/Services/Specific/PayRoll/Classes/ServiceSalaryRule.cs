using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Settings.Exceptions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
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
using ViewModels.DTO.PayRoll.Lexer;
using ViewModels.DTO.RH;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSalaryRule : Service<SalaryRuleViewModel, SalaryRule>, IServiceSalaryRule
    {
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly ILexicalAnalyzer _lexicalAnalyzer;
        private readonly ISyntacticAnalyzer _syntacticAnalyzer;
        private readonly IRepository<Payslip> _repoPayslip;

        public ServiceSalaryRule(IServiceRuleUniqueReference serviceRuleUniqueReference,
            IRepository<Payslip> repoPayslip,
            IRepository<SalaryRule> entityRepo, ILexicalAnalyzer lexicalAnalyzer,
            ISyntacticAnalyzer syntacticAnalyzer, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IUnitOfWork unitOfWork, ISalaryRuleBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IMemoryCache memoryCache, ICompanyBuilder companyBuilder)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _repoPayslip = repoPayslip;
            _lexicalAnalyzer = lexicalAnalyzer;
            _syntacticAnalyzer = syntacticAnalyzer;
        }


        public override object AddModelWithoutTransaction(SalaryRuleViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckSalaryRuleOrderAndApplicabilityLimits(model);
            LexicalAndSyntacticValidation(model);
            model.Type = (int)ExpressionTypeViewModel.ExpressionType.Rule;
            object a = _serviceRuleUniqueReference.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            model.IdRuleUniqueReference = ((CreatedDataViewModel)a).Id;
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(SalaryRuleViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckSalaryRuleOrderAndApplicabilityLimits(model);
            LexicalAndSyntacticValidation(model);
            model.IdRuleUniqueReference = _serviceRuleUniqueReference.GetModel(r => r.Reference == model.Reference).Id;
            if (model.UpdatePayslip)
            {
                UpdateSalaryRuleAssociateWithPayslip(model);
            }
            var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            ClearStructureInCacheAssociateWithRule(model.Id);
            return result;
        }

        /// <summary>
        /// Check salary rule order, applicability limits and reference value
        /// </summary>
        /// <param name="value"></param>
        /// <param name="property"></param>
        private void CheckSalaryRuleOrderAndApplicabilityLimits(SalaryRuleViewModel salaryRule)
        {
            Regex r = new Regex(@"^[a-zA-Z]+$");
            if (!r.IsMatch(salaryRule.Reference))
            {
                throw new CustomException(CustomStatusCode.VariableReferenceViolation);
            }
            if (salaryRule.Order < NumberConstant.Zero || salaryRule.Order > NumberConstant.Fifty)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { Constants.PROPERTY, PayRollConstant.SALARY_RULE_ORDER}
                };
                throw new CustomException(CustomStatusCode.OrderAndApplicabilityLimits, paramtrs);
            }
            if (salaryRule.Applicability < NumberConstant.Zero || salaryRule.Applicability > NumberConstant.Fifty)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { Constants.PROPERTY, nameof(salaryRule.Applicability).ToUpperInvariant()}
                };
                throw new CustomException(CustomStatusCode.OrderAndApplicabilityLimits, paramtrs);
            }
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            SalaryRuleViewModel salaryRuleViewModel = GetModel(r => r.Id == id);
            var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
            _serviceRuleUniqueReference.DeleteModelwithouTransaction(salaryRuleViewModel.IdRuleUniqueReference, nameof(RuleUniqueReference), userMail);
            return obj;
        }


        private void LexicalAndSyntacticValidation(SalaryRuleViewModel salaryRuleViewModel)
        {
            if (salaryRuleViewModel.Order != NumberConstant.Zero)
            {
                salaryRuleViewModel.SalaryRuleValidityPeriod.ToList().ForEach(salaryRuleValidityPeriod =>
                {
                    salaryRuleValidityPeriod.StartDate = salaryRuleValidityPeriod.StartDate.FirstDateOfMonth();
                    Queue<TokenViewModel> lexer = _lexicalAnalyzer.LexerForValidation(salaryRuleValidityPeriod.Rule, salaryRuleValidityPeriod.StartDate);
                    _syntacticAnalyzer.Parse(lexer);
                });
                if (salaryRuleViewModel.SalaryRuleValidityPeriod.Any(n => !n.IsDeleted &&
                    salaryRuleViewModel.SalaryRuleValidityPeriod.Any(m => !m.IsDeleted && n != m && n.StartDate.EqualsDate(m.StartDate))))
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(SalaryRule).ToUpper(CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.PeriodicityStartdateMustBeUnique, paramtrs);
                }
            }
        }

        public IList<SalaryRuleViewModel> GetSalaryRuleOrderedByApplicabilityThenByOrder()
        {
            return GetAllModels().OrderBy(x => x.Applicability).ThenBy(x => x.Order).ToList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="contract"></param>
        private void UpdateSalaryRuleAssociateWithPayslip(SalaryRuleViewModel salaryRuleViewModel)
        {
            IList<Payslip> payslips = CheckIfSalaryRuleIsAssociatedWithAnyPayslip(salaryRuleViewModel);
            if (payslips.Any())
            {
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(SalaryRule)}
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
        public IList<Payslip> CheckIfSalaryRuleIsAssociatedWithAnyPayslip(SalaryRuleViewModel salaryRuleViewModel)
        {
            SalaryRuleViewModel salaryRuleBeforeUpdate = GetModelAsNoTracked(x => x.Id == salaryRuleViewModel.Id, x => x.SalaryRuleValidityPeriod);
            // A date interval collection to contain the date intervals in which the generated payslips are corrupted
            List<DateInterval> dateIntervals = new List<DateInterval>();
            List<Payslip> payslips = new List<Payslip>();
            if (salaryRuleViewModel.SalaryRuleValidityPeriod.Any())
            {
                if (!new SalaryRuleComparer().Equals(salaryRuleViewModel, salaryRuleBeforeUpdate))
                {
                    DateInterval dateInterval = new DateInterval(salaryRuleBeforeUpdate.SalaryRuleValidityPeriod.OrderBy(x => x.StartDate).FirstOrDefault().StartDate);
                    dateIntervals.Add(dateInterval);
                }
                // For new base validityPeriods added, retrieve date intervals with existing payslips
                SalaryRuleValidityPeriodChek(salaryRuleViewModel.SalaryRuleValidityPeriod.Where(x => x.Id == NumberConstant.Zero).ToList(), salaryRuleBeforeUpdate.SalaryRuleValidityPeriod.ToList(), dateIntervals);
                // For existing validityPeriods modified or deleted, retrieve date intervals with existing payslips
                SalaryRuleValidityPeriodChek(salaryRuleViewModel.SalaryRuleValidityPeriod.Except(salaryRuleBeforeUpdate.SalaryRuleValidityPeriod, new SalaryRuleValidityPeriodComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), salaryRuleBeforeUpdate.SalaryRuleValidityPeriod.ToList(), dateIntervals);
                payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x =>
                                x.PayslipDetails.Any(d => d.IdSalaryRule == salaryRuleViewModel.Id) &&
                                dateIntervals.Any(d => d.EndDate.HasValue && x.Month.BetweenDateLimitIncluded(d.StartDate, d.EndDate.Value) ||
                                     !d.EndDate.HasValue && x.Month.AfterDateLimitIncluded(d.StartDate)),
                                     x => x.IdSessionNavigation, x  => x.IdEmployeeNavigation).ToList();
            }
            else
            {
                if (!new SalaryRuleComparer().Equals(salaryRuleViewModel, salaryRuleBeforeUpdate))
                {
                    payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x => x.PayslipDetails.Any(d => d.IdSalaryRule == salaryRuleViewModel.Id),
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
        /// Retrieves the list of date intervals of those affected by the changes to the salary rule
        /// </summary>
        /// <param name="referencedSalaryRuleValidityPeriods"></param>
        /// <param name="salaryRuleValidityPeriodsBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void SalaryRuleValidityPeriodChek(List<SalaryRuleValidityPeriodViewModel> referencedSalaryRuleValidityPeriods, List<SalaryRuleValidityPeriodViewModel> salaryRuleValidityPeriodsBeforeUpdate, List<DateInterval> dateIntervals)
        {
            referencedSalaryRuleValidityPeriods.ForEach(salaryRuleValidityPeriodAfterUpdate =>
            {
                // The existing salaryRuleValidityPeriod defined after the salaryRuleValidityPeriod (added or modified)
                SalaryRuleValidityPeriodViewModel salaryRuleValidityPeriod = salaryRuleValidityPeriodsBeforeUpdate.Where(x => x.Id != salaryRuleValidityPeriodAfterUpdate.Id && x.StartDate.AfterDate(salaryRuleValidityPeriodAfterUpdate.StartDate)).OrderBy(x => x.StartDate).FirstOrDefault();
                // The current salaryRuleValidityPeriod before it's update
                SalaryRuleValidityPeriodViewModel salaryRuleValidityPeriodBeforeUpdate = salaryRuleValidityPeriodsBeforeUpdate.FirstOrDefault(x => x.Id == salaryRuleValidityPeriodAfterUpdate.Id);
                // By default, the start date are equal to the modified or added salaryRuleValidityPeriod startDate
                DateTime startDate = salaryRuleValidityPeriodAfterUpdate.StartDate;
                if (salaryRuleValidityPeriodBeforeUpdate != null)
                {
                    startDate = salaryRuleValidityPeriodBeforeUpdate.StartDate.BeforeDate(salaryRuleValidityPeriodAfterUpdate.StartDate) ?
                            salaryRuleValidityPeriodBeforeUpdate.StartDate : salaryRuleValidityPeriodAfterUpdate.StartDate;
                }
                // The start date of the interval is the date of the salaryRuleValidityPeriod (added or modified)
                DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth());
                // If a following salaryRuleValidityPeriod is defined, take its start date as the end date of the interval
                if (salaryRuleValidityPeriod != null)
                {
                    dateInterval.EndDate = salaryRuleValidityPeriod.StartDate.LastDateOfMonth();
                }
                dateIntervals.Add(dateInterval);
            });
        }


        /// <summary>
        /// Delete from memoryCache all salary structures referencing the rule that has just been modified
        /// </summary>
        /// <param name="idSalaryRule"></param>
        private void ClearStructureInCacheAssociateWithRule(int idSalaryRule)
        {
            //Here we will recuperate the elements of the memory cache
            //We iterate through them to find keys and remove them
            List<SalaryStructure> salaryStructureAssociateWithSalaryRule = _entityRepo.GetAllAsNoTracking()
                .Where(x => x.Id == idSalaryRule)
                .Include(x => x.SalaryStructureValidityPeriodSalaryRule)
                .ThenInclude(x => x.IdSalaryStructureValidityPeriodNavigation)
                .ThenInclude(x => x.IdSalaryStructureNavigation).FirstOrDefault()
                .SalaryStructureValidityPeriodSalaryRule.Select(x => x.IdSalaryStructureValidityPeriodNavigation.IdSalaryStructureNavigation).ToList();
            PropertyInfo field = typeof(MemoryCache).GetProperty("EntriesCollection", BindingFlags.NonPublic | BindingFlags.Instance);
            if (field.GetValue(_cache) is ICollection memoryCollection)
            {
                foreach (var item in memoryCollection)
                {
                    var value = item.GetType().GetProperty("Key").GetValue(item);
                    if (salaryStructureAssociateWithSalaryRule.Any(x =>
                        value.ToString().Contains(string.Concat(GetCurrentCompany().Code, PayRollConstant.Separator, x.SalaryStructureReference, PayRollConstant.Separator))))
                    {
                        _cache.Remove(value.ToString());
                    }
                }
            }
        }
    }
}
