using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Interfaces.ISpecificLanguage
{
    public interface ILexicalAnalyzer
    {
        Queue<TokenViewModel> LexerForValidation(string Expression, DateTime? startDate = null);
        Queue<TokenViewModel> LexerForExcecution(string Expression);
    }
}
