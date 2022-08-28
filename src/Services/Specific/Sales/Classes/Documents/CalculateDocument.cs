using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        /// <summary>
        /// GetDocumentLineUnitPrice
        /// </summary>
        /// <param name="documentLineUnitPrice"></param>
        /// <returns></returns>
        public DocumentLineUnitPriceViewModel GetDocumentLineHtPrice(DocumentLineUnitPriceViewModel documentLineUnitPrice)
        {
            if (documentLineUnitPrice == null)
            {
                throw new ArgumentNullException(nameof(documentLineUnitPrice));
            }
            documentLineUnitPrice.DiscountPercentage = documentLineUnitPrice.DiscountPercentage ?? 0;
            double htAmount = (double)(1 - documentLineUnitPrice.DiscountPercentage / 100) * documentLineUnitPrice.HtUnitAmount;
            int PrecisionValues = GetPrecissionValue(documentLineUnitPrice.IdCurrency, documentLineUnitPrice.DocumentTypeCode);
            documentLineUnitPrice.HtAmount = AmountMethods.FormatValue(htAmount, PrecisionValues);
            return documentLineUnitPrice;
        }

        public void GetDocumentLinePrice(ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            var budgetPrice = itemPriceViewModel.DocumentLineViewModel.UnitPriceFromQuotation;
            double discountvalue = 1 - ((itemPriceViewModel.DocumentLineViewModel.DiscountPercentage ?? 0) / 100);
            double htAmount = discountvalue * (budgetPrice > 0 ? budgetPrice : itemPriceViewModel.DocumentLineViewModel.HtUnitAmountWithCurrency) ?? 0;
            itemPriceViewModel.DocumentLineViewModel.HtAmountWithCurrency = htAmount;
        }

        /// <summary>
        /// GetDocumentLineDiscountRate
        /// </summary>
        /// <param name="documentLineUnitPrice"></param>
        /// <returns></returns>
        public DocumentLineUnitPriceViewModel GetDocumentLineDiscountRate(DocumentLineUnitPriceViewModel documentLineUnitPrice)
        {
            if (documentLineUnitPrice.HtUnitAmount.Equals(0))
            {
                documentLineUnitPrice.DiscountPercentage = 0;
                return documentLineUnitPrice;
            }
            if (documentLineUnitPrice.HtAmount >= documentLineUnitPrice.HtUnitAmount)
            {
                documentLineUnitPrice.DiscountPercentage = 0;
                documentLineUnitPrice.HtAmount = documentLineUnitPrice.HtUnitAmount;
                return documentLineUnitPrice;
            }

            var rat = (1 - (documentLineUnitPrice.HtAmount / documentLineUnitPrice.HtUnitAmount)) * 100;
            documentLineUnitPrice.DiscountPercentage = AmountMethods.FormatValue(rat, 2);
            return documentLineUnitPrice;
        }

        /// <summary>
        /// Get Item Prices PHT and total Discount Rate
        /// </summary>
        /// <param name="itemPriceViewModel"></param>
        /// <returns></returns>
        public DocumentLineViewModel GetItemPrice(ItemPriceViewModel itemPriceViewModel, bool isFromBToB = false)
        {

            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            if (itemPriceViewModel.DocumentLineViewModel.MovementQty.Equals(0))
            {
                itemPriceViewModel.DocumentLineViewModel.MovementQty = 1;
            }

            CheckitemPricesObject(itemPriceViewModel);
            var pricesViewModel = new PriceGetterViewModel
            {
                CurrentQuantity = itemPriceViewModel.DocumentLineViewModel.MovementQty,
                IdItem = itemPriceViewModel.Item.Id,
                IdTiers = itemPriceViewModel.IdTiers,
                CurrentDate = itemPriceViewModel.DocumentDate,
                IdUsedCurrency = itemPriceViewModel.IdCurrency,
            };

            DocumentLineViewModel documentLine = itemPriceViewModel.DocumentLineViewModel ?? new DocumentLineViewModel();
            if (((itemPriceViewModel.DocumentTypeObject.IsSaleDocumentType) &&
                (itemPriceViewModel.DocumentType != DocumentEnumerator.SalesInvoice ||
                (itemPriceViewModel.DocumentType == DocumentEnumerator.SalesInvoice && itemPriceViewModel.InoicingType != (int)InvoicingTypeEnumerator.Other))
                && (itemPriceViewModel.DocumentType != DocumentEnumerator.BS ||
                (itemPriceViewModel.DocumentType == DocumentEnumerator.BS && itemPriceViewModel.Tiers.IdTypeTiers != (int)TiersType.Supplier)))
                || (itemPriceViewModel.DocumentType == DocumentEnumerator.BE && itemPriceViewModel.Tiers.IdTypeTiers == (int)TiersType.Customer))
            {
                var pricesResult = _servicePrices.GetSpecificPrice(pricesViewModel, itemPriceViewModel);
                if (pricesResult != null)
                {
                    documentLine.DocumentLinePrices = new List<DocumentLinePricesViewModel>();
                    DocumentLinePricesViewModel documentLinePrices = new DocumentLinePricesViewModel
                    {
                        IdPrices = pricesResult.Id
                    };
                    documentLine.DocumentLinePrices.Add(documentLinePrices);
                    documentLine.HtUnitAmountWithCurrency = pricesResult.UnitPriceHTaxe;
                    documentLine.HtUnitAmountWithCurrency =
                        (documentLine.HtUnitAmountWithCurrency.Value.IsApproximately(0, within: 0.0001) && itemPriceViewModel.Item.UnitHtsalePrice != null) ?
                        itemPriceViewModel.Item.UnitHtsalePrice : documentLine.HtUnitAmountWithCurrency.Value;
                    documentLine.DiscountPercentage = pricesResult.TotalDiscount;
                    documentLine.HtAmountWithCurrency = documentLine.HtUnitAmountWithCurrency - documentLine.HtUnitAmountWithCurrency * pricesResult.TotalDiscount / 100;
                    if (documentLine != null && itemPriceViewModel.IdCurrency != null && itemPriceViewModel.TiersPrecison != null)
                    {
                        SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, itemPriceViewModel.TiersPrecison, documentLine.HtUnitAmountWithCurrency ?? 0);
                    }
                }
                else
                {
                    if (itemPriceViewModel.IdCurrency == 0 && itemPriceViewModel.Tiers != null)
                    {
                        itemPriceViewModel.IdCurrency = (int)itemPriceViewModel.Tiers.IdCurrency;
                    }
                    SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, itemPriceViewModel.TiersPrecison, itemPriceViewModel.Item.UnitHtsalePrice ?? 0);
                    documentLine.DiscountPercentage = 0;
                }

            }
            else
            {
                // TODO: price per tier
                // TODO: price per tier
                if (itemPriceViewModel.IdCurrency != itemPriceViewModel.IdCurrency)
                {

                    documentLine.HtUnitAmountWithCurrency = 0;
                    documentLine.UnitHtsalePrice = 0;
                    documentLine.HtAmountWithCurrency = 0;
                }
                else
                {
                    documentLine.HtUnitAmountWithCurrency = itemPriceViewModel.Item.UnitHtpurchasePrice ?? 0;
                    if (itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseOrder || itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseFinalOrder ||
                        itemPriceViewModel.DocumentType == DocumentEnumerator.BE || itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseBudget ||
                        itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseQuotation || itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseAsset ||
                        itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseInvoice || itemPriceViewModel.DocumentType == DocumentEnumerator.BS)
                    {
                        List<ItemTiersViewModel> itemTiers = _serviceItemTiers.FindModelsByNoTracked(x => x.IdTiers == itemPriceViewModel.IdTiers && x.IdItem == itemPriceViewModel.DocumentLineViewModel.IdItem).ToList();
                        if (itemTiers != null && itemTiers.Any())
                        {
                            documentLine.HtUnitAmountWithCurrency = itemTiers.First().PurchasePrice;
                            if (itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseOrder)
                            {
                                documentLine.UnitPriceFromQuotation = itemTiers.First().PurchasePrice;
                            }
                        }
                        else
                        {
                            documentLine.HtUnitAmountWithCurrency = 0;
                        }
                    }
                    documentLine.UnitHtsalePrice = itemPriceViewModel.Item.UnitHtsalePrice ?? 0;
                    documentLine.HtAmountWithCurrency = itemPriceViewModel.Item.UnitHtpurchasePrice ?? 0;
                }


            }
            if (itemPriceViewModel.DocumentTypeObject.IsSaleDocumentType)
            {
                documentLine.CostPrice = itemPriceViewModel.Item.CostPrice ?? 0;
            }

            documentLine.IdMeasureUnit = itemPriceViewModel.DocumentTypeObject.IsSaleDocumentType ? itemPriceViewModel.Item.IdUnitSales : itemPriceViewModel.Item.IdUnitStock;
            documentLine.DocumentLineTaxe = GetTaxValues(itemPriceViewModel);
            documentLine.Designation = itemPriceViewModel.Item.Description;
            documentLine.MovementQty = itemPriceViewModel.DocumentLineViewModel.MovementQty;
            var measureUnitNavigation = itemPriceViewModel.DocumentTypeObject.IsSaleDocumentType ? itemPriceViewModel.Item.IdUnitSalesNavigation : itemPriceViewModel.Item.IdUnitStockNavigation;

            if (!isFromBToB && itemPriceViewModel.Item.IdNatureNavigation.IsStockManaged &&
                ((itemPriceViewModel.Item.IsForSales == true && itemPriceViewModel.Item.IdUnitSales == null) ||
                (itemPriceViewModel.Item.IsForPurchase == true && itemPriceViewModel.Item.IdUnitStock == null)))
            {
                throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
            }
            var idTaxes = itemPriceViewModel.Item.TaxeItem.Select(x => x.IdTaxe).ToList();

            if (itemPriceViewModel.Item.IdNatureNavigation.IsStockManaged && itemPriceViewModel.Item.ItemWarehouse.Any())
            {
                if (documentLine.IdWarehouse == null)
                {
                    documentLine.IdWarehouse = _serviceWarehouse.GetModelAsNoTracked(x => x.IsCentral).Id;
                }

                documentLine.ShelfAndStorage = _serviceDocumentLine.GetShelfAndStorageOfItemInWarehouse(documentLine.IdItem, documentLine.IdWarehouse);
                ItemWarehouse itemWarehouse = itemPriceViewModel.Item.ItemWarehouse.FirstOrDefault(x => x.IdWarehouse == documentLine.IdWarehouse);

                documentLine.AvailableQuantity = itemWarehouse?.AvailableQuantity - itemWarehouse?.ReservedQuantity;
                if (documentLine.AvailableQuantity < 0)
                {
                    documentLine.AvailableQuantity = 0;
                    _serviceItemWarehouse.LogEroor(documentLine.IdItem);
                }
            }

            documentLine.Taxe = _serviceTaxe.FindByAsNoTracking(x => idTaxes.Contains(x.Id)).ToList();
            if (documentLine.IdMeasureUnit != null)
            {
                documentLine.MesureUnitLabel = measureUnitNavigation.Label;
            }
            else
            {
                documentLine.MesureUnitLabel = null;
            }
            documentLine.IdItemNavigation = _itemBuilder.BuildEntity(itemPriceViewModel.Item);
            if (documentLine.IdDocumentLineStatus == null)
            {
                if (documentLine.IdDocumentNavigation != null && documentLine.IdDocumentNavigation.IdDocumentStatus != null)
                {
                    documentLine.IdDocumentLineStatus = documentLine.IdDocumentNavigation.IdDocumentStatus;
                }
                else if (documentLine.IdDocument != null && documentLine.IdDocument != 0)
                {
                    var docstatus = GetModel(x => x.Id == documentLine.IdDocument).IdDocumentStatus;
                    documentLine.IdDocumentLineStatus = docstatus != null ? docstatus : null;
                }
                else
                {
                    documentLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                }
            }
            return documentLine;
        }

        private void SetHTAmount(DocumentLineViewModel documentLine, int idUsedCurrency, DateTime documentDate, int precisionValues, double unitHtsalePrice)
        {
            if (idUsedCurrency == GetCurrentCompany().IdCurrency)
            {
                documentLine.HtUnitAmountWithCurrency = unitHtsalePrice;
                documentLine.HtAmountWithCurrency = unitHtsalePrice;

            }
            else
            {

                var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(idUsedCurrency, documentDate);

                documentLine.HtUnitAmountWithCurrency = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? unitHtsalePrice / exchangeRate : unitHtsalePrice, precisionValues);
                documentLine.HtAmountWithCurrency = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? unitHtsalePrice / exchangeRate : unitHtsalePrice, precisionValues);
            }
        }

        /// <summary>
        /// Get Totaux  document Value
        /// </summary>
        /// <param name="reduisDocumentViewModel"></param>
        /// <returns></returns>
        public DocumentTotalPricesViewModel GetDocumentTotalPrice(ReduisDocumentViewModel reduisDocumentViewModel)
        {
            var tier = _serviceTiers.GetModelAsNoTracked(x => x.Id == reduisDocumentViewModel.IdTiers);

            int PrecisionValues = GetPrecissionValue((int)tier.IdCurrency, reduisDocumentViewModel.DocumentType);

            reduisDocumentViewModel.DocumentLine = reduisDocumentViewModel.DocumentLine.Where(x => !x.IsDeleted).ToList();
            DocumentTotalPricesViewModel documentTotalPrices = new DocumentTotalPricesViewModel
            {
                DocumentHtpriceWithCurrency = AmountMethods.FormatValue(reduisDocumentViewModel.DocumentLine.Sum(x => x.HtTotalLineWithCurrency ?? 0), PrecisionValues),
                DocumentTotalVatTaxesWithCurrency = AmountMethods.FormatValue(reduisDocumentViewModel.DocumentLine.Where(x => x.VatTaxAmountWithCurrency != null)
                .Sum(x => x.VatTaxAmountWithCurrency ?? 0), PrecisionValues),
                DocumentTotalExcVatTaxesWithCurrency = AmountMethods.FormatValue(reduisDocumentViewModel.DocumentLine.Where(x => x.ExcVatTaxAmountWithCurrency != null)
                .Sum(x => x.ExcVatTaxAmountWithCurrency ?? 0), PrecisionValues),
                // Total discount = SUM ((Line Unit price - Line NET HT Amount) * QTY)
                // in case of Purchase order if Unit Price From Quotation != null && != 0  Total discount = SUM ((Line Unit Price From Quotation - Line NET HT Amount) * QTY)
                DocumentTotalDiscountWithCurrency = reduisDocumentViewModel.DocumentLine.Sum(x =>
                    Math.Round(((((x.UnitPriceFromQuotation != null && !x.UnitPriceFromQuotation.Value.IsApproximately(0, within: 0.0001)) ?
                                            x.UnitPriceFromQuotation : x.HtUnitAmountWithCurrency) ?? 0)
                                    - (x.HtAmountWithCurrency ?? 0))
                                    * x.MovementQty
                    , PrecisionValues
                    , MidpointRounding.ToEven)),
                DocumentOtherTaxesWithCurrency = AmountMethods.FormatValue(reduisDocumentViewModel.DocumentOtherTaxe, PrecisionValues)
            };
            documentTotalPrices.DocumentPriceIncludeVatWithCurrency =
                AmountMethods.FormatValue(documentTotalPrices.DocumentHtpriceWithCurrency + documentTotalPrices.DocumentTotalExcVatTaxesWithCurrency, PrecisionValues);
            documentTotalPrices.DocumentTtcpriceWithCurrency = AmountMethods.FormatValue(documentTotalPrices.DocumentHtpriceWithCurrency + documentTotalPrices.DocumentTotalVatTaxesWithCurrency
                + documentTotalPrices.DocumentTotalExcVatTaxesWithCurrency + documentTotalPrices.DocumentOtherTaxesWithCurrency, PrecisionValues);
            return documentTotalPrices;
        }



        public DocumentLineViewModel CalculeDocumentLine(ItemPriceViewModel itemPriceViewModel, int precisionTiers)
        {
            DocumentLineViewModel documentLineViewModel = GetTaxRate(itemPriceViewModel);
            documentLineViewModel.HtTotalLineWithCurrency = AmountMethods.FormatValue
              (itemPriceViewModel.DocumentLineViewModel.MovementQty * itemPriceViewModel.DocumentLineViewModel.HtAmountWithCurrency ?? 0, precisionTiers);
            if (!itemPriceViewModel.IsTaxCalculable)
            {
                if (itemPriceViewModel.TaxeType == (int)TaxTypeEnumerator.Vat)
                {
                    documentLineViewModel.VatTaxAmountWithCurrency = (itemPriceViewModel.Tiers != null &&
                        itemPriceViewModel.Tiers.IdTaxeGroupTiers == (int)TaxeGroupEnumerator.NotExempt) ? documentLineViewModel.TaxeAmount : 0;
                    documentLineViewModel.ExcVatTaxAmountWithCurrency = 0;
                }
                else
                {
                    documentLineViewModel.ExcVatTaxAmountWithCurrency = (itemPriceViewModel.Tiers != null &&
                        itemPriceViewModel.Tiers.IdTaxeGroupTiers == (int)TaxeGroupEnumerator.NotExempt) ? documentLineViewModel.TaxeAmount : 0;
                    documentLineViewModel.VatTaxAmountWithCurrency = 0;
                }
            }
            else
            {
                documentLineViewModel.VatTaxAmountWithCurrency = ((1 + (documentLineViewModel.ExcVatTaxRate ?? 0)) * (documentLineViewModel.VatTaxRate ?? 0) * documentLineViewModel.HtTotalLineWithCurrency) ?? 0;
                documentLineViewModel.ExcVatTaxAmountWithCurrency = (documentLineViewModel.ExcVatTaxRate ?? 0) * documentLineViewModel.HtTotalLineWithCurrency ?? 0;
            }
            documentLineViewModel.TtcTotalLineWithCurrency = AmountMethods.FormatValue
                (documentLineViewModel.HtTotalLineWithCurrency + (documentLineViewModel.ExcVatTaxAmountWithCurrency ?? 0) + documentLineViewModel.VatTaxAmountWithCurrency ?? 0, precisionTiers);
            return documentLineViewModel;
        }

        private double CalculatHtTotalLineWithCurrency(ItemPriceViewModel itemPriceViewModel)
        {
            return itemPriceViewModel.DocumentLineViewModel.MovementQty * (itemPriceViewModel.DocumentLineViewModel.HtUnitAmountWithCurrency ?? 0) *
                (1 - (itemPriceViewModel.DocumentLineViewModel.DiscountPercentage ?? 0) / 100);
        }


        private void UpdateDocumenLineValue(List<DocumentLineViewModel> documentLineList)
        {
            if (documentLineList == null || !documentLineList.Any())
                return;

            var document = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == documentLineList.First().IdDocument, r => r.IdTiersNavigation);
            var tiers = document.IdTiersNavigation;
            DocumentViewModel documentViewModel = _builderdocument.BuildEntity(document);

            var documentType = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.CodeType == documentViewModel.DocumentTypeCode);
            int precisionTierValues = GetPrecissionValue((int)tiers.IdCurrency, documentViewModel.DocumentTypeCode);
            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue((int)documentViewModel.IdUsedCurrency, documentViewModel.DocumentDate, documentViewModel.ExchangeRate);
            var companyPrecision = GetCompanyCurrencyPrecision();
            var listofitemList = documentViewModel.DocumentLine.Select(y => y.IdItem);

            var ItemListViewModel = _itemEntityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => listofitemList.Contains(x.Id)
            , x => x.IdUnitSalesNavigation, z => z.IdUnitStockNavigation, z => z.IdNatureNavigation, x => x.TaxeItem, x => x.ItemWarehouse);

            foreach (var documentLine in documentViewModel.DocumentLine.Where(x => !x.IsDeleted).ToList())
            {
                //CalculateDocumentLine(documentLine, calculDocument);
                ItemPriceViewModel priceViewModel = new ItemPriceViewModel
                {
                    DocumentDate = documentViewModel.DocumentDate,
                    DocumentLineViewModel = documentLine,
                    DocumentType = documentViewModel.DocumentTypeCode,
                    IdCurrency = documentViewModel.IdUsedCurrency ?? 0,
                    IdTiers = documentViewModel.IdTiers ?? 0,
                    Tiers = tiers,
                    CompanyPrecison = companyPrecision,
                    TiersPrecison = precisionTierValues,
                    exchangeRate = exchangeRate,
                    Document = document,
                    Item = ItemListViewModel.First(x => x.Id == documentLine.IdItem),
                    DocumentTypeObject = documentType
                };

                GetDocumentLinePrice(priceViewModel);
                CalculateDocumentLine(priceViewModel);
            }

        }


        /// <summary>
        /// CheckRealAndProvisionalStock
        /// </summary>
        /// <param name="itemPriceViewModel"></param>
        /// <returns></returns>
        public bool IsProvisionalStock(ItemPriceViewModel itemPriceViewModel)
        {
            bool isProvisionalStock = false;

            // Return false if the document is not SalesDelivery (the verification of provisional stock is specific for SalesDelivery)
            if (itemPriceViewModel.DocumentType != DocumentEnumerator.SalesDelivery)
            {
                return isProvisionalStock;
            }

            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }

            ItemViewModel item = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdItem, x => x.IdNatureNavigation);
            // if item is stock managed
            if (item != null && item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
            {
                if ((item.IsForSales && item.IdUnitSales == null) || (item.IdUnitStock == null && item.IsForPurchase))
                {
                    throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
                }
                if (itemPriceViewModel.DocumentLineViewModel.IdWarehouse == null)
                {
                    // Depot Required error
                    throw new CustomException(CustomStatusCode.DepotObligatoire);
                }
                isProvisionalStock = _serviceItemWarehouse.IsAvailableQuantityOnlyInProvisionalStock(
                    item.Id, (int)itemPriceViewModel.DocumentLineViewModel.IdWarehouse, itemPriceViewModel.DocumentLineViewModel.MovementQty, itemPriceViewModel.DocumentLineViewModel.Id);

            }



            return isProvisionalStock;
        }

        /// <summary>
        /// Get item details
        /// </summary>
        /// <param name="idItem"></param>
        /// <returns> document Lin View Model</returns>
        public DocumentLineViewModel GetItemDetails(int idItem, int idTiers = 0)
        {

            DocumentLineViewModel documentLineViewModel = new DocumentLineViewModel();
            var item = _serviceItem.GetModelWithRelations(x => x.Id == idItem, x => x.IdUnitStockNavigation, x => x.ItemTiers);
            List<ItemTiersViewModel> tiers = _serviceItem.GetItemTiers(idItem);
            if (item == null)
            {
                throw new CustomException(CustomStatusCode.ItemsInvalidError);
            }
            TiersViewModel supplier = null;
            if (idTiers != 0)
            {
                supplier = _serviceTiers.GetModelWithRelations(x => x.Id == idTiers, x => x.IdCurrencyNavigation);
            }
            else if (item.ItemTiers != null && item.ItemTiers.Any())
            {
                supplier = _serviceTiers.GetModelWithRelations(x => x.Id == item.ItemTiers.First().IdTiers, x => x.IdCurrencyNavigation);
            }
            ItemTiersViewModel itemtier = item.ItemTiers.Where(x => x.IdTiers == supplier.Id).FirstOrDefault();
            documentLineViewModel.Designation = item.Description;
            documentLineViewModel.MovementQty = 1;
            documentLineViewModel.IdItem = idItem;
            documentLineViewModel.IdMeasureUnit = item.IdUnitStock;
            documentLineViewModel.IdMeasureUnitNavigation = item.IdUnitStockNavigation;
            documentLineViewModel.HtAmountWithCurrency = itemtier != null ? itemtier.PurchasePrice : null;
            documentLineViewModel.HtUnitAmountWithCurrency = itemtier != null ? itemtier.PurchasePrice : null;
            documentLineViewModel.ItemTiers = tiers;
            documentLineViewModel.IdSupplier = supplier;
            return documentLineViewModel;
        }
        /// <summary>
        /// Get tax values
        /// </summary>
        /// <param name="itemPriceViewModel"></param>
        /// <returns></returns>
        public IList<DocumentLineTaxeViewModel> GetTaxValues(ItemPriceViewModel itemPriceViewModel, bool recalculTaxe = false, bool fromInverseDiscount = false)
        {
            CheckitemPricesObject(itemPriceViewModel);

            int precisionValues = itemPriceViewModel.TiersPrecison;

            // test if tiers exonoré ou pas  
            bool notExcludedTax = itemPriceViewModel.DocumentLineViewModel.VatTaxRate > 0 || itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount > 0;

            if (itemPriceViewModel.DocumentLineViewModel.Id > 0 && !itemPriceViewModel.Item.TaxeItem.Any())
            {
                throw new CustomException(CustomStatusCode.ItemWithoutTaxError);
            }
            if (itemPriceViewModel.TaxeGroupTiers == null)
            {
                itemPriceViewModel.TaxeGroupTiers = _entityRepoTaxeGroupTiers.GetAllAsNoTracking().Include(x => x.TaxeGroupTiersConfig).ThenInclude(x => x.IdTaxeNavigation).First(x => x.Id == itemPriceViewModel.Tiers.IdTaxeGroupTiers);
            }
            if ((itemPriceViewModel.DocumentLineViewModel.Id > 0 ||
                (itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe != null && itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Any())) && recalculTaxe == false)
            {
                if (itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe != null && itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Any())
                {
                    itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe = itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.ToList();
                }
                else
                {
                    itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe = _serviceDocumentLineTaxe.FindModelsByNoTracked(x => x.IdDocumentLine == itemPriceViewModel.DocumentLineViewModel.Id).ToList();
                    if (itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe != null && itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Any())
                    {
                        List<int> idTaxes = itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Select(x => x.IdTaxe).Distinct().ToList();


                        foreach (var tax in itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe)
                        {
                            var taxConfig = itemPriceViewModel.TaxeGroupTiers.TaxeGroupTiersConfig.FirstOrDefault(x => x.IdTaxe == tax.IdTaxe);
                            if (taxConfig == null)
                            {
                                continue;
                            }
                            var taxevalue = taxConfig.Value;
                            var taxe = taxConfig.IdTaxeNavigation;

                            tax.TaxeBase = itemPriceViewModel.DocumentLineViewModel.HtTotalLine.HasValue && itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount.HasValue ?
                            ((itemPriceViewModel.DocumentLineViewModel.HtTotalLine.Value) + ((taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount.Value : 0))

                             : NumberConstant.Zero;
                            tax.TaxeBaseWithCurrency = itemPriceViewModel.DocumentLineViewModel.HtTotalLineWithCurrency.HasValue && itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency.HasValue ?
                             ((itemPriceViewModel.DocumentLineViewModel.HtTotalLineWithCurrency.Value) + ((taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency.Value : 0))

                              : NumberConstant.Zero;
                            if (notExcludedTax && taxe.IsCalculable)
                            {
                                tax.TaxeValue = (tax.TaxeBase ?? 0) * ((taxevalue) / NumberConstant.Hundred);
                                tax.TaxeValueWithCurrency = (tax.TaxeBaseWithCurrency ?? 0) * ((taxevalue) / NumberConstant.Hundred);
                                itemPriceViewModel.DocumentLineViewModel.TaxeAmount = 0;
                            }
                            else if (notExcludedTax && !taxe.IsCalculable || (!notExcludedTax && !taxe.IsCalculable && taxe.TaxeValue == null))
                            {
                                tax.TaxeValue = (taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? itemPriceViewModel.DocumentLineViewModel.VatTaxAmount.Value : itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount.Value;
                                tax.TaxeValueWithCurrency = (taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? itemPriceViewModel.DocumentLineViewModel.VatTaxAmountWithCurrency.Value : itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency.Value;
                            }
                            else
                            {
                                tax.TaxeValue = 0;
                                itemPriceViewModel.DocumentLineViewModel.VatTaxAmount = 0;
                                itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount = 0;
                                tax.TaxeValueWithCurrency = 0;
                                itemPriceViewModel.DocumentLineViewModel.TtcTotalLineWithCurrency = AmountMethods.FormatValue(itemPriceViewModel.DocumentLineViewModel.TtcTotalLineWithCurrency, precisionValues);
                                itemPriceViewModel.DocumentLineViewModel.VatTaxAmountWithCurrency = 0;
                                itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency = 0;
                                itemPriceViewModel.DocumentLineViewModel.TaxeAmount = 0;
                            }

                        }
                    }
                }
                if (fromInverseDiscount == true && itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe != null && itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Any())
                {
                    List<DocumentLineTaxeViewModel> taxes = itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.ToList();
                    _serviceDocumentLineTaxe.BulkUpdateModelWithoutTransaction(taxes, null);
                }

                return itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.ToList();
            }
            if (itemPriceViewModel.Item.TaxeItem != null)
            {
                itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe = new List<DocumentLineTaxeViewModel>();
                List<int> idTaxes = itemPriceViewModel.Item.TaxeItem.Select(x => x.IdTaxe).Distinct().ToList();


                foreach (var tax in itemPriceViewModel.Item.TaxeItem)
                {
                    var taxConfig = itemPriceViewModel.TaxeGroupTiers.TaxeGroupTiersConfig.FirstOrDefault(x => x.IdTaxe == tax.IdTaxe);
                    if (taxConfig == null)
                    {
                        continue;

                    }
                    var taxevalue = taxConfig.Value;
                    var taxe = taxConfig.IdTaxeNavigation;

                    DocumentLineTaxeViewModel taxViewModel = new DocumentLineTaxeViewModel
                    {
                        IdTaxe = tax.IdTaxe,
                        TaxeName = taxe.Label,

                        TaxeBase = itemPriceViewModel.DocumentLineViewModel.HtTotalLine.HasValue && itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount.HasValue ?
                                   ((itemPriceViewModel.DocumentLineViewModel.HtTotalLine) + ((taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount.Value : 0))

                                   : NumberConstant.Zero


                    };

                    taxViewModel.TaxeBaseWithCurrency = itemPriceViewModel.DocumentLineViewModel.HtTotalLineWithCurrency.HasValue && itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency.HasValue ?
                             ((itemPriceViewModel.DocumentLineViewModel.HtTotalLineWithCurrency.Value) + ((taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency.Value : 0))

                              : NumberConstant.Zero;
                    if (notExcludedTax && taxe.IsCalculable)
                    {
                        taxViewModel.TaxeValue = (taxViewModel.TaxeBase ?? 0) * ((taxevalue) / NumberConstant.Hundred);
                        taxViewModel.TaxeValueWithCurrency = (taxViewModel.TaxeBaseWithCurrency ?? 0) * ((taxevalue) / NumberConstant.Hundred);
                        itemPriceViewModel.DocumentLineViewModel.TaxeAmount = 0;
                    }
                    else if (notExcludedTax && !taxe.IsCalculable || (!notExcludedTax && !taxe.IsCalculable && taxe.TaxeValue == null))
                    {
                        taxViewModel.TaxeValue = (taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? (itemPriceViewModel.DocumentLineViewModel.VatTaxAmount != null ? itemPriceViewModel.DocumentLineViewModel.VatTaxAmount.Value : 0) :
                            (itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount != null ? itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount.Value : 0);
                        taxViewModel.TaxeValueWithCurrency = (taxe.TaxeType == (int)TaxTypeEnumerator.Vat) ? (itemPriceViewModel.DocumentLineViewModel.VatTaxAmountWithCurrency != null ? itemPriceViewModel.DocumentLineViewModel.VatTaxAmountWithCurrency.Value : 0) :
                            (itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency != null ? itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency.Value : 0);
                        if (itemPriceViewModel.DocumentLineViewModel.TaxeAmount == null)
                        {
                            itemPriceViewModel.DocumentLineViewModel.TaxeAmount = 0;
                        }
                    }
                    else
                    {
                        taxViewModel.TaxeValue = 0;
                        itemPriceViewModel.DocumentLineViewModel.VatTaxAmount = 0;
                        itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmount = 0;
                        taxViewModel.TaxeValueWithCurrency = 0;
                        itemPriceViewModel.DocumentLineViewModel.TtcTotalLineWithCurrency = AmountMethods.FormatValue(itemPriceViewModel.DocumentLineViewModel.TtcTotalLineWithCurrency, precisionValues);
                        itemPriceViewModel.DocumentLineViewModel.VatTaxAmountWithCurrency = 0;
                        itemPriceViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency = 0;
                        itemPriceViewModel.DocumentLineViewModel.TaxeAmount = 0;
                    }
                    if (recalculTaxe == true)
                    {
                        taxViewModel.IdDocumentLineNavigation = itemPriceViewModel.DocumentLineViewModel;
                        taxViewModel.IdDocumentLine = itemPriceViewModel.DocumentLineViewModel.Id;
                        taxViewModel.IdDocumentLineNavigation.IdDocumentNavigation = null;
                        taxViewModel.IdDocumentLineNavigation.DocumentLineTaxe = null;
                        taxViewModel.IdDocumentLineNavigation.DocumentLinePrices = null;
                        taxViewModel.IdDocumentLineNavigation.DocumentLineNegotiationOptions = null;
                        taxViewModel.IdDocumentLineNavigation.InverseIdDocumentLineAssociatedNavigation = null;
                        taxViewModel.IdDocumentLineNavigation.ItemTiers = null;
                        taxViewModel.IdDocumentLineNavigation.StockMovement = null;
                        taxViewModel.IdDocumentLineNavigation.Taxe = null;
                    }
                    if (itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe == null)
                    {
                        itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe = new List<DocumentLineTaxeViewModel>();
                    }

                    itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Add(JsonConvert.DeserializeObject<DocumentLineTaxeViewModel>(JsonConvert.SerializeObject(taxViewModel)));

                }
            }
            return itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.ToList();
        }
        /// <summary>
        /// Get tax rate Percentage
        /// </summary>
        /// <param name="itemPriceViewModel"></param>
        /// <returns></returns>
        private DocumentLineViewModel GetTaxRate(ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel.Tiers == null)
            {
                itemPriceViewModel.Tiers = _entityRepoTiers.GetSingleNotTracked(x => x.Id == itemPriceViewModel.IdTiers);
            }
            DocumentLineViewModel documentLineView = itemPriceViewModel.DocumentLineViewModel;
            //case update document Line the taxe rate are already calculated  
            if (documentLineView.Id > 0)
            {

                var tax = _serviceTaxe.GetModelAsNoTracked(x => x.Id == itemPriceViewModel.Item.TaxeItem.First().IdTaxe);
                itemPriceViewModel.IsTaxCalculable = tax.IsCalculable;
                itemPriceViewModel.TaxeType = tax.TaxeType;
                return documentLineView;
            }
            /*if (!documentLineView.IdItemNavigation.TaxeItem.Any())
            {
                throw new CustomException(CustomStatusCode.ItemWithoutTaxError);
            }*/
            if (documentLineView.IsExpenseLine == true || (documentLineView.DocumentLineTaxe != null && documentLineView.DocumentLineTaxe.Any()))
            {
                //this controle need to be deleted after add All document please check with houssem 
                if ((documentLineView.VatTaxRate ?? 0).Equals(0) && (documentLineView.ExcVatTaxRate ?? 0).Equals(0))
                {
                    documentLineView.VatTaxRate = documentLineView.DocumentLineTaxe.Where(x => x.TaxType == (int)TaxTypeEnumerator.Vat).Sum(x => x.TaxeValue) / 100;
                    documentLineView.ExcVatTaxRate = documentLineView.DocumentLineTaxe.Where(x => x.TaxType == (int)TaxTypeEnumerator.BaseVat).Sum(x => x.TaxeValue) / 100;
                }
                var taxItem = _serviceTaxe.GetModelAsNoTracked(x => x.Id == documentLineView.DocumentLineTaxe.First().IdTaxe);
                if (documentLineView.IsExpenseLine == true)
                {
                    itemPriceViewModel.DocumentLineViewModel.DocumentLineTaxe.Clear();
                }
                itemPriceViewModel.IsTaxCalculable = taxItem.IsCalculable;
                itemPriceViewModel.TaxeType = taxItem.TaxeType;
            }
            else
            {

                if (itemPriceViewModel.DocumentLineViewModel.IdItemNavigation == null || itemPriceViewModel.DocumentLineViewModel.IdItemNavigation.TaxeItem == null
                     || (itemPriceViewModel.DocumentLineViewModel.IdItemNavigation.TaxeItem != null && !itemPriceViewModel.DocumentLineViewModel.IdItemNavigation.TaxeItem.Any()))
                {
                    itemPriceViewModel.DocumentLineViewModel.IdItemNavigation = _serviceItem.GetModelWithRelations(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdItem, x => x.TaxeItem, x => x.IdUnitSalesNavigation,
                    x => x.IdUnitStockNavigation);
                    if (!documentLineView.IdItemNavigation.TaxeItem.Any())
                    {
                        throw new CustomException(CustomStatusCode.ItemWithoutTaxError);
                    }
                }

                var taxconfigs = _entityRepoTaxeGroupTiersConfig.
                GetAllWithConditionsRelationsAsNoTracking(x => x.IdTaxeGroupTiers == itemPriceViewModel.Tiers.IdTaxeGroupTiers, x => x.IdTaxeNavigation).ToList();
                var documentLineTaxe = new List<DocumentLineTaxeViewModel>();
                

                if (itemPriceViewModel.Item.TaxeItem != null)
                {
                    foreach (var tax in itemPriceViewModel.Item.TaxeItem)
                    {
                        var taxValue = taxconfigs.FirstOrDefault(x => x.IdTaxe == tax.IdTaxe);
                        if (taxValue == null)
                        {
                            continue;
                        }
                        else
                        {
                            itemPriceViewModel.IsTaxCalculable = taxValue.IdTaxeNavigation.IsCalculable;
                            itemPriceViewModel.TaxeType = taxValue.IdTaxeNavigation.TaxeType;
                        }
                        DocumentLineTaxeViewModel taxViewModel = new DocumentLineTaxeViewModel
                        {
                            IdTaxe = tax.IdTaxe,
                            TaxeName = taxValue.IdTaxeNavigation.CodeTaxe,
                            TaxeValue = taxValue.Value,
                            TaxType = taxValue.IdTaxeNavigation.TaxeType,
                        };

                        documentLineTaxe.Add(taxViewModel);

                    }
                    documentLineView.VatTaxRate = documentLineTaxe.Where(x => x.TaxType == (int)TaxTypeEnumerator.Vat).Sum(x => x.TaxeValue) / 100;
                    documentLineView.ExcVatTaxRate = documentLineTaxe.Where(x => x.TaxType == (int)TaxTypeEnumerator.BaseVat).Sum(x => x.TaxeValue) / 100;

                }
            }
            return documentLineView;
        }


        /// <summary>
        /// check f sales document
        /// </summary>
        /// <param name="documenbTypeCode"></param>
        /// <returns></returns>
        private bool IsSalesDocumenType(string documenbTypeCode)
        {
            var documenType = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.Code == documenbTypeCode);
            if (documenType == null)
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            return documenType.IsSaleDocumentType;
        }

        /// <summary>
        /// Get nomber of Precission
        /// </summary>
        /// <param name="idCurrency"></param>
        /// <param name="documenbTypeCode"></param>
        /// <returns></returns>
        public int GetPrecissionValue(int idCurrency, string documenbTypeCode)
        {
            var usedCurrency = _serviceCurrency.GetModelAsNoTracked(x => x.Id == idCurrency);
            if (usedCurrency == null)
            {
                if (IsSalesDocumenType(documenbTypeCode))
                {
                    throw new CustomException(CustomStatusCode.ClientCurrencyError);
                }
                throw new CustomException(CustomStatusCode.SupplierCurrencyError);

            }
            return usedCurrency.Precision;
        }

        public DocumentLineViewModel GetDocumentLineValues(ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }

            int precision = GetPrecissionValue(itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentType);
            return CalculeDocumentLine(itemPriceViewModel, precision);
        }


        /// <summary>
        /// Recalculat eDocument And DocumentLine After Changing Currency ExchangeRate
        /// </summary>
        /// <param name="doumentId"></param>
        /// <param name="userMail"></param>
        public double RecalculateDocumentAndDocumentLineAfterChangingCurrencyExchangeRate(int doumentId, double exchangeRateValue)
        {

            var document = GetModelWithRelationsAsNoTracked(x => x.Id == doumentId, x => x.DocumentLine, x => x.IdUsedCurrencyNavigation);
            var Rate = _entityCurrencyRateRepo.GetSingleWithRelationsNotTracked(x => x.Document.FirstOrDefault().Id == doumentId);
            var defaultExchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate);
            if (exchangeRateValue != null && exchangeRateValue > 0)
            {
                if (Rate == null)
                {
                    if (defaultExchangeRate != null && defaultExchangeRate > 0 && exchangeRateValue == defaultExchangeRate)
                    {
                        document.ExchangeRate = exchangeRateValue;
                        document.IdExchangeRate = null;
                    }
                    else
                    {
                        CurrencyRateViewModel currencyRateViewModel = new CurrencyRateViewModel
                        {
                            IdCurrency = document.IdUsedCurrency,
                            Rate = exchangeRateValue,
                            Coefficient = 1,
                            StartDate = DateTime.Now,
                            EndDate = DateTime.Now
                        };
                        var CreatedChangeRate = (CreatedDataViewModel)_serviceCurrencyRate.AddModel(currencyRateViewModel, null, null);
                        document.ExchangeRate = exchangeRateValue;
                        document.IdExchangeRate = CreatedChangeRate.Id;
                    }
                }
                else
                {
                    if (defaultExchangeRate != null && defaultExchangeRate > 0 && exchangeRateValue == defaultExchangeRate)
                    {
                        document.ExchangeRate = exchangeRateValue;
                        document.IdExchangeRate = null;
                        _entityRepo.QuerableGetAll().Where(x => x.Id == document.Id).UpdateFromQuery(x => new Document { IdExchangeRate = null });
                        _entityCurrencyRateRepo.QuerableGetAll().Where(x => x.Id == Rate.Id).DeleteFromQuery();
                    }
                    else
                    {
                        _entityCurrencyRateRepo.QuerableGetAll().Where(x => x.Id == Rate.Id).UpdateFromQuery(x => new CurrencyRate
                        {
                            IdCurrency = (int)document.IdUsedCurrency,
                            Rate = exchangeRateValue,
                            Coefficient = 1,
                            StartDate = DateTime.Now,
                            EndDate = DateTime.Now
                        });
                        document.ExchangeRate = exchangeRateValue;
                    }
                }
            }
            else
            {
                if (Rate != null)
                {
                    _entityRepo.QuerableGetAll().Where(x => x.Id == document.Id).UpdateFromQuery(x => new Document { IdExchangeRate = null });
                    _entityCurrencyRateRepo.QuerableGetAll().Where(x => x.Id == Rate.Id).DeleteFromQuery();
                }
                document.ExchangeRate = null;
                document.IdExchangeRate = null;
                exchangeRateValue = 0;
            }

            UpdateDocumentWithoutTransaction(null, document, null, null, false);
            return exchangeRateValue;
        }
        public LastBLItemPriceViewModel GetLastBLPriceForItem(int idItem, int idTiers)
        {
            LastBLItemPriceViewModel lastBLItemPriceViewModel;
            var listDocument = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional
             && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery && x.IdItem == idItem && x.IdDocumentNavigation.IdTiers == idTiers).Include(x => x.IdDocumentNavigation).OrderByDescending(x => x.IdDocumentNavigation.DocumentDate);
            if (listDocument.Count() == 0)
            {
                return null;

            }
            var documentLine = listDocument.First();

            lastBLItemPriceViewModel = new LastBLItemPriceViewModel
            {
                idItem = idItem,
                DocumentRef = documentLine.IdDocumentNavigation.Code,
                idDocument = documentLine.IdDocument,
                ItemPrice = documentLine.HtUnitAmountWithCurrency ?? 0,
                ItemQte = documentLine.MovementQty,
                DocumentDate = (DateTime)documentLine.IdDocumentNavigation.ValidationDate,
                Discount = documentLine.DiscountPercentage ?? 0
            };
            return lastBLItemPriceViewModel;
        }

        public DocumentLineViewModel getDiscountValue(ItemPriceViewModel itemPriceViewModel)
        {
            // var taxPrices = GetTaxValues(itemPriceViewModel);
            TiersViewModel tiers = new TiersViewModel();
            ItemViewModel item = new ItemViewModel();
            if (itemPriceViewModel.Tiers == null)
            {
                tiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == itemPriceViewModel.IdTiers);
            }
            if (itemPriceViewModel.DocumentLineViewModel.IdItemNavigation == null)
            {
                item = _serviceItem.GetModelWithRelations(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdItem, x => x.TaxeItem, x => x.IdUnitSalesNavigation,
                x => x.IdUnitStockNavigation);
            }

            var pricesViewModel = new PriceGetterViewModel
            {
                CurrentQuantity = itemPriceViewModel.DocumentLineViewModel.MovementQty,
                IdItem = itemPriceViewModel.DocumentLineViewModel.IdItem,
                IdTiers = itemPriceViewModel.IdTiers,
                CurrentDate = itemPriceViewModel.DocumentDate,
                IdUsedCurrency = tiers.IdCurrency,
            };
            DocumentLineViewModel documentLine = itemPriceViewModel.DocumentLineViewModel ?? new DocumentLineViewModel();
            List<DocumentLinePrices> docLinePrices = _entityDocumentLinePricesRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocumentLine == documentLine.Id).ToList();
            var pricesResult = _servicePrices.GetSpecificPrice(pricesViewModel, itemPriceViewModel);
            TiersViewModel tier = _serviceTiers.GetModelsWithConditionsRelations(x => x.Id == pricesViewModel.IdTiers, y => y.IdCurrencyNavigation).FirstOrDefault();
            ItemViewModel itemP = _serviceItem.GetModelsWithConditionsRelations(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdItem, y => y.ItemSalesPrice).FirstOrDefault();
            if (pricesResult != null)
            {
                if (documentLine.Id == 0)
                {
                    documentLine.DocumentLinePrices = new List<DocumentLinePricesViewModel>();
                    DocumentLinePricesViewModel documentLinePrices = new DocumentLinePricesViewModel
                    {
                        IdPrices = pricesResult.Id
                    };
                    if (pricesResult.UsedDiscountType == (int)DiscountType.Quantity)
                    {
                        double itemPrice = 0;
                        if (tier != null && tier.IdSalesPrice != null && itemP != null && itemP.ItemSalesPrice != null && itemP.ItemSalesPrice.Any(x => x.IdSalesPrice == tier.IdSalesPrice))
                        {
                            itemPrice = Math.Round((double)(((itemP.ItemSalesPrice.Where(x => x.IdSalesPrice == tier.IdSalesPrice).FirstOrDefault().Percentage / 100) + 1) * itemP.UnitHtsalePrice ?? 0), tier.IdCurrencyNavigation != null &&
                                tier.IdCurrencyNavigation.Precision != null ? tier.IdCurrencyNavigation.Precision : 3);
                        }
                        else
                        {
                            itemPrice = itemP.UnitHtsalePrice != null ? (double)itemP.UnitHtsalePrice : 0;
                        }

                        documentLine.HtUnitAmountWithCurrency = itemPrice;
                        documentLine.DocumentLinePrices.Add(documentLinePrices);
                        documentLine.HtUnitAmountWithCurrency = pricesResult.UnitPriceHTaxe;
                        documentLine.HtUnitAmountWithCurrency =
                            (documentLine.HtUnitAmountWithCurrency.Value.IsApproximately(0, within: 0.0001) && item.UnitHtsalePrice != null) ?
                            item.UnitHtsalePrice : documentLine.HtUnitAmountWithCurrency.Value;
                        documentLine.DiscountPercentage = pricesResult.TotalDiscount;
                        documentLine.HtAmountWithCurrency = documentLine.HtUnitAmountWithCurrency - documentLine.HtUnitAmountWithCurrency * pricesResult.TotalDiscount / 100;
                        if (itemPriceViewModel != null && itemPriceViewModel.IdCurrency != null && itemPriceViewModel.DocumentDate != null && itemPriceViewModel.TiersPrecison != null)
                        {
                            SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, tier.IdCurrencyNavigation.Precision, itemPrice != null ? itemPrice : 0);
                        }
                    }
                    else if (pricesResult.UsedDiscountType == (int)DiscountType.SpecialPrice)
                    {
                        if (tier.IdCurrency == pricesResult.IdUsedCurrency)
                        {
                            documentLine.HtUnitAmountWithCurrency = pricesResult.UnitPriceHTaxe;
                            documentLine.DiscountPercentage = null;
                        }
                    }
                }
                else if (!docLinePrices.Any() && documentLine.Id > 0)
                {
                    _entityDocumentLinePricesRepo.Add(new DocumentLinePrices { IdPrices = pricesResult.Id, IdDocumentLine = documentLine.Id });
                    if (pricesResult.UsedDiscountType == (int)DiscountType.Quantity)
                    {
                        double itemPrice = 0;
                        if (tier != null && tier.IdSalesPrice != null && itemP != null && itemP.ItemSalesPrice != null && itemP.ItemSalesPrice.Any(x => x.IdSalesPrice == tier.IdSalesPrice))
                        {
                            itemPrice = Math.Round((double)(((itemP.ItemSalesPrice.Where(x => x.IdSalesPrice == tier.IdSalesPrice).FirstOrDefault().Percentage / 100) + 1) * itemP.UnitHtsalePrice), tier.IdCurrencyNavigation != null &&
                                tier.IdCurrencyNavigation.Precision != null ? tier.IdCurrencyNavigation.Precision : 3);
                        }
                        else
                        {
                            itemPrice = (double)itemP.UnitHtsalePrice;
                        }
                        documentLine.HtUnitAmountWithCurrency = itemPrice;
                        documentLine.DiscountPercentage = pricesResult.TotalDiscount;
                        if (itemPriceViewModel != null && itemPriceViewModel.IdCurrency != null && itemPriceViewModel.DocumentDate != null && itemPriceViewModel.TiersPrecison != null)
                        {
                            SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, tier.IdCurrencyNavigation.Precision, itemPrice != null ? itemPrice : 0);
                        }
                    }
                    else if (pricesResult.UsedDiscountType == (int)DiscountType.SpecialPrice)
                    {
                        if (tier.IdCurrency == pricesResult.IdUsedCurrency)
                        {
                            documentLine.HtUnitAmountWithCurrency = pricesResult.UnitPriceHTaxe;
                            documentLine.DiscountPercentage = null;
                        }
                    }
                    SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, tier.IdCurrencyNavigation.Precision, itemPriceViewModel.Item != null ? (double)itemPriceViewModel.Item.UnitHtsalePrice :
                        (itemPriceViewModel.DocumentLineViewModel != null && itemPriceViewModel.DocumentLineViewModel.IdItemNavigation != null ?
                        (double)itemPriceViewModel.DocumentLineViewModel.IdItemNavigation.UnitHtsalePrice : 0));
                }
                else if (docLinePrices.Count == 1)
                {
                    _entityDocumentLinePricesRepo.QuerableGetAll().Where(x => x.IdPrices == docLinePrices.FirstOrDefault().IdPrices && x.IdDocumentLine == documentLine.Id).UpdateFromQuery(
                        x => new DocumentLinePrices { IdPrices = pricesResult.Id });
                    if (pricesResult.UsedDiscountType == (int)DiscountType.Quantity)
                    {
                        double itemPrice = 0;
                        if (tier != null && tier.IdSalesPrice != null && itemP != null && itemP.ItemSalesPrice != null && itemP.ItemSalesPrice.Any(x => x.IdSalesPrice == tier.IdSalesPrice))
                        {
                            itemPrice = Math.Round((double)(((itemP.ItemSalesPrice.Where(x => x.IdSalesPrice == tier.IdSalesPrice).FirstOrDefault().Percentage / 100) + 1) * itemP.UnitHtsalePrice ?? 0), tier.IdCurrencyNavigation != null &&
                                tier.IdCurrencyNavigation.Precision != null ? tier.IdCurrencyNavigation.Precision : 3);
                        }
                        else
                        {
                            itemPrice = (double)itemP.UnitHtsalePrice;
                        }
                        documentLine.HtUnitAmountWithCurrency = itemPrice;
                        documentLine.DiscountPercentage = pricesResult.TotalDiscount;
                        if (itemPriceViewModel != null && itemPriceViewModel.IdCurrency != null && itemPriceViewModel.DocumentDate != null && itemPriceViewModel.TiersPrecison != null)
                        {
                            SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, tier.IdCurrencyNavigation.Precision, itemPrice != null ? itemPrice : 0);
                        }
                    }
                    else if (pricesResult.UsedDiscountType == (int)DiscountType.SpecialPrice)
                    {
                        if (tier.IdCurrency == pricesResult.IdUsedCurrency)
                        {
                            documentLine.HtUnitAmountWithCurrency = pricesResult.UnitPriceHTaxe;
                            documentLine.DiscountPercentage = null;
                        }
                    }
                }
            }
            else
            {
                if (docLinePrices.Any())
                {
                    _entityDocumentLinePricesRepo.QuerableGetAll().Where(x => x.IdDocumentLine == documentLine.Id).DeleteFromQuery();
                    documentLine.DiscountPercentage = 0;
                    double itemPrice = 0;
                    if (tier != null && tier.IdSalesPrice != null && itemP != null && itemP.ItemSalesPrice != null && itemP.ItemSalesPrice.Any(x => x.IdSalesPrice == tier.IdSalesPrice))
                    {
                        itemPrice = Math.Round((double)(((itemP.ItemSalesPrice.Where(x => x.IdSalesPrice == tier.IdSalesPrice).FirstOrDefault().Percentage / 100) + 1) * itemP.UnitHtsalePrice), tier.IdCurrencyNavigation != null &&
                            tier.IdCurrencyNavigation.Precision != null ? tier.IdCurrencyNavigation.Precision : 3);
                    }
                    else
                    {
                        itemPrice = (double)itemP.UnitHtsalePrice;
                    }
                    documentLine.HtUnitAmountWithCurrency = itemPrice;
                    if (itemPriceViewModel != null && itemPriceViewModel.IdCurrency != null && itemPriceViewModel.DocumentDate != null && itemPriceViewModel.TiersPrecison != null)
                    {
                        SetHTAmount(documentLine, itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, tier.IdCurrencyNavigation.Precision, itemPrice != null ? itemPrice : 0);
                    }
                }
                if (documentLine.DiscountPercentage > 0 && !docLinePrices.Any())
                {
                    documentLine.DiscountPercentage = 0;
                }
            }
            _unitOfWork.Commit();
            return documentLine;
        }

        #region garage
        /// <summary>
        /// Get price of many item for garage
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="quantity"></param>
        /// <param name="discount"></param>
        public dynamic GetItemPriceForGarage(Dictionary<int, IList<dynamic>> dataToSend)
        {

            if (dataToSend == null)
            {
                throw new Exception();
            }

            Dictionary<int, IList<dynamic>> itemPriceKeyPairValue = new Dictionary<int, IList<dynamic>>();

            IList<int> listIdsItem = dataToSend.Keys.ToList();
            // Get the item
            IList<ItemViewModel> listItemViewModel = _itemEntityRepo.GetAllWithConditionsQueryable(p => listIdsItem.Contains(p.Id))
                                                        .Include(r => r.TaxeItem)
                                                        .ThenInclude(r => r.IdTaxeNavigation).ToList().Select(_itemBuilder.BuildEntity).ToList();

            // Get the current company
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;

            listItemViewModel.ToList().ForEach((itemViewModel) =>
            {
                // Retrieve the taxes
                IList<TaxeViewModel> listTaxtViewModels = listItemViewModel.Where(p => p.Id == itemViewModel.Id)
                                                                        .SelectMany(s => s.TaxeItem)
                                                                        .Select(s => s.IdTaxeNavigation).ToList();

                // Calculate all taxes rate of the item
                double? vatTaxeRate = listTaxtViewModels.Where(p => p.TaxeType == (int)TaxTypeEnumerator.Vat).Sum(s => s.TaxeValue) / 100;
                double? excvatTaxeRate = listTaxtViewModels.Where(p => p.TaxeType == (int)TaxTypeEnumerator.BaseVat).Sum(s => s.TaxeValue) / 100;


                // Get quantity and discount
                IList<dynamic> data = dataToSend.Where(p => p.Key == itemViewModel.Id).FirstOrDefault().Value;
                double quantity = data.ElementAt(0);
                double? discount = data.Count > 1 ? data.ElementAt(1) : null; ;

                // Calculate price
                double totalHtsalePrice = AmountMethods.FormatValue((itemViewModel.UnitHtsalePrice ?? 0) * quantity, companyCurrency.Precision);

                double excVatTaxeValue = (excvatTaxeRate ?? 0) * totalHtsalePrice;

                double vatTaxeValue = (1 + (excvatTaxeRate ?? 0)) * (vatTaxeRate ?? 0) * totalHtsalePrice;

                double discountValue = totalHtsalePrice * ((discount ?? 0) / 100);

                double totalTtcPrice = AmountMethods.FormatValue(totalHtsalePrice + excVatTaxeValue + vatTaxeValue - discountValue, companyCurrency.Precision);

                itemPriceKeyPairValue.Add(itemViewModel.Id, new List<dynamic>() { itemViewModel.UnitHtsalePrice, totalHtsalePrice, totalTtcPrice });
            });

            return itemPriceKeyPairValue;
        }


        /// <summary>
        /// Get price of one item for garage
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="quantity"></param>
        /// <param name="discount"></param>
        /// <returns></returns>
        public dynamic GetOneItemPriceForGarage(int? idWharehouse, int idItem, double quantity, double? discount = null)
        {
            ItemViewModel itemViewModel = _itemEntityRepo.GetAllWithConditionsQueryable(p => p.Id == idItem)
                                                       .Include(r => r.TaxeItem)
                                                       .ThenInclude(r => r.IdTaxeNavigation).ToList().Select(_itemBuilder.BuildEntity).FirstOrDefault();

            // Get the current company
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;

            // Retrieve the taxes
            IList<TaxeViewModel> listTaxtViewModels = itemViewModel.TaxeItem.Select(s => s.IdTaxeNavigation).ToList();

            // Calculate all taxes rate of the item
            double? vatTaxeRate = listTaxtViewModels.Where(p => p.TaxeType == (int)TaxTypeEnumerator.Vat).Sum(s => s.TaxeValue) / 100;
            double? excvatTaxeRate = listTaxtViewModels.Where(p => p.TaxeType == (int)TaxTypeEnumerator.BaseVat).Sum(s => s.TaxeValue) / 100;

            // Calculate price
            double totalHtsalePrice = AmountMethods.FormatValue((itemViewModel.UnitHtsalePrice ?? 0) * quantity, companyCurrency.Precision);

            double excVatTaxeValue = (excvatTaxeRate ?? 0) * totalHtsalePrice;

            double vatTaxeValue = (1 + (excvatTaxeRate ?? 0)) * (vatTaxeRate ?? 0) * totalHtsalePrice;

            double discountValue = totalHtsalePrice * ((discount ?? 0) / 100);

            double totalTtcPrice = AmountMethods.FormatValue(totalHtsalePrice + excVatTaxeValue + vatTaxeValue - discountValue, companyCurrency.Precision);

            // Get remaining quantity of the item in the garage wharehouse
            double remainingQuantity = 0;
            if (idWharehouse != null && idWharehouse > 0)
            {
                remainingQuantity = _serviceItemWarehouse.GetItemQtyInWarehouse(idItem, (int)idWharehouse);
            }
            dynamic result = new ExpandoObject();
            result.UnitHtsalePrice = itemViewModel.UnitHtsalePrice;
            result.Htprice = totalHtsalePrice;
            result.TtcPrice = totalTtcPrice;
            result.RemainingQuantity = remainingQuantity;

            return result;
        }

        public DataSourceResult<ItemViewModel> GetItemPriceAndRemaningQuantityForGarage(Dictionary<int, double> itemIdAndQuanity, int? idWarehouse)
        {
            if (itemIdAndQuanity == null)
            {
                throw new Exception();
            }

            IList<int> listIdsItem = itemIdAndQuanity.Keys.ToList();

            // Get the item
            List<ItemViewModel> listItemViewModel = _itemEntityRepo.GetAllWithConditionsQueryable(p => listIdsItem.Contains(p.Id))
                                                .Include(r => r.IdUnitStockNavigation)
                                                .Include(r => r.ItemWarehouse)
                                                .ToList().Select(_itemBuilder.BuildEntity).ToList();

            // Get the current company
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;

            listItemViewModel.ForEach((item) =>
            {
                ItemWarehouseViewModel currentItemWarehouse = item.ItemWarehouse?.Where(p => p.IdWarehouse == idWarehouse)?.FirstOrDefault();
                item.RemainingQuantity = currentItemWarehouse != null ? AmountMethods.FormatValue((currentItemWarehouse.AvailableQuantity
                        - currentItemWarehouse.ReservedQuantity), item.IdUnitStockNavigation.DigitsAfterComma) : 0;
                item.OrderedQuantity = itemIdAndQuanity.Where(p => p.Key == item.Id).FirstOrDefault().Value;
                item.Htprice = AmountMethods.FormatValue((item.UnitHtsalePrice ?? 0) * item.OrderedQuantity, companyCurrency.Precision);
            });
            DataSourceResult<ItemViewModel> dataSourceResult = new DataSourceResult<ItemViewModel>();
            dataSourceResult.data = listItemViewModel;
            dataSourceResult.total = listItemViewModel.Count;
            return dataSourceResult;
        }
        #endregion
    }
}


