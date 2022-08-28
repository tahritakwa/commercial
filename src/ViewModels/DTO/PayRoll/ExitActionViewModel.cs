using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExitActionViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<ExitActionEmployeeViewModel> ExitActionEmployee { get; set; }
    }
}
