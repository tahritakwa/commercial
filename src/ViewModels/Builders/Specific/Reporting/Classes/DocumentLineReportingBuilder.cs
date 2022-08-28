using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Reporting.Classes
{
    public class DocumentLineReportingBuilder : GenericBuilder<DocumentLineReportingViewModel, DocumentLine>, IDocumentLineReportingBuilder
    {
        private readonly ITaxeBuilder _taxeBuilder;

        public DocumentLineReportingBuilder(ITaxeBuilder taxeBuilder)
        {
            _taxeBuilder = taxeBuilder;
        }
        public  DocumentLineReportingViewModel BuildEntity(DocumentLine entity, List<Taxe> taxes = null, Company company = null)
        {
            if (entity.IdDocumentLineAssociatedNavigation != null)
            {
                entity.IdDocumentLineAssociatedNavigation.IdDocumentNavigation.IdUsedCurrencyNavigation = null;
                entity.IdDocumentLineAssociatedNavigation.IdDocumentNavigation.DocumentLine = null;
            }
            Currency currency = new Currency();
            if (entity.IdDocumentNavigation != null)
            {
                currency = entity.IdDocumentNavigation.IdUsedCurrencyNavigation;
                entity.IdDocumentNavigation.DocumentLine = null;
            }
            
            DocumentLineReportingViewModel model = base.BuildEntity(entity);
            if (entity.DocumentLineTaxe != null && entity.DocumentLineTaxe.Any())
            {
                foreach (DocumentLineTaxeViewModel documentLineTaxe in model.DocumentLineTaxe)
                {
                    if (documentLineTaxe.IdTaxeNavigation == null)
                    {
                        DocumentLineTaxe currentDocLineTaxe = entity.DocumentLineTaxe.Where(x => x.Id == documentLineTaxe.Id).FirstOrDefault();
                        if (currentDocLineTaxe != null)
                        {
                            documentLineTaxe.IdTaxeNavigation = _taxeBuilder.BuildEntity(currentDocLineTaxe.IdTaxeNavigation);
                        }
                    }
                }
            }
            if (entity.IdDocumentNavigation != null)
            {
                if (currency != null && currency.Symbole != null)
                {
                    model.Symbole = currency.Symbole;
                    model.CurrencyPrecision = currency.Precision;
                }

                if (entity.IdItemNavigation != null)
                {
                    model.CodeArticle = entity.IdItemNavigation.Code;
                    model.Code = entity.CodeDocumentLine;
                    model.Reference = entity.IdItemNavigation.Code;

                    if (entity.IdItemNavigation.ItemWarehouse != null && entity.IdItemNavigation.ItemWarehouse.Any())
                    {
                        var itemWarehouse = entity.IdItemNavigation.ItemWarehouse.FirstOrDefault(x => x.IdWarehouse == entity.IdWarehouse);
                        model.ShelfAndStorage = itemWarehouse?.Shelf + itemWarehouse?.Storage;

                        ItemWarehouse itemWarehouseCentral = entity.IdItemNavigation.ItemWarehouse.Where(x => x.IdWarehouseNavigation != null && x.IdWarehouseNavigation.IsCentral).FirstOrDefault();
                        if (itemWarehouse != null)
                        {
                            model.WarehouseName = itemWarehouse.IdWarehouseNavigation?.WarehouseName;
                            model.ShelfAndStorageOfItemCentral = itemWarehouseCentral?.Shelf + itemWarehouseCentral?.Storage;
                        }
                    }
                    if(entity.IdItemNavigation.IdProductItemNavigation != null)
                    {
                        model.Brand = entity.IdItemNavigation.IdProductItemNavigation.CodeProduct ?? string.Empty;
                        
                    }
                    else
                    {
                        model.Brand = string.Empty;
                    }
                }

                if (entity.IdDocumentLineAssociatedNavigation != null)
                {
                    model.IdDocumentAssociatedNavigation = entity.IdDocumentLineAssociatedNavigation.IdDocumentNavigation;
                    model.IdDocumentAssociated = model.IdDocumentAssociatedNavigation.Id;
                    model.IdDocumentAssociatedNavigationCode = model.IdDocumentAssociatedNavigation.Code;
                }
                model.IsNotValid = entity.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional;
            }
            model.HtAmountWithCurrency = entity.HtAmountWithCurrency;
            if (entity.IdMeasureUnitNavigation != null)
            {
                model.MesureUnitLabel = entity.IdMeasureUnitNavigation.Label;
            }
            if (taxes != null  && taxes.Any())
            {
                model.HtUnitAmountWithCurrencyString = CurrencyUtility.GenerateCurrencyByCulture(model.HtUnitAmountWithCurrency.Value, model.CurrencyPrecision.Value, "", company.Culture);
                model.HtTotalLineWithCurrencyString = CurrencyUtility.GenerateCurrencyByCulture(model.HtTotalLineWithCurrency.Value, model.CurrencyPrecision.Value, "", company.Culture);
                model.TTcTotalLineWithCurrencyString = CurrencyUtility.GenerateCurrencyByCulture(model.TTcTotalLineWithCurrency.Value, model.CurrencyPrecision.Value, "", company.Culture);
                if (model.DocumentLineTaxe != null)
                {
                    List<DocumentLineTaxeViewModel> listDocLineWithCalculableTaxe = model.DocumentLineTaxe.Where(y => taxes.FirstOrDefault(u => u.Id == y.IdTaxe).IsCalculable && taxes.FirstOrDefault(u => u.Id == y.IdTaxe).TaxeValue != null).ToList();
                    List<DocumentLineTaxeViewModel> listDocLineWithoutCalculableTaxe = model.DocumentLineTaxe.Where(y => !taxes.FirstOrDefault(u => u.Id == y.IdTaxe).IsCalculable).ToList();
                    model.AllVatTaxRate = "-";
                    if (listDocLineWithCalculableTaxe != null && listDocLineWithCalculableTaxe.Any())
                    {
                        model.AllVatTaxRate = string.Join(GenericConstants.Comma, listDocLineWithCalculableTaxe.Select(x => taxes.FirstOrDefault(u => u.Id == x.IdTaxe).Label.ToString())) ?? "-";

                    }
                    else if (listDocLineWithoutCalculableTaxe != null && listDocLineWithoutCalculableTaxe.Any())
                    {
                        model.AllVatTaxRate = model.VatTaxAmountWithCurrency != null ?
                            model.HtUnitAmountWithCurrencyString = CurrencyUtility.GenerateCurrencyByCulture
                            (model.VatTaxAmountWithCurrency.Value, model.CurrencyPrecision.Value,
                            model.Symbole, company.Culture) : "-";
                    }
                }
            }


            return model;
        }



    }
}
