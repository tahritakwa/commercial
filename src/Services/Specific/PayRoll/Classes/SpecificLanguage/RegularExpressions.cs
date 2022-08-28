using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.PayrollEnumerators;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Classes.SpecificLanguage
{
    public sealed class RegularExpressions
    {
        public readonly List<TokenDefinitionViewModel> _frenshKeywords;
        public readonly List<TokenDefinitionViewModel> _englishKeywords;
        public readonly List<TokenDefinitionViewModel> _comparisonOperators;

        private static RegularExpressions instance = null;
        private static readonly object padlock = new object();

        public RegularExpressions()
        {
            if (_frenshKeywords is null)
            {
                _frenshKeywords = new List<TokenDefinitionViewModel>
                    {   new TokenDefinitionViewModel(TokenTypeEnumerator.If, @"\bSi\b", 2),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Then, @"\bAlors\b", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Else, @"\bSinon\b", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.EndIf, @"\bFinSi\b", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.True, @"\bVrai\b", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.False, @"\bFaux\b", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Not, "!", 2),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Equals, "=", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.NotEquals, "<>|!=", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.HigherOrEqual, ">=", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Higher, ">", 2),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.LowerOrEqual, "<=", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Lower, "<", 2),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Like, "Like", 3),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.NotLike, "NotLike", 3),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.And, "Et|&&", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Or, "Ou|\\|\\|", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.OpenParenthesis, "\\(", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.CloseParenthesis, "\\)", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.NotDefined, "UnDefined", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.NonDefini, "Defined", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Addition, @"([+])", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Substraction, @"([-])", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Multiplication, @"([*])", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Division, @"([/])", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Number, @"(([0-9]+)((\,|\.)[0-9]+)?)", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Semicolon, ";", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Formalism, @"(([a-zA-Z_]+)(\.[a-zA-Z_]+))", 3),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.SumFormalism, @"Sum\\((([a-zA-Z_]+)(\.[a-zA-Z_]+))\\)", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.Reference, @"([a-zA-Z_]+)", 3),
                
                        //new TokenDefinitionViewModel(TokenType.Space, " ", 1),
                        //new TokenDefinitionViewModel(TokenType.NewLine, "\n", 1),

                        new TokenDefinitionViewModel(TokenTypeEnumerator.PrimeCotisable, "PRIME_COTISABLE", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.PrimeImposable, "PRIME_IMPOSABLE", 1),
                        new TokenDefinitionViewModel(TokenTypeEnumerator.TotalPrime, "TOTAL_PRIME", 1),
                    };
            }
            if (_englishKeywords is null)
            {
                _englishKeywords = new List<TokenDefinitionViewModel>
                            {   new TokenDefinitionViewModel(TokenTypeEnumerator.If, @"\bIf\b", 2),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Then, @"\bThen\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Else, @"\bElse\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.EndIf, @"\bEndIf\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.True, @"\bTrue\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.False, @"\bFalse\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Not, "!", 2),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Equals, "=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.NotEquals, "<>|!=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.HigherOrEqual, ">=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Higher, ">", 2),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.LowerOrEqual, "<=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Lower, "<", 2),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Like, "Like", 3),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.NotLike, "NotLike", 3),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.And, @"\bAnd\b|\b&&\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Or, @"\bOr\b|\b\\|\\|\b", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.OpenParenthesis, "\\(", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.CloseParenthesis, "\\)", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.NotDefined, "UnDefined", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.NonDefini, "Defined", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Addition, @"([+])", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Substraction, @"([-])", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Multiplication, @"([*])", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Division, @"([/])", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Number, @"(([0-9]+)((\,|\.)[0-9]+)?)", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Semicolon, ";", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Formalism, @"(([a-zA-Z_]+)(\.[a-zA-Z_]+))", 3),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.SumFormalism, @"Sum\\((([a-zA-Z_]+)(\.[a-zA-Z_]+))\\)", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Reference, @"([a-zA-Z_]+)", 3),
                
                                //new TokenDefinitionViewModel(TokenType.Space, " ", 1),
                                //new TokenDefinitionViewModel(TokenType.NewLine, "\n", 1),

                                new TokenDefinitionViewModel(TokenTypeEnumerator.PrimeCotisable, "PRIME_COTISABLE", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.PrimeImposable, "PRIME_IMPOSABLE", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.TotalPrime, "TOTAL_PRIME", 1),
                            };
            }
            if (_comparisonOperators is null)
            {
                _comparisonOperators = new List<TokenDefinitionViewModel>
                            {
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Equals, "=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.NotEquals, "<>|!=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.HigherOrEqual, ">=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Higher, ">", 2),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.LowerOrEqual, "<=", 1),
                                new TokenDefinitionViewModel(TokenTypeEnumerator.Lower, "<", 2),
                            };
            }
        }

        /// <summary>
        /// A singleton pattern to restricts the instantiation of the class
        public static RegularExpressions Instance
        {
            get
            {
                lock(padlock)
                {
                    if (instance is null)
                    {
                        instance = new RegularExpressions();
                    }
                    return instance;
                }
            }

        }

        /// <summary>
        /// Returns true if the input value matches any value of the List of TokenDefinitionViewModel given else returns false
        /// </summary>
        /// <param name="input"></param>
        /// <param name="tokenDefinitionViewModels"></param>
        /// <returns></returns>
        public bool IsMatchValue(string input, List<TokenDefinitionViewModel> tokenDefinitionViewModels)
        {
            return tokenDefinitionViewModels.Any(m => m.IsMatchValue(input));
        }

        /// <summary>
        /// Returns true if the given TokenType matches any TokenType of the List of TokenDefinitionViewModel given else returns false
        /// </summary>
        /// <param name="tokenType"></param>
        /// <param name="tokenDefinitionViewModels"></param>
        /// <returns></returns>
        public bool IsMatchType(TokenTypeEnumerator tokenType, List<TokenDefinitionViewModel> tokenDefinitionViewModels)
        {
            return tokenDefinitionViewModels.Any(m => m.TokenType == tokenType); 
       }
    }
}
