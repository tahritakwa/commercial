using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{
    [Serializable]
    public class ReducedDocumentLineViewModel : GenericViewModel
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
        public virtual ReducedDocumentViewModel IdDocumentNavigation { get; set; }
        public virtual ReducedItemViewModel IdItemNavigation { get; set; }
        public virtual ReducedMeasureUnitViewModel IdMeasureUnitNavigation { get; set; }
        public virtual PricesViewModel IdPricesNavigation { get; set; }
        public virtual ReducedWarehouseViewModel IdWarehouseNavigation { get; set; }
        public double? UnitPriceFromQuotation { get; set; }
        public string ShelfAndStorage { get; set; }
        public bool? IsExpenseLine { get; set; }

        public bool IsValidReservationFromProvisionalStock { get; set; }
        public double? CostPrice { get; set; }
        public double? PercentageMargin { get; set; }
        public double? SellingPrice { get; set; }
        public string DeletedToken { get; set; }
        public ReducedTiersViewModel IdSupplier { get; set; }
        public int? IdDocumentAssociated { get; set; }
        public double? ConclusiveSellingPrice { get; set; }
        public double? AvailableQuantity { get; set; }
        public List<ReducedTaxeViewModel> Taxe { get; set; } = new List<ReducedTaxeViewModel>();
        public ReducedDocumentLineViewModel IdDocumentLineAssociatedNavigation { get; set; }

        public ReducedDocumentLineViewModel()
        {

        }

        public ReducedDocumentLineViewModel(DocumentLineViewModel entity) : base(entity)
        {
            if (entity != null)
            {
                CodeDocumentLine = entity.CodeDocumentLine;
                IdDocument = entity.IdDocument;
                IdItem = entity.IdItem;
                Designation = entity.Designation;
                RefDesignation = entity.RefDesignation;
                MovementQty = entity.MovementQty;
                RemainingQuantity = entity.RemainingQuantity;
                ReceivedQuantity = entity.ReceivedQuantity;
                IsChecked = entity.IsChecked;
                IdMeasureUnit = entity.IdMeasureUnit;
                MesureUnitLabel = entity.MesureUnitLabel;
                IdPrices = entity.IdPrices;
                IdWarehouse = entity.IdWarehouse;
                HtUnitAmount = entity.HtUnitAmount;
                DiscountPercentage = entity.DiscountPercentage;
                HtAmount = entity.HtAmount;
                VatTaxAmount = entity.VatTaxAmount;
                VatTaxRate = entity.VatTaxRate;
                HtTotalLine = entity.HtTotalLine;
                IdDocumentLineAssociated = entity.IdDocumentLineAssociated;
                IdDocumentLineStatus = entity.IdDocumentLineStatus;
                HtUnitAmountWithCurrency = entity.HtUnitAmountWithCurrency;
                HtAmountWithCurrency = entity.HtAmountWithCurrency;
                UnitHtsalePrice = entity.UnitHtsalePrice;
                HtTotalLineWithCurrency = entity.HtTotalLineWithCurrency;
                VatTaxAmountWithCurrency = entity.VatTaxAmountWithCurrency;
                ExcVatTaxAmount = entity.ExcVatTaxAmount;
                ExcVatTaxRate = entity.ExcVatTaxRate;
                ExcVatTaxAmountWithCurrency = entity.ExcVatTaxAmountWithCurrency;
                Requirement = entity.Requirement;
                IsActive = entity.IsActive;
                TtcTotalLine = entity.TtcTotalLine;
                TtcTotalLineWithCurrency = entity.TtcTotalLineWithCurrency;
                SymboleCurrency = entity.SymboleCurrency;
                CurrencyPrecision = entity.CurrencyPrecision;
                DocumentLineTaxe = entity.DocumentLineTaxe;
                DocumentLinePrices = entity.DocumentLinePrices;
                StockMovement = entity.StockMovement;
                IdDocumentNavigation = new ReducedDocumentViewModel(entity.IdDocumentNavigation);
                IdItemNavigation = new ReducedItemViewModel(entity.IdItemNavigation);
                IdMeasureUnitNavigation = new ReducedMeasureUnitViewModel(entity.IdMeasureUnitNavigation);
                IdPricesNavigation = entity.IdPricesNavigation;
                IdWarehouseNavigation = new ReducedWarehouseViewModel(entity.IdWarehouseNavigation);
                UnitPriceFromQuotation = entity.UnitPriceFromQuotation;
                ShelfAndStorage = entity.ShelfAndStorage;
                IsExpenseLine = entity.IsExpenseLine;
                IsValidReservationFromProvisionalStock = entity.IsValidReservationFromProvisionalStock;
                CostPrice = entity.CostPrice;
                PercentageMargin = entity.PercentageMargin;
                SellingPrice = entity.SellingPrice;
                DeletedToken = entity.DeletedToken;
                IdSupplier = new ReducedTiersViewModel(entity.IdSupplier);
                IdDocumentAssociated = entity.IdDocumentAssociated;
                ConclusiveSellingPrice = entity.ConclusiveSellingPrice;
                AvailableQuantity = entity.AvailableQuantity;
            }
        }
    }
}
