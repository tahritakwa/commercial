using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class FormationViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public int IdFormationType { get; set; }

        public FormationTypeViewModel IdFormationTypeNavigation { get; set; }
        public ICollection<ReviewFormationViewModel> ReviewFormation { get; set; }
    }
}
