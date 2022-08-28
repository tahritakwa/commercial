using System.Collections.Generic;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class ItemSheetViewModel
    {
        public int Id { get; set; }
        public string LabelNature { get; set; }
        public string Note { get; set; }
        public string UrlBrandPicture { get; set; }
        public int NumberDaysOutOfStock { get; set; }
        public string LabelFamily { get; set; }
        public string LabelSubFamily { get; set; }
        public string BarCode1D { get; set; }
        public string BarCode2D { get; set; }
        public string LabelUnitStock { get; set; }
        public double? CoeffConversion { get; set; }
        public int? IdPolicyValorization { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public string LabelUnitSales { get; set; }
        public virtual ICollection<ListItemVehicleBrandModelSubModel> ItemVehicleBrandModelSubModel { get; set; }
        public virtual ICollection<ListTiersPurchasePrice> TiersPurchasePrice { get; set; }
        public virtual ICollection<string> TaxesLabel { get; set; }
        public virtual ICollection<OemItemViewModel> OemItem { get; set; }
    }
    public class ListItemVehicleBrandModelSubModel
    {
        public string LabelVehicleBrand { get; set; }
        public string LabelModel { get; set; }
        public string LabelSubModel { get; set; }
    }

    public class ListTiersPurchasePrice
    {
        public string UrlPicture { get; set; }
        public string Name { get; set; }
        public string CodeTiers { get; set; }
        public double? PurchasePrice { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }
    }
}
