using Infrastruture.Utility;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using Utils.Constants;
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
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        public DocumentViewModel UpdateDocumentInRealTimeOperations(DocumentViewModel document, DocumentType documentType,
            IList<EntityAxisValuesViewModel> entityAxisValues, string userMail)
        {
            CurrencyViewModel companyCurrency = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;
            int precision = (documentType != null && documentType.IsSaleDocumentType) ?
                 companyCurrency.Precision : companyCurrency.Precision;
            if (document.IdTiers != null && document.IdTiers != 0)
            {
                SetDocumentValueCurrency(document, precision);
                ConvertAmountToLetter(document);
                if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType == null)
                {
                    document.InoicingType = (int)InvoicingTypeEnumerator.Cash;
                }
            }
            return document;
        }
        public object AddDocumentInRealTime(IList<IFormFile> files, DocumentViewModel document, string userMail, IList<EntityAxisValuesViewModel> entityAxisValuesModelList)
        {
            BeginTransaction();
            CreatedDataViewModel addDocuemnt = AddDocumentWithoutTransactionInRealTime(files, document, userMail, entityAxisValuesModelList);
            EndTransaction();
            return addDocuemnt;
        }

        public override object AddModelWithoutTransaction(DocumentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            var isValid = model?.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid;
            if (isValid)
            {
                GenerateValidationCodification(model);
            }
            Document entity = _builder.BuildModel(model);

            // Generate Codification
            GenerateCodification(entity, property, false,false);
            entity.ProvisionalCode = entity.Code;
            if (isValid)
            {
                entity.Code = model.Code;
            }
            // add entity
            _entityRepo.Add(entity);
            // add entityAxesValues
            //AddEntityAxesValues(entityAxisValuesModelList, (int)entity.Id, userMail);
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), DocumentTtcpriceWithCurrency = entity.DocumentTtcpriceWithCurrency, Reference = entity.Reference, EntityName = entity.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        public CreatedDataViewModel AddDocumentWithoutTransactionInRealTime(IList<IFormFile> files, DocumentViewModel document, string userMail, IList<EntityAxisValuesViewModel> entityAxisValuesModelList)
        {
            SetDocumentDate(document);
            if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice)
            {
                document.InoicingType = (int)InvoicingTypeEnumerator.Cash;
            }

            document.IdCreator = _entityRepoUser.GetSingleNotTracked(x => x.Email == document.UserMail).Id;
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery || document.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice)
            {
                var exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate);
                if (exchangeRate > 0)
                {
                    document.ExchangeRate = exchangeRate;
                }
                if (document.Id == 0)
                {
                    ManageFileInRealTime(document);
                }
            }
            return (CreatedDataViewModel)AddModelWithoutTransaction(document, entityAxisValuesModelList, userMail, "DocumentTypeCode");
        }


        public List<DocumentLineViewModel> SaveBalances(DocumentWithDocumentLineViewModel documentLineViewModel)
        {
            List<DocumentLineViewModel> ListToSend = new List<DocumentLineViewModel>();

            Document document = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == documentLineViewModel.idDocument, r => r.IdTiersNavigation);
            List<int> idItem = documentLineViewModel.importedData.Select(x => x.IdItem).Distinct().ToList();
            List<Item> itemList = _itemEntityRepo.GetAllAsNoTracking().Include(x => x.IdUnitSalesNavigation).Include(z => z.IdUnitStockNavigation).Include(z => z.IdNatureNavigation)
                .Include(x => x.TaxeItem).Where(x => idItem.Contains(x.Id)).ToList();
            var tiers = document.IdTiersNavigation;
            var documentType = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.CodeType == document.DocumentTypeCode);
            int precisionTierValues = GetPrecissionValue((int)tiers.IdCurrency, document.DocumentTypeCode);
            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue((int)document.IdUsedCurrency, document.DocumentDate, document.ExchangeRate);

            foreach (var documentLineImported in documentLineViewModel.importedData)
            {
                DocumentLineViewModel rowToUpdate = null;
                var item = itemList.First(x => x.Id == documentLineImported.IdItem);
                ItemPriceViewModel itemPrice = new ItemPriceViewModel
                {
                    DocumentDate = documentLineViewModel.DocumentDate,
                    DocumentType = documentLineViewModel.DocumentType,
                    IdTiers = documentLineViewModel.IdTiers,
                    Tiers = tiers,
                    exchangeRate = exchangeRate,
                    Document = document,
                    DocumentTypeObject = documentType,
                    Item = item,
                    TiersPrecison = precisionTierValues,
                    CompanyPrecison = _serviceCompany.GetCompanyCurrencyPrecision(),
                };
                if (documentLineViewModel.gridData.Any())
                {
                    List<DocumentLineViewModel> documentLine = documentLineViewModel.gridData.Where(line => line.IdDocumentLineAssociated == documentLineImported.Id).ToList();

                    if (documentLine != null && documentLine.Count > 0)
                    {
                        rowToUpdate = documentLine[0];
                    }
                }
                if (rowToUpdate != null)
                {
                    rowToUpdate.IdDocument = documentLineViewModel.idDocument;
                    rowToUpdate.MovementQty = (rowToUpdate.MovementQty) + (documentLineImported.ReceivedQuantity);
                    rowToUpdate.RemainingQuantity = (documentLineImported.RemainingQuantity) - (documentLineImported.ReceivedQuantity);
                    if ((documentLineImported.UnitPriceFromQuotation != null) && (documentLineImported.UnitPriceFromQuotation != 0))
                    {
                        // if in the purchase order user has indicate the price of the quotation then usee this price as unitprice
                        rowToUpdate.HtUnitAmountWithCurrency = documentLineImported.UnitPriceFromQuotation;
                    }
                    itemPrice.DocumentLineViewModel = rowToUpdate;
                    CalculateDocumentLine(itemPrice);
                    var documentLine = _documentLineBuilder.BuildModel(rowToUpdate);
                    _entityDocumentLineRepo.Update(documentLine);
                    _unitOfWork.Commit();
                    rowToUpdate.Id = documentLine.Id;
                    ListToSend.Add(rowToUpdate);
                }

                else
                {
                    documentLineImported.MovementQty = (documentLineImported.ReceivedQuantity);
                    documentLineImported.RemainingQuantity = (documentLineImported.RemainingQuantity) - (documentLineImported.ReceivedQuantity);
                    if ((documentLineImported.UnitPriceFromQuotation != null) && (documentLineImported.UnitPriceFromQuotation != 0))
                    {
                        // if in the purchase order user has indicate the price of the quotation then usee this price as unitprice
                        documentLineImported.HtUnitAmountWithCurrency = documentLineImported.UnitPriceFromQuotation;
                    }
                    documentLineImported.IdDocumentNavigation = null;
                    documentLineImported.IdDocumentLineAssociated = documentLineImported.Id;
                    documentLineImported.Id = 0;
                    documentLineImported.IdDocument = documentLineViewModel.idDocument;

                    itemPrice.DocumentLineViewModel = documentLineImported;
                    CalculateDocumentLine(itemPrice);
                    var documentLine = _documentLineBuilder.BuildModel(documentLineImported);
                    _entityDocumentLineRepo.Add(documentLine);
                    _unitOfWork.Commit();
                    documentLineImported.Id = documentLine.Id;
                    ListToSend.Add(documentLineImported);
                }
            }

            return ListToSend.Union(documentLineViewModel.gridData, new EntityComparator<DocumentLineViewModel>()).ToList();

        }


        public void CalculateDocumentLine(ItemPriceViewModel itemPricesViewModel, bool recalculDiscount = false, bool fromInverseDiscount = false)
        {
            CheckitemPricesObject(itemPricesViewModel);
            var exchangeRate = itemPricesViewModel.exchangeRate;
            DocumentLineViewModel documentCalculated = CalculeDocumentLine(itemPricesViewModel, itemPricesViewModel.TiersPrecison);
            itemPricesViewModel.DocumentLineViewModel.HtTotalLineWithCurrency = documentCalculated.HtTotalLineWithCurrency;
            itemPricesViewModel.DocumentLineViewModel.ExcVatTaxAmountWithCurrency = documentCalculated.ExcVatTaxAmountWithCurrency;
            itemPricesViewModel.DocumentLineViewModel.VatTaxAmountWithCurrency = documentCalculated.VatTaxAmountWithCurrency;
            itemPricesViewModel.DocumentLineViewModel.TtcTotalLineWithCurrency = documentCalculated.TtcTotalLineWithCurrency;
            SetDocumentLineValueCurrency(itemPricesViewModel.DocumentLineViewModel, itemPricesViewModel.exchangeRate, itemPricesViewModel.CompanyPrecison);
            if (recalculDiscount == true)
            {
                itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = null;
            }
            if (fromInverseDiscount == false)
            {
                itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = GetTaxValues(itemPricesViewModel, recalculDiscount);
            }
            else
            {
                itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = GetTaxValues(itemPricesViewModel, false, fromInverseDiscount);
            }

            itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = GetTaxValues(itemPricesViewModel, recalculDiscount);

            if (itemPricesViewModel.DocumentLineViewModel.UnitPriceFromQuotation > 0)
            {
                itemPricesViewModel.DocumentLineViewModel.HtAmount = ((exchangeRate > 0) ? exchangeRate * itemPricesViewModel.DocumentLineViewModel.UnitPriceFromQuotation : itemPricesViewModel.DocumentLineViewModel.UnitPriceFromQuotation) ?? 0;
            }
            else
            {
                itemPricesViewModel.DocumentLineViewModel.HtAmount = ((exchangeRate > 0) ? exchangeRate * itemPricesViewModel.DocumentLineViewModel.HtAmountWithCurrency : itemPricesViewModel.DocumentLineViewModel.HtAmountWithCurrency) ?? 0;
            }
            itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus = itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus ?? (int)DocumentStatusEnumerator.Provisional;
        }
        private void SetDocumentLineValueCurrency(DocumentLineViewModel dlViewModel, double exchangeRate, int precision)
        {

            dlViewModel.ExcVatTaxAmount = exchangeRate * dlViewModel.ExcVatTaxAmountWithCurrency;
            dlViewModel.HtTotalLine = AmountMethods.FormatValue((exchangeRate > 0) ? exchangeRate * dlViewModel.HtTotalLineWithCurrency : dlViewModel.HtTotalLineWithCurrency, precision);
            dlViewModel.HtUnitAmount = AmountMethods.FormatValue((exchangeRate > 0) ? exchangeRate * dlViewModel.HtUnitAmountWithCurrency : dlViewModel.HtUnitAmountWithCurrency, precision);
            dlViewModel.TtcTotalLine = AmountMethods.FormatValue((exchangeRate > 0) ? exchangeRate * dlViewModel.TtcTotalLineWithCurrency : dlViewModel.TtcTotalLineWithCurrency, precision);
            dlViewModel.VatTaxAmount = AmountMethods.FormatValue((exchangeRate > 0) ? exchangeRate * dlViewModel.VatTaxAmountWithCurrency : dlViewModel.VatTaxAmountWithCurrency, precision);
            dlViewModel.HtAmount = AmountMethods.FormatValue((exchangeRate > 0) ? exchangeRate * dlViewModel.HtAmountWithCurrency : dlViewModel.HtAmountWithCurrency, precision);
        }


        public DocumentExpenseLineViewModel SaveUpdateExpenseLine(DocumentExpenseLineViewModel expenseLine, string userMail)
        {
            expenseLine = _serviceDocumentExpenseLine.CalculateTTCAmount(expenseLine);
            if (expenseLine.Id == 0)
            {
                var resultAdd = (CreatedDataViewModel)_serviceDocumentExpenseLine.AddModel(expenseLine, null, userMail);
                expenseLine.Id = resultAdd.Id;
            }
            else
            {
                if (expenseLine != null)
                {
                    expenseLine.IdCurrencyNavigation = null;
                    expenseLine.IdDocumentNavigation = null;
                    expenseLine.IdExpenseNavigation = null;
                    expenseLine.IdTaxeNavigation = null;
                    expenseLine.IdTiersNavigation = null;
                }
                _serviceDocumentExpenseLine.UpdateModel(expenseLine, null, userMail);

            }
            return _serviceDocumentExpenseLine.GetModelWithRelations(p => p.Id == expenseLine.Id,
           p => p.IdExpenseNavigation,
           p => p.IdExpenseNavigation.IdItemNavigation,
           p => p.IdTaxeNavigation, p => p.IdTiersNavigation, p => p.IdCurrencyNavigation);
        }

        public DocumentViewModel UpdateDocumentFields(DocumentViewModel document, string userMail)
        {
            VerifyIfValidatedOrDeletedDocument(document.Id, document.IdDocumentStatus, document.IsContactChanged);
            SettlementMode settlementMode = _entitySettlementModeRepo.FindByAsNoTracking(x => x.Id == document.IdSettlementMode).FirstOrDefault();
            if ((document.DocumentTypeCode == DocumentEnumerator.SalesInvoice || document.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice) && settlementMode == null)
            {
                throw new CustomException(CustomStatusCode.DeletedSettlementMode);
            }
            try
            {
                BeginTransaction();
                // verifier timbre fiscal 
                CompanyViewModel company = _serviceCompany.GetCurrentCompany();
                TiersViewModel tiersViewModel = _serviceTiers.GetModelWithRelationsAsNoTracked(x => x.Id == document.IdTiers, x => x.Address,
                    x => x.IdCurrencyNavigation, x => x.IdPhoneNavigation);

                document.DocumentLine = _serviceDocumentLine.FindByAsNoTracking(x => x.IdDocument == document.Id);
                if (tiersViewModel.IdCurrencyNavigation.Code != company.IdCurrencyNavigation.Code)
                {
                    document.DocumentOtherTaxesWithCurrency = 0;
                }
                DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);

                if (document.IdCreator == null || document.IdCreator == 0)
                {
                    document.IdCreator = _entityRepoUser.GetSingle(x => x.Email == userMail).Id;
                }
                if (document.DocumentTypeCode == DocumentEnumerator.SalesInvoice && document.InoicingType == 0)
                {
                    document.InoicingType = (int)InvoicingTypeEnumerator.Cash;
                }
                document.IdTiersNavigation = null;
                document.isAbledToMerge = _entityRepo.QuerableGetAll().Where(x => x.IdTiers == document.IdTiers && x.Id != document.Id &&
                x.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional && x.DocumentTypeCode == DocumentEnumerator.SalesDelivery).Count() > 0;
                UpdateDocumentInRealTimeOperations(document, documentType, null, userMail);
                Document doc = _builder.BuildModel(document);
                if(doc != null && doc.DocumentExpenseLine != null && doc.DocumentExpenseLine.Any())
                {
                    doc.DocumentExpenseLine.ToList().ForEach(x =>
                    {
                        x.IdExpenseNavigation = null;
                        x.IdCurrencyNavigation = null;
                    });
                }
                if(doc.DocumentLine != null)
                {
                    doc.DocumentLine = null;
                }
                if(doc.DocumentTaxsResume != null)
                {
                    doc.DocumentTaxsResume = null;
                }
                if (doc.DocumentWithholdingTax != null)
                {
                    doc.DocumentWithholdingTax = null;
                }
                if(doc.DocumentExpenseLine != null)
                {
                    doc.DocumentExpenseLine = null;
                }
                _entityRepo.Update(doc);
                _unitOfWork.Commit();
                EndTransaction();
                return document;
            }
            catch (Exception ex)
            {
                // rollback transaction
                RollBackTransaction();
                throw ex;
            }
        }

        public void CheckitemPricesObject(ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel.Document == null && itemPriceViewModel.DocumentLineViewModel!=null && itemPriceViewModel.DocumentLineViewModel.IdDocument > 0)
            {
                itemPriceViewModel.Document = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdDocument, r => r.IdTiersNavigation);
                if (itemPriceViewModel.Document == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                itemPriceViewModel.Tiers = itemPriceViewModel.Document.IdTiersNavigation;
            }
            if (itemPriceViewModel.Tiers == null)
            {
                itemPriceViewModel.Tiers = _entityRepoTiers.FindByAsNoTracking(x => x.Id == itemPriceViewModel.IdTiers).FirstOrDefault();
            }
            if (itemPriceViewModel.DocumentTypeObject == null)
            {
                itemPriceViewModel.DocumentTypeObject = _entityDocumentTypeRepo.GetSingleNotTracked(x => x.Code == itemPriceViewModel.DocumentType);
            }
            if (itemPriceViewModel.Item == null)
            {
                itemPriceViewModel.Item = _itemEntityRepo.GetSingleWithRelationsNotTracked(x => x.Id == itemPriceViewModel.DocumentLineViewModel.IdItem, x => x.IdUnitSalesNavigation, z => z.IdUnitStockNavigation, z => z.IdNatureNavigation, x => x.TaxeItem, x => x.ItemWarehouse, t => t.ItemSalesPrice);
            }

            if (itemPriceViewModel.exchangeRate.Equals(0))
            {
                itemPriceViewModel.exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentDate, itemPriceViewModel.Document != null ? itemPriceViewModel.Document.ExchangeRate : null);
            }
            if (itemPriceViewModel.TiersPrecison.Equals(0))
            {
                itemPriceViewModel.TiersPrecison = GetPrecissionValue((int)itemPriceViewModel.IdCurrency, itemPriceViewModel.DocumentType);
            }
            if (itemPriceViewModel.CompanyPrecison.Equals(0))
            {
                itemPriceViewModel.CompanyPrecison = GetCompanyCurrencyPrecision();
            }
            if (itemPriceViewModel.Tiers.IdTypeTiers == (int)TiersType.Customer && itemPriceViewModel.Tiers.IdSalesPrice != null && itemPriceViewModel.Item.ItemSalesPrice.Any(x => x.IdSalesPrice == itemPriceViewModel.Tiers.IdSalesPrice) &&
                itemPriceViewModel.Item.UnitHtsalePrice != null)
            {
                itemPriceViewModel.Item.UnitHtsalePrice = Math.Round((double)((1 + (itemPriceViewModel.Item.ItemSalesPrice.Where(x => x.IdSalesPrice == itemPriceViewModel.Tiers.IdSalesPrice).First().Percentage / 100)) * itemPriceViewModel.Item.UnitHtsalePrice), itemPriceViewModel.CompanyPrecison);
            }


        }

        public DocumentViewModel UpdateDocumentAmounts(int doumentId, string userMail)
        {
            try
            {
                BeginTransaction();
                DocumentViewModel documentViewModel = UpdateDocumentAmountsWithoutTransaction(doumentId, userMail);
                EndTransaction();
                return documentViewModel;
            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }
        public DocumentViewModel GetDocumentAmounts(int doumentId, string userMail)
        {
            try
            {
                BeginTransactionunReadUncommitted();
                DocumentViewModel documentViewModel = _builderdocument.BuildDocumentEntity(_entityRepo.GetAllAsNoTracking().Include(x => x.DocumentLine).Include(x => x.DocumentTaxsResume).ThenInclude(x => x.IdTaxNavigation).FirstOrDefault(x => x.Id == doumentId));
                if (documentViewModel != null)
                {
                    documentViewModel.DocumentTaxsResume = documentViewModel.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
                }
                EndTransaction();
                return documentViewModel;
            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }


        public DocumentViewModel UpdateDocumentAmountsWithoutTransaction(int doumentId, string userMail)
        {
            try
            {
                Document document = _entityRepo.GetAllAsNoTracking().Include(x => x.IdTiersNavigation).Include(x => x.DocumentLine).ThenInclude(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation).FirstOrDefault(x => x.Id == doumentId); if (document == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
                document.DocumentTaxsResume = null;
                DocumentViewModel documentViewModel = UpdateDocAmountsWithoutTransaction(document, userMail);
                documentViewModel.haveReservedLines = documentViewModel.DocumentTypeCode != DocumentEnumerator.SalesDelivery ? false : _serviceStockMovement.GetModelsWithConditionsRelations(c => c.Operation == OperationEnumerator.Output &&
                c.Status == DocumentEnumerator.Reservation && c.IdDocumentLineNavigation.IdDocument == documentViewModel.Id, x => x.IdDocumentLineNavigation)
                 .Select(x => x.IdDocumentLineNavigation.IdDocument).Any();
                return documentViewModel;

            }
            catch (CustomException)
            {
                // rollback transaction
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                VerifyDuplication(e);
                throw;
            }
        }

        public DocumentViewModel UpdateDocAmountsWithoutTransaction(Document document, string userMail)
        {
            DocumentViewModel documentViewModel = _builderdocument.BuildDocumentEntity(document);
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);
            List<DocumentTaxsResume> updatedDocumentTaxsResumes = new List<DocumentTaxsResume>();
            lock (string.Intern(documentViewModel.Id.ToString()) as object)
            {
                CalculDocument(documentViewModel, updatedDocumentTaxsResumes, null, document);
                var ctx = _unitOfWork.GetContext();
                updatedDocumentTaxsResumes.ToList().ForEach(z =>
                {
                    var attachedEntity = ctx.ChangeTracker.Entries<DocumentTaxsResume>().FirstOrDefault(e => e.Entity.Id == z.Id);
                    if (attachedEntity != null)
                    {
                        ctx.Entry(attachedEntity.Entity).State = EntityState.Detached;
                    }
                });
                _entityDocumentTaxsResume.BulkUpdate(updatedDocumentTaxsResumes);
                _unitOfWork.Commit();
            }
            UpdateDocumentInRealTimeOperations(documentViewModel, documentType, null, userMail);
            if (documentViewModel.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
            {
                GetDocumentAvailibilityStock(documentViewModel);
            }
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseOrder && IsDocumentLineNegotiatedFromDocumentId(document.Id))
            {
                documentViewModel.IsNegotitated = true;
            }

            //set remaining amount for invoice and asset
            SetRemainingAmount(documentViewModel);
            documentViewModel.DocumentLine.Clear();
            int tiersPrecision = GetPrecissionValue(documentViewModel.IdUsedCurrency ?? 0, documentViewModel.DocumentTypeCode);
            if (documentViewModel.DocumentTtcpriceWithCurrency != null && documentViewModel.DocumentTtcpriceWithCurrency > 0)
            {
                documentViewModel.DocumentTtcpriceWithCurrency = Math.Round((double)documentViewModel.DocumentTtcpriceWithCurrency, (tiersPrecision != null ? tiersPrecision : 3));
            }


            var context = _unitOfWork.GetContext();
            var attacheddocument = context.ChangeTracker.Entries<Document>().FirstOrDefault(e => e.Entity.Id == document.Id);
            if (attacheddocument != null)
            {
                context.Entry(attacheddocument.Entity).State = EntityState.Detached;
            }
            documentViewModel.IdTiersNavigation = null;
            documentViewModel.IdCreatorNavigation = null;
            documentViewModel.IdValidatorNavigation = null;
            _entityRepo.Update(_builder.BuildModel(documentViewModel));
            _unitOfWork.Commit();

            documentViewModel.DocumentTaxsResume = _entityDocumentTaxsResume.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocument == document.Id, x => x.IdTaxNavigation).Select(x => _documentTaxsResumeBuilder.BuildEntity(x)).ToList();
            return documentViewModel;
        }
        public void FusionBl(ImportDocumentsViewModel importDocuments)
        {
            BeginTransaction();
            Document currentDocument = _entityRepo.GetAllAsNoTracking().Include(x => x.DocumentLine).Include(x => x.IdTiersNavigation).FirstOrDefault(x => x.Id == importDocuments.IdCurrentDocument);

            if (currentDocument != null && currentDocument.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { "Document", DocumentsLongName.GetValueOrDefault(currentDocument.DocumentTypeCode)}
                    };
                throw new CustomException(CustomStatusCode.AlreadyValidatedDocument, paramtrs);
            }
            var documentsToUpdate = FindByAsNoTracking(x => importDocuments.IdsDocuments.Contains(x.Id)).ToList();
            _entityDocumentLineRepo.QuerableGetAll().Where(x => importDocuments.IdsDocuments.Contains(x.IdDocument)).UpdateFromQuery(x => new DocumentLine { IdDocument = importDocuments.IdCurrentDocument });
            double ttcCurrentPrice = (double)currentDocument.DocumentHtpriceWithCurrency;

            foreach (var document in documentsToUpdate)
            {
                document.IsDeleted = true;
                document.DeletedToken = Guid.NewGuid().ToString();
                ttcCurrentPrice = (double)(ttcCurrentPrice + document.DocumentHtpriceWithCurrency);
            }
            var totalTierPrices = _serviceTiers.CalculateTotalAmountOfSalesDelivery(currentDocument.IdTiers.Value) + ttcCurrentPrice;
            if (currentDocument.IdTiers.HasValue && currentDocument.DocumentTypeCode == DocumentEnumerator.SalesDelivery
        && (currentDocument.IdTiersNavigation.AuthorizedAmountInvoice != null) && (totalTierPrices >
          ((currentDocument.IdTiersNavigation.AuthorizedAmountInvoice ?? 0) + (currentDocument.IdTiersNavigation.ProvisionalAuthorizedAmountDelivery ?? 0))))
            {
                throw new CustomException(CustomStatusCode.AuthorizedAmountExceeded);
            }
            UpdateDocumentAmountsWithoutTransaction(importDocuments.IdCurrentDocument, null);
            BulkUpdateModelWithoutTransaction(documentsToUpdate, null);
            _unitOfWork.Commit();
            if (_unitOfWork.GetContext().Database.CurrentTransaction != null)
            {
                EndTransaction();
            }
        }

        public DocumentViewModel ImportDocuments(ImportDocumentsViewModel importDocuments, string userMail)
        {
            try
            {
                BeginTransaction();

                if (importDocuments == null)
                {
                    throw new Exception();
                }

                bool allLinesAreAdded = true;
                bool isAllLinesAreAvailbles = true;
                double exchangeRate;
                Document document = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == importDocuments.IdCurrentDocument, x => x.DocumentLine, r => r.IdTiersNavigation);
                DocumentViewModel currentDocument = _builderdocument.BuildDocumentEntity(document);
                var tier = document.IdTiersNavigation;
                int idCurrency = _entityRepoTiers.GetAllAsNoTracking().FirstOrDefault(x => x.Id == currentDocument.IdTiers).IdCurrency.Value;
                if (currentDocument.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && currentDocument.DocumentLine.Count == 0 && importDocuments.IdsDocuments.Count == 1)
                {
                    exchangeRate = _entityRepo.GetSingleNotTracked(x => x.Id == importDocuments.IdsDocuments.First()).ExchangeRate.Value;
                }
                else
                {
                    exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(idCurrency, currentDocument.DocumentDate, currentDocument.ExchangeRate);
                }

                DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == currentDocument.DocumentTypeCode);
                int companyPrecision = GetCompanyCurrencyPrecision();
                int tiersPrecision = GetPrecissionValue(idCurrency, currentDocument.DocumentTypeCode);



                DocumentViewModel resultEntity;
                lock (string.Intern(currentDocument.IdTiers.Value.ToString()) as object)
                {
                    if (currentDocument == null)
                    {
                        throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                    }

                    if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesInvoice)
                    {
                        // check if the document the Invoice already containes imported Bl Lines
                        var idDocLines = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocument == currentDocument.Id).Select(x => x.IdDocumentLineAssociated).ToList();
                        var isBlImported = _entityDocumentLineRepo.QuerableGetAll().Any(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS && idDocLines.Contains(x.Id));
                        if (isBlImported)
                        {
                            throw new CustomException(CustomStatusCode.CANNOT_IMPORT_BS_BL);
                        }
                    }

                    // all imported lines
                    List<DocumentLineViewModel> documentLines = _entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.DocumentLineTaxe).Include(x => x.IdItemNavigation)
                        .Where(x => importDocuments.IdsDocumentLines.Contains(x.Id)
                        || importDocuments.IdsDocuments.Contains(x.IdDocument) && x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Refused).ToList().Select(p => _documentLineBuilder.BuildEntity(p)).ToList();
                    if (documentType.CodeType == DocumentEnumerator.SalesDelivery)
                    {
                        List<int> idsItems = documentLines.Where(x => x.IdItemNavigation.ProvInventory).Select(p => p.IdItem).Distinct().ToList();
                        List<int?> idsWearhouse = documentLines.Where(x => x.IdItemNavigation.ProvInventory).Select(p => p.IdWarehouse).Distinct().ToList();
                        IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                       x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                       && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                       && (x.IdStockDocumentNavigation.IdTiers != null || idsWearhouse.Contains(x.IdStockDocumentNavigation.IdWarehouseSource)));
                        if (inventaireList.Any())
                        {
                            throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                        }
                    }
                    List<int> documentLinesAssocied = currentDocument.DocumentLine.Select(y => y.IdDocumentLineAssociated ?? 0).Distinct().ToList();

                    // old imported lines
                    List<DocumentLineViewModel> updatedDocumentLines = currentDocument.DocumentLine
                        .Where(x => importDocuments.IdsDocumentLines.Contains(x.IdDocumentLineAssociated ?? 0)).ToList();

                    // new imported lines
                    List<DocumentLineViewModel> addedDocumentLines = documentLines.Where(x => !documentLinesAssocied.Contains(x.Id)).ToList();

                   
                    DocumentLineViewModel discountLineToUpdate = new DocumentLineViewModel();

                    Item discountProduct = _itemEntityRepo.GetSingleWithRelationsNotTracked(x => x.Code == "Remise" && x.Description == "Remise", r => r.IdNatureNavigation, z=> z.TaxeItem);
                    if (importDocuments != null && importDocuments.IdsDocumentWithDiscountLine != null)
                    {
                        List<int> idsDocsDiscount = importDocuments.IdsDocumentWithDiscountLine.Distinct().ToList();
                        List<DocumentLineViewModel> DiscountLines = _serviceDocumentLine.GetAllModelsAsNoTracking().Where(x => idsDocsDiscount.Contains(x.IdDocument) && x.IdItem == discountProduct.Id).ToList();
                        addedDocumentLines.AddRange(DiscountLines);
                    }
                    if (document.DocumentLine != null && document.DocumentLine.Any(x => x.IdItem == discountProduct.Id))
                        {
                           discountLineToUpdate = currentDocument.DocumentLine.Where(x => x.IdItem == discountProduct.Id).FirstOrDefault();
                             addedDocumentLines.Where(x => x.IdItem == discountProduct.Id).ToList().ForEach(x=>{
                                    discountLineToUpdate.HtAmountWithCurrency = discountLineToUpdate.HtAmountWithCurrency + x.HtAmountWithCurrency;
                                    discountLineToUpdate.HtUnitAmount = discountLineToUpdate.HtUnitAmount + x.HtUnitAmount;
                                    discountLineToUpdate.HtUnitAmountWithCurrency = discountLineToUpdate.HtUnitAmountWithCurrency + x.HtUnitAmountWithCurrency;
                                 addedDocumentLines.Remove(x);
                                });
                        ItemPriceViewModel itemPricesViewModel = new ItemPriceViewModel
                        {
                            IsToImport = true,
                            DocumentDate = currentDocument.DocumentDate,
                            DocumentType = currentDocument.DocumentTypeCode,
                            IdCurrency = currentDocument.IdUsedCurrency ?? 0,
                            IdTiers = currentDocument.IdTiers ?? 0,
                            DocumentLineViewModel = discountLineToUpdate,
                            Tiers = tier,
                            exchangeRate = exchangeRate,
                            Document = document,
                            Item = discountProduct,
                            DocumentTypeObject = documentType,
                            CompanyPrecison = companyPrecision,
                            TiersPrecison = tiersPrecision

                        };
                        GetDocumentLinePrice(itemPricesViewModel);
                        CalculateDocumentLine(itemPricesViewModel);
                        }
                    else
                        {
                            List<DocumentLineViewModel> newDiscountLinesToAdd = addedDocumentLines.Where(x => x.IdItem == discountProduct.Id).ToList();
                            if(newDiscountLinesToAdd.Count > 1)
                            {
                                DocumentLineViewModel SelectedDiscountLine = newDiscountLinesToAdd.FirstOrDefault();
                                newDiscountLinesToAdd.Where(x => x.Id != SelectedDiscountLine.Id).ToList().ForEach(x =>
                                {
                                    SelectedDiscountLine.HtAmountWithCurrency = SelectedDiscountLine.HtAmountWithCurrency + x.HtAmountWithCurrency;
                                    SelectedDiscountLine.HtUnitAmount = SelectedDiscountLine.HtUnitAmount + x.HtUnitAmount;
                                    SelectedDiscountLine.HtUnitAmountWithCurrency = SelectedDiscountLine.HtUnitAmountWithCurrency + x.HtUnitAmountWithCurrency;
                                    addedDocumentLines.Remove(x);
                                });
                            }
                        }

                    List<int> idImporetedDocumentLine = addedDocumentLines.Select(y => y.Id).ToList();

                    List<DocumentLine> imporetedOldDocumentLine = _entityDocumentLineRepo.GetAllAsNoTracking()
                          .Where(x => idImporetedDocumentLine.Contains(x.IdDocumentLineAssociated ?? 0)).Include(x => x.IdDocumentLineAssociatedNavigation).ToList();
                    List<string> imporetedOldSelectedDocumentsFromModalCodes = new List<string>();
                    foreach (DocumentLine documentLine in imporetedOldDocumentLine)
                    {
                        var documentassocieted = _entityRepo.GetSingleNotTracked(x => x.Id == documentLine.IdDocumentLineAssociatedNavigation.IdDocument);
                        if (documentassocieted != null && !imporetedOldSelectedDocumentsFromModalCodes.Contains(documentassocieted.Code))
                        {
                            imporetedOldSelectedDocumentsFromModalCodes.Add(documentassocieted.Code);
                        }
                    }
                    // get documents Lines List that are selected from the reliquats list
                    List<DocumentLine> balancesDocumentsLines = imporetedOldDocumentLine.Where(x => importDocuments.IdsDocumentLines.Contains(x.IdDocumentLineAssociated.Value)).ToList();
                    var balancesDocumentsLinesGrouped = balancesDocumentsLines.GroupBy(x => x.IdDocumentLineAssociated)
                                        .Select(s => new
                                        {
                                            s.Key,
                                            idDocument = s.FirstOrDefault().IdDocumentLineAssociatedNavigation.IdDocument,
                                            originalQte = s.FirstOrDefault().IdDocumentLineAssociatedNavigation.MovementQty,
                                            sumMovementQty = s.Sum(y => y.MovementQty)
                                        }).ToList();
                    //get document code of each documents line from the reliquats list
                    List<string> imporetedBalancesDocumentsLinesFromModalCodes = new List<string>();
                    foreach (var balanceDocumentLine in balancesDocumentsLinesGrouped)
                    {
                        var documentassocieted = _entityRepo.GetSingleNotTracked(x => x.Id == balanceDocumentLine.idDocument &&
                        (balanceDocumentLine.originalQte - balanceDocumentLine.sumMovementQty) > NumberConstant.Zero);
                        if (documentassocieted != null && !imporetedBalancesDocumentsLinesFromModalCodes.Contains(documentassocieted.Code))
                        {
                            imporetedBalancesDocumentsLinesFromModalCodes.Add(documentassocieted.Code);
                        }
                    }
                    imporetedOldSelectedDocumentsFromModalCodes = imporetedOldSelectedDocumentsFromModalCodes.Except(imporetedBalancesDocumentsLinesFromModalCodes).ToList();

                    List<int> idItems = addedDocumentLines.Select(y => y.IdItem).Distinct().ToList();
                    idItems.AddRange(updatedDocumentLines.Select(y => y.IdItem).Distinct().ToList());
                    List<Item> itemList = _itemEntityRepo.GetAllAsNoTracking().Include(r => r.IdNatureNavigation).Include(r => r.TaxeItem).Where(p => idItems.Distinct().Contains(p.Id)).ToList();
                    List<int> allDLIds = updatedDocumentLines.Select(y => y.Id).ToList();
                    allDLIds.AddRange(idImporetedDocumentLine);
                    List<StockMovement> stockMovmentList = new List<StockMovement>();
                    List<ItemWarehouse> itemWarehouseList = new List<ItemWarehouse>();
                    if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesDelivery || currentDocument.DocumentTypeCode == DocumentEnumerator.SalesAsset)
                    {
                        itemWarehouseList = _entityItemWarehouseRepo.GetAllAsNoTracking().Where(p => idItems.Distinct().Contains(p.IdItem)).ToList();
                        stockMovmentList = _entityStockMovementRepo.GetAllAsNoTracking()
                        .Where(p => p.IdDocumentLine != null && allDLIds.Contains(p.IdDocumentLine ?? 0)).ToList();
                    }
                    List<StockMovement> stockMovmentToUpdate = new List<StockMovement>();
                    List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();

                    List<DocumentLineViewModel> documentLinesToAdd = new List<DocumentLineViewModel>();
                    List<DocumentLineViewModel> documentLinesToUpdate = new List<DocumentLineViewModel>();


                    foreach (DocumentLineViewModel documentLine in addedDocumentLines)
                    {
                        documentLine.MovementQty -= imporetedOldDocumentLine.Where(x => (x.IdDocumentLineAssociated ?? 0) == documentLine.Id).Sum(x => x.MovementQty);
                        ItemWarehouse itemWarehouse = itemWarehouseList.FirstOrDefault(p => p.IdItem == documentLine.IdItem && p.IdWarehouse == documentLine.IdWarehouse);
                        documentLine.HtUnitAmountWithCurrency = documentLine.UnitPriceFromQuotation > 0 ?
                            documentLine.UnitPriceFromQuotation : documentLine.HtUnitAmountWithCurrency;
                        if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesDelivery && currentDocument.IsBToB == false)
                        {
                            var availbelquantity = _serviceItemWarehouse.GetItemQtyInWarehouse(documentLine.IdItem, itemWarehouse);
                            if (availbelquantity > 0 && availbelquantity < documentLine.MovementQty)
                            {
                                documentLine.MovementQty = availbelquantity;
                            }
                            // get new Prices of Item
                            if (discountProduct == null || (documentLine.IdItem != discountProduct.Id))
                            {
                                SetHTAmount(documentLine, currentDocument.IdUsedCurrency ?? 0, currentDocument.DocumentDate, tiersPrecision, itemList.First(x => x.Id == documentLine.IdItem).UnitHtsalePrice ?? 0);
                                documentLine.HtAmountWithCurrency = documentLine.HtUnitAmountWithCurrency - documentLine.HtUnitAmountWithCurrency
                                       * documentLine.DiscountPercentage / 100;
                            }
                        }

                        if (documentLine.MovementQty == 0)
                        {
                            continue;
                        }

                        documentLine.IdDocumentLineAssociated = documentLine.Id;
                        documentLine.Id = 0;
                        documentLine.IdDocumentNavigation = null;
                        documentLine.Designation = string.IsNullOrEmpty(documentLine.Designation) ? itemList.First(x => x.Id == documentLine.IdItem).Description : documentLine.Designation;

                        documentLine.UnitPriceFromQuotation = 0;
                        documentLine.IdDocument = importDocuments.IdCurrentDocument;
                        documentLine.IdDocumentLineStatus = currentDocument.IdDocumentStatus;
                        if (documentLine.DocumentLineTaxe != null && documentLine.DocumentLineTaxe.Any())
                        {
                            documentLine.DocumentLineTaxe.Clear();

                        }
                        Item item = itemList.FirstOrDefault(p => p.Id == documentLine.IdItem);
                        ItemPriceViewModel itemPricesViewModel = new ItemPriceViewModel
                        {
                            IsToImport = true,
                            DocumentDate = currentDocument.DocumentDate,
                            DocumentType = currentDocument.DocumentTypeCode,
                            IdCurrency = currentDocument.IdUsedCurrency ?? 0,
                            IdTiers = currentDocument.IdTiers ?? 0,
                            DocumentLineViewModel = documentLine,
                            Tiers = tier,
                            exchangeRate = exchangeRate,
                            Document = document,
                            Item = item,
                            DocumentTypeObject = documentType,
                            CompanyPrecison = companyPrecision,
                            TiersPrecison = tiersPrecision
                        };
                        GetDocumentLinePrice(itemPricesViewModel);
                        CalculateDocumentLine(itemPricesViewModel);


                        if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                        {
                            if (item.IdNatureNavigation.IsStockManaged)
                            {
                                StockMovement stockMovments = stockMovmentList.FirstOrDefault(p => p.IdDocumentLine == documentLine.Id);
                                if (!CheckAvailableStock(itemPricesViewModel, item, itemWarehouse, stockMovments))
                                {
                                    allLinesAreAdded = false;
                                }
                                else
                                {
                                    isAllLinesAreAvailbles = false;
                                    MangeSaleDeliveryImportedAdd(documentLine, itemWarehouse);
                                    documentLinesToAdd.Add(documentLine);
                                    itemWarehouseToUpdate.Add(itemWarehouse);

                                }
                            }
                            else
                            {
                                documentLinesToAdd.Add(documentLine);
                            }

                        }
                        else if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesAsset
                            && currentDocument.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                        {
                            if (item.IdNatureNavigation.IsStockManaged)
                            {
                                MangeAssetDeliveryImportedAdd(documentLine, itemWarehouse);
                                itemWarehouseToUpdate.Add(itemWarehouse);
                            }
                            documentLinesToAdd.Add(documentLine);
                        }
                        else
                        {
                            documentLinesToAdd.Add(documentLine);
                            //_entityDocumentLineRepo.Add(documentLine);
                        }
                    }

                    foreach (var documentLine in updatedDocumentLines)
                    {
                        Item item = itemList.FirstOrDefault(p => p.Id == documentLine.IdItem);
                        var movementQuantity = documentLine.MovementQty;
                        documentLine.IdDocumentNavigation = null;
                        documentLine.IdDocumentLineStatus = currentDocument.IdDocumentStatus;

                        var previousImporteQuantity = _serviceDocumentLine.AccountAssocietedQuantity((int)documentLine.IdDocumentLineAssociated);

                        var ReaminingQuantity = documentLines.First(x => x.Id == documentLine.IdDocumentLineAssociated).MovementQty - previousImporteQuantity;
                        documentLine.MovementQty += ReaminingQuantity;

                        ItemWarehouse itemWarehouse = new ItemWarehouse();
                        if (item.IdNatureNavigation.IsStockManaged)
                        {
                            itemWarehouse = itemWarehouseList.FirstOrDefault(p => p.IdItem == documentLine.IdItem && p.IdWarehouse == documentLine.IdWarehouse);
                        }
                        if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesDelivery && item.IdNatureNavigation.IsStockManaged)
                        {
                            var availbelquantity = _serviceItemWarehouse.GetItemQtyInWarehouse(documentLine.IdItem, itemWarehouse);
                            if (availbelquantity > 0 && availbelquantity < documentLine.MovementQty)
                            {
                                documentLine.MovementQty = movementQuantity + availbelquantity;
                            }
                        }
                        else if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesAsset
                          && currentDocument.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                        {
                            throw new CustomException(CustomStatusCode.ItemAlreadyExistInDocument);
                        }

                        ItemPriceViewModel itemPricesViewModel = new ItemPriceViewModel
                        {
                            IsToImport = true,
                            DocumentDate = currentDocument.DocumentDate,
                            DocumentType = currentDocument.DocumentTypeCode,
                            IdCurrency = currentDocument.IdUsedCurrency ?? 0,
                            IdTiers = currentDocument.IdTiers ?? 0,
                            DocumentLineViewModel = documentLine,
                            Tiers = tier,
                            exchangeRate = exchangeRate,
                            Document = document,
                            Item = item,
                            DocumentTypeObject = documentType,
                            CompanyPrecison = companyPrecision,
                            TiersPrecison = tiersPrecision

                        };
                        GetDocumentLinePrice(itemPricesViewModel);
                        CalculateDocumentLine(itemPricesViewModel);
                        var index = currentDocument.DocumentLine.ToList().FindIndex(x => x.Id == documentLine.Id);
                        currentDocument.DocumentLine.ToList()[index] = itemPricesViewModel.DocumentLineViewModel;
                        if (currentDocument.DocumentTypeCode == DocumentEnumerator.SalesDelivery && item.IdNatureNavigation.IsStockManaged)
                        {
                            StockMovement stockMovments = stockMovmentList.FirstOrDefault(p => p.IdDocumentLine == documentLine.Id);
                            if (!CheckAvailableStock(itemPricesViewModel, item, itemWarehouse, stockMovments))
                            {
                                allLinesAreAdded = false;
                            }
                            else
                            {
                                isAllLinesAreAvailbles = false;
                                //_entityDocumentLineRepo.Update(_documentLineBuilder.BuildModel(documentLine));
                                UpdateDocumentLineStockMovment(documentLine, stockMovments, itemWarehouse);
                                documentLinesToUpdate.Add(documentLine);
                                itemWarehouseToUpdate.Add(itemWarehouse);
                                stockMovmentToUpdate.Add(stockMovments);
                            }
                        }
                        else
                        {
                            documentLinesToUpdate.Add(documentLine);
                        }
                    }
                    if(discountLineToUpdate != null &&  discountLineToUpdate.Id > 0)
                    {
                        if(discountLineToUpdate.IdDocumentNavigation != null)
                        {
                            discountLineToUpdate.IdDocumentNavigation = null;
                        }
                        documentLinesToUpdate.Add(discountLineToUpdate);
                    }
                    var startEntity = GetModelWithRelationsAsNoTracked(x => x.Id == currentDocument.Id, x => x.DocumentLine);
                    //SaveIdInvoiceEcommerce 
                    if (importDocuments.IdsDocuments != null && importDocuments.IdsDocuments.Count > 0)
                    {
                        DocumentViewModel importedDocument = GetModelAsNoTracked(x => x.Id == importDocuments.IdsDocuments[0]);
                        if (importedDocument.IdInvoiceEcommerce != null)
                        {
                            startEntity.IdInvoiceEcommerce = importedDocument.IdInvoiceEcommerce;
                        }
                    }

                    startEntity.IfLinesAreAlreadyImported = imporetedOldDocumentLine.Count != NumberConstant.Zero || imporetedOldDocumentLine.Count == addedDocumentLines.Count;
                    startEntity.AlreadyImportedDocumentsCodes = imporetedOldSelectedDocumentsFromModalCodes.Count != NumberConstant.Zero ? string.Join(", ", imporetedOldSelectedDocumentsFromModalCodes.Distinct()) : string.Empty;

                    if (startEntity.IfLinesAreAlreadyImported && !string.IsNullOrEmpty(startEntity.AlreadyImportedDocumentsCodes))
                    {
                        return startEntity;
                    }
                    if (startEntity.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice && startEntity.ExchangeRate != exchangeRate)
                    {
                        startEntity.ExchangeRate = exchangeRate;
                        _entityRepo.Update(_builder.BuildModel(startEntity));
                    }
                    _entityDocumentLineRepo.BulkAdd(documentLinesToAdd.Select(x => _documentLineBuilder.BuildModel(x)).ToList());
                    _entityDocumentLineRepo.BulkUpdate(documentLinesToUpdate.Select(x => _documentLineBuilder.BuildModel(x)).ToList());

                    _entityItemWarehouseRepo.BulkUpdate(itemWarehouseToUpdate);
                    _entityStockMovementRepo.BulkUpdate(stockMovmentToUpdate);

                    _unitOfWork.Commit();

                    resultEntity = UpdateDocumentAmountsWithoutTransaction(startEntity.Id, null);
                    resultEntity.IsAllLinesAreAdded = allLinesAreAdded;
                    resultEntity.isAllLinesAreAvailbles = isAllLinesAreAvailbles;
                    resultEntity.AlreadyImportedDocumentsCodes = startEntity.AlreadyImportedDocumentsCodes;
                    EndTransaction();

                }
                if (resultEntity.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                {
                    resultEntity.haveReservedLines = _serviceStockMovement.GetModelsWithConditionsRelations(c => c.Operation == OperationEnumerator.Output &&
                 c.Status == DocumentEnumerator.Reservation && c.IdDocumentLineNavigation.IdDocument == resultEntity.Id, x => x.IdDocumentLineNavigation)
                     .Select(x => x.IdDocumentLineNavigation.IdDocument).Any();
                    if (_entityRepo.QuerableGetAll().Where(x => importDocuments.IdsDocuments.Contains(x.Id) && x.IdSessionCounterSales!=null && x.IdSessionCounterSales>0).Any())
                    {
                        _ticketRepo.GetAllAsNoTracking().Where(x => importDocuments.IdsDocuments.Contains(x.IdDeliveryForm)).UpdateFromQuery(p => new Ticket
                        {
                            IdInvoice = resultEntity.Id
                        });
                    }
                }
                if (resultEntity.DocumentTypeCode == DocumentEnumerator.SalesInvoice)
                {
                    if (_entityRepo.QuerableGetAll().Where(x => importDocuments.IdsDocuments.Contains(x.Id) && x.IdSessionCounterSales != null && x.IdSessionCounterSales > 0).Any())
                    {
                        _ticketRepo.GetAllAsNoTracking().Where(x => importDocuments.IdsDocuments.Contains(x.IdDeliveryForm)).UpdateFromQuery(p => new Ticket
                        {
                            IdInvoice = resultEntity.Id
                        });
                    }
                }
                resultEntity.DocumentTaxsResume = resultEntity.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
                if (resultEntity.DocumentTypeCode == DocumentEnumerator.SalesInvoice && resultEntity.IdSalesDepositInvoice != null && resultEntity.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    resultEntity.LeftToPayAmount = Math.Round((double)(resultEntity.DocumentTtcpriceWithCurrency - GetModelAsNoTracked(x => x.Id == resultEntity.IdSalesDepositInvoice).DocumentTtcpriceWithCurrency), tiersPrecision);
                }
                return resultEntity;

            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }

        public void VerifyBlRelatedToBsWhenDeletedLine(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentType != DocumentEnumerator.SalesDelivery)
            {
                return;
            }
            if (itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                Document doc = itemPricesViewModel.Document;
                if (doc == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }

                List<DocumentLine> listDocLine = _entityDocumentLineRepo.FindBy(x => x.IdDeliveryAssociated == itemPricesViewModel.DocumentLineViewModel.Id).ToList();
                if (listDocLine != null && listDocLine.Any())
                {

                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { "EntityToDelete", "Ligne BL" }
                        };
                    paramtrs.Add("EntityNameReleated", "BS");
                    throw new CustomException(CustomStatusCode.DeleteError, paramtrs);
                }

            }
        }

        public DocumentViewModel InsertUpdateDocumentLine(ItemPriceViewModel itemPricesViewModel, string userMail)
        {
            try
            {
                BeginTransactionunReadUncommitted();
                if (itemPricesViewModel.DocumentLineViewModel.Id > 0)
                {
                    var existingDocumentline = _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == itemPricesViewModel.DocumentLineViewModel.Id);

                    if (existingDocumentline == null || !existingDocumentline.Any())
                    {
                        throw new CustomException(CustomStatusCode.DELETED_DOCUMENTS_LINE);
                    }
                }
                if (itemPricesViewModel.RecalculateDiscount != null && itemPricesViewModel.RecalculateDiscount == true)
                {
                    var discountResult = getDiscountValue(itemPricesViewModel);
                    itemPricesViewModel.DocumentLineViewModel.DiscountPercentage = discountResult.DiscountPercentage;
                }

                if (itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseBudget)
                {
                    itemPricesViewModel.DocumentLineViewModel.UnitPriceFromQuotation = itemPricesViewModel.DocumentLineViewModel.HtUnitAmountWithCurrency;
                }
                Document doc = _entityRepo.GetSingleNotTracked(x => x.Id == itemPricesViewModel.DocumentLineViewModel.IdDocument);
                if(doc == null)
                {
                    throw new CustomException(CustomStatusCode.AddDocumentLineToNotExistingDocument);
                }
                int docTierId = doc.IdTiers ?? 0;
                if (itemPricesViewModel.IdTiers != docTierId)
                {
                    itemPricesViewModel.IdTiers = docTierId;
                }
                CheckitemPricesObject(itemPricesViewModel);
                VerifyBlRelatedToBsWhenDeletedLine(itemPricesViewModel);
                if (itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseOrder || itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseFinalOrder
                    || itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseAsset || itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseInvoice)
                {
                    CheckItemTierRelation(itemPricesViewModel);
                }
                DocumentLineViewModel documentLineViewModel = InsertUpdateDocumentLineWithoutTransaction(itemPricesViewModel, userMail);
                DocumentViewModel document = GetModelWithRelationsAsNoTracked(x => x.Id == itemPricesViewModel.DocumentLineViewModel.IdDocument,
                    x => x.IdTiersNavigation);
                if ((document.DocumentTypeCode == DocumentEnumerator.SalesDelivery || document.DocumentTypeCode == DocumentEnumerator.BS
                    || (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid && document.DocumentTypeCode == DocumentEnumerator.SalesAsset))
                    && itemPricesViewModel.Item.ProvInventory)
                {
                    IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == documentLineViewModel.IdItem &&
                   x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                   && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                   && (x.IdStockDocumentNavigation.IdTiers != null ||
                   x.IdStockDocumentNavigation.IdWarehouseSource == documentLineViewModel.IdWarehouse ||
                   x.IdStockDocumentNavigation.IdWarehouseDestination == documentLineViewModel.IdWarehouse));
                    if (inventaireList.Any())
                    {
                        throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
                    }
                }
                if (itemPricesViewModel.DocumentLineViewModel.IdDocumentLineAssociated != null &&
                    itemPricesViewModel.DocumentType != DocumentEnumerator.PurchaseOrder)
                {
                    double Qty = (double)_entityDocumentLineRepo.GetAllAsNoTracking().Where(p => p.Id == itemPricesViewModel.DocumentLineViewModel.IdDocumentLineAssociated).Select(x => x.MovementQty).FirstOrDefault();
                    if (itemPricesViewModel.DocumentLineViewModel.MovementQty > Qty)
                    {
                        var paramters = new Dictionary<string, dynamic>
                        {
                            ["Code"] = itemPricesViewModel.DocumentLineViewModel.RefDesignation.ToString()
                        };
                        throw new CustomException(CustomStatusCode.CheckItemsQty, paramters);
                    }
                }
                if (document.DocumentTypeCode == DocumentEnumerator.BE && itemPricesViewModel.Item.ProvInventory)
                {
                    IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == documentLineViewModel.IdItem &&
                   x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement &&
                   (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft) &&
                   (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSourceNavigation.IsCentral || x.IdStockDocumentNavigation.IdWarehouseDestinationNavigation.IsCentral));
                    if (inventaireList.Any())
                    {
                        throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
                    }
                }


                CheckRolesBeforeDeleting(documentLineViewModel, document.DocumentTypeCode, document.IdDocumentStatus);
                var result = UpdateDocumentAmountsWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.IdDocument, null);
                CheckPlafont(itemPricesViewModel, document);

                EndTransaction();

                if (document.DocumentTypeCode == DocumentEnumerator.PurchaseBudget)
                {
                    DocumentViewModel documentPurchaseOrder = GetModelAsNoTracked(x => x.IdDocumentAssociated == document.Id);
                    if (documentPurchaseOrder != null)
                        RecalculateDocumentAfterSetBudgetPurchase(documentPurchaseOrder, itemPricesViewModel);
                }
                result.DocumentLine = new List<DocumentLineViewModel>() { documentLineViewModel };
                if (result.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                {
                    result.haveReservedLines = _serviceStockMovement.GetModelsWithConditionsRelations(c => c.Operation == OperationEnumerator.Output &&
             c.Status == DocumentEnumerator.Reservation && c.IdDocumentLineNavigation.IdDocument == result.Id, x => x.IdDocumentLineNavigation)
                 .Select(x => x.IdDocumentLineNavigation.IdDocument).Any();

                }
                if (result.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional)
                {
                    SoldeDocumentAssociated(result.Id, userMail);
                }
                result.DocumentTaxsResume = result.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
                var taxe = _serviceDocumentLineTaxe.GetAllModelsQueryableWithRelation(x => x.IdDocumentLine == documentLineViewModel.Id, y => y.IdTaxeNavigation).ToList();
                if (taxe != null && taxe.Any())
                {
                    result.DocumentLine.First().Taxe = taxe.Select(x => x.IdTaxeNavigation).ToList();
                }
                if(result.DocumentTypeCode == DocumentEnumerator.SalesInvoice && result.IdSalesDepositInvoice != null && result.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional)
                {
                    result.LeftToPayAmount =Math.Round((double)(result.DocumentTtcpriceWithCurrency - GetModelAsNoTracked(x => x.Id == result.IdSalesDepositInvoice).DocumentTtcpriceWithCurrency), itemPricesViewModel.TiersPrecison);
                }

                return result;
            }
            catch (CustomException ex)
            {
                RollBackTransaction();
                throw ex;
            }
        }
        private void CheckPlafont(ItemPriceViewModel itemPricesViewModel, DocumentViewModel document)
        {
            if (document.DocumentTypeCode != DocumentEnumerator.SalesDelivery)
            {
                return;
            }
            double ttcCurrentPrice = 0;
            if (itemPricesViewModel.DocumentLineViewModel != null)
            {
                ttcCurrentPrice = itemPricesViewModel.DocumentLineViewModel.TtcTotalLineWithCurrency ?? 0;
            }
            var totalTierPrices = _serviceTiers.CalculateTotalAmountOfSalesDelivery(document.IdTiers.Value) + ttcCurrentPrice;
            if (!itemPricesViewModel.DocumentLineViewModel.IsDeleted && document.IdTiers.HasValue
        && (document.IdTiersNavigation.AuthorizedAmountInvoice != null) && (totalTierPrices >
          ((document.IdTiersNavigation.AuthorizedAmountInvoice ?? 0) + (document.IdTiersNavigation.ProvisionalAuthorizedAmountDelivery ?? 0))))
            {
                throw new CustomException(CustomStatusCode.AuthorizedAmountExceeded);
            }
        }
        private static void CheckRolesBeforeDeleting(DocumentLineViewModel documentLineViewModel, string documentTypeCode, int? statusDoc = null)
        {
            var isSalesDocument = documentTypeCode == DocumentEnumerator.SalesInvoice || documentTypeCode == DocumentEnumerator.SalesQuotation
                || documentTypeCode == DocumentEnumerator.SalesDelivery || documentTypeCode == DocumentEnumerator.SalesAsset
                || documentTypeCode == DocumentEnumerator.SalesOrder || documentTypeCode == DocumentEnumerator.SalesInvoiceAsset;

            if (documentLineViewModel.IsDeleted && documentLineViewModel.IsValidReservationFromProvisionalStock && !RoleHelper.HasPermission(RoleHelper.Delete_DocLine))
            {
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_RESERVED_LINE);
            }
            if (documentLineViewModel.IsDeleted && isSalesDocument && !RoleHelper.HasPermission(RoleHelper.Delete_DocLine))
            {
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_LINE);
            }
            if (documentLineViewModel.IsDeleted && (documentTypeCode == DocumentEnumerator.BE || documentTypeCode == DocumentEnumerator.BS) &&
                    !RoleHelper.HasPermission(RoleHelper.Delete_DocLine_Stock_Correction))
            {
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_LINE);
            }
            if (documentLineViewModel.IsDeleted && !isSalesDocument && documentTypeCode != DocumentEnumerator.BE && documentTypeCode != DocumentEnumerator.BS &&
                !RoleHelper.HasPermission(RoleHelper.Delete_DocLine_PU))
            {
                throw new CustomException(CustomStatusCode.NO_RIGHTS_TO_DELETE_LINE);
            }
            if (documentTypeCode == DocumentEnumerator.SalesDelivery && statusDoc == (int)DocumentStatusEnumerator.Valid)
            {
                if (documentLineViewModel.IsDeleted && !RoleHelper.HasPermission(RoleHelper.Update_Valid_Delivery_SA))
                {
                    throw new CustomException(CustomStatusCode.AlreadyValidatedDocument);
                }
            }
        }

        private string CheckUpdateQuantityForDeliveryPurchase(DocumentLineViewModel documentLineViewModel)
        {
            Document doc = _entityRepo.GetAllAsNoTracking().FirstOrDefault(x => x.Id == documentLineViewModel.IdDocument);
            if (doc.DocumentTypeCode != DocumentEnumerator.PurchaseDelivery)
            {
                return "";
            }
            var oldEntity = _entityDocumentLineRepo.GetAllAsNoTracking().FirstOrDefault(x => x.Id == documentLineViewModel.Id);
            if (oldEntity != null && oldEntity.MovementQty != documentLineViewModel.MovementQty)
            {
                //check reservation quatity 
                var resv = _entityStockMovementRepo.GetAllAsNoTracking().FirstOrDefault(x => x.IdItem == documentLineViewModel.IdItem);
                if (resv != null)
                {
                    var CodeDelivery = _entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.IdDocumentNavigation)
                        .FirstOrDefault(x => x.Id == resv.IdDocumentLine).IdDocumentNavigation.Code;
                    return CodeDelivery;
                }
            }
            return "";
        }

        public DocumentLineViewModel InsertUpdateDocumentLineWithoutTransaction(ItemPriceViewModel itemPricesViewModel, string userMail)
        {
            CheckitemPricesObject(itemPricesViewModel);
            VerifyIfValidatedOrDeletedDocument(itemPricesViewModel.DocumentLineViewModel.IdDocument, null, false, itemPricesViewModel.Document);
            if (itemPricesViewModel.DocumentLineViewModel.MovementQty < 0 && !itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                if (itemPricesViewModel.DocumentLineViewModel.IdItemNavigation == null || (itemPricesViewModel.DocumentLineViewModel.IdItemNavigation != null && itemPricesViewModel.DocumentLineViewModel.IdItemNavigation.Code != "Remise") &&
                    itemPricesViewModel.DocumentLineViewModel.IdItemNavigation.Description != ("Remise"))
                {
                    throw new CustomException(CustomStatusCode.PositiveQuantityViolation);
                }
            }

            if (itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseBudget &&
                _serviceDocumentLine.IsDocumentLineNegotiatedFromDocumentLineId(itemPricesViewModel.DocumentLineViewModel.Id))
            {  // the modification of a line in the purchase budget not allowed when the line has a negotiated assoted line
                throw new CustomException(CustomStatusCode.NEGOTIATION_ALREADY_ADDED);
            }
            if(itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery || itemPricesViewModel.DocumentType == DocumentEnumerator.SalesInvoice
                || itemPricesViewModel.DocumentType == DocumentEnumerator.SalesAsset || itemPricesViewModel.DocumentType == DocumentEnumerator.SalesInvoiceAsset
                || itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseDelivery || itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseInvoice
                || itemPricesViewModel.DocumentType == DocumentEnumerator.PurchaseAsset)
            {
                AddItemInWarehouse(itemPricesViewModel);
            }
            CheckHasRoleUpdateSA(itemPricesViewModel);
            return InsertUpdateDocumentLineProcess(itemPricesViewModel);
        }
        /// <summary>
        /// method to add item warehouse 
        /// </summary>
        /// <param name="itemPricesViewModel"></param>
        public void AddItemInWarehouse(ItemPriceViewModel itemPricesViewModel)
        {
            ItemWarehouse itemWarehouse = _entityItemWarehouseRepo.GetSingleNotTracked(x => x.IdItem == itemPricesViewModel.DocumentLineViewModel.IdItem &&
                    x.IdWarehouse == itemPricesViewModel.DocumentLineViewModel.IdWarehouse);
            if(itemWarehouse == null && itemPricesViewModel.DocumentLineViewModel.IdWarehouse != null)
            {
                ItemWarehouse newItemWarehouse = new ItemWarehouse
                {
                    IdItem = itemPricesViewModel.DocumentLineViewModel.IdItem,
                    IdWarehouse = itemPricesViewModel.DocumentLineViewModel.IdWarehouse.Value,
                    IdStorage = itemPricesViewModel.DocumentLineViewModel.IdStorage,
                    MinQuantity = 5,
                    MaxQuantity = 1000
                };
                _entityItemWarehouseRepo.Add(newItemWarehouse);
            }
        }
        public DocumentLineViewModel InsertUpdateDocumentLineProcess(ItemPriceViewModel itemPricesViewModel)
        {
            CheckitemPricesObject(itemPricesViewModel);
            int idCurrency = itemPricesViewModel.IdCurrency;
            Document document = itemPricesViewModel.Document;

            Item item = itemPricesViewModel.Item;

            if (item.IdNatureNavigation.IsStockManaged)
            {
                if (itemPricesViewModel.DocumentLineViewModel.IdWarehouse == null && itemPricesViewModel.DocumentType == DocumentEnumerator.SalesQuotation
                && !itemPricesViewModel.DocumentLineViewModel.IsDeleted)
                {   // Depot Required error
                    throw new CustomException(CustomStatusCode.DepotObligatoire);
                }

                ItemWarehouse itemWarehouse = item.ItemWarehouse.FirstOrDefault(p => p.IdItem == itemPricesViewModel.DocumentLineViewModel.IdItem && p.IdWarehouse == itemPricesViewModel.DocumentLineViewModel.IdWarehouse);
                if (itemPricesViewModel.DocumentType != DocumentEnumerator.SalesInvoice ||
                    (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesInvoice &&
                    (itemPricesViewModel.InoicingType == null || itemPricesViewModel.InoicingType != (int)InvoicingTypeEnumerator.Other)))
                {
                    lock (string.Intern(item.Id.ToString()) as object)
                    {

                        CheckUnicity(itemPricesViewModel);
                        CheckAndSplietDocumentLine(itemPricesViewModel);
                        StockMovement dbStockMovments = _entityStockMovementRepo.GetAllAsNoTracking()
                            .FirstOrDefault(x => x.IdDocumentLine == itemPricesViewModel.DocumentLineViewModel.Id
                                && x.IdWarehouse == itemPricesViewModel.DocumentLineViewModel.IdWarehouse
                                && x.Status != DocumentEnumerator.Reservation);
                        if (!CheckAvailableStock(itemPricesViewModel, item, itemWarehouse, dbStockMovments))
                        {
                            throw new CustomException(CustomStatusCode.InsufficientQuantity);
                        }
                        if (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery)
                        {
                            IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == item.Id &&
                       x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                       && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                       && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSource == itemWarehouse.IdWarehouse));
                            if (inventaireList.Any())
                            {
                                throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
                            }
                        }
                        if (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery && itemPricesViewModel.DocumentLineViewModel.IsValidReservationFromProvisionalStock &&
                             itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Provisional)
                        {
                            var discountResult = getDiscountValue(itemPricesViewModel);
                            itemPricesViewModel.DocumentLineViewModel.DiscountPercentage = discountResult.DiscountPercentage;
                        }
                        MangeStockSalesDeliveryDocumentInsertUpdate(itemPricesViewModel, item, itemWarehouse);
                        MangeStockSalesDeliveryForValidSalesAssetDocument(itemPricesViewModel);
                        UpdateItemWarehouseAndRecalculateDocument(itemPricesViewModel);
                    }
                }
            }
            else
            {
                itemPricesViewModel.DocumentLineViewModel.IdWarehouse = null;
            }


            if (!itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                GetDocumentLinePrice(itemPricesViewModel);
                CalculateDocumentLine(itemPricesViewModel);
            }

            if (itemPricesViewModel.DocumentLineViewModel.Id == 0)
            {
                SetStatusSuperAdminUpdate(itemPricesViewModel);
                itemPricesViewModel.DocumentLineViewModel.Designation = itemPricesViewModel.DocumentLineViewModel.Designation ?? item.Description;
                var DocumentLineAfterSave = (CreatedDataViewModel)_serviceDocumentLine.AddModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel, null, null);
                itemPricesViewModel.DocumentLineViewModel.Id = DocumentLineAfterSave.Id;
            }
            else
            {
                if (itemPricesViewModel.DocumentLineViewModel.IsDeleted)
                {
                    itemPricesViewModel.DocumentLineViewModel.StockMovement = null;
                }
                if (itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe != null && itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe.Any())
                {
                    _serviceDocumentLineTaxe.BulkUpdateModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe.ToList(), null);
                    itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = null;
                }
                _serviceDocumentLine.UpdateModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel);
            }
            _unitOfWork.Commit();
            if (!itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                _serviceDocumentLine.UpdateDocumentLineOperation(itemPricesViewModel.DocumentLineViewModel);
            }
            itemPricesViewModel.DocumentLineViewModel.IdWarehouseNavigation = _serviceWarehouse.GetModelAsNoTracked(x => x.Id == itemPricesViewModel.DocumentLineViewModel.IdWarehouse);
            itemPricesViewModel.DocumentLineViewModel.IdStorageNavigation = _serviceStorage.GetModelWithRelationsAsNoTracked(x => x.Id == itemPricesViewModel.DocumentLineViewModel.IdStorage,
                x => x.IdShelfNavigation);
            if(itemPricesViewModel.DocumentLineViewModel.IdStorageNavigation != null)
            {
                StringBuilder shelfAndStorage = new StringBuilder();
                shelfAndStorage.Append(itemPricesViewModel.DocumentLineViewModel.IdStorageNavigation.IdShelfNavigation.Label);
                shelfAndStorage.Append(itemPricesViewModel.DocumentLineViewModel.IdStorageNavigation.Label);
                itemPricesViewModel.DocumentLineViewModel.ShelfAndStorage = shelfAndStorage.ToString();
            }
            return itemPricesViewModel.DocumentLineViewModel;
        }
        private void CheckIfLineHaveDraftInoice(ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel.DocumentType == DocumentEnumerator.SalesDelivery)
            {
                var doc = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice
                 && x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft && x.IdDocumentLineAssociated == itemPriceViewModel.DocumentLineViewModel.Id);
                if (doc.Count() > 0)
                {
                    throw new CustomException(CustomStatusCode.VALID_ASSOCIATED_INVOICE);
                }
            }
        }

        private bool CheckAvailableStock(ItemPriceViewModel itemPriceViewModel, Item item,
            ItemWarehouse itemWarehouse, StockMovement dbStockMovments)
        {
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            if (itemPriceViewModel.DocumentLineViewModel.IsDeleted)
            {
                return true;
            }
            if (itemPriceViewModel.DocumentType == DocumentEnumerator.BE &&
                    itemPriceViewModel.DocumentLineViewModel.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)
            {
                if (item != null && item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
                {
                    double stockMovmentOldQty = 0;
                    if (itemPriceViewModel.DocumentLineViewModel.Id != 0)
                    {
                        stockMovmentOldQty = dbStockMovments != null ? dbStockMovments.MovementQty ?? 0 : 0;
                    }
                    if (itemWarehouse.AvailableQuantity - itemWarehouse.ReservedQuantity <
                        stockMovmentOldQty - itemPriceViewModel.DocumentLineViewModel.MovementQty)
                    {
                        return false;
                    }
                }
            }
            if ((itemPriceViewModel.DocumentType == DocumentEnumerator.SalesDelivery || itemPriceViewModel.DocumentType == DocumentEnumerator.SalesInvoice
                || itemPriceViewModel.DocumentType == DocumentEnumerator.BS || itemPriceViewModel.DocumentType == DocumentEnumerator.PurchaseAsset)
                      && (!itemPriceViewModel.DocumentLineViewModel.IsValidReservationFromProvisionalStock))
            {
                // if item is stock managed
                if (item != null && item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
                {
                    if (itemPriceViewModel.DocumentTypeObject.IsSaleDocumentType && itemPriceViewModel.DocumentLineViewModel.IdWarehouse == null)
                    {
                        // Depot Required error
                        throw new CustomException(CustomStatusCode.DepotObligatoire);
                    }
                    if (itemPriceViewModel.DocumentLineViewModel.IdDocumentLineAssociated != null &&
                        itemPriceViewModel.DocumentType == DocumentEnumerator.SalesInvoice)
                    {
                        return true;
                    }


                    double stockMovmentOldQty = 0;
                    if (itemPriceViewModel.DocumentLineViewModel.Id != 0)
                    {
                        stockMovmentOldQty = dbStockMovments != null ? dbStockMovments.MovementQty ?? 0 : 0;
                    }

                    var isAvailable = _serviceItemWarehouse.GetItemQtyInWarehouse(item.Id, itemWarehouse) + stockMovmentOldQty
                        >= itemPriceViewModel.DocumentLineViewModel.MovementQty;
                    return isAvailable;
                }
            }
            return true;

        }

        /// <summary>
        /// Spliet Document Ligne Case reservation
        /// </summary>
        /// <param name="itemPriceView"></param>
        /// <param name="availbleQuantity"></param>
        private void SplietDocumentLine(ItemPriceViewModel itemPriceView, double availbleQuantity, double oldQuantity)
        {
            var itemClone = (ItemPriceViewModel)itemPriceView.Clone();

            itemClone.DocumentLineViewModel.MovementQty = availbleQuantity + oldQuantity;
            itemClone.DocumentLineViewModel.Id = 0;
            itemClone.DocumentLineViewModel.IdDocumentLineAssociated = null;
            itemClone.DocumentLineViewModel.IsValidReservationFromProvisionalStock = false;

            itemClone.Tiers = itemPriceView.Tiers;
            itemClone.Document = itemPriceView.Document;
            itemClone.Item = itemPriceView.Item;
            itemClone.exchangeRate = itemPriceView.exchangeRate;
            itemClone.CompanyPrecison = itemPriceView.CompanyPrecison;
            itemClone.TiersPrecison = itemPriceView.TiersPrecison;


            ItemWarehouse itemWarehouse = itemPriceView.Item.ItemWarehouse.FirstOrDefault(p => p.IdWarehouse == itemClone.DocumentLineViewModel.IdWarehouse);
            if (itemClone.DocumentType == DocumentEnumerator.SalesDelivery)
            {
                var discountResult = getDiscountValue(itemClone);
                itemClone.DocumentLineViewModel.DiscountPercentage = discountResult.DiscountPercentage;
            }
            MangeStockSalesDeliveryDocumentInsertUpdate(itemClone, itemPriceView.Item, itemWarehouse);
            if (string.IsNullOrEmpty(itemClone.DocumentLineViewModel.Designation))
            {
                itemClone.DocumentLineViewModel.Designation = itemPriceView.Item.Description;
            }
            GetDocumentLinePrice(itemClone);
            itemClone.DocumentLineViewModel.DocumentLineTaxe = null;
            CalculateDocumentLine(itemClone);
            _serviceDocumentLine.AddModelWithoutTransaction(itemClone.DocumentLineViewModel, null, null);
            _unitOfWork.Commit();
        }


        private void CheckUnicity(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                return;
            }
            DocumentLine docLine = null;
            if (itemPricesViewModel.DocumentLineViewModel.Id != 0)
            {
                docLine = _entityDocumentLineRepo.FindByAsNoTracking(x => x.Id == itemPricesViewModel.DocumentLineViewModel.Id).FirstOrDefault();
            }
            if ((itemPricesViewModel.DocumentLineViewModel.IdDocumentLineAssociated == null && itemPricesViewModel.DocumentLineViewModel.Id == 0) || (docLine != null && docLine.IdWarehouse != itemPricesViewModel.DocumentLineViewModel.IdWarehouse))
            {
                var documentLineList = _entityDocumentLineRepo.GetAllAsNoTracking()
                             .Where(x => x.IdDocument == itemPricesViewModel.DocumentLineViewModel.IdDocument && x.IdItem == itemPricesViewModel.DocumentLineViewModel.IdItem &&
                             x.IdWarehouse == itemPricesViewModel.DocumentLineViewModel.IdWarehouse && x.Id != itemPricesViewModel.DocumentLineViewModel.Id
                             ).ToList();


                if (documentLineList.Count() != 0)
                {
                    if (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery)
                    {
                        IList<StockMovementViewModel> stockMvts = new List<StockMovementViewModel>();
                        List<DocumentLineViewModel> documentLine = new List<DocumentLineViewModel>();


                        if (itemPricesViewModel.DocumentLineViewModel.IsValidReservationFromProvisionalStock)
                        {
                            stockMvts = _serviceStockMovement.FindModelsByNoTracked(x => x.Status == DocumentEnumerator.Reservation);
                            stockMvts = stockMvts.Where(x => documentLineList.Any(y => y.IdWarehouse == x.IdWarehouse && y.Id == x.IdDocumentLine)).ToList();
                            documentLine = _serviceDocumentLine.FindModelsByNoTracked(x => x.StockMovement.Any(st => st.Status == DocumentEnumerator.Reservation) &&
                            itemPricesViewModel.DocumentLineViewModel.IdItem == x.IdItem).ToList();


                        }
                        else
                        {
                            string status = (itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid) ? DocumentEnumerator.Real : DocumentEnumerator.Provisional;
                            stockMvts = _serviceStockMovement.FindModelsByNoTracked(x => x.Status == status);
                            stockMvts = stockMvts.Where(x => documentLineList.Any(y => y.IdWarehouse == x.IdWarehouse && y.Id == x.IdDocumentLine)).ToList();
                            documentLine = _serviceDocumentLine.FindModelsByNoTracked(x => x.StockMovement.Any(st => st.Status == status) &&
                            itemPricesViewModel.DocumentLineViewModel.IdItem == x.IdItem).ToList();


                        }
                        if (stockMvts != null && stockMvts.Any() && documentLine != null)
                        {
                            throw new CustomException(CustomStatusCode.ItemAlreadyExistInDocument);
                        }
                    }
                    else
                    {

                        throw new CustomException(CustomStatusCode.ItemAlreadyExistInDocument);
                    }
                }
            }

        }


        private CostPriceViewModel GeneratePriceOneCostLineFromDocumentLine(DocumentLine DocumentLine, string currency)
        {
            _serviceItemWarehouse.GetAvailbleQuantityForItem(DocumentLine.IdItemNavigation);
            int policy = (DocumentLine.SelectedItemSalePolicy ?? 0) > 0 ? DocumentLine.SelectedItemSalePolicy ?? 0 : DocumentLine.IdItemNavigation.IdPolicyValorization ?? 0;
            CostPriceViewModel costPriceLine = new CostPriceViewModel
            {
                IdItem = DocumentLine.IdItem,
                ItemUnitAmount = DocumentLine.HtAmountWithCurrency ?? 0,
                LineHtAmount = DocumentLine.HtTotalLineWithCurrency ?? 0,
                PercentageMargin = DocumentLine.PercentageMargin ?? 0,
                Quantity = DocumentLine.MovementQty,
                SellingPrice = DocumentLine.SellingPrice ?? 0,
                ConclusiveSellingPrice = DocumentLine.ConclusiveSellingPrice ?? 0,
                LabelItem =new StringBuilder().Append(DocumentLine.IdItemNavigation.Code).Append("-").Append(DocumentLine.IdItemNavigation.Description).ToString(),
                CostPrice = DocumentLine.CostPrice ?? 0,
                SalePolicy = ItemSalePolicyName.SalePolicyName[policy > 0 ? policy - 1 : policy],
                Id = DocumentLine.Id,
                CodeItem = DocumentLine.IdItemNavigation.Code,
                DesignationItem = DocumentLine.IdItemNavigation.Description,
                OldPrice = DocumentLine.IdItemNavigation.UnitHtpurchasePrice ?? 0,
                Currency = currency,
                OldSellingPrice = DocumentLine.IdItemNavigation.UnitHtsalePrice ?? 0,
                StockQty = DocumentLine.IdItemNavigation.AllAvailableQuantity
            };

            return costPriceLine;
        }

        private static CostPriceViewModel PrepareCostpriceObject(DocumentLine item)
        {
            int policy = (item.SelectedItemSalePolicy ?? 0) > 0 ? item.SelectedItemSalePolicy ?? 0 : item.IdItemNavigation.IdPolicyValorization ?? 0;

            CostPriceViewModel costPriceLine = new CostPriceViewModel
            {
                IdItem = item.IdItem,
                Reference = item.IdItemNavigation.Code,
                ItemUnitAmount = item.HtAmountWithCurrency ?? 0,
                LineHtAmount = item.HtTotalLineWithCurrency ?? 0,
                PercentageMargin = item.PercentageMargin ?? 0,
                Quantity = item.MovementQty,
                SellingPrice = item.SellingPrice ?? 0,
                ConclusiveSellingPrice = item.ConclusiveSellingPrice ?? 0,
                LabelItem = item.IdItemNavigation.Code + "-" + item.IdItemNavigation.Description,
                CostPrice = item.CostPrice ?? 0,
                SalePolicy = ItemSalePolicyName.SalePolicyName[policy > 0 ? policy - 1 : policy],
                Id = item.Id,
                VatTaxRate = item.VatTaxRate ?? 0,
                HtUnitAmountWithCurrency = item.HtUnitAmountWithCurrency ?? 0,
                CodeItem = item.IdItemNavigation.Code,
                DesignationItem = item.IdItemNavigation.Description,
                OldPrice = item.IdItemNavigation.UnitHtpurchasePrice ?? 0,
                Currency = item.IdDocumentNavigation?.IdUsedCurrencyNavigation.Description,
                OldSellingPrice = item.IdItemNavigation.UnitHtsalePrice ?? 0,
                PudevQty = item.HtUnitAmountWithCurrency != null ? item.HtUnitAmountWithCurrency.Value * item.MovementQty : 0,
                PrevQty = (item.CostPrice != null ? item.CostPrice.Value : 0) * item.MovementQty,
                PvhtQty = (item.ConclusiveSellingPrice != null ? item.ConclusiveSellingPrice.Value : 0) * item.MovementQty

            };
            return costPriceLine;
        }
        public double CalculateCostPrice(InputToCalculateCoefficientOfPriceCostViewModel inputToCalculatePriceCostViewModel, string userMail)
        {
            BeginTransaction();
            var documentLines = _entityDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdDocument == inputToCalculatePriceCostViewModel.IdDocument)
                .AsNoTracking().Include(x => x.IdDocumentNavigation).Include(x => x.IdItemNavigation).ToList();
            if (!documentLines.Any())
            {
                return 0;
            }
            var coefficient = _serviceDocumentExpenseLine.CalculateCoefficientOfCostPrice(inputToCalculatePriceCostViewModel);
            int precisionValues = GetCompanyCurrencyPrecision();
            if (documentLines.Any())
            {
                documentLines.ToList().ForEach(line =>
                {
                    line.CostPrice = AmountMethods.FormatValue(line.HtAmountWithCurrency * coefficient, precisionValues);
                    line.PercentageMargin = (line.PercentageMargin != 0 && line.PercentageMargin != null) ? line.PercentageMargin : inputToCalculatePriceCostViewModel.Margin;
                    line.SellingPrice = AmountMethods.FormatValue(line.CostPrice + (line.CostPrice * line.PercentageMargin / 100), precisionValues);
                });
                UpdateDocumentLinesFromCostPrice(documentLines);
            }
            EndTransaction();
            return coefficient;
        }

        private void UpdateDocumentLinesFromCostPrice(List<DocumentLine> documentLine)
        {
            List<Item> itemsList = null;
            var selectPolicyList = documentLine.Where(x => x.SelectedItemSalePolicy > 0).ToList();
            var notselectPolicyList = documentLine.Where(x => x.SelectedItemSalePolicy == null).ToList();
            List<int> idItems = documentLine.Select(p => p.IdItem).Distinct().ToList();
            int precision = GetCompanyCurrencyPrecision();
            itemsList = _itemEntityRepo.GetAllWithConditionsRelationsAsNoTracking(item => idItems.Contains(item.Id)).ToList();


            //SUP or INF
            selectPolicyList.Where(p => (p.SelectedItemSalePolicy == (int)ItemSalePolicy.SUP || p.SelectedItemSalePolicy == (int)ItemSalePolicy.INF)).ToList().ForEach(dl =>
            {
                var item = itemsList.First(x => x.Id == dl.IdItem);
                double maxCurrentSellingPrice;
                if (dl.SelectedItemSalePolicy == (int)ItemSalePolicy.INF)
                {
                    maxCurrentSellingPrice = documentLine.Where(p => p.IdItem == item.Id).Min(p => p.SellingPrice).Value;
                }
                else
                {
                    maxCurrentSellingPrice = documentLine.Where(p => p.IdItem == item.Id).Max(p => p.SellingPrice).Value;
                }
                SetSalesPriceIfINF_SUP(maxCurrentSellingPrice, item, precision, documentLine, (int)dl.SelectedItemSalePolicy);
            });

            // PMP
            selectPolicyList.Where(p => p.SelectedItemSalePolicy == (int)ItemSalePolicy.PMP).ToList().ForEach(dl =>
            {
                double availableQty = _entityItemWarehouseRepo.GetAllAsNoTracking().Where(p => p.IdItem == dl.IdItem)
                .Sum(p => p.AvailableQuantity - p.ReservedQuantity);
                var item = itemsList.First(x => x.Id == dl.IdItem);
                List<DocumentLine> documentLineOfSameItem = documentLine.Where(p => p.IdItem == dl.IdItem).ToList();
                SetSalesPriceIfPMP(documentLineOfSameItem, item, precision, availableQty);
            });

            //NOV
            selectPolicyList.Where(p => p.SelectedItemSalePolicy == (int)ItemSalePolicy.NOV).ToList().ForEach(dl =>
            {
                var item = itemsList.First(x => x.Id == dl.IdItem);
                List<DocumentLine> documentLineOfSameItem = documentLine.Where(p => p.IdItem == dl.IdItem).ToList();
                SetSalesPriceIfNov(item, precision, documentLineOfSameItem);
            });

            if (notselectPolicyList.Any())
            {
                var notselectitemList = itemsList.Where(x => notselectPolicyList.Select(y => y.IdItem).Contains(x.Id));
                //SUP or INF
                notselectitemList.Where(p => (p.IdPolicyValorization == (int)ItemSalePolicy.SUP ||
                p.IdPolicyValorization == (int)ItemSalePolicy.INF || p.IdPolicyValorization == null
                || p.IdPolicyValorization == 0)).ToList().ForEach(item =>
                {
                    double maxCurrentSellingPrice;
                    if (item.IdPolicyValorization == (int)ItemSalePolicy.INF)
                    {
                        maxCurrentSellingPrice = documentLine.Where(p => p.IdItem == item.Id).Min(p => p.SellingPrice).Value;
                    }
                    else
                    {
                        maxCurrentSellingPrice = documentLine.Where(p => p.IdItem == item.Id).Max(p => p.SellingPrice).Value;
                    }
                    SetSalesPriceIfINF_SUP(maxCurrentSellingPrice, item, precision, documentLine, item.IdPolicyValorization ?? ((int)ItemSalePolicy.SUP));
                });

                // PMP
                notselectitemList.Where(p => p.IdPolicyValorization == (int)ItemSalePolicy.PMP).ToList().ForEach(item =>
                {
                    double availableQty = _entityItemWarehouseRepo.GetAllAsNoTracking().Where(p => p.IdItem == item.Id)
                .Sum(p => p.AvailableQuantity - p.ReservedQuantity);
                    List<DocumentLine> documentLineOfSameItem = documentLine.Where(p => p.IdItem == item.Id).ToList();
                    SetSalesPriceIfPMP(documentLineOfSameItem, item, precision, availableQty);
                });

                //NOV
                notselectitemList.Where(p => p.IdPolicyValorization == (int)ItemSalePolicy.NOV).ToList().ForEach(item =>
                {
                    List<DocumentLine> documentLineOfSameItem = documentLine.Where(p => p.IdItem == item.Id).ToList();
                    SetSalesPriceIfNov(item, precision, documentLineOfSameItem);
                });
            }
            foreach (var documentLines in documentLine)
            {
                if (documentLines.IdDocumentNavigation != null)
                {
                    documentLines.IdDocumentNavigation = null;
                }
                if (documentLines.IdItemNavigation != null)
                {
                    documentLines.IdItemNavigation = null;
                }
            }
            _serviceDocumentLine.BulkUpdateModelWithoutTransaction(documentLine);


        }


        private void SetSalesPriceIfINF_SUP(double maxCurrentSellingPrice, Item item, int precision, List<DocumentLine> documentLine, int IdPolicyValorization)
        {

            double conclusiveSellingPrice;
            if (IdPolicyValorization == (int)ItemSalePolicy.INF)
            {
                conclusiveSellingPrice = Math.Min(maxCurrentSellingPrice, item.UnitHtsalePrice ?? 0);
                conclusiveSellingPrice = AmountMethods.FormatValue(conclusiveSellingPrice > 0 ? conclusiveSellingPrice : Math.Max(maxCurrentSellingPrice, item.UnitHtsalePrice ?? 0), precision);
            }
            else
            {
                conclusiveSellingPrice = AmountMethods.FormatValue(Math.Max(maxCurrentSellingPrice, item.UnitHtsalePrice ?? 0), precision);
            }
            List<DocumentLine> documentLineOfSameItem = documentLine.Where(p => p.IdItem == item.Id).ToList();
            documentLineOfSameItem.ForEach(x => x.ConclusiveSellingPrice = conclusiveSellingPrice);
        }
        private void SetSalesPriceIfNov(Item item, int precision, List<DocumentLine> documentLine)
        {
            List<DocumentLine> documentLineOfSameItem = documentLine.Where(p => p.IdItem == item.Id).ToList();
            documentLineOfSameItem.ForEach(x => x.ConclusiveSellingPrice = x.SellingPrice);
        }
        private void SetSalesPriceIfPMP(List<DocumentLine> documentLineOfSameItem, Item item, int precision, double availableQty)
        {
            List<KeyValuePair<double, double>> listOfNewQtyPrice = documentLineOfSameItem.Select(p => new KeyValuePair<double, double>(p.MovementQty, p.SellingPrice.Value)).ToList();

            double conclusiveSellingPriceWithoutFormat = CalculateSalesPricePerItemDependOnSalesPolicy(item, listOfNewQtyPrice,
                availableQty);
            double conclusiveSellingPrice = AmountMethods.FormatValue(conclusiveSellingPriceWithoutFormat, precision);

            documentLineOfSameItem.ForEach(x => x.ConclusiveSellingPrice = conclusiveSellingPrice);

        }
        public IList<CostPriceViewModel> GetCostPriceWithPaging(DocumentLinesWithPagingViewModel costPriceWithPagingViewModel, out int total)
        {
            var documentLines = _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocument == costPriceWithPagingViewModel.IdDocument &&
                (x.IdItemNavigation.Code + x.IdItemNavigation.Description).ToUpper().Contains(costPriceWithPagingViewModel.RefDescription.ToUpper())).Include(x => x.IdItemNavigation)
                .Include(x => x.IdPricesNavigation).Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdUsedCurrencyNavigation).OrderBy(p => p.IdItemNavigation.Code);
            total = documentLines.Count();
            return GeneratePriceCostLinesFromDocumentLine(documentLines.Skip(costPriceWithPagingViewModel.Skip).Take(costPriceWithPagingViewModel.pageSize).ToList());
        }


        public CostPriceViewModel AssingMargin(InputToCalculatePriceCostViewModel inputToCalculatePriceCostViewModel)
        {
            var documentLines = _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocument == inputToCalculatePriceCostViewModel.IdDocument).AsNoTracking()
             .Include(x => x.IdItemNavigation).Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdUsedCurrencyNavigation).ToList();
            if (documentLines != null && documentLines.Any())
            {

                Document document = documentLines.FirstOrDefault().IdDocumentNavigation;
                var totalExpenseLine = _entityDocumentExpenseLineRepo.GetAllAsNoTracking().Where(p => p.IdDocument == document.Id).Sum(p => p.HtAmountLineWithCurrency);
                InputToCalculateCoefficientOfPriceCostViewModel inputToCalculateCoefficientOfPriceCostViewModel = new InputToCalculateCoefficientOfPriceCostViewModel
                {
                    DocumentDate = document.DocumentDate,
                    IdCurrency = document.IdUsedCurrency ?? 0,
                    IdDocument = document.Id,
                    Margin = inputToCalculatePriceCostViewModel.Margin,
                    TotalDocumentPrice = document.DocumentHtpriceWithCurrency ?? 0,
                    TotalExpensePrice = totalExpenseLine
                };
                var coefficient = _serviceDocumentExpenseLine.CalculateCoefficientOfCostPrice(inputToCalculateCoefficientOfPriceCostViewModel);

                int precisionValues = GetCompanyCurrencyPrecision();

                if (inputToCalculatePriceCostViewModel.IdLine > 0)
                {
                    var dl = documentLines.FirstOrDefault(p => p.Id == inputToCalculatePriceCostViewModel.IdLine);
                    Item item = dl.IdItemNavigation;
                    var currencyDescription = dl.IdDocumentNavigation.IdUsedCurrencyNavigation.Description;
                    dl.CostPrice = AmountMethods.FormatValue((dl.HtTotalLineWithCurrency * coefficient) / dl.MovementQty, precisionValues);
                    dl.PercentageMargin = inputToCalculatePriceCostViewModel.Margin;
                    dl.SellingPrice = AmountMethods.FormatValue(dl.CostPrice + (dl.CostPrice * dl.PercentageMargin / 100), precisionValues);
                    List<DocumentLine> documentLineOfSameItem = documentLines.Where(p => p.IdItem == dl.IdItem).ToList();
                    UpdateDocumentLinesFromCostPrice(documentLineOfSameItem);
                    dl.IdItemNavigation = item;
                    return GeneratePriceOneCostLineFromDocumentLine(dl, currencyDescription);
                }
                else
                {
                    documentLines.ToList().ForEach(line =>
                    {
                        line.CostPrice = AmountMethods.FormatValue((line.HtTotalLineWithCurrency * coefficient) / line.MovementQty, precisionValues);
                        line.PercentageMargin = inputToCalculatePriceCostViewModel.Margin;
                        line.SellingPrice = AmountMethods.FormatValue(line.CostPrice + (line.CostPrice * line.PercentageMargin / 100), precisionValues);
                    });
                    UpdateDocumentLinesFromCostPrice(documentLines);
                    return null;
                }

            }
            return null;
        }




        /// <summary>
        /// Manget File Delete file and copy new file 
        /// </summary>
        /// <param name="files"></param>
        /// <param name="document"></param>
        public void ManageFileInRealTime(DocumentViewModel document)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(document.AttachmentUrl))
            {
                if (document.FilesInfos != null)
                {
                    document.AttachmentUrl = Path.Combine("Sales", "Document", document.DocumentTypeCode, Guid.NewGuid().ToString());
                    CopyFiles(document.AttachmentUrl, document.FilesInfos);
                }
            }
            else
            {
                DeleteFiles(document.AttachmentUrl, document.FilesInfos);
                CopyFiles(document.AttachmentUrl, document.FilesInfos);
            }
            if (document.Id > 0)
            {
                _entityRepo.Update(_builder.BuildModel(document));
            }
            _unitOfWork.Commit();

        }

        private void VerifyIfValidatedOrDeletedDocument(int documentId, int? documentStatus = null, bool IsContactChanged = false, Document doc = null)
        {
            List<int> validatedStatus = new List<int> { (int)DocumentStatusEnumerator.Valid, (int)DocumentStatusEnumerator.TotallySatisfied,
                (int)DocumentStatusEnumerator.PartiallySatisfied, (int)DocumentStatusEnumerator.Balanced, (int)DocumentStatusEnumerator.Printed };
            Document document;
            if (doc == null)
            {
                document = _entityRepo.GetSingleNotTracked(p => p.Id == documentId);
                if (document == null)
                {
                    throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
                }
            }
            else
            {
                document = doc;
            }


            if (document == null)
            {
                throw new CustomException(CustomStatusCode.DeletedOrUnreachableEntity);
            }
            if (document.IdDocumentStatus != 13 && document.DocumentTypeCode != "O-SA" && documentStatus != null && documentStatus != document.IdDocumentStatus)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "Document", DocumentsLongName.GetValueOrDefault(document.DocumentTypeCode)}
                };
                throw new CustomException(CustomStatusCode.AlreadyValidatedDocument, paramtrs);
            }
            if (!IsContactChanged && !IsHaveRole(document.DocumentTypeCode) && new[] {(int)DocumentStatusEnumerator.Valid,
               (int)DocumentStatusEnumerator.Printed }.Contains(document.IdDocumentStatus)
                && validatedStatus.Contains(document.IdDocumentStatus))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { "Document", DocumentsLongName.GetValueOrDefault(document.DocumentTypeCode)}
                    };
                throw new CustomException(CustomStatusCode.AlreadyValidatedDocument, paramtrs);

            }
        }

        public void CheckHasRoleUpdateSA(ItemPriceViewModel itemPricesViewModel)
        {

            if (itemPricesViewModel.DocumentType != DocumentEnumerator.SalesDelivery && itemPricesViewModel.DocumentType != DocumentEnumerator.SalesAsset
                && itemPricesViewModel.DocumentType != DocumentEnumerator.BS && itemPricesViewModel.DocumentType != DocumentEnumerator.SalesOrder)
            {
                return;
            }
            var document = itemPricesViewModel.Document;
            if (document.IdDocumentStatus != (int)DocumentStatusEnumerator.Valid)
            {
                return;
            }


            if (!IsHaveRole(itemPricesViewModel.DocumentType))
            {   // Super admin required
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
            else
            {
                itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid;
            }
        }

        private bool IsHaveRole(string documentTypeCode)
        {
            if (documentTypeCode == DocumentEnumerator.SalesDelivery && RoleHelper.HasPermission(RoleHelper.Update_Valid_Delivery_SA)) { return true; }
            else if (documentTypeCode == DocumentEnumerator.SalesAsset && RoleHelper.HasPermission(RoleHelper.Update_Valid_Asset_SA)) { return true; }
            else if (documentTypeCode == DocumentEnumerator.SalesOrder && RoleHelper.HasPermission(RoleHelper.Update_Valid_Order_SA)) { return true; }
            else if (documentTypeCode == DocumentEnumerator.BS && RoleHelper.HasPermission(RoleHelper.Update_Valid_BS)) { return true; }
            else if (documentTypeCode == DocumentEnumerator.BE && RoleHelper.HasPermission(RoleHelper.Update_Valid_BE)) { return true; }
            else
            {
                return false;
            }
        }


        public void SetStatusSuperAdminUpdate(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery || itemPricesViewModel.DocumentType == DocumentEnumerator.BS)
            {
                if (itemPricesViewModel.Document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid;
                }
            }
        }

        public DocumentViewModel ApplyDiscountForAllDocumentLines(double discount, int id)
        {
            BeginTransaction();
            var document = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == id, r => r.IdTiersNavigation);

            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(document.IdUsedCurrency ?? 0, document.DocumentDate, document.ExchangeRate);

            int companyPrecision = GetCompanyCurrencyPrecision();
            int tiersPrecision = GetPrecissionValue(document.IdUsedCurrency ?? 0, document.DocumentTypeCode);
            var documentTypeObject = _entityDocumentTypeRepo.GetSingle(x => x.Code == document.DocumentTypeCode);

            var ItemPrices = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking().Include(x => x.IdDocumentNavigation).Where(x => x.IdDocument == id).Select(x => new ItemPriceViewModel
            {
                DocumentDate = x.IdDocumentNavigation.DocumentDate,
                DocumentLineViewModel = _documentLineBuilder.BuildEntity(x),
                DocumentType = x.IdDocumentNavigation.DocumentTypeCode,
                IdCurrency = x.IdDocumentNavigation.IdUsedCurrency ?? 0,
                IdTiers = x.IdDocumentNavigation.IdTiers ?? 0,
                Document = document,
                Tiers = document.IdTiersNavigation,
                CompanyPrecison = companyPrecision,
                TiersPrecison = tiersPrecision,
                exchangeRate = exchangeRate,
                DocumentTypeObject = documentTypeObject,

            }).ToList();

            foreach (var item in ItemPrices)
            {
                item.DocumentLineViewModel.DiscountPercentage = discount;
                GetDocumentLinePrice(item);
                CalculateDocumentLine(item);
                item.DocumentLineViewModel.IdDocumentNavigation = null;
            }
            _serviceDocumentLine.BulkUpdateModelWithoutTransaction(ItemPrices.Select(c => c.DocumentLineViewModel).ToList(), null);
            _unitOfWork.Commit();
            var result = UpdateDocumentAmountsWithoutTransaction(id, null);
            EndTransaction();
            if (document.DocumentTypeCode == DocumentEnumerator.PurchaseBudget)
            {
                DocumentViewModel documentPurchaseOrder = GetModelAsNoTracked(x => x.IdDocumentAssociated == document.Id);
                if (documentPurchaseOrder != null)
                    RecalculateDocumentAfterSetBudgetPurchaseDiscount(documentPurchaseOrder, ItemPrices);
            }
            result.DocumentTaxsResume = result.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
            return result;
        }

        public void CancelDocument(int idDocument)
        {
            BeginTransaction();
            var document = GetModelAsNoTracked(x => x.Id == idDocument);
            List<DocumentViewModel> docList = new List<DocumentViewModel>();
            List<DocumentViewModel> docs = new List<DocumentViewModel>();
            if (document != null && document.IdSalesDepositInvoice != null)
            {
                docs = GetAllModelsAsNoTracking().Where(x => x.Id == document.IdSalesDepositInvoice || (x.InoicingType != (int)InvoicingTypeEnumerator.advancePayment && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice && 
                x.IdSalesDepositInvoice == document.IdSalesDepositInvoice)).ToList();
            }
            if (document.IdDocumentStatus == (int)DocumentStatusEnumerator.Valid ||
                document.IdDocumentStatus == (int)DocumentStatusEnumerator.PartiallySatisfied)
            {
                document.IdDocumentStatus = (int)DocumentStatusEnumerator.Refused;
                if (docs != null && docs.Count() == 1)
                {
                    docs.FirstOrDefault().IsDeleted = true;
                    docList.Add(document);
                    docList.Add(docs.FirstOrDefault());
                    BulkUpdateModelWithoutTransaction(docList, null);
                    _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocument == idDocument)
                   .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Refused });
                    _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocument == docs.FirstOrDefault().Id)
                  .UpdateFromQuery(x => new DocumentLine { IsDeleted = true });
                }else if(docs != null && docs.Count() > 1)
                {
                    DocumentViewModel invoice = docs.Where(x => x.Id != document.IdSalesDepositInvoice).FirstOrDefault();
                    invoice.IsDeleted = true;
                    docList.Add(document);
                    docList.Add(invoice);
                    BulkUpdateModelWithoutTransaction(docList, null);
                    _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocument == idDocument)
                   .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Refused });
                    _entityDocumentLineRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdDocument == invoice.Id)
                  .UpdateFromQuery(x => new DocumentLine { IsDeleted = true });
                }
                else
                {
                    UpdateModelWithoutTransaction(document, null, null);
                    _entityDocumentLineRepo.QuerableGetAll().Where(x => x.IdDocument == idDocument)
                        .UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Refused });
                }
                
                _unitOfWork.Commit();
            }
            else
            {
                throw new CustomException(CustomStatusCode.INVALID_SATATUS_DOCUMENT);
            }
            EndTransaction();
        }

        public void SetDocumentLineSalePolicy(int idDocument, int selectedPolicy, int idLine)
        {
            IQueryable<DocumentLine> dl = null;
            BeginTransaction();
            if (idLine > 0)
            {
                dl = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking().Where(x => x.Id == idLine);
            }
            else
            {
                dl = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking().Where(x => x.IdDocument == idDocument);

            }
            dl.UpdateFromQuery(x => new DocumentLine { SelectedItemSalePolicy = selectedPolicy });
            _unitOfWork.Commit();
            EndTransaction();
            UpdateDocumentLinesFromCostPrice(dl.ToList());
        }

        public CostPriceViewModel GetDocumentLineCost(int idLine)
        {
            var doLine = _entityDocumentLineRepo.GetSingleWithRelationsNotTracked(x => x.Id == idLine, x => x.IdItemNavigation);
            _serviceItemWarehouse.GetAvailbleQuantityForItem(doLine.IdItemNavigation);
            var costPriceLine = PrepareCostpriceObject(doLine);
            costPriceLine.StockQty = doLine.IdItemNavigation.AllAvailableQuantity;
            return costPriceLine;
        }
        public void CheckItemTierRelation(ItemPriceViewModel itemPrices)
        {
            ItemViewModel item = _serviceItem.FindModelsByNoTracked(x => x.Id == itemPrices.DocumentLineViewModel.IdItem, x => x.ItemTiers).FirstOrDefault();
            List<ItemTiersViewModel> itemTier = item.ItemTiers.ToList();
            if (itemTier.Select(x => x.IdTiers).Contains(itemPrices.IdTiers) == false)
            {
                TiersViewModel tier = _serviceTiers.GetModelAsNoTracked(x => x.Id == itemPrices.IdTiers);
                ItemTiersViewModel itemTiersView = new ItemTiersViewModel
                {
                    IdItem = item.Id,
                    IdTiers = tier.Id
                };
                if(item.ListTiers == null)
                {
                    item.ListTiers = new List<TiersViewModel>();
                }
                item.ListTiers.Add(tier);
                item.ItemTiers.Add(itemTiersView);
                foreach (var itemTierView in item.ItemTiers)
                {
                    itemTierView.IdItemNavigation = null;
                }
                _serviceItem.UpdateModelWithoutTransaction(item, null, null);
            }
        }
    }
}

