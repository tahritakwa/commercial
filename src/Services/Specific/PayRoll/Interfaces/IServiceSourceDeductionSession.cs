using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSourceDeductionSession : IService<SourceDeductionSessionViewModel, SourceDeductionSession>
    {
        bool GetUnicitySessionNumberPerYear(SourceDeductionSessionViewModel sourceDeductionSessionViewModel);
        SourceDeductionSessionViewModel GetSessionDetails(int idSession);
        void CheckSourceDeductionSessionBeforeClosing(SourceDeductionSessionViewModel sourceDeductionSession);
    }
}
