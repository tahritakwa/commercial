using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class DiscountForListViewModel : GenericViewModel
    {
        public string CodePrices { get; set; }
        public ICollection<string> TypesLabels { get; set; }
        public bool IsActif { get; set; }
        public string State { get; set; }
        public string ListTypesLabels { get; set; }
    }
}
