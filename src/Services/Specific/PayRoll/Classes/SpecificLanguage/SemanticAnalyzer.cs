using Microsoft.Extensions.Caching.Memory;
using Services.Specific.Administration.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes.SpecificLanguage
{
    public class SemanticAnalyzer : ISemanticAnalyzer
    {
        private readonly IServiceCalculator _serviceCalculator;
        private readonly IServiceBooleanExpression _serviceBooleanExpression;
        private readonly IRecuperateValueFromReference _recuperateValueFromReference;
        private readonly IServiceRuleUniqueReference _serviceRuleUniqueReference;
        private readonly IServiceConstantValue _serviceConstantValue;
        private readonly IServiceConstantRate _serviceConstantRate;
        private readonly IServiceVariable _serviceVariable;
        private readonly ILexicalAnalyzer _lexicalAnalyzer;
        private readonly ISyntacticAnalyzer _syntacticAnalyzer;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServicePeriod _servicePeriod;
        private readonly IMemoryCache _memoryCache;
        private IDictionary<string, Dictionary<string, double>> Buffer;

        private readonly static CultureInfo frCulture = new CultureInfo("fr-FR", false);

        public SemanticAnalyzer(IServiceCompany serviceCompany, IServiceCalculator serviceCalculator, IServiceBooleanExpression serviceBooleanExpression,
            IServicePeriod servicePeriod,
            IRecuperateValueFromReference recuperateValueFromReference, IServiceRuleUniqueReference serviceRuleUniqueReference,
            IServiceConstantValue serviceConstantValue, IServiceConstantRate serviceConstantRate, IServiceVariable serviceVariable,
            ILexicalAnalyzer lexicalAnalyzer, ISyntacticAnalyzer syntacticAnalyzer, IMemoryCache memoryCache)
        {
            _serviceCompany = serviceCompany;
            _serviceCalculator = serviceCalculator;
            _serviceBooleanExpression = serviceBooleanExpression;
            _recuperateValueFromReference = recuperateValueFromReference;
            _serviceRuleUniqueReference = serviceRuleUniqueReference;
            _serviceConstantValue = serviceConstantValue;
            _serviceConstantRate = serviceConstantRate;
            _serviceVariable = serviceVariable;
            _servicePeriod = servicePeriod;
            _lexicalAnalyzer = lexicalAnalyzer;
            _syntacticAnalyzer = syntacticAnalyzer;
            _memoryCache = memoryCache;
        }

        public void InitializeBuffer()
        {
            Buffer = new Dictionary<string, Dictionary<string, double>>();
        }

        public void ClearBuffer()
        {
            Buffer.Clear();
        }
        public void SetValueInBuffer(SalaryRuleViewModel salaryRuleViewModel)
        {
            Buffer[salaryRuleViewModel.Reference] = new Dictionary<string, double>
            {
                [PayRollConstant.Salary] = salaryRuleViewModel.Rules[PayRollConstant.Salary]
            };
            if (Buffer[salaryRuleViewModel.Reference].ContainsKey(PayRollConstant.Employer))
            {
                Buffer[salaryRuleViewModel.Reference][PayRollConstant.Employer] = salaryRuleViewModel.Rules[PayRollConstant.Employer];
            }
        }

        public void SetValueInBuffer(string key, double value)
        {
            Buffer[key] = new Dictionary<string, double>
            {
                [PayRollConstant.Salary] = value
            };
        }

        public Dictionary<string, double> Execute(SubTreeViewModel tree, int idEmployee, int idContract, DateTime month, SalaryRuleViewModel salaryRule, double numberDaysWorked)
        {
            if (salaryRule != null)
            {
                switch (salaryRule.RuleCategory)
                {
                    case (int)RuleCategoryEnumerator.Patronal:
                        return ExcecutePatronalCategoryRule(tree, idEmployee, idContract, month, salaryRule, numberDaysWorked);
                    case (int)RuleCategoryEnumerator.Both:
                        return ExcecuteBothCategoryRule(tree, idEmployee, idContract, month, salaryRule, numberDaysWorked);
                    default:
                        return ExcecuteSalaryCategoryRule(tree, idEmployee, idContract, month, salaryRule, numberDaysWorked);
                }
            }
            throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
        }


        public Dictionary<string, double> ExcecuteSalaryCategoryRule(SubTreeViewModel Tree, int IdEmployee, int IdContract, DateTime month, SalaryRuleViewModel salaryRule, double NumberDaysWorked)
        {
            if (salaryRule == null || Tree == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            if (Tree.HasChild())
            {
                for (int i = Tree.Op.Count; i > 0; i--)
                {
                    TokenViewModel Head = Tree.Op.Dequeue();
                    if (Head.TokenType == TokenTypeEnumerator.Formalism || Head.TokenType == TokenTypeEnumerator.Reference)
                    {
                        if (Buffer.ContainsKey(Head.Value))
                        {
                            Tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Convert.ToString(Buffer[Head.Value][PayRollConstant.Salary], frCulture)));
                        }
                        else
                        {
                            Dictionary<string, double> ExpressionResult = RuleAndValuesInArithmeticExpression(Head, IdEmployee, IdContract, month, NumberDaysWorked);
                            Tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Convert.ToString(ExpressionResult[PayRollConstant.Salary], frCulture)));
                        }
                    }
                    else
                    {
                        Tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Head.Value));
                    }
                }
                bool result = _serviceBooleanExpression.Excecute(Tree.Op);
                Dictionary<string, double> SubTree = result ? ExcecuteSalaryCategoryRule(Tree.Left, IdEmployee, IdContract, month, salaryRule, NumberDaysWorked)
                    : ExcecuteSalaryCategoryRule(Tree.Right, IdEmployee, IdContract, month, salaryRule, NumberDaysWorked);
                return SubTree;
            }
            else
            {
                Queue<TokenViewModel> SalaryRule = new Queue<TokenViewModel>();
                Dictionary<string, double> Result = new Dictionary<string, double>();
                for (int i = Tree.Op.Count; i > 0; i--)
                {
                    TokenViewModel tokenViewModel = Tree.Op.Dequeue();
                    if (tokenViewModel.TokenType == TokenTypeEnumerator.Formalism || tokenViewModel.TokenType == TokenTypeEnumerator.Reference
                        || tokenViewModel.TokenType == TokenTypeEnumerator.PrimeCotisable || tokenViewModel.TokenType == TokenTypeEnumerator.PrimeImposable
                        || tokenViewModel.TokenType == TokenTypeEnumerator.TotalPrime)
                    {
                        if (Buffer.ContainsKey(tokenViewModel.Value))
                        {
                            Result[PayRollConstant.Salary] = Buffer[tokenViewModel.Value][PayRollConstant.Salary];
                            SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                        }
                        else
                        {
                            Result = RuleAndValuesInArithmeticExpression(tokenViewModel, IdEmployee, IdContract, month, NumberDaysWorked);
                            SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                        }
                    }
                    else
                    {
                        SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, tokenViewModel.Value));
                    }
                }
                Result[PayRollConstant.Salary] = _serviceCalculator.Excecute(SalaryRule);
                if (!salaryRule.IsBonus && !salaryRule.IsBenefitInKind && !salaryRule.IsLoan && salaryRule.DependNumberDaysWorked)
                {
                    Result[PayRollConstant.Salary] = Result[PayRollConstant.Salary] * NumberDaysWorked / _servicePeriod.NumberOfDaysWorkedByCompanyInMonth(month.FirstDateOfMonth());
                    Buffer[salaryRule.Reference] = new Dictionary<string, double>
                    {
                        [PayRollConstant.Salary] = Result[PayRollConstant.Salary]
                    };
                }
                else
                {
                    if (string.Compare(salaryRule.Reference, "NETANNUEL", StringComparison.OrdinalIgnoreCase) == NumberConstant.Zero)
                    {
                        Result[PayRollConstant.Salary] = Math.Ceiling(Result[PayRollConstant.Salary]);
                    }
                    Buffer[salaryRule.Reference] = new Dictionary<string, double>
                    {
                        [PayRollConstant.Salary] = Result[PayRollConstant.Salary]
                    };
                }
                return Result;
            }
        }


        public Dictionary<string, double> ExcecutePatronalCategoryRule(SubTreeViewModel tree, int idEmployee, int idContract, DateTime month, SalaryRuleViewModel salaryRule, double numberDaysWorked)
        {
            if (salaryRule == null || tree == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            if (tree.HasChild())
            {
                for (int i = tree.Op.Count; i > 0; i--)
                {
                    TokenViewModel Head = tree.Op.Dequeue();
                    if (Head.TokenType == TokenTypeEnumerator.Formalism || Head.TokenType == TokenTypeEnumerator.Reference)
                    {
                        if (Buffer.ContainsKey(Head.Value))
                        {
                            tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Convert.ToString(Buffer[Head.Value][PayRollConstant.Salary], frCulture)));
                        }
                        else
                        {
                            Dictionary<string, double> ExpressionResult = RuleAndValuesInArithmeticExpression(Head, idEmployee, idContract, month, numberDaysWorked);
                            tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Convert.ToString(ExpressionResult[PayRollConstant.Employer], frCulture)));
                        }
                    }
                    else
                    {
                        tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Head.Value));
                    }
                }
                Boolean result = _serviceBooleanExpression.Excecute(tree.Op);
                Dictionary<string, double> SubTree = result ? ExcecutePatronalCategoryRule(tree.Left, idEmployee, idContract, month, salaryRule, numberDaysWorked)
                    : ExcecutePatronalCategoryRule(tree.Right, idEmployee, idContract, month, salaryRule, numberDaysWorked);
                return SubTree;
            }
            else
            {
                Queue<TokenViewModel> employerRule = new Queue<TokenViewModel>();
                Dictionary<string, double> Result = new Dictionary<string, double>();
                for (int i = tree.Op.Count; i > 0; i--)
                {
                    TokenViewModel tokenViewModel = tree.Op.Dequeue();
                    if (tokenViewModel.TokenType == TokenTypeEnumerator.Formalism || tokenViewModel.TokenType == TokenTypeEnumerator.Reference)
                    {
                        if (Buffer.ContainsKey(tokenViewModel.Value))
                        {
                            Result[PayRollConstant.Employer] = Buffer[tokenViewModel.Value][PayRollConstant.Salary];
                            employerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Employer].ToString(frCulture)));
                        }
                        else
                        {
                            Result = RuleAndValuesInArithmeticExpression(tokenViewModel, idEmployee, idContract, month, numberDaysWorked);
                            employerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Employer].ToString(frCulture)));
                        }
                    }
                    else
                    {
                        employerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, tokenViewModel.Value));
                    }
                }
                Result[PayRollConstant.Employer] = _serviceCalculator.Excecute(employerRule);
                Buffer[salaryRule.Reference] = new Dictionary<string, double>
                {
                    [PayRollConstant.Employer] = Result[PayRollConstant.Employer]
                };
                return Result;
            }
        }


        public Dictionary<string, double> ExcecuteBothCategoryRule(SubTreeViewModel Tree, int IdEmployee, int IdContract, DateTime month, SalaryRuleViewModel salaryRule, double NumberDaysWorked)
        {
            if (salaryRule == null || Tree == null)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
            if (Tree.HasChild())
            {
                for (int i = Tree.Op.Count; i > 0; i--)
                {
                    TokenViewModel Head = Tree.Op.Dequeue();
                    if (Head.TokenType == TokenTypeEnumerator.Formalism || Head.TokenType == TokenTypeEnumerator.Reference)
                    {
                        if (Buffer.ContainsKey(Head.Value))
                        {
                            Tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Convert.ToString(Buffer[Head.Value][PayRollConstant.Salary], frCulture)));
                        }
                        else
                        {
                            Dictionary<string, double> ExpressionResult = RuleAndValuesInArithmeticExpression(Head, IdEmployee, IdContract, month, NumberDaysWorked);
                            Tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Convert.ToString(ExpressionResult[PayRollConstant.Salary], frCulture)));
                        }
                    }
                    else
                    {
                        Tree.Op.Enqueue(new TokenViewModel(Head.TokenType, Head.Value));
                    }
                }
                Boolean result = _serviceBooleanExpression.Excecute(Tree.Op);
                Dictionary<string, double> SubTree = result ? ExcecuteBothCategoryRule(Tree.Left, IdEmployee, IdContract, month, salaryRule, NumberDaysWorked)
                    : ExcecuteBothCategoryRule(Tree.Right, IdEmployee, IdContract, month, salaryRule, NumberDaysWorked);
                return SubTree;
            }
            else
            {
                Queue<TokenViewModel> SalaryRule = new Queue<TokenViewModel>();
                Queue<TokenViewModel> EmployerRule = new Queue<TokenViewModel>();
                Dictionary<string, double> Result = new Dictionary<string, double>();
                for (int i = Tree.Op.Count; i > 0; i--)
                {
                    TokenViewModel tokenViewModel = Tree.Op.Dequeue();
                    if (tokenViewModel.TokenType == TokenTypeEnumerator.Formalism || tokenViewModel.TokenType == TokenTypeEnumerator.Reference)
                    {
                        if (Buffer.ContainsKey(tokenViewModel.Value))
                        {
                            if (Buffer[tokenViewModel.Value].ContainsKey(PayRollConstant.Employer))
                            {
                                Result[PayRollConstant.Salary] = Buffer[tokenViewModel.Value][PayRollConstant.Salary];
                                Result[PayRollConstant.Employer] = Buffer[tokenViewModel.Value][PayRollConstant.Employer];
                                SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                                EmployerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Employer].ToString(frCulture)));
                            }
                            else
                            {
                                Result[PayRollConstant.Salary] = Buffer[tokenViewModel.Value][PayRollConstant.Salary];
                                SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                                EmployerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                            }
                        }
                        else
                        {
                            Result = RuleAndValuesInArithmeticExpression(tokenViewModel, IdEmployee, IdContract, month, NumberDaysWorked);
                            if (Result.ContainsKey(PayRollConstant.Employer))
                            {
                                SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                                EmployerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Employer].ToString(frCulture)));
                            }
                            else
                            {
                                SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                                EmployerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, Result[PayRollConstant.Salary].ToString(frCulture)));
                            }
                        }
                    }
                    else
                    {
                        SalaryRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, tokenViewModel.Value));
                        EmployerRule.Enqueue(new TokenViewModel(tokenViewModel.TokenType, tokenViewModel.Value));
                    }
                }
                Result[PayRollConstant.Salary] = _serviceCalculator.Excecute(SalaryRule);
                Result[PayRollConstant.Employer] = _serviceCalculator.Excecute(EmployerRule);
                Buffer[salaryRule.Reference] = new Dictionary<string, double>
                {
                    [PayRollConstant.Salary] = Result[PayRollConstant.Salary],
                    [PayRollConstant.Employer] = Result[PayRollConstant.Employer]
                };
                return Result;
            }
        }



        public dynamic RuleAndValuesInBooleanExpression(TokenViewModel bestMatch, int IdEmployee, int IdContract, DateTime month, double NumberDaysWorked)
        {
            dynamic Value = 0.0;
            if (bestMatch.TokenType == TokenTypeEnumerator.Formalism)
            {
                Value = _recuperateValueFromReference.GetSingleFormalismValue(IdEmployee, IdContract, bestMatch.Value);
                Buffer[bestMatch.Value] = Value;
                return Value;
            }
            else
            {
                RuleUniqueReferenceViewModel ruleUniqueReference = _serviceRuleUniqueReference.GetModel(p => p.Reference == bestMatch.Value);
                switch (ruleUniqueReference.Type)
                {
                    case (int)ExpressionTypeViewModel.ExpressionType.ConstantValue:
                        Value = _serviceConstantValue.ReplaceConstantValue(ruleUniqueReference.Id, month);
                        break;
                    case (int)ExpressionTypeViewModel.ExpressionType.ConstantRate:
                        IDictionary<string, dynamic> refParamtrs = new Dictionary<string, dynamic>
                            {
                                { Constants.BAD_REFERENCE, bestMatch.Value }
                            };
                        throw new CustomException(customStatusCode: CustomStatusCode.LexicalError, paramtrs: refParamtrs);
                    case (int)ExpressionTypeViewModel.ExpressionType.Variable:
                        SalaryRuleViewModel salaryRule = new SalaryRuleViewModel
                        {
                            Reference = ruleUniqueReference.Reference,
                            Rule = _serviceVariable.GetModel(p => p.IdRuleUniqueReference == ruleUniqueReference.Id).Formule
                        };
                        Queue<TokenViewModel> tokens = _lexicalAnalyzer.LexerForExcecution(salaryRule.Rule);
                        SubTreeViewModel tree = _syntacticAnalyzer.Parse(tokens);
                        return Execute(tree, IdEmployee, IdContract, month, salaryRule, NumberDaysWorked);
                    default: break;
                }
                Buffer[bestMatch.Value] = Value;
                return Value;
            }
        }


        /// <summary>
        /// Get rule and values in arithmetic expression
        /// </summary>
        /// <param name="bestMatch"></param>
        /// <param name="IdEmployee"></param>
        /// <param name="IdContract"></param>
        /// <param name="month"></param>
        /// <param name="BulletinEndDate"></param>
        /// <param name="NumberDaysWorked"></param>
        /// <returns></returns>

        public Dictionary<string, double> RuleAndValuesInArithmeticExpression(TokenViewModel bestMatch, int IdEmployee, int IdContract, DateTime month, double NumberDaysWorked)
        {
            dynamic Value;
            if (bestMatch.TokenType == TokenTypeEnumerator.Formalism)
            {
                Value = _recuperateValueFromReference.GetSingleFormalismValue(IdEmployee, IdContract, bestMatch.Value);

                Buffer[bestMatch.Value] = new Dictionary<string, double>
                {
                    { PayRollConstant.Salary, Convert.ToDouble(Value) }
                };
                return Buffer[bestMatch.Value];
            }
            else
            {
                RuleUniqueReferenceViewModel ruleUniqueReference = _serviceRuleUniqueReference.GetModel(p => p.Reference == bestMatch.Value);
                if (ruleUniqueReference != null)
                {
                    switch (ruleUniqueReference.Type)
                    {
                        case (int)ExpressionTypeViewModel.ExpressionType.ConstantValue:
                            Value = _serviceConstantValue.ReplaceConstantValue(ruleUniqueReference.Id, month);
                            Buffer[bestMatch.Value] = new Dictionary<string, double>
                            {
                                { PayRollConstant.Salary, Value }
                            };
                            return Buffer[bestMatch.Value];
                        case (int)ExpressionTypeViewModel.ExpressionType.ConstantRate:
                            Dictionary<string, double> Result = _serviceConstantRate.ReplaceConstantRate(ruleUniqueReference.Id, month);
                            Buffer[bestMatch.Value] = Result;
                            return Buffer[bestMatch.Value];
                        case (int)ExpressionTypeViewModel.ExpressionType.Variable:
                            VariableViewModel variable = _serviceVariable.GetModelWithRelations(p => p.IdRuleUniqueReference == ruleUniqueReference.Id, p => p.VariableValidityPeriod);
                            variable.Formule = variable.VariableValidityPeriod.Where(m => m.StartDate.BeforeDateLimitIncluded(month)).OrderByDescending(m => m.StartDate).FirstOrDefault().Formule;
                            SalaryRuleViewModel salaryRule = new SalaryRuleViewModel
                            {
                                Reference = ruleUniqueReference.Reference,
                                Rule = variable.Formule
                            };
                            SubTreeViewModel treeToSave = _memoryCache.GetOrCreate(string.Concat(_serviceCompany.GetCurrentCompany().Code, PayRollConstant.Separator, variable.Reference,
                                PayRollConstant.Separator, month.Month, PayRollConstant.Separator, month.Year), entry =>
                            {
                                Queue<TokenViewModel> tokens = _lexicalAnalyzer.LexerForExcecution(salaryRule.Rule);
                                treeToSave = _syntacticAnalyzer.Parse(tokens);
                                // Here each item will be expired if it has not been accessed within the timespan provided (here we have 1 minute).
                                entry.SlidingExpiration = TimeSpan.FromMinutes(60);
                                return treeToSave;
                            });
                            SubTreeViewModel SalaryRuleTree = treeToSave.DeepCopyByExpressionTree();
                            return Execute(SalaryRuleTree, IdEmployee, IdContract, month, salaryRule, NumberDaysWorked);
                        default: throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
                    }
                }
                throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
            }
        }
    }
}
