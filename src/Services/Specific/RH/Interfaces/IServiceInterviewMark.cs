using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceInterviewMark : IService<InterviewMarkViewModel, InterviewMark>
    {   
        InterviewMarkViewModel GetInterviewMark(int idInterviewMark);
        IList<CriteriaMarkViewModel> GetInterviewMarkCriteriaMarkList(int idInterviewMark);
        void UpdateInterviewMarkWithCriteriaMark(InterviewMarkViewModel model, string userMail);
    }
}
