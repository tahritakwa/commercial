using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Settings.Exceptions;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes.SpecificLanguage
{
    public class SyntacticAnalyzer : ISyntacticAnalyzer
    {
        private readonly IServiceCalculator _serviceCalculator;
        private readonly IServiceBooleanExpression _serviceBooleanExpression;

        public SyntacticAnalyzer(IServiceCalculator serviceCalculator, IServiceBooleanExpression serviceBooleanExpression)
        {
            _serviceCalculator = serviceCalculator;
            _serviceBooleanExpression = serviceBooleanExpression;
        }

        /// <summary>
        /// This  method is recursive. The role of this method are:
        /// 1- Syntax validation
        /// 2- Creation sub tree expression 
        /// </summary>
        /// <param name="expression">Expression</param>
        /// <returns> Exception if there are one or more error in expression 
        /// else  return Tree expression</returns>
        public SubTreeViewModel Parse(Queue<TokenViewModel> expression)
        {
            if (expression == null || expression.Count == NumberConstant.Zero)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
            }
            TokenViewModel firstElement = expression.Peek();
            if (firstElement != null && firstElement.TokenType == TokenTypeEnumerator.If)
            {
                SubTreeViewModel tree = new SubTreeViewModel
                {
                    Op = ExtractCondition(expression)
                };
                SubTreeViewModel booleanTree = _serviceBooleanExpression.AnalyzeSyntactic(new Queue<TokenViewModel>(tree.Op));
                if (booleanTree.Op == null)
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }
                TokenTypeEnumerator elementToCheck = expression.Peek().TokenType;
                if (elementToCheck == TokenTypeEnumerator.Reference || elementToCheck == TokenTypeEnumerator.Formalism ||
                    elementToCheck == TokenTypeEnumerator.Number || elementToCheck == TokenTypeEnumerator.PrimeCotisable ||
                    elementToCheck == TokenTypeEnumerator.PrimeImposable || elementToCheck == TokenTypeEnumerator.TotalPrime ||
                    elementToCheck == TokenTypeEnumerator.OpenParenthesis)
                {

                    tree.Left = Parse(expression);
                    firstElement = expression.Peek();
                    if (firstElement.TokenType == TokenTypeEnumerator.EndIf)
                    {
                        expression.Dequeue();
                        return tree;
                    }
                    if (firstElement.TokenType == TokenTypeEnumerator.Else)
                    {
                        expression.Dequeue();
                        tree.Right = Parse(expression);
                        expression.Dequeue();
                    }
                    return tree;
                }
                else
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }

            }
            else
            {
                Queue<TokenViewModel> operation = ExtractExpression(expression);
                OperationTreeViewModel operationTree = _serviceCalculator.AnalyzeSyntactic(new Queue<TokenViewModel>(operation));
                if (operationTree == null || operationTree.Op == null)
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }
                else
                {
                    return new SubTreeViewModel(operation);
                }
            }
        }

        /// <summary>
        /// Extract the condition expression 
        /// The condition must be between two parenthesis else a syntactic expression will be generated
        /// a tab is used to get the first and the last element of the queue 
        /// </summary>
        /// <param name="expression">Expression</param>
        /// <returns> queue of expressions </returns>
        private static Queue<TokenViewModel> ExtractCondition(Queue<TokenViewModel> expression)
        {
            Queue<TokenViewModel> newQueue = new Queue<TokenViewModel>();
            expression.Dequeue();
            if (expression.Count == NumberConstant.Zero)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
            }

            while (expression.Count != NumberConstant.Zero && expression.Peek().TokenType != TokenTypeEnumerator.Then)
            {

                newQueue.Enqueue(expression.Dequeue());    
            }
            TokenViewModel[] tabQueue = newQueue.ToArray();
            if (tabQueue[NumberConstant.Zero].TokenType == TokenTypeEnumerator.OpenParenthesis && tabQueue[tabQueue.Length - 1].TokenType == TokenTypeEnumerator.CloseParenthesis)
            {
                
                expression.Dequeue();
                return newQueue;
            }
            else
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
            }    
        }
        /// <summary>
        /// Decompose an expression into expressions
        /// </summary>
        /// <param name="expression">expression</param>
        /// <returns> queue of expressions </returns>
        private static Queue<TokenViewModel> ExtractExpression(Queue<TokenViewModel> expression)
        {
            Queue<TokenViewModel> newQueue = new Queue<TokenViewModel>();
            while (expression.Count != NumberConstant.Zero && expression.Peek().TokenType != TokenTypeEnumerator.Else && expression.Peek().TokenType != TokenTypeEnumerator.EndIf)
            {
                newQueue.Enqueue(expression.Dequeue());
            }
            return newQueue;
        }
    }
}

