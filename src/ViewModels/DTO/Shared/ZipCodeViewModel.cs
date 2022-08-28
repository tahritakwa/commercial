using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class ZipCodeViewModel : GenericViewModel
    {
        public string Region { get; set; }
        public string Code { get; set; }
        public int? IdCity { get; set; }
        public CityViewModel IdCityNavigation { get; set; }
    }
}
