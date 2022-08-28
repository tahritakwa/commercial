using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExitReasonViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public int Type { get; set; }
        public ICollection<ExitEmployeeViewModel> EmployeeExit { get; set; }
    }
}
