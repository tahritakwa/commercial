using Services.Specific.PayRoll.Interfaces.ISpecificLanguage;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Globalization;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes.SpecificLanguage
{
    /// <summary>
    /// This class parses a formula, constructs a binary tree of mathematical operations, and computes them.
    /// If the formula is badly formed syntactically, an exception of type InvalidFormulaFormatException is propagated.
    /// Else the result of the calculation of the formula is returned
    /// </summary>
    public class ServiceCalculator : IServiceCalculator
    {
        private readonly static CultureInfo frCulture = new CultureInfo("fr-FR", false);
        public ServiceCalculator()
        {

        }

        /// <summary>
        /// Execute the mathematical expression in the queue
        /// <param name="queue"></param>
        /// Invokes the lexical analyzer, which will return an instance of data structure file, 
        /// then performs the parsing of this file, which will return a tree that will be executed.
        /// </summary>
        /// <returns></returns>
        public double Excecute(Queue<TokenViewModel> Expression)
        {
            if (Expression.Count != NumberConstant.Zero)
            {
                OperationTreeViewModel Parser = AnalyzeSyntactic(Expression);
                return Execution(Parser);
            }
            return 0.0;
        }

        /// <summary>
        /// Proceed by reduction of the tree: either the node is a number, return this number in a Substree without son (left = null and right = null),
        /// or the node is an operator, apply it on both children.
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        private double Execution(OperationTreeViewModel Tree)
        {
            if (Tree.Left != null && Tree.Right != null)
            {
                double a = Execution(Tree.Left);
                double b = Execution(Tree.Right);
                switch (Tree.Op.TokenType)
                {
                    case TokenTypeEnumerator.Addition: return a + b;
                    case TokenTypeEnumerator.Substraction: return a - b;
                    case TokenTypeEnumerator.Multiplication: return a * b;
                    case TokenTypeEnumerator.Division: return a / b;
                    default: throw new CustomException(customStatusCode: CustomStatusCode.EXECUTION_ERROR);
                }
            }
            else
            {
                var number = Tree.Op.Value.Replace(".", ",");
                return double.Parse(number, frCulture);
            }
        }

        /// <summary>
        /// The syntactic analyzer oh the mathematical expression, work with the the Lexical analyzer return value
        /// </summary>
        /// <param name="queue"></param>
        /// To build the tree, the method takes as input an instance of the Queue data structure. 
        /// She will scroll through the elements to build the tree. When building this tree, the highest priority operators, 
        /// such as multiplication and division, will be placed at the lowest level of the tree. While the lowest priority operators 
        /// such as the addition operator and the subtraction operator will be placed at the top of the tree.
        /// So when calculating the tree, the path of the tree will be from the innermost level to the top.
        /// The BNF on which this code is based is as follows
        /// OperationLow ::= OperationHigh(('+'|'-')OperationHigh)*
        /// OperationHigh ::= OperationParentheses(('*'|'/')OperationParentheses)*
        /// OperationParentheses ::= ('('OperationLow')')|num
        /// num ::= ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')+
        /// <returns></returns>
        public OperationTreeViewModel AnalyzeSyntactic(Queue<TokenViewModel> Queue)
        {
            return OperationLow(Queue);
        }

        /// <summary>
        /// The OperationLow function takes the lexer (the queue) argument, processes the OperationHigh (which returns a binary
        /// tree that we call "left"),  and matches the rest of the lexer. Invoke the ConstructOperationLowOperationTreeViewModel method  with the "left" OperationTreeViewModel and the rest of lexer
        /// </summary>
        /// <param name="queue"></param>
        /// <returns></returns>
        private OperationTreeViewModel OperationLow(Queue<TokenViewModel> Queue)
        {
            OperationTreeViewModel Left = OperationHigh(Queue);
            return ConstructOperationLowOperationTreeViewModel(Left, Queue);
        }

        /// <summary>
        /// Checks if there is a weak operator that comes next, and that the rest of the lexer checks the OperationHigh rule(binary tree "right"),
        /// return a binary tree consisting of the operator in node , of "left" for the left branch and of "right" for the right branch, 
        /// then one begins again(recall of the function ConstructOperationLowOperationTreeViewModel until the following tokens no longer respect 
        /// the pattern + || - of the method ConstructOperationLowOperationTreeViewModel
        /// </summary>
        /// <param name="s"></param>
        /// <param name="queue"></param>
        /// <returns></returns>
        private OperationTreeViewModel ConstructOperationLowOperationTreeViewModel(OperationTreeViewModel Tree, Queue<TokenViewModel> Queue)
        {
            if (Queue.Count != NumberConstant.Zero)
            {
                TokenViewModel Op = Queue.Peek();
                if (Op.TokenType == TokenTypeEnumerator.Addition || Op.TokenType == TokenTypeEnumerator.Substraction)
                {
                    Op = Queue.Dequeue();
                    OperationTreeViewModel right = OperationHigh(Queue);
                    OperationTreeViewModel sTree = new OperationTreeViewModel(Tree, Op, right);
                    return ConstructOperationLowOperationTreeViewModel(sTree, Queue);
                }
                else if(Op.TokenType == TokenTypeEnumerator.Number)
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
        /// The OperationHigh function takes the lexer (the queue) argument, processes the OperationParentheses (which returns a terminal OperationTreeViewModel
        /// construct with the number at the top of the list or construct a new queue daughter and submitted it to OperationLow method because it is the basic operation for triggering any blocking.
        /// By after, matches the rest of the lexer. Invoke the ConstructOperationHighOperationTreeViewModel method with the "left" OperationTreeViewModel and the rest of lexer
        /// </summary>
        /// <param name="queue"></param>
        /// <returns></returns>
        private OperationTreeViewModel OperationHigh(Queue<TokenViewModel> Queue)
        {
            OperationTreeViewModel Left = OperationParentheses(Queue);
            return ConstructOperationHighOperationTreeViewModel(Left, Queue);
        }

        /// <summary>
        /// Check if there is a strong operator at the head of the queue, and the rest of the lexer checks the OperationParentheses rule that returns 
        /// a binary tree consisting of the operator in the root node, or builds other OperationTreeViewModels. then we start again(recall of the ConstructOperationLowOperationTreeViewModel function
        /// until the following tokens no longer respect the reason * || / the ConstructOperationLowOperationTreeViewModel method
        /// </summary>
        /// <param name="Tree"></param>
        /// <param name="Queue"></param>
        /// <returns></returns>
        private OperationTreeViewModel ConstructOperationHighOperationTreeViewModel(OperationTreeViewModel Tree, Queue<TokenViewModel> Queue)
        {
            if (Queue.Count != NumberConstant.Zero)
            {
                TokenViewModel Op = Queue.Peek();
                if (Op.TokenType == TokenTypeEnumerator.Multiplication || Op.TokenType == TokenTypeEnumerator.Division)
                {
                    Op = Queue.Dequeue();
                    OperationTreeViewModel Right = OperationParentheses(Queue);
                    OperationTreeViewModel SubTree = new OperationTreeViewModel(Tree, Op, Right);
                    return ConstructOperationHighOperationTreeViewModel(SubTree, Queue);
                }
                else if(Op.TokenType == TokenTypeEnumerator.CloseParenthesis || Op.TokenType == TokenTypeEnumerator.OpenParenthesis || Op.TokenType == TokenTypeEnumerator.Number)
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
        /// This method checks whether the item at the front of the queue is an opening parenthesis. 
        /// If so, he walks the rest of the queue building a new queue. It stops at the closing parenthesis corresponding to that previously opened. 
        /// Operation: With each opening parenthesis inserted into the new list, it increments a pthDepth counter and decrements it by each closing parenthesis encountered. 
        /// As soon as this counter is equal to 0 (the corresponding closing parenthesis is found), it stops the threading.
        /// The resulting new queue will be submitted to OperationLow as it is the basic operation for triggering any blocking.
        /// On the other hand (else), if the item at the top of the list is not an opening parenthesis, the method retrieves the number at the top of the list 
        /// and builds a terminal OperationTreeViewModel whose value is op the number met, the left and right OperationTreeViewModels set to null.
        /// </summary>
        /// <param name="Queue"></param>
        /// <returns></returns>
        private OperationTreeViewModel OperationParentheses(Queue<TokenViewModel> Queue)
        {
            if (Queue.Count != NumberConstant.Zero)
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
                else if((Queue.Peek().TokenType == TokenTypeEnumerator.Number) || (Queue.Peek().TokenType == TokenTypeEnumerator.Reference) || 
                    (Queue.Peek().TokenType == TokenTypeEnumerator.Formalism) || (Queue.Peek().TokenType == TokenTypeEnumerator.PrimeCotisable) || 
                    (Queue.Peek().TokenType == TokenTypeEnumerator.PrimeImposable) || (Queue.Peek().TokenType == TokenTypeEnumerator.TotalPrime))
                {
                    return new OperationTreeViewModel(Queue.Dequeue());
                }
                else
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
                }

            }
            else
            {
                throw new CustomException(customStatusCode: CustomStatusCode.SYNTACTIC_ERROR);
            }
        }
    }
}
