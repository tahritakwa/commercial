using Persistence.Entities;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {

        // <summary>
        /// Validate or Reject document
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public CreatedDataViewModel ValidateOrRejectDocument(int idDocument, string userMail, int status)
        {
            try
            {
                BeginTransaction();
                CreatedDataViewModel document = ValidateOrRejectDocumentWithoutTransaction(idDocument, userMail, status);
                EndTransaction();
                return document;
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Validate or Reject document without transaction
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private CreatedDataViewModel ValidateOrRejectDocumentWithoutTransaction(int idDocument, string userMail, int status)
        {
            try
            {
                DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == idDocument, c => c.DocumentLine);
                User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);
                if(document.DocumentTypeCode == DocumentEnumerator.PurchaseRequest)
                {
                    if(document.DocumentLine.FirstOrDefault().IdMeasureUnit == null )
                    {
                        throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
                    }
                }
                document.IdValidator = connectedUser != null ? connectedUser.Id : (int)UserEnumerator.SystemId;
                document.IdDocumentStatus = status;
                document.ValidationDate = DateTime.Today;
                foreach (var documentLine in document.DocumentLine)
                {
                    if (documentLine.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Provisional)
                    {
                        documentLine.IdDocumentLineStatus = status;
                    }
                    documentLine.IdDocumentNavigation = null;
                }
                Document entity = _builder.BuildModel(document);
                _serviceDocumentLine.BulkUpdateModelWithoutTransaction(document.DocumentLine.ToList(), userMail);
                entity.DocumentLine = null;
                // update entity               
                _entityRepo.Update(entity);
                _unitOfWork.Commit();
                return new CreatedDataViewModel { Id = document.Id, Code = document.Code };
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }

        }

        /// <summary>
        /// GeneratePurchaseOrder
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>

        public CreatedDataViewModel GeneratePurchaseOrder(IList<int> listOfIdDocument, string userMail, SmtpSettings smtpSettings)
        {
            try
            {
                BeginTransaction();
                CreatedDataViewModel documentPurchaseOrder = GeneratePurchaseOrderWithoutTransaction(listOfIdDocument, userMail);
                EndTransaction();
                return documentPurchaseOrder;
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }



        /// <summary>
        /// Validate document and generate without transaction
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private CreatedDataViewModel GeneratePurchaseOrderWithoutTransaction(IList<int> listOfIdDocument, string userMail)
        {
            IList<CreatedDataViewModel> listOfCodeOfPO = new List<CreatedDataViewModel>();
            if (listOfIdDocument != null && listOfIdDocument.Any())
            {
                //  List of documents
                List<DocumentViewModel> documents = new List<DocumentViewModel>();
                // List of documentLines
                List<DocumentLineViewModel> documentLines = new List<DocumentLineViewModel>();
                IEnumerable<IGrouping<int?, DocumentLineViewModel>> groupedDocumentLine = GroupedDocumentLineByTiers(listOfIdDocument, documents, documentLines);
                if(documentLines.Where(x=> x.IdMeasureUnit==null).Any())
                {
                    throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                }

                // Get connected user
                User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);
                foreach (var dLines in groupedDocumentLine)
                {
                    if (dLines.Key.HasValue)
                    {
                        // Prepare purchase order
                        DocumentViewModel documentPurchaseOrder = PrepareDocumentPurchaseOrder(documents[0], dLines.Key.Value);
                        // create purchase order
                        CreatedDataViewModel purchaseOrderDocument = CreateTargetedDocument(dLines.Key.Value, documentPurchaseOrder, dLines.ToList(), userMail, connectedUser.Id);
                        if (purchaseOrderDocument != null)
                        {
                            listOfCodeOfPO.Add(purchaseOrderDocument);
                        }
                    }
                }
                // Fetch list of document and change status to 'ACommander'
                foreach (var doc in documents)
                {
                    ACommanderPurchaseRequest(doc, userMail, (int)DocumentStatusEnumerator.ToOrder, connectedUser.Id);
                }
            }
            return new CreatedDataViewModel { ListOfCreatedData = listOfCodeOfPO };

        }

        /// <summary>
        /// ACommanderPurchaseRequest
        /// </summary>
        /// <param name="document"></param>
        /// <param name="userMail"></param>
        /// <param name="status"></param>
        /// <param name="idConnectedUser"></param>
        private void ACommanderPurchaseRequest(DocumentViewModel document, string userMail, int status, int idConnectedUser)
        {
            // Set IdValidator = id of connected user
            document.IdValidator = idConnectedUser;
            // Change status
            document.IdDocumentStatus = status;
            document.ValidationDate = DateTime.Today;
            // Fetch list of document line and change status to 'ACommander'
            foreach (var documentLine in document.DocumentLine)
            {
                documentLine.IdDocumentLineStatus = status;
                documentLine.IdDocumentNavigation = null;
            }
            UpdateModelValidation(document, userMail);
        }

        /// <summary>
        /// PrepareDocumentPurchaseOrder
        /// </summary>
        /// <param name="purchaseRequestDocument"></param>
        /// <param name="idTiers"></param>
        /// <returns></returns>
        private DocumentViewModel PrepareDocumentPurchaseOrder(DocumentViewModel purchaseRequestDocument, int idTiers)
        {
            // Prepare purchase order
            DocumentViewModel documentPurchaseOrder = new DocumentViewModel();
            if (purchaseRequestDocument != null)
            {
                // Get type of current Document (Purchase request)
                DocumentType targetedType = _entityDocumentTypeRepo.GetSingle(p => p.CodeType == purchaseRequestDocument.DocumentTypeCode);
                // Get Type of document associated
                documentPurchaseOrder.DocumentTypeCode = targetedType.DefaultCodeDocumentTypeAssociated;
            }
            if (idTiers != 0)
            {
                // Get Supplier
                TiersViewModel supplier = _serviceTiers.GetModelAsNoTracked(t => t.Id == idTiers);
                // Get Id of currency
                documentPurchaseOrder.IdUsedCurrency = supplier.IdCurrency;
            }
            documentPurchaseOrder.DocumentOtherTaxesWithCurrency = _servicePurchaseSettings.GetAllModels().FirstOrDefault().PurchaseOtherTaxes;
            return documentPurchaseOrder;
        }

        /// <summary>
        /// CreateTargetedDocument
        /// </summary>
        /// <param name="idTiers"></param>
        /// <param name="document"></param>
        /// <param name="lines"></param>
        /// <param name="userMail"></param>
        /// <param name="idConnectedUser"></param>
        /// <returns></returns>
        private CreatedDataViewModel CreateTargetedDocument(int idTiers, DocumentViewModel document, List<DocumentLineViewModel> lines, string userMail, int idConnectedUser)
        {
            var idWarehouse = _serviceWarehouse.GetModel(x => x.IsCentral).Id;
            Document purchaseOrder = new Document
            {
                Id = 0,
                TransactionUserId = idConnectedUser,
                IdTiersNavigation = null,
                FinancialCommitment = null,
                Code = null,
                IdTiers = idTiers,
                IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                DocumentTypeCode = document.DocumentTypeCode,
                DocumentLine = lines.Select(p => _documentLineBuilder.BuildModel(p)).ToList(),
                IdUsedCurrency = document.IdUsedCurrency,
                DocumentDate = DateTime.Today
            };
            //set documentLine Taxe and Prices          
            foreach (var documentLine in purchaseOrder.DocumentLine)
            {
                documentLine.IdDocumentLineAssociated = documentLine.Id;
                documentLine.DocumentLineTaxe = _entityDocumentLineTaxeRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocumentLine == documentLine.Id).ToList();
                documentLine.DocumentLineTaxe.ToList().ForEach(x => x.Id = 0);
                documentLine.DocumentLinePrices = _entityDocumentLinePricesRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocumentLine == documentLine.Id).ToList();
                documentLine.DocumentLinePrices.ToList().ForEach(x => x.Id = 0);
                documentLine.Id = 0;
                documentLine.IdWarehouse= idWarehouse;
                documentLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
            }
            purchaseOrder.DocumentHtprice = purchaseOrder.DocumentLine.Sum(c => c.HtTotalLine);
            purchaseOrder.DocumentTotalVatTaxes = purchaseOrder.DocumentLine.Sum(c => c.ExcVatTaxAmount * c.MovementQty);
            purchaseOrder.DocumentTotalExcVatTaxes = purchaseOrder.DocumentLine.Sum(c => c.ExcVatTaxAmount * c.MovementQty);
            purchaseOrder.DocumentTotalExcVatTaxesWithCurrency = purchaseOrder.DocumentLine.Sum(c => c.ExcVatTaxAmountWithCurrency * c.MovementQty);
            //purchaseOrder.DocumentPriceIncludeVat = purchaseOrder.DocumentLine.Sum(c => c.TtcTotalLine);//houssem
            purchaseOrder.DocumentOtherTaxes = document.DocumentOtherTaxes;
            purchaseOrder.DocumentTotalDiscount = purchaseOrder.DocumentLine.Sum(c => (c.HtUnitAmount - c.HtAmount) * c.MovementQty);
            purchaseOrder.DocumentTtcprice = purchaseOrder.DocumentPriceIncludeVat + purchaseOrder.DocumentOtherTaxes;

            purchaseOrder.DocumentHtpriceWithCurrency = purchaseOrder.DocumentLine.Sum(c => c.HtTotalLineWithCurrency);
            purchaseOrder.DocumentTotalVatTaxesWithCurrency = purchaseOrder.DocumentLine.Sum(c => c.VatTaxAmountWithCurrency * c.MovementQty);
            //purchaseOrder.DocumentPriceIncludeVatwithCurrency = purchaseOrder.DocumentLine.Sum(c => c.TtcTotalLineWithCurrency);//houssem
            purchaseOrder.DocumentOtherTaxesWithCurrency = document.DocumentOtherTaxesWithCurrency;
            purchaseOrder.DocumentTotalDiscountWithCurrency = purchaseOrder.DocumentLine.Sum(c => (c.HtUnitAmountWithCurrency - c.HtAmountWithCurrency) * c.MovementQty);
            purchaseOrder.DocumentTtcpriceWithCurrency = purchaseOrder.DocumentPriceIncludeVatwithCurrency + purchaseOrder.DocumentOtherTaxesWithCurrency;
            //Recuperate analytical Axis
            List<EntityAxisValuesViewModel> listOfAxisViewModel = _entityRepoEntityAxisValues.FindBy(c => c.IdEntityItem == document.Id).Select(_builderEntityAxisValues.BuildEntity).ToList();
            listOfAxisViewModel.ForEach(x => x.Id = 0);
            CreatedDataViewModel createdDocument = (CreatedDataViewModel)AddDocumentWithoutTransaction(null, _builder.BuildEntity(purchaseOrder),
                _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == purchaseOrder.DocumentTypeCode), userMail, listOfAxisViewModel);
            return createdDocument;
        }


        /// <summary>
        /// GeneratePurchaseOrder
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>

        public CreatedDataViewModel GeneratePriceRequest(IList<int> listOfIdDocument, string userMail, SmtpSettings smtpSettings)
        {
            try
            {
                BeginTransaction();
                CreatedDataViewModel documentPriceRequest = GeneratePriceRequestWithoutTransaction(listOfIdDocument, userMail);
                EndTransaction();
                return documentPriceRequest;
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }


        /// <summary>
        /// Validate document and generate without transaction
        /// </summary>
        /// <param name="idDocument"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private CreatedDataViewModel GeneratePriceRequestWithoutTransaction(IList<int> listOfIdDocument, string userMail)
        {
            PriceRequestViewModel documentPriceRequest = new PriceRequestViewModel();
            if (listOfIdDocument != null && listOfIdDocument.Any())
            {
                //  List of documents
                List<DocumentViewModel> documents = new List<DocumentViewModel>();
                // List of documentLines
                List<DocumentLineViewModel> documentLines = new List<DocumentLineViewModel>();
                IEnumerable<IGrouping<int?, DocumentLineViewModel>> groupedDocumentLine = GroupedDocumentLineByTiers(listOfIdDocument, documents, documentLines);
                if(documentLines.Where(x=> x.IdMeasureUnit == null).Any())
                {
                    throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                }
                // Get connected user
                User connectedUser = _entityRepoUser.GetSingleNotTracked(p => p.Email == userMail);
                CreatedDataViewModel createdDataViewModel = PrepareDocumentPriceRequest(connectedUser.Id, groupedDocumentLine);
                return new CreatedDataViewModel { Id = createdDataViewModel.Id, Code = createdDataViewModel.Code };
            }
            return new CreatedDataViewModel { };
        }

        private dynamic GroupedDocumentLineByTiers(IList<int> listOfIdDocument, List<DocumentViewModel> documents, List<DocumentLineViewModel> documentLines)
        {
            // Get list of documentLine
            foreach (var idDocument in listOfIdDocument)
            {
                DocumentViewModel document = GetModelWithRelationsAsNoTracked(c => c.Id == idDocument, c => c.DocumentLine);
                document.DocumentLine.ToList().ForEach(p => p.IdItemNavigation = _serviceItem.FindModelBy(c => c.Id == p.IdItem).FirstOrDefault());
                documents.Add(document);
                documentLines.AddRange(document.DocumentLine);
            }
            // Group list of documentLine by Tiers
            var groupedDocumentLine = documentLines.GroupBy(p => p.IdDocumentNavigation.IdTiers).ToList();

            // Get list of documentLine without supplier
            var documentLinesWithoutSupplier = groupedDocumentLine.Where(p => !p.Key.HasValue).ToList();
            // If there is one documentLine without supplier ==> error
            if (documentLinesWithoutSupplier.Any())
            {
                throw new CustomException(CustomStatusCode.SetSupplierToItems);
            }
            return groupedDocumentLine;
        }


        /// <summary>
        /// PrepareDocumentPurchaseOrder
        /// </summary>
        /// <param name="purchaseRequestDocument"></param>
        /// <param name="idTiers"></param>
        /// <returns></returns>
        private CreatedDataViewModel PrepareDocumentPriceRequest(int idConnectedUser, IEnumerable<IGrouping<int?, DocumentLineViewModel>> groupedDocumentLine)
        {
            IList<string> listOfSupplierWithoutContacts = new List<string>();
            PriceRequestViewModel documentPriceRequest = new PriceRequestViewModel
            {
                Id = 0,
                TransactionUserId = idConnectedUser,
                Code = null,
                Reference = null,
                CreationDate = DateTime.Today,
                DocumentDate = DateTime.Today,
                PriceRequestDetail = new List<PriceRequestDetailViewModel>()
            };
            foreach (var dLines in groupedDocumentLine)
            {
                if (dLines.Key.HasValue)
                {
                    foreach (var documentLine in dLines)
                    {
                        PriceRequestDetailViewModel priceRequestDetailViewModel = new PriceRequestDetailViewModel
                        {
                            IdItem = documentLine.IdItem,
                            IdTiers = dLines.Key.Value,
                            Designation = (documentLine.IdItemNavigation != null) ? documentLine.IdItemNavigation.Description : "",
                            MovementQty = documentLine.MovementQty,
                            IdPriceRequest = documentPriceRequest.Id
                        };
                        documentPriceRequest.PriceRequestDetail.Add(priceRequestDetailViewModel);
                    }
                }
            }
            if (listOfSupplierWithoutContacts.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { "listOfSupplierWithoutContacts", listOfSupplierWithoutContacts }
                    };
                // Error of generate price request
                throw new CustomException(CustomStatusCode.GeneratePriceRequestError, paramtrs);
            }
            else
            {
                CreatedDataViewModel createdPriceRequest = (CreatedDataViewModel)_servicePriceRequest.AddModelWithoutTransaction(documentPriceRequest, null, null);
                return createdPriceRequest;
            }
        }


        public DocumentViewModel UpdatePurchaseRequest(DocumentViewModel document)
        {
            BeginTransaction();
            DocumentViewModel documentViewModel = UpdatePurchaseRequestWithoutTransaction(document);
            EndTransaction();
            return documentViewModel;
        }

        public DocumentViewModel UpdatePurchaseRequestWithoutTransaction(DocumentViewModel document)
        {
            ItemPriceViewModel itemPricesViewModel = new ItemPriceViewModel()
            {
                DocumentDate = document.DocumentDate,
                DocumentLineViewModel = (document.DocumentLine != null && document.DocumentLine.Any()) ? document.DocumentLine.ToList()[0] : null,
                DocumentType = document.DocumentTypeCode,
                IdCurrency = document.IdUsedCurrency.GetValueOrDefault(),
                IdTiers = document.IdTiers.Value,
            };
            InsertUpdateDocumentLineWithoutTransaction(itemPricesViewModel, null);
            var documentViewModel = UpdateDocumentAmountsWithoutTransaction(document.Id, null);

            return documentViewModel;
        }
    }
}
