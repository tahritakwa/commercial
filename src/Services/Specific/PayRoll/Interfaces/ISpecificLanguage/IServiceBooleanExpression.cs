using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.PayRoll.Lexer;

namespace Services.Specific.PayRoll.Interfaces.ISpecificLanguage
{
    public interface IServiceBooleanExpression
    {
        SubTreeViewModel AnalyzeSyntactic(Queue<TokenViewModel> Queue);
        Boolean Excecute(Queue<TokenViewModel> Expression);
    }
}
