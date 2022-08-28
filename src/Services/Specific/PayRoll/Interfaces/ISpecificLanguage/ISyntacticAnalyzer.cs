using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Interfaces.ISpecificLanguage
{
    public interface ISyntacticAnalyzer
    {
        SubTreeViewModel Parse(Queue<TokenViewModel> expression);
    }
}
