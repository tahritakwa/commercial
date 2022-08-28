using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class InterviewViewModel : GenericViewModel
    {
        public double? AverageMark { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime InterviewDate { get; set; }
        public TimeSpan StartTime { get; set; }
        public string Remarks { get; set; }
        public int Status { get; set; }
        public int? IdInterviewType { get; set; }
        public int? IdCandidacy { get; set; }
        public int? IdEmail { get; set; }
        public int? IdReview { get; set; }
        public string DeletedToken { get; set; }
        public int? IdExitEmployee { get; set; }
        public int? IdSupervisor { get; set; }
        public int? IdCreator { get; set; }
        public string Token { get; set; }
        public TimeSpan EndTime { get; set; }

        public virtual EmployeeViewModel IdCreatorNavigation { get; set; }
        public  CandidacyViewModel IdCandidacyNavigation { get; set; }
        public InterviewTypeViewModel IdInterviewTypeNavigation { get; set; }
        public EmailViewModel IdEmailNavigation { get; set; }
        public ReviewViewModel IdReviewNavigation { get; set; }
        public ExitEmployeeViewModel IdExitEmployeeNavigation { get; set; }
        public EmployeeViewModel IdSupervisorNavigation { get; set; }

        public ICollection<InterviewMarkViewModel> InterviewMark { get; set; }
        public ICollection<InterviewMarkViewModel> OptionalInterviewMark { get; set; }    
        public virtual ICollection<QuestionViewModel> Question { get; set; }

    }
}
