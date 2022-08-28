using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class ObjectiveViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public int? ObjectiveCollaboratorStatus { get; set; }
        public int? ObjectiveManagerStatus { get; set; }
        public DateTime ExpectedDate { get; set; }
        public string DescriptionCollaborator { get; set; }
        public string DescriptionManager { get; set; }
        public DateTime? RealisationDate { get; set; }
        public int IdReview { get; set; }
        public string DeletedToken { get; set; }
        public int IdEmployee { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ReviewViewModel IdReviewNavigation { get; set; }
    }
}
