using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales.Document;

namespace ViewModels.DTO.Sales
{
    [Serializable]
    public class DocumentLineViewModel : GenericViewModel, ICloneable
    {
        public string CodeDocumentLine { get; set; }
        public int IdDocument { get; set; }
        public int IdItem { get; set; }
        public string Designation { get; set; }
        public string RefDesignation { get; set; }
        public double MovementQty { get; set; }
        public double RemainingQuantity { get; set; }
        public double ReceivedQuantity { get; set; }
        public bool IsChecked { get; set; }
        public int? IdMeasureUnit { get; set; }
        public string MesureUnitLabel { get; set; }
        public int? IdPrices { get; set; }
        public int? IdWarehouse { get; set; }
        public double? HtUnitAmount { get; set; }
        public double? DiscountPercentage { get; set; }
        public double HtAmount { get; set; }
        public double? VatTaxAmount { get; set; }
        public double? VatTaxRate { get; set; }
        public double? HtTotalLine { get; set; }
        public int? IdDocumentLineAssociated { get; set; }
        public int? IdDocumentLineStatus { get; set; }
        public double? HtUnitAmountWithCurrency { get; set; }
        public double? HtAmountWithCurrency { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public double? HtTotalLineWithCurrency { get; set; }
        public double? VatTaxAmountWithCurrency { get; set; }
        public double? ExcVatTaxAmount { get; set; }
        public double? ExcVatTaxRate { get; set; }
        public double? ExcVatTaxAmountWithCurrency { get; set; }
        public string Requirement { get; set; }
        public bool IsActive { get; set; }
        public double? TtcTotalLine { get; set; }
        public double? TtcTotalLineWithCurrency { get; set; }
        public string SymboleCurrency { get; set; }
        public int? CurrencyPrecision { get; set; }
        public virtual ICollection<DocumentLineTaxeViewModel> DocumentLineTaxe { get; set; }
        public virtual ICollection<DocumentLinePricesViewModel> DocumentLinePrices { get; set; }
        public virtual ICollection<StockMovementViewModel> StockMovement { get; set; }
        public virtual DocumentViewModel IdDocumentNavigation { get; set; }
        public virtual ItemViewModel IdItemNavigation { get; set; }
        public virtual MeasureUnitViewModel IdMeasureUnitNavigation { get; set; }
        public virtual PricesViewModel IdPricesNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseNavigation { get; set; }
        public virtual List<TaxeViewModel> Taxe { get; set; } = new List<TaxeViewModel>();
        public double? UnitPriceFromQuotation { get; set; }
        public string ShelfAndStorage { get; set; }
        public bool? IsExpenseLine { get; set; }
        public int? IdDocumentAssociated { get; set; }
        public bool IsValidReservationFromProvisionalStock { get; set; }
        public double? CostPrice { get; set; }
        public double? PercentageMargin { get; set; }
        public double? SellingPrice { get; set; }
        public string DeletedToken { get; set; }
        public TiersViewModel IdSupplier { get; set; }
        //public int? idDocumentAssociated { get; set; }
        public double? ConclusiveSellingPrice { get; set; }
        public double? AvailableQuantity { get; set; }
        public double? TaxeAmoun { get; set; }
        public int? IdDeliveryAssociated { get; set; }
        public DocumentLineViewModel IdDocumentLineAssociatedNavigation { get; set; }
        public DocumentLineViewModel IdDeliveryAssociatedNavigation { get; set; }
        public DocumentViewModel IdDocumentAssociatedNavigation { get; set; }
        public int? SelectedItemSalePolicy { get; set; }
        public double? ReliquaQty { get; set; }
        public double? NewSalesPrice { get; set; }
        public double? IncreaseRate { get; set; }
        public double? OrderedQty { get; set; }
        public string ColorRate { get; set; }
        public bool  IsNegotitated { get; set; }
        public bool? IsFromGarage { get; set; }
        public bool IsNegotitatedInOldDocument { get; set; }
        public virtual ICollection<DocumentLineViewModel> InverseIdDocumentLineAssociatedNavigation { get; set; }
        public bool IsNegotitationAccpted { get; set; }
        public bool IsNegotitatedRefused { get; set; }
        public int? IdStorage { get; set; }
        public List<ItemTiersViewModel> ItemTiers { get; set; }
        public DateTime? DateAvailability { get; set; }
        public virtual List<DocumentLineNegotiationOptionsViewModel> DocumentLineNegotiationOptions { get; set; }
        public double? TaxeAmount { get; set; }
        public double? Price { get; set; }
        public string Marque { get; set; }
        public virtual ShelfStorageViewModel IdStorageNavigation { get; set; }
        public bool HaveDiscountLineInDocument { get; set; }
        public object Clone()
        {
            return JsonConvert.DeserializeObject<DocumentLineViewModel>(JsonConvert.SerializeObject(this));
        }
        public object CloneTaxes()
        {
            return JsonConvert.DeserializeObject<List<DocumentLineTaxeViewModel>>(JsonConvert.SerializeObject(this.DocumentLineTaxe));
        }
    }
}
