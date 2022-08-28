using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Immobilisation
{
    public class CategoryViewModel : GenericViewModel
    {
        public int? MinPeriod { get; set; }
        public int? MaxPeriod { get; set; }
        public int? ImmobilisationType { get; set; }
        public string ImmobilisationTypeText { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }
        public string Code { get; set; }
        public ICollection<ActiveViewModel> Active { get; set; }
    }
}
