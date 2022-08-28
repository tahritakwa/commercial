using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class ReviewSkillsViewModel : GenericViewModel
    {
        public int? CollaboratorMark { get; set; }
        public int? ManagerMark { get; set; }
        public int IdReview { get; set; }
        public int IdSkills { get; set; }
        public string DeletedToken { get; set; }
        public int IdEmployee { get; set; }
        public bool IsOld { get; set; }
        public int? OldRate { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ReviewViewModel IdReviewNavigation { get; set; }
        public SkillsViewModel IdSkillsNavigation { get; set; }
    }
}
