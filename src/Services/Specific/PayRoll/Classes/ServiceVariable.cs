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
    public class ServiceVariable : Service<VariableViewModel, Variable>, IServiceVariable
    {
        private readonly IRepository<SalaryRule> _entityRepoSalaryRule;
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly ILexicalAnalyzer _lexicalAnalyzer;
        private readonly ISyntacticAnalyzer _syntacticAnalyzer;
        private readonly IRepository<Payslip> _repoPayslip;

        public ServiceVariable(IServiceRuleUniqueReference serviceRuleUniqueReference, IRepository<Variable> entityRepo,
            IRepository<Payslip> repoPayslip,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IVariableBuilder builder, ILexicalAnalyzer lexicalAnalyzer, ISyntacticAnalyzer syntacticAnalyzer,
            IRepository<SalaryRule> entityRepoSalaryRule, IEntityAxisValuesBuilder builderEntityAxisValues, IMemoryCache memoryCache, ICompanyBuilder companyBuilder)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _repoPayslip = repoPayslip;
            _lexicalAnalyzer = lexicalAnalyzer;
            _syntacticAnalyzer = syntacticAnalyzer;
            _entityRepoSalaryRule = entityRepoSalaryRule;
        }


        public override object AddModelWithoutTransaction(VariableViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckVariableReference(model.Reference);
            LexicalAndSyntacticValidation(model.VariableValidityPeriod.ToList());
            model.Type = (int)ExpressionTypeViewModel.ExpressionType.Variable;
            object a = _serviceRuleUniqueReference.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            model.IdRuleUniqueReference = ((CreatedDataViewModel)a).Id;
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Check if variable reference is alphabetic
        /// </summary>
        /// <param name="code"></param>
        private void CheckVariableReference(string reference)
        {
            Regex r = new Regex(@"^[a-zA-Z]+$");
            if (!r.IsMatch(reference))
            {
                throw new CustomException(CustomStatusCode.VariableReferenceViolation);
            }
        }

        public override object UpdateModelWithoutTransaction(VariableViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckVariableReference(model.Reference);
            LexicalAndSyntacticValidation(model.VariableValidityPeriod.ToList());
            RuleUniqueReferenceViewModel ruleBeforeUpdate = _serviceRuleUniqueReference.GetModelAsNoTracked(m => m.Id.Equals(model.IdRuleUniqueReference));
            if (ruleBeforeUpdate.Id != model.IdRuleUniqueReference ||
                !ruleBeforeUpdate.Reference.Equals(model.IdRuleUniqueReferenceNavigation.Reference))
            {
                model.IdRuleUniqueReferenceNavigation.Id = ruleBeforeUpdate.Id;
                model.IdRuleUniqueReferenceNavigation.Reference = ruleBeforeUpdate.Reference;
            }
            if (model.UpdatePayslip)
            {
                UpdatePayslipAssociateWithVariable(model);
            }
            var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            IList<SalaryRule> idsalaryRules = SalaryRuleReferencedByVariable(model.Reference);
            if(idsalaryRules.Count != NumberConstant.Zero)
            {
                ClearStructureInCacheAssociateWithRule(idsalaryRules.Select(x => x.Id).ToList());
            }
            return result;
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            VariableViewModel variableViewModel = GetModel(r => r.Id == id);
            var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
            _serviceRuleUniqueReference.DeleteModelwithouTransaction(variableViewModel.IdRuleUniqueReference, nameof(RuleUniqueReference), userMail);
            return obj;
        }

        private void LexicalAndSyntacticValidation(IList<VariableValidityPeriodViewModel> variableValidityPeriods)
        {
            variableValidityPeriods.ToList().ForEach(variableValidityPeriod =>
            {
                variableValidityPeriod.StartDate = variableValidityPeriod.StartDate.FirstDateOfMonth();
                Queue<TokenViewModel> lexer = _lexicalAnalyzer.LexerForValidation(variableValidityPeriod.Formule, variableValidityPeriod.StartDate);
                _syntacticAnalyzer.Parse(lexer);
            });
            if (variableValidityPeriods.Any(n => !n.IsDeleted && variableValidityPeriods.Any(m => !m.IsDeleted && n != m && n.StartDate.EqualsDate(m.StartDate))))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(Variable)}
                    };
                throw new CustomException(CustomStatusCode.PeriodicityStartdateMustBeUnique, paramtrs);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="contract"></param>
        private void UpdatePayslipAssociateWithVariable(VariableViewModel variableViewModel)
        {
            IList<Payslip> payslips = CheckIfVariableIsUsedInAnyRuleUsedinAnyPayslip(variableViewModel);
            if (payslips.Any())
            {
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(Variable)}
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
        public IList<Payslip> CheckIfVariableIsUsedInAnyRuleUsedinAnyPayslip(VariableViewModel variableViewModel)
        {
            VariableViewModel variableBeforeUpdate = GetModelAsNoTracked(x => x.Id == variableViewModel.Id,
                x => x.IdRuleUniqueReferenceNavigation,
                x => x.VariableValidityPeriod);
            // A date interval collection to contain the date intervals in which the generated payslips are corrupted
            List<DateInterval> dateIntervals = new List<DateInterval>();
            List<Payslip> payslips = new List<Payslip>();
            IList<int> idsalaryRules = SalaryRuleReferencedByVariable(variableViewModel.Reference).Select(x => x.Id).ToList();
            if (variableViewModel.VariableValidityPeriod.Any())
            {
                if (!new VariableComparer().Equals(variableViewModel, variableBeforeUpdate))
                {
                    DateInterval dateInterval = new DateInterval(variableBeforeUpdate.VariableValidityPeriod.OrderBy(x => x.StartDate).FirstOrDefault().StartDate);
                    dateIntervals.Add(dateInterval);
                }
                // For new base validityPeriods added, retrieve date intervals with existing payslips
                VariableValidityPeriodChek(variableViewModel.VariableValidityPeriod.Where(x => x.Id == NumberConstant.Zero).ToList(), variableBeforeUpdate.VariableValidityPeriod.ToList(), dateIntervals);
                // For existing validityPeriods modified or deleted, retrieve date intervals with existing payslips
                VariableValidityPeriodChek(variableViewModel.VariableValidityPeriod.Except(variableBeforeUpdate.VariableValidityPeriod, new VariableValidityPeriodComparer()).Where(x => x.Id != NumberConstant.Zero).ToList(), variableBeforeUpdate.VariableValidityPeriod.ToList(), dateIntervals);
                payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x =>
                                x.PayslipDetails.Any(d => d.IdSalaryRule.HasValue && idsalaryRules.Contains(d.IdSalaryRule.Value)) &&
                                dateIntervals.Any(d => d.EndDate.HasValue && x.Month.BetweenDateLimitIncluded(d.StartDate, d.EndDate.Value) ||
                                    !d.EndDate.HasValue && x.Month.AfterDateLimitIncluded(d.StartDate)),
                                    x => x.IdSessionNavigation, x => x.IdEmployeeNavigation).ToList();
            }
            else
            {
                if (!new VariableComparer().Equals(variableViewModel, variableBeforeUpdate))
                {
                    payslips = _repoPayslip.GetAllWithConditionsRelationsAsNoTracking(x => x.PayslipDetails.Any(d => d.IdSalaryRule.HasValue && idsalaryRules.Contains(d.IdSalaryRule.Value)),
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
        /// <param name="referencedVariableValidityPeriods"></param>
        /// <param name="variableValidityPeriodsBeforeUpdate"></param>
        /// <param name="dateIntervals"></param>
        private void VariableValidityPeriodChek(List<VariableValidityPeriodViewModel> referencedVariableValidityPeriods, List<VariableValidityPeriodViewModel> variableValidityPeriodsBeforeUpdate, List<DateInterval> dateIntervals)
        {
            referencedVariableValidityPeriods.ForEach(variableValidityPeriodAfterUpdate =>
            {
                // The existing variableValidityPeriod defined after the variableValidityPeriod (added or modified)
                VariableValidityPeriodViewModel variableValidityPeriod = variableValidityPeriodsBeforeUpdate.Where(x => x.Id != variableValidityPeriodAfterUpdate.Id && x.StartDate.AfterDate(variableValidityPeriodAfterUpdate.StartDate)).OrderBy(x => x.StartDate).FirstOrDefault();
                // The current variableValidityPeriod before it's update
                VariableValidityPeriodViewModel variableValidityPeriodBeforeUpdate = variableValidityPeriodsBeforeUpdate.FirstOrDefault(x => x.Id == variableValidityPeriodAfterUpdate.Id);
                // By default, the start date are equal to the modified or added variableValidityPeriod startDate
                DateTime startDate = variableValidityPeriodAfterUpdate.StartDate;
                if (variableValidityPeriodBeforeUpdate != null)
                {
                    startDate = variableValidityPeriodBeforeUpdate.StartDate.BeforeDate(variableValidityPeriodAfterUpdate.StartDate) ?
                            variableValidityPeriodBeforeUpdate.StartDate : variableValidityPeriodAfterUpdate.StartDate;
                }
                // The start date of the interval is the date of the variableValidityPeriod (added or modified)
                DateInterval dateInterval = new DateInterval(startDate.FirstDateOfMonth());
                // If a following variableValidityPeriod is defined, take its start date as the end date of the interval
                if (variableValidityPeriod != null)
                {
                    dateInterval.EndDate = variableValidityPeriod.StartDate.LastDateOfMonth();
                }
                dateIntervals.Add(dateInterval);
            });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="reference"></param>
        /// <returns></returns>
        private IList<Variable> VariableReferencedByVariable(string reference)
        {
            IList<Variable> variables = _entityRepo.GetAllAsNoTracking()
                .Include(x => x.VariableValidityPeriod).ToList();
            variables.ToList().ForEach(variable =>
            {
                variable.VariableValidityPeriod.Where(x => !string.IsNullOrEmpty(x.Formule)).ToList().ForEach(validityPeriodRule =>
                {
                    Queue<TokenViewModel> lexer = _lexicalAnalyzer.LexerForExcecution(validityPeriodRule.Formule);
                    if (lexer.Any(x => x.Value == reference))
                    {
                        variables.Add(variable);
                    }
                });
            });
            return variables;
        }

        /// <summary>
        /// Returns the list of salary rules that use this variable
        /// </summary>
        /// <param name="variableViewModel"></param>
        /// <returns></returns>
        private IList<SalaryRule> SalaryRuleReferencedByVariable(string reference)
        {
            IList<SalaryRule> salaryRules = _entityRepoSalaryRule.GetAllAsNoTracking()
                .Include(x => x.SalaryRuleValidityPeriod).ToList();
            IList<SalaryRule> salaryRulesReferenced = new List<SalaryRule>();
            salaryRules.Where(r => r.Order != NumberConstant.Zero).ToList().ForEach(salaryRule =>
            {
                salaryRule.SalaryRuleValidityPeriod.Where(x => !string.IsNullOrEmpty(x.Rule)).ToList().ForEach(validityPeriodRule =>
                {
                    Queue<TokenViewModel> lexer = _lexicalAnalyzer.LexerForExcecution(validityPeriodRule.Rule);
                    if (lexer.Any(x => x.Value == reference))
                    {
                        salaryRulesReferenced.Add(salaryRule);
                    }
                });
            });
            return salaryRulesReferenced;
        }


        /// <summary>
        /// Delete from memoryCache all salary structures referencing the rule that has just been modified
        /// </summary>
        /// <param name="idSalaryRule"></param>
        private void ClearStructureInCacheAssociateWithRule(IList<int> idsalaryRules)
        {
            //Here we will recuperate the elements of the memory cache
            //We iterate through them to find keys and remove them
            List<SalaryStructure> salaryStructureAssociateWithSalaryRule = _entityRepoSalaryRule.GetAllAsNoTracking()
                .Where(x => idsalaryRules.Contains(x.Id))
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
