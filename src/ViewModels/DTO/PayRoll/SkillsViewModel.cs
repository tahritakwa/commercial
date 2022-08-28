using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class SkillsViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public int? IdFamily { get; set; }

        public virtual SkillsFamilyViewModel IdFamilyNavigation { get; set; }

        public ICollection<JobSkillsViewModel> JobSkills { get; set; }
        public ICollection<ReviewSkillsViewModel> ReviewSkills { get; set; }
        public ICollection<ExternalTrainerSkillsViewModel> ExternalTrainerSkills { get; set; }
        public ICollection<RecruitmentSkillsViewModel> RecruitmentSkills { get; set; }

    }
}
