using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
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
        /// update stauts of document line to "Provisoire"
        /// </summary>
        /// <param name="document"></param>
        private void SetDocumentLinesStatus(DocumentViewModel document)
        {
            document.DocumentLine.ToList().ForEach(p => p.IdDocumentLineStatus = document.IdDocumentStatus);
        }

        /// <summary>
        /// update stauts of document line to "Provisoire"
        /// </summary>
        /// <param name="document"></param>
        private void SetDocumentLinesStatusForUpdate(DocumentViewModel document)
        {
            document.DocumentLine.Where(p => !p.IdDocumentLineStatus.HasValue).ToList().ForEach(p => p.IdDocumentLineStatus = document.IdDocumentStatus);
        }

        /// <summary>
        /// set document Month date
        /// </summary>
        /// <param name="document"></param>
        private void SetDocumentDate(DocumentViewModel document)
        {
            document.DocumentMonthDate = Convert.ToInt32(document.DocumentDate.ToString("yyyyMM"));
            document.CreationDate = document.CreationDate == null ? DateTime.Now : document.CreationDate;
        }

        private void SetRemainingAmount(DocumentViewModel document)
        {
            if (new[] { DocumentEnumerator.PurchaseAsset, DocumentEnumerator.SalesInvoiceAsset,
                DocumentEnumerator.PurchaseInvoice, DocumentEnumerator.SalesInvoice }.Contains(document.DocumentTypeCode))
            {
                document.DocumentRemainingAmount = document.DocumentTtcprice;
                document.DocumentRemainingAmountWithCurrency = document.DocumentTtcpriceWithCurrency;
            }
        }

        /// <summary>
        /// Convert amount of document (TTC) to Letter
        /// </summary>
        /// <param name="document"></param>
        private void ConvertAmountToLetter(DocumentViewModel document)
        {
            Currency usedCurrency = _entityRepoCurrency.GetAllAsNoTracking().FirstOrDefault(x => x.Id == document.IdUsedCurrency);
            string culture = _entityRepoCompany.GetAllAsNoTracking().FirstOrDefault().Culture;
            document.AmountInLetter = HumanizerUtils.DecimalToWords(Convert.ToDecimal(document.DocumentTtcpriceWithCurrency), culture, usedCurrency);
        }

        /// <summary>
        /// addDocument
        /// </summary>
        /// <param name="files"></param>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public void AddDocumentOperation(IList<IFormFile> files, DocumentViewModel document, DocumentType documentType, string userMail, string property = null)
        {
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
            int precision = documentType.IsSaleDocumentType ? companyCurrency.Precision : companyCurrency.Precision;
            if (document.IdTiers != null && document.IdTiers != 0)
            {
                CalculateDocumentAndDocumenLineValues(document);
                SetDocumentValueCurrency(document, precision);
                //SetDocumentFinancialCommitment(document, documentType);

                ConvertAmountToLetter(document);

                CopyFile(files, document);
            }
            SetDocumentLinesStatus(document);
            SetDocumentDate(document);
            SetRemainingAmount(document);
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery && document.DocumentExpenseLine != null && document.DocumentExpenseLine.Any())
            {
                SetExchangeLinesValueCurrency(document.DocumentExpenseLine.ToList(), document.DocumentDate, precision);
                VerifyCostPrice(document);
            }
            MangeStockSalesDeliveryMultiDocumentLinesInsert(document);
        }

        private void VerifyCostPrice(DocumentViewModel document)
        {
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
            InputToCalculateCoefficientOfPriceCostViewModel priceCost = new InputToCalculateCoefficientOfPriceCostViewModel
            {
                DocumentDate = document.DocumentDate,
                TotalDocumentPrice = document.DocumentHtpriceWithCurrency ?? 0,
                TotalExpensePrice = document.DocumentExpenseLine.Sum(p => p.HtAmoutLine),
                IdCurrency = document.IdUsedCurrency ?? 0
            };
            var coef = _serviceDocumentExpenseLine.CalculateCoefficientOfCostPrice(priceCost);
            document.DocumentLine.ToList().ForEach(p =>
            {
                if (p.PercentageMargin < 0)
                {
                    p.PercentageMargin = 0;
                }

                if (p.PercentageMargin > 100)
                {
                    p.PercentageMargin = 100;
                }
                p.PercentageMargin = (p.PercentageMargin != null) ? p.PercentageMargin : 0;
                p.CostPrice = AmountMethods.FormatValue((p.HtAmountWithCurrency ?? 0) * coef, companyCurrency.Precision);
                p.SellingPrice = AmountMethods.FormatValue(((p.CostPrice + (p.CostPrice * p.PercentageMargin / 100)) ?? 0), companyCurrency.Precision);
            });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="document"></param>
        private void CalculateDocumentAndDocumenLineValues(DocumentViewModel document)
        {

            Document documentModel = _builderdocument.BuildModel(document);
            var tiers = _entityRepoTiers.GetSingleNotTracked(x=>x.Id==document.IdTiers);
            var documentType = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.CodeType == document.DocumentTypeCode);
            int precisionTierValues = GetPrecissionValue((int)tiers.IdCurrency, document.DocumentTypeCode);
            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue((int)document.IdUsedCurrency, document.DocumentDate, document.ExchangeRate);
            var companyPrecision = GetCompanyCurrencyPrecision();
            var listofitemList = document.DocumentLine.Select(y => y.IdItem);

            var ItemListViewModel = _itemEntityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => listofitemList.Contains(x.Id)
            , x => x.IdUnitSalesNavigation, z => z.IdUnitStockNavigation, z => z.IdNatureNavigation, x => x.TaxeItem,x=>x.ItemWarehouse);

            foreach (var documentLine in document.DocumentLine.Where(x => !x.IsDeleted).ToList())
            {
                //CalculateDocumentLine(documentLine, calculDocument);
                ItemPriceViewModel priceViewModel = new ItemPriceViewModel
                {
                    DocumentDate = document.DocumentDate,
                    DocumentLineViewModel = documentLine,
                    DocumentType = document.DocumentTypeCode,
                    IdCurrency = document.IdUsedCurrency ?? 0,
                    IdTiers = document.IdTiers ?? 0,
                    Tiers = tiers,
                    Document = documentModel,
                    DocumentTypeObject = documentType,
                    TiersPrecison = precisionTierValues,
                    CompanyPrecison = companyPrecision,
                    Item = ItemListViewModel.First(x => x.Id == documentLine.IdItem),
                    exchangeRate = exchangeRate
                };

                GetDocumentLinePrice(priceViewModel);
                CalculateDocumentLine(priceViewModel);
            }
            documentModel = _builderdocument.BuildModel(document);
            documentModel.DocumentLine.ToList().ForEach(dl =>
            {
                dl.DocumentLineTaxe.ToList().ForEach(x =>
                {
                    x.IdDocumentLineNavigation = dl;
                });
            });
            List<DocumentTaxsResume> updatedDocumentTaxsResumes = new List<DocumentTaxsResume>();
            CalculDocument(document, updatedDocumentTaxsResumes, null, documentModel);
            document.DocumentTaxsResume = updatedDocumentTaxsResumes.Select(x => _documentTaxsResumeBuilder.BuildEntity(x)).ToList();

        }


       

        /// <summary>
        /// 
        /// </summary>
        /// <param name="document"></param>
        private void SetDocumentValueCurrency(DocumentViewModel document, int precision)
        {

            var exchangeRate = document.ExchangeRate;

            document.DocumentHtprice = document.DocumentLine != null ? AmountMethods.FormatValue(document.DocumentLine.Sum(x => x.HtTotalLine.Value), precision) : 0;

            document.DocumentOtherTaxes = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentOtherTaxesWithCurrency : document.DocumentOtherTaxesWithCurrency, precision);
            document.DocumentPriceIncludeVat = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentPriceIncludeVatWithCurrency : document.DocumentPriceIncludeVatWithCurrency, precision);
            document.DocumentTotalDiscount = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTotalDiscountWithCurrency : document.DocumentTotalDiscountWithCurrency, precision);
            document.DocumentTotalExcVatTaxes = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTotalExcVatTaxesWithCurrency : document.DocumentTotalExcVatTaxesWithCurrency, precision);
            document.DocumentTotalVatTaxes = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTotalVatTaxesWithCurrency : document.DocumentTotalVatTaxesWithCurrency, precision);

            document.DocumentRemainingAmount = document.DocumentTtcprice;
            if (!exchangeRate.Equals(1))
            {
                document.ExchangeRate = exchangeRate;
            }

        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="files"></param>
        /// <param name="document"></param>
        /// <param name="entityAxisValues"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public DocumentViewModel UpdateDocumentOperation(IList<IFormFile> files, DocumentViewModel document,
            IList<EntityAxisValuesViewModel> entityAxisValues, string userMail, bool manageFile = true)
        {

            int precision = GetCompanyCurrencyPrecision();
            if (document.IdTiers != null && document.IdTiers != 0)
            {
                CalculateDocumentAndDocumenLineValues(document);
                SetDocumentValueCurrency(document, precision);
                SetFileDocument(files, document);
                ConvertAmountToLetter(document);
                if (manageFile)
                {
                    ManageFile(files, document);
                }

            }
            SetDocumentLinesStatusForUpdate(document);
            SetDocumentDate(document);
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery && document.DocumentExpenseLine != null)
            {
                SetExchangeLinesValueCurrency(document.DocumentExpenseLine, document.DocumentDate, precision);
                VerifyCostPrice(document);
            }
            return document;

        }
        private void SetExchangeLinesValueCurrency(IEnumerable<DocumentExpenseLineViewModel> documentExpenseLineViewModels, DateTime documentDate, int precision)
        {
            var documentIds = documentExpenseLineViewModels.Select(x => x.IdDocument);
            var documentsExchangeRate = FindModelBy(x => documentIds.Contains(x.Id)).ToList();

            documentExpenseLineViewModels.ToList().ForEach(line =>
            {
                var documentExchangeRate = documentsExchangeRate.FirstOrDefault(x => x.Id == line.IdDocument).ExchangeRate;

                var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(line.IdCurrency ?? 0, documentDate, documentExchangeRate);

                line.HtAmoutLine = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * line.HtAmountLineWithCurrency : line.HtAmountLineWithCurrency, precision);
                line.TtcAmoutLine = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * line.TtcAmountLineWithCurrency : line.TtcAmountLineWithCurrency, precision);
            });
        }
        public DocumentViewModel ValidateOperation(int idDocument, string userMail, int status, bool isFromAssocieteddocument, bool isDepositInvoice = false )
        {
            DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == idDocument,
               doc => doc.IdTiersNavigation, expesne => expesne.DocumentExpenseLine);
            if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType != (int)InvoicingTypeEnumerator.advancePayment)
            {
                if (_entityRepo.GetAllWithConditionsRelationsAsNoTracking(p => p.DocumentTypeCode == document.DocumentTypeCode
                                                     && p.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
                                                     && !p.IsDeleted && p.IsRestaurn == document.IsRestaurn
                                                     && DateTime.Compare(p.DocumentDate.Date, document.DocumentDate.Date) < 0).Count() > 0)
                {
                    throw new CustomException(CustomStatusCode.VALIDATE_PREVIOUS_INVOICES);
                }
            }
            SettlementMode settlementMode = _entitySettlementModeRepo.FindByAsNoTracking(x => x.Id == document.IdSettlementMode).FirstOrDefault();
            if((document.DocumentTypeCode == DocumentEnumerator.SalesInvoice || document.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice) && settlementMode == null)
            {
                throw new CustomException(CustomStatusCode.DeletedSettlementMode);
            }
            if (document == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            var dlLines = _serviceDocumentLine.FindModelsByNoTracked(x => x.IdDocument == document.Id, x => x.IdItemNavigation);
            document.DocumentLine = dlLines;
            int idtier = (int)document.IdTiers;
            if (!document.DocumentLine.Any())
            {
                throw new CustomException(CustomStatusCode.NoLinesAreAdded);
            }
            User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);
            document.IdValidator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId;
            if (document.IdCreator == 0 || document.IdCreator == null)
            {
                document.IdCreator = document.IdValidator;
            }
            if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || document.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
            {
                if (status == (int)DocumentStatusEnumerator.Valid ||
                    status == (int)DocumentStatusEnumerator.Printed)
                {
                    GenerateValidationCodification(document, isDepositInvoice);
                }

                if (document.DocumentTypeCode == DocumentEnumerator.SalesOrder && document.IsBToB == true)
                {
                    document.IsSynchronizedBtoB = false;
                }
                DocumentType documentType = _entityDocumentTypeRepo
                        .GetSingleWithRelationsNotTracked(c => c.CodeType == document.DocumentTypeCode, p => p.DefaultCodeDocumentTypeAssociatedNavigation);
                List<int> idsItems = dlLines.Where(z => z.IdItemNavigation.ProvInventory).Select(x => x.IdItem).Distinct().ToList();

                if (idsItems.Any())
                {
                    if (documentType.CodeType == DocumentEnumerator.BE  || documentType.CodeType == DocumentEnumerator.PurchaseDelivery
                        || documentType.CodeType == DocumentEnumerator.PurchaseAsset)
                    {
                        IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                    x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                    && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                    && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSourceNavigation.IsCentral));
                        if (inventaireList.Any())
                        {
                            throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                        }
                    }
                    if (documentType.CodeType == DocumentEnumerator.SalesAsset || documentType.CodeType == DocumentEnumerator.SalesDelivery || documentType.CodeType == DocumentEnumerator.BS
                        || documentType.CodeType == DocumentEnumerator.SalesInvoice || documentType.CodeType == DocumentEnumerator.SalesInvoiceAsset)
                    {
                        List<int?> idsWarehouses = dlLines.Where(z => z.IdItemNavigation.ProvInventory).Select(x => x.IdWarehouse).Distinct().ToList();
                        IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                    x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                    && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                    && (x.IdStockDocumentNavigation.IdTiers != null || idsWarehouses.Contains(x.IdStockDocumentNavigation.IdWarehouseSource)));
                        if (inventaireList.Any())
                        {
                            throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                        }
                    }
                }
                MangetStockOperation(document, documentType, isFromAssocieteddocument, userMail);
                ChangeDocumentAndLinesToNewStatus(document, status);
                if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery && !isFromAssocieteddocument)
                {
                    CalculateOldSalesPurchasePrice(document.DocumentLine.ToList());
                    GenerateInvoice(document);
                }  
                SetDocumentFinancialCommitment(document, documentType);
                if (document != null && document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.IdSalesOrder != null && document.IdSalesDepositInvoice != null)
                {
                    Document depositInvoice = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == document.IdSalesDepositInvoice, x => x.FinancialCommitment);
                    List<FinancialCommitment> financialCommitment = depositInvoice.FinancialCommitment.ToList();

                    financialCommitment.ForEach(x =>
                    {
                        x.IdDocument = document.Id;
                        x.IdDocumentNavigation = null;
                    });
                    _serviceFinancialCommitment.BulkUpdateModelWithoutTransaction(financialCommitment);
                }

                if ((document.DocumentTypeCode != DocumentEnumerator.SalesInvoice ||
                    (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType != (int)InvoicingTypeEnumerator.Other && document.InoicingType != (int)InvoicingTypeEnumerator.advancePayment)) && !(bool)document.IsRestaurn
                   )
                {
                    CreateDocumentAssociated(document, userMail, documentType);
                }
                if (document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder)
                {
                    updatePucrhasePrice(document.DocumentLine.ToList(), idtier);

                } 
                SoldeDocumentAssociated(document.Id, userMail);
                ValidateBPU(status, document);
                _unitOfWork.Commit();
                }
            else if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Printed)
            {
                document.IdDocumentStatus = status;
                document.ValidationDate = DateTime.Today;
                _entityDocumentLineRepo.QuerableGetAll().Where(p => p.IdDocument == document.Id && (p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Printed
                                                                                    || p.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Provisional))
                    .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = status });
                Document entity = _builder.BuildModel(document);
                _entityRepo.Update(entity);
                _unitOfWork.Commit();
            }
            return document;
        }
        
        private void CalculateOldSalesPurchasePrice(IList<DocumentLineViewModel> documentLine)
        {
            int precision = GetCompanyCurrencyPrecision();
            List<int> idItems = documentLine.Select(p => p.IdItem).Distinct().ToList();
            List<Item> itemsList = _itemEntityRepo.GetAllWithConditionsRelationsAsNoTracking(item => idItems.Contains(item.Id)).ToList();

            documentLine.ToList().ForEach(x =>
            {
                var item = itemsList.First(y => y.Id == x.IdItem);
                item.UnitHtsalePrice = AmountMethods.FormatValue(x.ConclusiveSellingPrice, precision);
                item.UnitHtpurchasePrice = AmountMethods.FormatValue(x.HtUnitAmountWithCurrency, precision);
                item.CostPrice = AmountMethods.FormatValue(x.CostPrice, precision);
            });

            _itemEntityRepo.BulkUpdate(itemsList);
            _unitOfWork.Commit();
        }
        private void updatePucrhasePrice(List<DocumentLineViewModel> documentLines, int idtiers)
        {
            List<int> idItems = documentLines.Select(p => p.IdItem).Distinct().ToList();
            List<ItemTiersViewModel> itemsTiers = _serviceItemTiers.GetAllModelsAsNoTracking().Where(x => x.IdTiers == idtiers && idItems.Contains(x.IdItem)).ToList();
            int precision = GetCompanyCurrencyPrecision();
            foreach (var item in documentLines)
            {
                var purchasePrice = item.UnitPriceFromQuotation > 0 ? item.UnitPriceFromQuotation : item.HtAmountWithCurrency ?? 0;
                item.IdItemNavigation.UnitHtpurchasePrice = AmountMethods.FormatValue(purchasePrice, precision);
                if (itemsTiers.Where(x => x.IdItem == item.IdItem).Any())
                {
                    itemsTiers.Where(x => x.IdItem == item.IdItem).FirstOrDefault().PurchasePrice = item.IdItemNavigation.UnitHtpurchasePrice;
                }
            }
            List<ItemViewModel> listItemsDocLine= documentLines.Select(x => x.IdItemNavigation).ToList();
            if(listItemsDocLine!=null && listItemsDocLine.Any())
            {
                List<ItemViewModel> itemsToUpdate = listItemsDocLine.OrderByDescending(z => z.UnitHtpurchasePrice).GroupBy(x => x.Id).Select(y => y.First()).ToList();
                _serviceItem.BulkUpdateModelWithoutTransaction(itemsToUpdate, null);
            }
            
            _serviceItemTiers.BulkUpdateModelWithoutTransaction(itemsTiers, null);
        }
        private void MangetStockOperation(DocumentViewModel document, DocumentType documentType, bool isFromAssocieteddocument, string userMail)
        {
            if (document.DocumentTypeCode == DocumentEnumerator.BS)
            {
                var documentAssocieted = document.DocumentLine.Where(x => x.IdDocumentAssociated != null).Select(x => x.IdDocumentAssociated).ToList();
                if (documentAssocieted != null && documentAssocieted.Any())
                {
                    return;
                }
                ManageStockMovementForValidation(document, documentType);
            }
            else
            {
                if (documentType.IsStockAffected && (isFromAssocieteddocument
                    || document.DocumentTypeCode != DocumentEnumerator.SalesDelivery))
                {
                    ManageStockMovementForValidation(document, documentType);
                }

                if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery && !isFromAssocieteddocument)
                {
                    CheckAmountCeilling(document.IdTiersNavigation, document.DocumentTtcpriceWithCurrency);
                    ValidateStockMovementFromSalesDelivery(document);
                    SplitSalesDeliveryWithReservationLine(document, userMail);
                }
            }
        }

        private void ValidateBPU(int status, DocumentViewModel document)
        {
            if (status == (int)DocumentStatusEnumerator.Valid && document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder &&
                document.IdDocumentAssociated != null)
            {
                DocumentViewModel documentAssociated = GetModelAsNoTracked(x => x.Id == document.IdDocumentAssociated.Value);
                if (documentAssociated != null && documentAssociated.IdDocumentStatus != status)
                {
                    documentAssociated.IdDocumentStatus = status;

                    _entityDocumentLineRepo.QuerableGetAll().Where(p => p.IdDocument == documentAssociated.Id)
                                            .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = status });
                    _entityRepo.Update(_builder.BuildModel(documentAssociated));
                }

            }
        }
        private void GenerateValidationCodification(DocumentViewModel document, bool isDepositInvoice = false)
        {
            if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice || document.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                || (document.DocumentTypeCode == DocumentEnumerator.BS && !_entityClaimRepo.GetAllAsNoTracking().Any(p => p.IdMovementOut == document.Id)) || document.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset
                || document.DocumentTypeCode == DocumentEnumerator.SalesAsset)
            {
                if ((document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType != (int)InvoicingTypeEnumerator.advancePayment) || document.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset)
                {
                    if (_entityRepo.GetCountWithPredicate(p => p.DocumentTypeCode == document.DocumentTypeCode
                                                         && p.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
                                                         && !p.IsDeleted && p.IsRestaurn == document.IsRestaurn
                                                         && DateTime.Compare(p.DocumentDate.Date, document.DocumentDate.Date) < 0) > 0)
                    {
                        throw new CustomException(CustomStatusCode.VALIDATE_PREVIOUS_INVOICES);
                    }
                }
                else if (document.DocumentTypeCode == DocumentEnumerator.SalesDelivery || document.DocumentTypeCode == DocumentEnumerator.BS
                    || document.DocumentTypeCode == DocumentEnumerator.SalesAsset)
                {
                    document.DocumentDate = DateTime.Now;
                }

                // Generate Codification
                List<object> codification;
                Document entity = _builder.BuildModel(document);

                codification = getCodification(entity, "DocumentTypeCode", true, false, isDepositInvoice);

                document.Code = codification[2].ToString();

                if (codification.Any() && ((Codification)codification[0]).Id != 0)
                {
                    ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                    _entityRepoCodification.Update(((Codification)codification[0]));
                    _unitOfWork.Commit();
                }
            }
            else if (document.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice || document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery
                || document.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder || document.DocumentTypeCode == DocumentEnumerator.PurchaseAsset || document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder)
            {
                document.ValidationDate = DateTime.Now;
                // Generate Codification
                List<object> codification;
                Document entity = _builder.BuildModel(document);


                codification = getCodification(entity, "DocumentTypeCode", true, false);

                document.Code = codification[2].ToString();

                if (codification.Any() && ((Codification)codification[0]).Id != 0)
                {
                    ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                    _entityRepoCodification.Update(((Codification)codification[0]));
                    _unitOfWork.Commit();
                }
            }
        }

        public List<DocumentViewModel> FindDocumentBudget(int id)
        {
            var Document = GetAllModelsQueryableWithRelation(x => x.IdPriceRequest == id && x.DocumentTypeCode == DocumentEnumerator.PurchaseBudget).Select(x => x.Id).ToList();

            return FindDocumentWithDocumentLine(Document);
        }


        public DocumentViewModel GetPurchaseBudgetForPriceRequest(PurchaseBudgetPriceRequest purchaseBudgetPriceRequest)
        {
            var prisceRequest = _servicePriceRequest.GetModelWithRelations(x => x.Id == purchaseBudgetPriceRequest.IdPriceRequest, x => x.PriceRequestDetail);

            var document = CreateDocumentLineForPriceRequest(prisceRequest.PriceRequestDetail.Where(x => x.IdTiers == purchaseBudgetPriceRequest.IdTiers).ToList());
            return GetDocumentDetails(document.Id, null);
        }

        private CreatedDataViewModel CreateDocumentLineForPriceRequest(List<PriceRequestDetailViewModel> priceRequestDetails)
        {
            var documentLines = new List<DocumentLineViewModel>();
            var itemsList = priceRequestDetails.Select(y => y.IdItem);

            List<ItemViewModel> itemObject = _serviceItem.GetItemDetails(itemsList);
            DocumentViewModel document = new DocumentViewModel
            {
                DocumentDate = DateTime.Now,
                CreationDate = DateTime.Now,
                IdPriceRequest = priceRequestDetails.First().IdPriceRequest,
                DocumentTypeCode = DocumentEnumerator.PurchaseBudget,
                IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                IdTiers = priceRequestDetails.First().IdTiers
            };
            var tiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == document.IdTiers);
            document.IsGenerated = true;
            document.IdUsedCurrency = tiers.IdCurrency;
            foreach (var priceRequestDetail in priceRequestDetails)
            {
                DocumentLineViewModel documentLine = new DocumentLineViewModel();
                ItemViewModel item = itemObject.First(x => x.Id == priceRequestDetail.IdItem);
                var itemTier = item.ItemTiers.Where(x => x.IdTiers == tiers.Id);
                documentLine.IdDocument = document.Id;
                documentLine.IdItem = priceRequestDetail.IdItem;
                documentLine.MovementQty = priceRequestDetail.MovementQty;
                documentLine.DiscountPercentage = 0;
                documentLine.MesureUnitLabel = item.IdUnitSalesNavigation != null ? item.IdUnitSalesNavigation.Label : null;
                documentLine.HtUnitAmountWithCurrency = itemTier != null && itemTier.Any() ? itemTier.First().PurchasePrice : 0;
                documentLine.HtAmountWithCurrency = documentLine.HtUnitAmountWithCurrency;
                documentLine.HtTotalLineWithCurrency = documentLine.HtUnitAmountWithCurrency * priceRequestDetail.MovementQty;
                documentLine.IdMeasureUnit = item.IdUnitSales;
                documentLine.Designation = item.Description;
                documentLine.IdItemNavigation = item;
                documentLine.Taxe = documentLine.IdItemNavigation.TaxeItem.Select(x => x.IdTaxeNavigation).ToList();
                documentLine.IdDocumentLineStatus = document.IdDocumentStatus;
                documentLines.Add(documentLine);
            }
            document.DocumentLine = documentLines;
            return (CreatedDataViewModel)AddDocument(null, document, null, null);
        }

        public void UpdateDocumentLine(Document document)
        {
            foreach (DocumentLine documentLine in document.DocumentLine)
            {
                documentLine.IdItemNavigation = null;
                documentLine.IdDocumentNavigation = null;
                documentLine.IdDocumentLineAssociatedNavigation = null;
                // add new line 
                if (documentLine.Id == 0)
                {
                    documentLine.IdDocument = document.Id;
                    _entityDocumentLineRepo.Add(documentLine);
                }
                //update old line
                else
                {
                    // line deleted
                    if (documentLine.IsDeleted)
                    {
                        // delete taxes of document line
                        foreach (DocumentLineTaxe documentLineTaxe in documentLine.DocumentLineTaxe)
                        {
                            DocumentLineTaxe oldDocumentLineTaxe = _entityDocumentLineTaxeRepo
                                .FindByAsNoTracking(p => p.IdTaxe == documentLineTaxe.IdTaxe && p.IdDocumentLine == documentLine.Id).FirstOrDefault();
                            oldDocumentLineTaxe.IsDeleted = true;
                            oldDocumentLineTaxe.DeletedToken = Guid.NewGuid().ToString();
                            _entityDocumentLineTaxeRepo.Update(oldDocumentLineTaxe);
                        }
                        // delete prices of document line
                        foreach (DocumentLinePrices documentLinePrices in documentLine.DocumentLinePrices)
                        {
                            documentLinePrices.IsDeleted = true;
                            documentLinePrices.DeletedToken = Guid.NewGuid().ToString();
                            _entityDocumentLinePricesRepo.Update(documentLinePrices);
                        }


                        documentLine.DeletedToken = Guid.NewGuid().ToString();
                    }
                    else
                    {
                        _entityDocumentLineTaxeRepo.BulkUpdate(documentLine.DocumentLineTaxe.ToList());
                    }

                    documentLine.DocumentLineTaxe.Clear();
                    documentLine.DocumentLinePrices.Clear();
                    _entityDocumentLineRepo.Update(documentLine);
                }
            }
        }

        public void SplitSalesDeliveryWithReservationLine(DocumentViewModel document, string userMail)
        {
            IList<DocumentLineViewModel> reservationLines = new List<DocumentLineViewModel>();
            IList<DocumentLineViewModel> lineToUpdate = new List<DocumentLineViewModel>();

            List<int> idDocumentLine = document.DocumentLine.Select(p => p.Id).ToList();
            List<StockMovementViewModel> stockMovementList = _serviceStockMovement.FindByAsNoTracking(y => idDocumentLine.Contains(y.IdDocumentLine.Value)
            && y.Status == DocumentEnumerator.Reservation).ToList();

            if (stockMovementList.Any())
            {
                stockMovementList.ForEach(stockLine =>
                {
                    DocumentLineViewModel line = document.DocumentLine.FirstOrDefault(y => y.Id == stockLine.IdDocumentLine);
                    DocumentLineViewModel dLVM = new DocumentLineViewModel();
                    _documentLineBuilder.MappingEntity(line, dLVM);
                    dLVM.StockMovement = new List<StockMovementViewModel>
                    {
                        stockLine
                    };
                    reservationLines.Add(dLVM);

                    // delete reservation line
                    line.IsDeleted = true;
                    line.DeletedToken = Guid.NewGuid().ToString();
                    // delete taxes of document line
                    _entityDocumentLineTaxeRepo.GetAllAsNoTracking().Where(p => p.IdDocumentLine == line.Id)
                            .UpdateFromQuery(documentLineTaxe => new DocumentLineTaxe
                            {
                                IsDeleted = true,
                                DeletedToken = Guid.NewGuid().ToString()

                            });
                    // delete prices of document line
                    _entityDocumentLinePricesRepo.GetAllAsNoTracking().Where(p => p.IdDocumentLine == line.Id)
                            .UpdateFromQuery(documentLinePrice => new DocumentLinePrices
                            {
                                IsDeleted = true,
                                DeletedToken = Guid.NewGuid().ToString()
                            });
                    // delete stockMovements of document line 
                    stockLine.IsDeleted = true;
                    stockLine.DeletedToken = Guid.NewGuid().ToString();
                    lineToUpdate.Add(line);
                });

                _entityStockMovementRepo.BulkUpdate(stockMovementList.Select(stockLine => _stockMovementBuilder.BuildModel(stockLine)).ToList());

                if (reservationLines.Any())
                {
                    _serviceDocumentLine.BulkUpdateModelWithoutTransaction(lineToUpdate, userMail);
                    // Update Sales Delivery total document
                    int precisionCompany = GetCompanyCurrencyPrecision();
                    ReduisDocumentViewModel reduisDocument = new ReduisDocumentViewModel
                    {
                        DocumentType = document.DocumentTypeCode,
                        DocumentDate = DateTime.Today,
                        IdTiers = document.IdTiers ?? 0,
                        DocumentOtherTaxe = document.DocumentOtherTaxesWithCurrency ?? 0,
                        DocumentLine = document.DocumentLine,
                    };
                    var totalDocument = GetDocumentTotalPrice(reduisDocument);
                    document.DocumentHtpriceWithCurrency = totalDocument.DocumentHtpriceWithCurrency;
                    document.DocumentTotalVatTaxesWithCurrency = totalDocument.DocumentTotalVatTaxesWithCurrency;
                    document.DocumentTtcpriceWithCurrency = totalDocument.DocumentTtcpriceWithCurrency;
                    document.DocumentTotalDiscountWithCurrency = totalDocument.DocumentTotalDiscountWithCurrency;
                    document.DocumentPriceIncludeVatWithCurrency = totalDocument.DocumentPriceIncludeVatWithCurrency;
                    document.DocumentTotalExcVatTaxesWithCurrency = totalDocument.DocumentTotalExcVatTaxesWithCurrency;

                    var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);
                    document.DocumentHtprice = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentHtpriceWithCurrency : document.DocumentHtpriceWithCurrency, precisionCompany);
                    document.DocumentOtherTaxes = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentOtherTaxesWithCurrency : document.DocumentOtherTaxesWithCurrency, precisionCompany);
                    document.DocumentPriceIncludeVat = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentPriceIncludeVatWithCurrency : document.DocumentPriceIncludeVatWithCurrency, precisionCompany);
                    document.DocumentTotalDiscount = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTotalDiscountWithCurrency : document.DocumentTotalDiscountWithCurrency, precisionCompany);
                    document.DocumentTotalExcVatTaxes = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTotalExcVatTaxesWithCurrency : document.DocumentTotalExcVatTaxesWithCurrency, precisionCompany);
                    document.DocumentTotalVatTaxes = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTotalVatTaxesWithCurrency : document.DocumentTotalVatTaxesWithCurrency, precisionCompany);
                    document.DocumentTtcprice = AmountMethods.FormatValue((exchangeRate != null && exchangeRate > 0) ? exchangeRate * document.DocumentTtcpriceWithCurrency : document.DocumentTtcpriceWithCurrency, precisionCompany);
                    ConvertAmountToLetter(document);

                    // add new Sales Delivery
                    DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);
                    DocumentViewModel newDocument = new DocumentViewModel
                    {
                        IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                        DocumentTypeCode = document.DocumentTypeCode,
                        IdTiers = document.IdTiers,
                        IdDeliveryType = document.IdDeliveryType,
                        IdDiscountGroupTiers = document.IdDiscountGroupTiers,
                        IsTermBilling = document.IsTermBilling,
                        DocumentDate = document.DocumentDate,
                        IdUsedCurrency = document.IdUsedCurrency,
                        IdContact = document.IdContact,
                        IdCreator = document.IdCreator,
                        CreationDate = DateTime.Now
                    };
                    newDocument.DocumentLine = new List<DocumentLineViewModel>();
                    reservationLines.ToList().ForEach(line =>
                    {
                        line.Id = 0;
                        line.IdDocument = 0;
                        line.IsValidReservationFromProvisionalStock = true;
                        line.IdDocumentLineStatus = newDocument.IdDocumentStatus;
                        line.StockMovement.ToList().ForEach(x => { x.IdDocumentLine = 0; x.Id = 0; x.IsDeleted = false; x.DeletedToken = null; });
                        newDocument.DocumentLine.Add(line);
                    });
                    AddDocumentWithoutTransaction(new List<IFormFile>(), newDocument, documentType, userMail, null);

                    UpdateDocumentAmountsWithoutTransaction(document.Id, null);
                }
            }
        }

    }
}
