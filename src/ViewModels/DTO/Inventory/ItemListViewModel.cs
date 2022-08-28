using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class ItemListViewModel
    {

        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public double? UnitHtpurchasePrice { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public string NameTiers { get; set; }
        public string LabelProduct { get; set; }
        public double AllAvailableQuantity { get; set; }
        public double WarhouseAvailableQuantity { get; set; }
        public string TecDocRef { get; set; }
        public bool IsEcommerce { get; set; }
        public int? SynchonizationStatus { get; set; }
        public string CRP { get; set; }
        public double CMD { get; set; }
        public string LabelVehicule { get; set; }
        public double ReliquatQty { get; set; }
        public string CodeTiers { get; set; }
        public int? IdTiers { get; set; }
        public bool? HaveClaims { get; set; }
        public string LabelNature { get; set; }
        public NumberFormatOptionsViewModel UnitHtPurchasePriceFormatOption { get; set; }
        public DateTime? AvailableDate { get; set; }
        [Key]
        public int? TecDocId { get; set; }
        public int? TecDocIdSupplier { get; set; }
        public bool IsStockManaged { get; set; }
        public int? OnlineSynchonizationStatus { get; set; }
        public string Oem { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public ICollection<TiersViewModel> ListTiers { get; set; }
        public List<string> TecDocImageList { get; set; }
    }
}
