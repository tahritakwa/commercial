using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{

    public class CountryViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string Alpha2 { get; set; }
        public string Alpha3 { get; set; }
        public string NameFr { get; set; }
        public string NameEn { get; set; }
        public virtual ICollection<CityViewModel> City { get; set; }

        public virtual ICollection<TiersViewModel> Tiers { get; set; }
    }
}
