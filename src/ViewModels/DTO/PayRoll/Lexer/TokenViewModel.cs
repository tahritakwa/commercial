using Utils.Enumerators.PayrollEnumerators;

namespace ViewModels.DTO.PayRoll.Lexer
{
    public class TokenViewModel
    {
        public TokenTypeEnumerator TokenType { get; set; }
        public string Value { get; set; }

        public TokenViewModel(TokenTypeEnumerator tokenType)
        {
            TokenType = tokenType;
            Value = string.Empty;
        }

        public TokenViewModel(TokenTypeEnumerator tokenType, string value)
        {
            TokenType = tokenType;
            Value = value;
        }

        public TokenViewModel Clone()
        {
            return new TokenViewModel(TokenType, Value);
        }
    }
}
