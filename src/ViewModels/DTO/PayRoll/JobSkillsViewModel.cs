using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class JobSkillsViewModel : GenericViewModel
    {
        public int IdJob { get; set; }
        public int IdSkill { get; set; }
        public int? Rate { get; set; }

        public JobViewModel IdJobNavigation { get; set; }
        public SkillsViewModel IdSkillNavigation { get; set; }
    }
}
