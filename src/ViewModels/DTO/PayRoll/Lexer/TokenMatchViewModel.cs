using Utils.Enumerators.PayrollEnumerators;

namespace ViewModels.DTO.PayRoll.Lexer
{
    public class TokenMatchViewModel
    {
        public TokenTypeEnumerator TokenType { get; set; }
        public string Value { get; set; }
        public int Startindex { get; set; }
        public int EndIndex { get; set; }
        public int Precedence { get; set; }
    }
}
