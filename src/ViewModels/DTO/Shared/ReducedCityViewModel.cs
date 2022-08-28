using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{

    public class ReducedCityViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public int? IdCountry { get; set; }
    }
}
