using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class FormationTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<FormationViewModel> Formation { get; set; }
    }
}
