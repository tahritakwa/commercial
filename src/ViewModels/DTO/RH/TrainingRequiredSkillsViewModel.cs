using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class TrainingRequiredSkillsViewModel : GenericViewModel
    {
        public int IdTraining { get; set; }
        public int IdSkills { get; set; }
        public string DeletedToken { get; set; }

        public SkillsViewModel IdSkillsNavigation { get; set; }
        public TrainingViewModel IdTrainingNavigation { get; set; }
    }
}
