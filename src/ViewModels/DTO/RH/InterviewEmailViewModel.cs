using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class InterviewEmailViewModel : GenericViewModel
    {
        public int IdInterview { get; set; }
        public int IdEmail { get; set; }
        public DateTime? CreationDate { get; set; }

        public string DeletedToken { get; set; }

        public virtual EmailViewModel IdEmailNavigation { get; set; }
        public virtual InterviewViewModel IdInterviewNavigation { get; set; }
    }
}
