using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Interfaces.ISpecificLanguage
{
    public interface IServiceCalculator
    {
        OperationTreeViewModel AnalyzeSyntactic(Queue<TokenViewModel> Queue);
        double Excecute(Queue<TokenViewModel> Expression);
    }
}
