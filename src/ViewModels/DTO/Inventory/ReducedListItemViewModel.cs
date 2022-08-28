using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ViewModels.DTO.Inventory
{
    public class ReducedListItemViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public int NumberOfItemEquiKit { get; set; }
        public string UrlPicture { get; set; }
        public double QuantityForDocumentLine { get; set; }
        public bool IsChecked { get; set; }
        public double AllAvailableQuantity { get; set; }
        public ICollection<string> NamesTiers { get; set; }
        public string LabelProduct { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public double? UnitHtpurchasePrice { get; set; }
        public double ReliquatQty { get; set; }
        public double WarhouseAvailableQuantity { get; set; }
        public DateTime? AvailableDate { get; set; }
        [Key]
        public int? TecDocId { get; set; }
        public string TecDocRef { get; set; }
        public int? TecDocIdSupplier { get; set; }
        public bool? HaveClaims { get; set; }
        public bool IsStockManeged { get; set; }
        public bool IsForSales { get; set; }
        public bool IsForPurchase { get; set; }
        public bool IsKit { get; set; }
        public bool? IsFromGarage { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public string NatureLabel { get; set; }
        public string Oem { get; set; }
        public ICollection<int> IdsTiers { get; set; }

    }
}
