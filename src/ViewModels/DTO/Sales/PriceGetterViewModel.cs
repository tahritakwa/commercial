using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class PriceGetterViewModel : GenericViewModel
    {
        public int IdTiers { get; set; }
        public int IdItem { get; set; }
        public DateTime CurrentDate { get; set; }
        public double CurrentQuantity { get; set; }
        public int? IdUsedCurrency { get; set; }
    }
}
