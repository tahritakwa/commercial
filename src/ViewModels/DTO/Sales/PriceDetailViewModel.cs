using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class PriceDetailViewModel : GenericViewModel
    {
        public int IdPrices { get; set; }
        public DateTime StartDateTime { get; set; }
        public DateTime EndDateTime { get; set; }
        public double? Percentage { get; set; }
        public double? ReducedValue { get; set; }
        public double? SpecialPrice { get; set; }
        public double? MinimumQuantity { get; set; }
        public double? MaximumQuantity { get; set; }
        public double? TotalPrices { get; set; }
        public double? SaledItemsNumber { get; set; }
        public double? GiftedItemsNumber { get; set; }
        public int TypeOfPriceDetail { get; set; }
        public string DeletedToken { get; set; }

        public virtual PricesViewModel IdPricesNavigation { get; set; }
    }
}
