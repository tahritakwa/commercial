using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes.SpecificLanguage
{
    public class ServiceBooleanExpression : IServiceBooleanExpression
    {
        private static readonly CultureInfo frCulture = new CultureInfo("fr-FR", false);
        private readonly IServiceCalculator _serviceCalculator;
        public ServiceBooleanExpression(IServiceCalculator serviceCalculator)
        {
            _serviceCalculator = serviceCalculator;
           

        }

        public Boolean Excecute(Queue<TokenViewModel> Expression)
        {
            if (Expression.Count != NumberConstant.Zero)
            {
                SubTreeViewModel Parser = AnalyzeSyntactic(Expression);
                return Execution(Parser);
            }
            return false;
        }


        /// <summary>
        /// In this method we have 2 cases if the length of the queue <= 2 that's mean we have If(A) or If(!A)
        /// The other case we have a whole expression. We separate the two expressions on the left and the right of the sign (>,<,...),
        /// calculate their values and continue the comparison
        /// </summary>

        private Boolean Execution(SubTreeViewModel Tree)
        {
            if (Tree.Left != null && Tree.Right != null)
            {
                bool a = Execution(Tree.Left);
                bool b = Execution(Tree.Right);
                switch (Tree.Op.Dequeue().TokenType)
                {
                    case TokenTypeEnumerator.And: return a && b;
                    case TokenTypeEnumerator.Or: return a || b;
                    default: throw new BooleanExpressionException("Invalid Expression");
                }
            }
            else
            {   if(Tree.Op.Count <= NumberConstant.Two)
                {
                    TokenViewModel Left = Tree.Op.Dequeue();
                    if (Tree.Op.Count == NumberConstant.Zero)
                    {
                        return Double.Parse(Left.Value, frCulture).Equals(NumberConstant.One);
                    }
                    else 
                    {
                        return Double.Parse(Tree.Op.Dequeue().Value, frCulture).Equals(NumberConstant.Zero);
                    }
                }
                else
                {
                    Queue<TokenViewModel> newQueue = Tree.Op;
                    Queue<TokenViewModel> LeftQueue = new Queue<TokenViewModel>();
                    Queue<TokenViewModel> RightQueue = new Queue<TokenViewModel>();


                    RegularExpressions regularExpressions = new RegularExpressions();
                    while (newQueue.Count != NumberConstant.Zero && !regularExpressions.IsMatchType(newQueue.Peek().TokenType, regularExpressions._comparisonOperators))
                    {
                        LeftQueue.Enqueue(newQueue.Dequeue());
                    }
                    TokenViewModel Op = newQueue.Dequeue();
                    while(newQueue.Count != NumberConstant.Zero)
                    {
                        RightQueue.Enqueue(newQueue.Dequeue());
                    }
                    double LeftValue = _serviceCalculator.Excecute(LeftQueue);
                    double RightValue = _serviceCalculator.Excecute(RightQueue);
                    switch (Op.TokenType)
                    {
                        case TokenTypeEnumerator.Lower: return LeftValue < RightValue;
                        case TokenTypeEnumerator.LowerOrEqual: return LeftValue <= RightValue;
                        case TokenTypeEnumerator.Equals: return LeftValue == RightValue;
                        case TokenTypeEnumerator.Higher: return LeftValue > RightValue;
                        case TokenTypeEnumerator.HigherOrEqual: return LeftValue >= RightValue;
                        case TokenTypeEnumerator.NotEquals: return LeftValue == RightValue;
                        default: throw new BooleanExpressionException("Invalid Expression");
                    }
                }
            }
        }



        public SubTreeViewModel AnalyzeSyntactic(Queue<TokenViewModel> Queue)
        {   
            return OperationLow(Queue);
        }



        private SubTreeViewModel OperationLow(Queue<TokenViewModel> Queue)
        {
            SubTreeViewModel Left = OperationHigh(Queue);
            return ConstructOperationLowSubTreeViewModel(Left, Queue);
        }



        private SubTreeViewModel ConstructOperationLowSubTreeViewModel(SubTreeViewModel Tree, Queue<TokenViewModel> Queue)
        {
            if (Queue.Count != NumberConstant.Zero)
            {
                if (Queue.Peek().TokenType == TokenTypeEnumerator.Or)
                {
                    Queue<TokenViewModel> Operator = new Queue<TokenViewModel>();
                    Operator.Enqueue(Queue.Dequeue());
                    SubTreeViewModel right = OperationHigh(Queue);
                    SubTreeViewModel sTree = new SubTreeViewModel(Tree, Operator, right);
                    return ConstructOperationLowSubTreeViewModel(sTree, Queue);
                }
                else if (Queue.Peek().TokenType == TokenTypeEnumerator.Number)
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }
                else
                {
                    return Tree;
                }
            }
            else
            {
                return Tree;
            }
        }





        /// <summary>
        /// In this method we added the ValidateBooleanExpression to ensure the validation 
        /// according to the lenghth of Left.Op because if we have If(A) it passes
        /// else Left must not pass without syntactic validation
        /// </summary>
        private SubTreeViewModel OperationHigh(Queue<TokenViewModel> Queue)
        {
            SubTreeViewModel Left = OperationParentheses(Queue);
            if(Left.Op.Count >= NumberConstant.Two)
            {
                SubTreeViewModel booleanValidationTree = ValidateBooleanExpression(Left);
                return ConstructOperationHighSubTreeViewModel(booleanValidationTree, Queue);
            }
            
            
            return ConstructOperationHighSubTreeViewModel(Left, Queue);
        }



        private SubTreeViewModel ConstructOperationHighSubTreeViewModel(SubTreeViewModel Tree, Queue<TokenViewModel> Queue)
        {
            if (Queue.Count != NumberConstant.Zero)
            {
                if (Queue.Peek().TokenType == TokenTypeEnumerator.And)
                {
                    Queue<TokenViewModel> Operator = new Queue<TokenViewModel>();
                    Operator.Enqueue(Queue.Dequeue());
                    SubTreeViewModel Right = OperationParentheses(Queue);
                    SubTreeViewModel SubTree = new SubTreeViewModel(Tree, Operator, Right);
                    return ConstructOperationHighSubTreeViewModel(SubTree, Queue);
                }
                else if (Queue.Peek().TokenType == TokenTypeEnumerator.CloseParenthesis || Queue.Peek().TokenType == TokenTypeEnumerator.OpenParenthesis || Queue.Peek().TokenType == TokenTypeEnumerator.Number)
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }
                else
                {
                    return Tree;
                }
            }
            else
            {
                return Tree;
            }
        }

        /// <summary>
        /// This method is responsible for the syntactic validation inside the boolean expression.
        /// The first case is when we have If(!A) ; the first element should be "!" else this will generate an exception.
        /// In the other case we will generate 2 queues LeftQueue and RightQueue they will contain the 
        /// expressions that exist at the left and the right of the sign <,>,>=,...
        /// And the 2 queues should pass by the ServiceCalculator
        /// </summary>
        private SubTreeViewModel ValidateBooleanExpression(SubTreeViewModel Tree)
        {
            Queue<TokenViewModel> LeftQueue = new Queue<TokenViewModel>();
            Queue<TokenViewModel> RightQueue = new Queue<TokenViewModel>();
            Queue<TokenViewModel> newQueue = new Queue<TokenViewModel>();

            if (Tree.Op.Count == NumberConstant.Two)
            {
                
                if (Tree.Op.Peek().TokenType == TokenTypeEnumerator.Not)
                {
                    return Tree;
                }
                else
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }
            }
            RegularExpressions regularExpressions = new RegularExpressions();       
            while (Tree.Op.Count != NumberConstant.Zero && !regularExpressions.IsMatchType(Tree.Op.Peek().TokenType, regularExpressions._comparisonOperators))
            {
                LeftQueue.Enqueue(Tree.Op.Dequeue());
            }
            if (Tree.Op.Count == NumberConstant.Zero)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
            }
            TokenViewModel Op = Tree.Op.Dequeue();
            while (Tree.Op.Count != NumberConstant.Zero)
            {
                RightQueue.Enqueue(Tree.Op.Dequeue());
            }
            _serviceCalculator.AnalyzeSyntactic(new Queue<TokenViewModel>(LeftQueue));
            _serviceCalculator.AnalyzeSyntactic(new Queue<TokenViewModel>(RightQueue));
            while (LeftQueue.Count != NumberConstant.Zero)
            {
                newQueue.Enqueue(LeftQueue.Dequeue());
            }
            newQueue.Enqueue(Op);
            while (RightQueue.Count != NumberConstant.Zero)
            {
                newQueue.Enqueue(RightQueue.Dequeue());
            }
            SubTreeViewModel tree = new SubTreeViewModel(newQueue);
            return tree;

        }

        private SubTreeViewModel OperationParentheses(Queue<TokenViewModel> Queue)
        {
            Queue<TokenViewModel> NewQueue = new Queue<TokenViewModel>();
            if (Queue.Peek().TokenType == TokenTypeEnumerator.OpenParenthesis)
            {
                TokenViewModel Scroll;
                Queue.Dequeue();
                int PthDepth = 1;
                while (PthDepth > NumberConstant.Zero)
                {
                    if (Queue.Count != NumberConstant.Zero)
                    {
                        Scroll = Queue.Dequeue();
                        if (Scroll.TokenType == TokenTypeEnumerator.OpenParenthesis)
                        {
                            PthDepth++;
                        }
                        else
                        {
                            if (Scroll.TokenType == TokenTypeEnumerator.CloseParenthesis)
                            {
                                PthDepth--;
                            }
                        }
                        if (PthDepth != NumberConstant.Zero)
                        {
                            NewQueue.Enqueue(Scroll);
                        }
                    }
                    else
                    {
                        throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                    }
                }
                return OperationLow(NewQueue);
            }
            else
            {
                Queue<TokenViewModel> Expression = new Queue<TokenViewModel>();
                while (Queue.Count != NumberConstant.Zero && Queue.Peek().TokenType != TokenTypeEnumerator.CloseParenthesis)
                {
                    Expression.Enqueue(Queue.Dequeue());
                }
                return new SubTreeViewModel(Expression);
            }
        }
    }
}