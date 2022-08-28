using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Immobilisation
{
    public class ReducedCategoryViewModel : GenericViewModel
    {
        public int? ImmobilisationType { get; set; }
        public string ImmobilisationTypeText { get; set; }
        public string Label { get; set; }
        public string Code { get; set; }
    }
}
