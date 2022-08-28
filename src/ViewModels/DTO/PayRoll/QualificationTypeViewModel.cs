using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class QualificationTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }
        public string Description { get; set; }

        public ICollection<EmployeeViewModel> Employee { get; set; }
        public ICollection<RecruitmentViewModel> Recruitment { get; set; }
    }
}
