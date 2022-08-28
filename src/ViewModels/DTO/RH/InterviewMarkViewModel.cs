using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class InterviewMarkViewModel : GenericViewModel
    {
        public double Mark { get; set; }
        public bool IsRequired { get; set; }
        public int Status { get; set; }
        public int IdEmployee { get; set; }
        public int IdInterview { get; set; }
        public string DeletedToken { get; set; }
        public int? InterviewerDecision { get; set; }
        public string StrongPoints { get; set; }
        public string Weaknesses { get; set; }
        public string OtherInformations { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public InterviewViewModel IdInterviewNavigation { get; set; }
        public ICollection<CriteriaMarkViewModel> CriteriaMark { get; set; }
    }
}
