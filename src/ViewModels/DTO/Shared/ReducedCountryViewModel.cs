using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{

    public class ReducedCountryViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string Alpha2 { get; set; }
        public string Alpha3 { get; set; }
        public string NameFr { get; set; }
        public string NameEn { get; set; }
    }
}
