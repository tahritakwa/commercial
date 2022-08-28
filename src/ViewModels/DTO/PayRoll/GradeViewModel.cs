using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class GradeViewModel : GenericViewModel
    {
        public string Designation { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<EmployeeViewModel> Employee { get; set; }
    }
}
