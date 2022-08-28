using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{

    public class CivilityViewModel : GenericViewModel
    {
        public string CivilityCode { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
    }
}
