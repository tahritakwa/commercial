using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class ReviewFormationViewModel : GenericViewModel
    {
        public DateTime? Date { get; set; }
        public int? FormationCollaboratorStatus { get; set; }
        public int? FormationManagerStatus { get; set; }
        public string ManagerComment { get; set; }
        public string CollaboratorComment { get; set; }
        public int IdReview { get; set; }
        public int IdFormation { get; set; }
        public string DeletedToken { get; set; }
        public int IdEmployee { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public FormationViewModel IdFormationNavigation { get; set; }
        public ReviewViewModel IdReviewNavigation { get; set; }






    }
}
