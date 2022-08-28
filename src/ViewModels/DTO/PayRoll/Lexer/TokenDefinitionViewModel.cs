using System.Collections.Generic;
using System.Text.RegularExpressions;
using Utils.Enumerators.PayrollEnumerators;

namespace ViewModels.DTO.PayRoll.Lexer
{
    public class TokenDefinitionViewModel
    {
        private readonly Regex _regex;
        private readonly int _precedence;

        public TokenDefinitionViewModel(TokenTypeEnumerator returnsToken, string regexPattern, int precedence)
        {
            _regex = new Regex(regexPattern, RegexOptions.IgnoreCase | RegexOptions.Compiled);
            TokenType = returnsToken;
            _precedence = precedence;
        }

        public TokenTypeEnumerator TokenType { get; }

        public IEnumerable<TokenMatchViewModel> FindMatches(string inputString)
        {
            var matches = _regex.Matches(inputString);
            for (int i = 0; i < matches.Count; i++)
            {
                yield return new TokenMatchViewModel()
                {
                    Startindex = matches[i].Index,
                    EndIndex = matches[i].Index + matches[i].Length,
                    TokenType = TokenType,
                    Value = matches[i].Value,
                    Precedence = _precedence
                };
            }
        }

        /// <summary>
        /// Returns true if Regex finds a match of the input string 
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public bool IsMatchValue(string input)
        {
            return _regex.IsMatch(input);
        }
    }
}
