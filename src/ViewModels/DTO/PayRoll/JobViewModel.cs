using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class JobViewModel : GenericViewModel
    {
        public string Designation { get; set; }
        public string DeletedToken { get; set; }
        public string FunctionSheet { get; set; }
        public int? IdUpperJob { get; set; }
        public string Text { get; set; }
        public string HierarchyLevel { get; set; }

        public JobViewModel IdUpperJobNavigation { get; set; }
        public ICollection<JobViewModel> InverseIdUpperJobNavigation { get; set; }
        public ICollection<JobEmployeeViewModel> JobEmployee { get; set; }
        public ICollection<JobSkillsViewModel> JobSkills { get; set; }
        public ICollection<JobViewModel> Items { get; set; }
        public ICollection<RecruitmentViewModel> Recruitment { get; set; }
    }
}
