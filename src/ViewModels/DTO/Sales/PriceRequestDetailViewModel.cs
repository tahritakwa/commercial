using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{
    public class PriceRequestDetailViewModel : GenericViewModel
    {
        public int IdPriceRequest { get; set; }
        public int IdItem { get; set; }
        public string Designation { get; set; }
        public double MovementQty { get; set; }
        public string DeletedToken { get; set; }
        public int? IdContact { get; set; }
        public int IdTiers { get; set; }

        public ItemViewModel IdItemNavigation { get; set; }
        public PriceRequestViewModel IdPriceRequestNavigation { get; set; }
        public ContactViewModel IdContactNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }

    }
}
