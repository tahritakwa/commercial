using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class RecruitmentSkillsViewModel : GenericViewModel
    {
        public int IdSkills { get; set; }
        public int IdRecruitment { get; set; }
        public string DeletedToken { get; set; }
        public int Rate { get; set; }

        public RecruitmentViewModel IdRecruitmentNavigation { get; set; }
        public  SkillsViewModel IdSkillsNavigation { get; set; }
    }
}
