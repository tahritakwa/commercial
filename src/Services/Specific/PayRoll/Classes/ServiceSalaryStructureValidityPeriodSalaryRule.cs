using Microsoft.Extensions.Caching.Memory;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSalaryStructureValidityPeriodSalaryRule : Service<SalaryStructureValidityPeriodSalaryRuleViewModel, SalaryStructureValidityPeriodSalaryRule>, IServiceSalaryStructureValidityPeriodSalaryRule
    {
        private readonly IServiceSalaryStructure _serviceSalaryStructure;
        private readonly IMemoryCache _memoryCache;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceSalaryRule _serviceSalaryRule;
        private readonly ILexicalAnalyzer _lexicalAnalyzer;
        private readonly ISyntacticAnalyzer _syntacticAnalyzer;
        public ServiceSalaryStructureValidityPeriodSalaryRule(IRepository<SalaryStructureValidityPeriodSalaryRule> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
          ISalaryStructureValidityPeriodSalaryRuleBuilder builder,
          IRepository<Entity> entityRepoEntity,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceSalaryStructure serviceSalaryStructure,
            IServiceCompany serviceCompany, IMemoryCache memoryCache, IServiceSalaryRule serviceSalaryRule,
            ILexicalAnalyzer lexicalAnalyzer,
            ISyntacticAnalyzer syntacticAnalyze)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceSalaryStructure = serviceSalaryStructure;
            _memoryCache = memoryCache;
            _serviceCompany = serviceCompany;
            _serviceSalaryRule = serviceSalaryRule;
            _lexicalAnalyzer = lexicalAnalyzer;
            _syntacticAnalyzer = syntacticAnalyze;
        }

        public IList<string> GetSessionResumeColumnOrder(DateTime month = default)
        {
            // Get CDI salary structure
            SalaryStructureViewModel salaryStructureViewModel = _serviceSalaryStructure.GetModel(structure =>
                structure.SalaryStructureReference.Equals(PayRollConstant.Cdi, StringComparison.OrdinalIgnoreCase));
            // List of salary rules of salary structure CDI ordered by applicability and rule order
            IList<SalaryRuleViewModel> salaryRuleViewModels = GetSalaryStructureHierarchyRules(salaryStructureViewModel, month);
            // Return list of salary rules reference
            return salaryRuleViewModels.Select(element => element.Reference).ToList();
        }

        /// <summary>
        /// Create the collection which is meant to contain the hierrarchy 
        /// And call the GetSingleInHierarchy method who return the hoole hierarchy of Salary structure
        /// </summary>
        /// <param name="salaryStructure"></param>
        /// <returns></returns>
        public IList<SalaryRuleViewModel> GetSalaryStructureHierarchyRules(SalaryStructureViewModel salaryStructureViewModel, DateTime month)
        {
            List<SalaryRuleViewModel> salaryRules = new List<SalaryRuleViewModel>();
            IDictionary<int, SalaryStructureViewModel> keyValuePairs = new Dictionary<int, SalaryStructureViewModel>
            {
                { NumberConstant.Zero, salaryStructureViewModel }
            };
            keyValuePairs = Hierrarchy(salaryStructureViewModel, keyValuePairs);
            keyValuePairs = keyValuePairs.OrderByDescending(key => key.Key).ToDictionary((keyItem) => keyItem.Key, (valueItem) => valueItem.Value);
            keyValuePairs.ToList().ForEach(key =>
            {
                SalaryStructureViewModel tempSalaryStructure = SaveSalaryStructureInMemoryCache(key.Value, month);
                salaryRules.AddRange(tempSalaryStructure.SalaryRules);
            });
            salaryRules = salaryRules.Distinct(new SalaryRuleComparer()).ToList();
            return salaryRules;
        }

        /// <summary>
        /// Get Salary rules of Salary structure
        /// </summary>
        /// <param name="salaryStructureViewModel"></param>
        /// <param name="keyValuePairs"></param>
        /// <returns></returns>
        public IDictionary<int, SalaryStructureViewModel> Hierrarchy(SalaryStructureViewModel salaryStructureViewModel, IDictionary<int, SalaryStructureViewModel> keyValuePairs)
        {
            if (salaryStructureViewModel.IdParent.HasValue)
            {
                SalaryStructureViewModel parentSalaryStructureViewModel = _serviceSalaryStructure.GetModel(s => s.Id == salaryStructureViewModel.IdParent);
                keyValuePairs.Add(keyValuePairs.Keys.Max() + 1, parentSalaryStructureViewModel);
                return Hierrarchy(parentSalaryStructureViewModel, keyValuePairs);
            }
            return keyValuePairs;
        }

        /// <summary>
        /// Save Salary Structure in  memory cache 
        /// </summary>
        /// <param name="salaryStructureViewModel"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public SalaryStructureViewModel SaveSalaryStructureInMemoryCache(SalaryStructureViewModel salaryStructureViewModel, DateTime month)
        {
            salaryStructureViewModel = _memoryCache.GetOrCreate(string.Concat(_serviceCompany.GetCurrentCompany().Code, PayRollConstant.Separator, salaryStructureViewModel.SalaryStructureReference,
                     PayRollConstant.Separator, month.Month, PayRollConstant.Separator, month.Year), entry =>
                     {
                         salaryStructureViewModel.SalaryRules = GetSalaryRulesOfOneSalaryStructure(salaryStructureViewModel.Id, month);
                         //item will be expired if it has not been accessed within the timespan provided (here we have 60 minute).
                         entry.SlidingExpiration = TimeSpan.FromMinutes(60);
                         return salaryStructureViewModel;
                     });
            return salaryStructureViewModel.DeepCopyByExpressionTree();
        }

        /// <summary>
        /// Take a SalaryStructure parameter and return the list of salary rules associated with this structure
        /// </summary>
        /// <param name="salaryStructure"></param>
        /// <returns></returns>
        private List<SalaryRuleViewModel> GetSalaryRulesOfOneSalaryStructure(int idSalaryStructure, DateTime month)
        {
            SalaryStructureViewModel salaryStructureViewModel = _serviceSalaryStructure.GetModelWithRelationsAsNoTracked(x => x.Id == idSalaryStructure,
                x => x.SalaryStructureValidityPeriod);
            SalaryStructureValidityPeriodViewModel currentValidityperiod = salaryStructureViewModel.SalaryStructureValidityPeriod.Where(x =>
            x.StartDate.Date.BeforeDateLimitIncluded(month)).OrderByDescending(m => m.StartDate).FirstOrDefault();
            if (currentValidityperiod is null)
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(SalaryStructure)},
                        { nameof(SalaryStructure.Name), salaryStructureViewModel.SalaryStructureReference }
                    };
                throw new CustomException(CustomStatusCode.NoValidityPeriodIsConfiguredForThisPeriod, errorParams);
            }
            //Retrieve the association table list of SalaryStructureValidityperiodSalaryRule that are associated with the current salary structure
            IList<SalaryStructureValidityPeriodSalaryRuleViewModel> salaryStructureValidityPeriodSalaryRuleViewModels = FindModelsByNoTracked(ssr =>
                ssr.IdSalaryStructureValidityPeriod == currentValidityperiod.Id).ToList();
            //Define new List of SalaryRule for contain the collection of salaryRule
            List<SalaryRuleViewModel> salaryRules = _serviceSalaryRule.GetModelsWithConditionsRelations(sr => salaryStructureValidityPeriodSalaryRuleViewModels.Any(x => x.IdSalaryRule == sr.Id),
                sr => sr.IdRuleUniqueReferenceNavigation, sr => sr.SalaryRuleValidityPeriod).ToList();
            salaryRules.ForEach(salaryRule =>
            {
                SalaryRuleValidityPeriodViewModel salaryRuleValidityPeriod = salaryRule.SalaryRuleValidityPeriod.Where(m => m.StartDate.BeforeDateLimitIncluded(month)).OrderByDescending(m => m.StartDate).FirstOrDefault();
                if (salaryRuleValidityPeriod is null)
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(SalaryRule)},
                        { nameof(SalaryRule.Name), salaryRule.Reference }
                    };
                    throw new CustomException(CustomStatusCode.NoValidityPeriodIsConfiguredForThisPeriod, errorParams);
                }
                salaryRule.Rule = salaryRuleValidityPeriod.Rule;
                salaryRule.Reference = salaryRule.IdRuleUniqueReferenceNavigation.Reference;
                if (salaryRule.Rule != null)
                {
                    Queue<TokenViewModel> rule = _lexicalAnalyzer.LexerForExcecution(salaryRule.Rule);
                    salaryRule.ParsedSalaryRule = _syntacticAnalyzer.Parse(rule);
                }
            });
            return salaryRules;
        }

    }
}
