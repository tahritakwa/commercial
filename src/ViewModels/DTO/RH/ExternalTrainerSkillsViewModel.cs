using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class ExternalTrainerSkillsViewModel : GenericViewModel
    {
        public string DeletedToken { get; set; }
        public int? IdExternalTrainer { get; set; }
        public int? IdSkills { get; set; }
        public bool? IsRecognized { get; set; }
        public bool? IsCertified { get; set; }
        public int? Rate { get; set; }
        public ExternalTrainerViewModel IdExternalTrainerNavigation { get; set; }
        public SkillsViewModel IdSkillsNavigation { get; set; }
    }
}
