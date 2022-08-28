using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Settings.Exceptions;
using System;
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
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes.SpecificLanguage
{
    public class LexicalAnalyzer : ILexicalAnalyzer
    {
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly IRepository<Variable> _variableEntityRepo;
        private readonly IRepository<SalaryRule> _salaryRuleEntityRepo;

        public LexicalAnalyzer(IServiceRuleUniqueReference serviceRuleUniqueReference, IRepository<Variable> variableEntityRepo, IRepository<SalaryRule> salaryRuleEntityRepo)
        {
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _variableEntityRepo = variableEntityRepo;
            _salaryRuleEntityRepo = salaryRuleEntityRepo;
        }



        /// <summary>
        /// Return all TokenMatchViewModel .
        /// That is to say the Tokens with her TokenType, Value, StartIndex, EndIndex, Precedence
        /// </summary>
        /// <param name="Expression"></param>
        /// <returns></returns>
        private List<TokenMatchViewModel> FindTokenMatches(string Expression, string language)
        {
            RegularExpressions regularExpressions = new RegularExpressions();
            var tokenMatches = new List<TokenMatchViewModel>();
            if (language.Equals("english"))
            {
                foreach (var englishKeywords in regularExpressions._englishKeywords)
                {
                    var res = englishKeywords.FindMatches(Expression).ToList();
                    tokenMatches.AddRange(res);
                }
                return tokenMatches;
            }
            else
            {
                foreach (var frenshKeywords in regularExpressions._frenshKeywords)
                {
                    var res = frenshKeywords.FindMatches(Expression).ToList();
                    tokenMatches.AddRange(res);
                }
                return tokenMatches;
            }
        }

        /// <summary>
        /// Return all match tokens with her TokenType, Value  
        /// Add salaryrule and variable Lexer
        /// In the case of a Formalism or a Reference TokenType this method will verify if they exists else a lexical 
        /// exception will be generated
        /// </summary>
        /// <param name="Expression"></param>
        /// <returns></returns>
        public Queue<TokenViewModel> LexerForValidation(string Expression, DateTime? startDate)
        {
            Queue<TokenViewModel> Rule = new Queue<TokenViewModel>();
            List<string> References = _serviceRuleUniqueReference.GetAllModelsQueryable().Select(x => x.Reference).ToList();
            string newExpression = Expression.TrimStart();
            List<TokenMatchViewModel> tokenMatches = new List<TokenMatchViewModel>();
            string pattern = @"\bSi|\bIf";
            Match match = Regex.Match(newExpression, pattern, RegexOptions.IgnoreCase);
            if (match.Success && newExpression.Substring(NumberConstant.Zero, NumberConstant.Two).Equals(TokenTypeEnumerator.If.ToString(), StringComparison.OrdinalIgnoreCase))
            {
                tokenMatches = FindTokenMatches(newExpression, "english");
            }
            else
            {
                tokenMatches = FindTokenMatches(newExpression, "frensh");
            }
            var groupedByIndex = tokenMatches.GroupBy(x => x.Startindex)
                .OrderBy(x => x.Key)
                .ToList();
            TokenMatchViewModel lastMatch = null;
            for (int i = 0; i < groupedByIndex.Count; i++)
            {
                var bestMatch = groupedByIndex[i].OrderBy(x => x.Precedence).First();
                if (lastMatch != null && bestMatch.Startindex < lastMatch.EndIndex)
                { continue; }
                switch (bestMatch.TokenType)
                {
                    case TokenTypeEnumerator.Formalism:
                        string[] formalismValue = bestMatch.Value.Split(PayRollConstant.Point);
                        string className = formalismValue[NumberConstant.Zero];
                        string assemblyName = nameof(Persistence);
                        string nameSpace = string.Concat(assemblyName, PayRollConstant.Point, nameof(Persistence.Entities));
                        string fullName = string.Format("{0}.{1},{2}", nameSpace, className, assemblyName);
                        Type type = Type.GetType(fullName);
                        if (type != null)
                        {
                            PropertyInfo verifyAttribute = type.GetProperty(formalismValue[NumberConstant.One]);
                            if (verifyAttribute != null)
                            {
                                Rule.Enqueue(new TokenViewModel(bestMatch.TokenType, bestMatch.Value));
                                break;
                            }
                            IDictionary<string, dynamic> formParamtrs = new Dictionary<string, dynamic>
                                {
                                    { Constants.FORMALISM_VALUE, bestMatch.Value }
                                };
                            throw new CustomException(customStatusCode: CustomStatusCode.LexicalError, paramtrs: formParamtrs);
                        }
                        IDictionary<string, dynamic> formParam = new Dictionary<string, dynamic>
                            {
                                { Constants.FORMALISM_VALUE, bestMatch.Value }
                            };
                        throw new CustomException(customStatusCode: CustomStatusCode.LexicalError, paramtrs: formParam);                        

                    case TokenTypeEnumerator.Reference:
                        if (References.Contains(bestMatch.Value))
                        {
                            Variable variable = _variableEntityRepo.GetAllAsNoTracking().Include(x => x.VariableValidityPeriod)
                                .Where(x => x.IdRuleUniqueReferenceNavigation.Reference == bestMatch.Value).FirstOrDefault();

                            SalaryRule salaryRule = _salaryRuleEntityRepo.GetAllAsNoTracking().Include(x => x.SalaryRuleValidityPeriod)
                                .Where(x => x.IdRuleUniqueReferenceNavigation.Reference == bestMatch.Value).FirstOrDefault();
                            if (variable != null && startDate.Value.BeforeDate(variable.VariableValidityPeriod.Min(x => x.StartDate)) ||
                                salaryRule != null && startDate.Value.BeforeDate(salaryRule.SalaryRuleValidityPeriod.Min(x => x.StartDate)))
                            {
                                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                                {
                                    { Constants.REFERENCE, bestMatch.Value },
                                    { Constants.START_DATE, variable != null ? variable.VariableValidityPeriod.Min(x => x.StartDate).ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture) :
                                    salaryRule.SalaryRuleValidityPeriod.Min(x => x.StartDate).ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                                };
                                throw new CustomException(CustomStatusCode.VariableStartDateValidity, paramtrs: errorParams);
                            }
                            Rule.Enqueue(new TokenViewModel(bestMatch.TokenType, bestMatch.Value));
                            break;
                        }
                        IDictionary<string, dynamic> refParamtrs = new Dictionary<string, dynamic>
                            {
                                { Constants.BAD_REFERENCE, bestMatch.Value }
                            };
                        throw new CustomException(customStatusCode: CustomStatusCode.LexicalError, paramtrs: refParamtrs);                        

                    default:
                        Rule.Enqueue(new TokenViewModel(bestMatch.TokenType, bestMatch.Value));
                        break;
                }
                lastMatch = bestMatch;
            }
            return Rule;
        }


        /// <summary>
        /// Return all match tokens with her TokenType, Value  
        /// </summary>
        /// <param name="Expression"></param>
        /// <returns></returns>
        public Queue<TokenViewModel> LexerForExcecution(string Expression)
        {
            Queue<TokenViewModel> Queue = new Queue<TokenViewModel>();
            string newExpression = Expression.TrimStart();
            List<TokenMatchViewModel> tokenMatches = new List<TokenMatchViewModel>();
            string pattern = @"\bSi|\bIf";
            Match match = Regex.Match(newExpression, pattern, RegexOptions.IgnoreCase);
            if (match.Success && newExpression.Substring(NumberConstant.Zero, NumberConstant.Two).Equals(TokenTypeEnumerator.If.ToString(), StringComparison.OrdinalIgnoreCase))
            {
                tokenMatches = FindTokenMatches(newExpression, "english");
            }
            else
            {
                tokenMatches = FindTokenMatches(newExpression, "frensh");
            }
            var groupedByIndex = tokenMatches.GroupBy(x => x.Startindex)
                .OrderBy(x => x.Key)
                .ToList();
            TokenMatchViewModel lastMatch = null;
            for (int i = 0; i < groupedByIndex.Count; i++)
            {
                var bestMatch = groupedByIndex[i].OrderBy(x => x.Precedence).First();
                if (lastMatch != null && bestMatch.Startindex < lastMatch.EndIndex)
                { continue; }
                Queue.Enqueue(new TokenViewModel(bestMatch.TokenType, bestMatch.Value));
                lastMatch = bestMatch;
            }
            return Queue;
        }
    }


}
