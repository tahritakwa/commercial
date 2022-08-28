using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        private void CreateDocumentAssociated(DocumentViewModel document, string userMail, DocumentType documentType)
        {
            if (document.IdDocumentAssociated != null && document.IdDocumentAssociated != 0)
            {
                return;
            }
            if (document.DocumentLine.Any(x => x.IdDocumentLineAssociated == null) && documentType.CreateAssociatedDocument && documentType.DefaultCodeDocumentTypeAssociatedNavigation != null)
            {
                Document documentAssociated = _builder.BuildModel(document);
                documentAssociated.IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional;
                documentAssociated.ValidationDate = DateTime.Today;
                documentAssociated.DocumentTypeCode = documentType.DefaultCodeDocumentTypeAssociatedNavigation.CodeType;
                documentAssociated.DocumentLine = documentAssociated.DocumentLine.Where(x => x.IdDocumentLineAssociated == null).ToList();
                //set documentLine Taxe and Prices          
                foreach (var documentLine in documentAssociated.DocumentLine)
                {
                    documentLine.DocumentLineTaxe = _entityDocumentLineTaxeRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocumentLine == documentLine.Id).ToList();
                    documentLine.DocumentLineTaxe.ToList().ForEach(x => x.Id = 0);
                    documentLine.DocumentLinePrices = _entityDocumentLinePricesRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdDocumentLine == documentLine.Id).ToList();
                    documentLine.DocumentLinePrices.ToList().ForEach(x => x.Id = 0);
                    documentLine.IdDocumentLineAssociated = document.DocumentLine.First(y => y.Id == documentLine.Id).Id;
                    documentLine.Id = 0;
                    documentLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                }
                documentAssociated.Id = 0;
                documentAssociated.IdTiersNavigation = null;
                documentAssociated.FinancialCommitment = null;
                documentAssociated.Code = null;
                documentAssociated.IdInvoiceEcommerce = document.IdInvoiceEcommerce;
                // totaux
                documentAssociated.DocumentHtprice = documentAssociated.DocumentLine.Sum(c => c.HtTotalLine);
                documentAssociated.DocumentTotalVatTaxes = documentAssociated.DocumentLine.Sum(c => c.VatTaxAmount * c.MovementQty);
                documentAssociated.DocumentTotalExcVatTaxes = documentAssociated.DocumentLine.Sum(c => c.ExcVatTaxAmount * c.MovementQty);
                documentAssociated.DocumentOtherTaxes = documentAssociated.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                    ? 0 : document.DocumentOtherTaxes;
                documentAssociated.DocumentTotalDiscount = documentAssociated.DocumentLine.Sum(c => (c.HtUnitAmount - c.HtAmount) * c.MovementQty);
                documentAssociated.DocumentPriceIncludeVat = documentAssociated.DocumentHtprice + documentAssociated.DocumentTotalExcVatTaxes;
                documentAssociated.DocumentTtcprice = documentAssociated.DocumentHtprice + documentAssociated.DocumentTotalVatTaxes
                    + documentAssociated.DocumentTotalExcVatTaxes + documentAssociated.DocumentOtherTaxes;
                documentAssociated.DocumentHtpriceWithCurrency = documentAssociated.DocumentLine.Sum(c => c.HtTotalLineWithCurrency);
                documentAssociated.DocumentTotalVatTaxesWithCurrency = documentAssociated.DocumentLine.Sum(c => c.VatTaxAmountWithCurrency * c.MovementQty);
                documentAssociated.DocumentTotalExcVatTaxesWithCurrency = documentAssociated.DocumentLine.Sum(c => c.ExcVatTaxAmountWithCurrency * c.MovementQty);
                documentAssociated.DocumentPriceIncludeVatwithCurrency = documentAssociated.DocumentHtpriceWithCurrency + documentAssociated.DocumentTotalExcVatTaxesWithCurrency;
                documentAssociated.DocumentOtherTaxesWithCurrency = documentAssociated.DocumentTypeCode == DocumentEnumerator.SalesDelivery
                    ? 0 : document.DocumentOtherTaxesWithCurrency;
                documentAssociated.DocumentTotalDiscountWithCurrency = documentAssociated.DocumentLine.Sum(c => (c.HtUnitAmountWithCurrency - c.HtAmountWithCurrency) * c.MovementQty);
                documentAssociated.DocumentTtcpriceWithCurrency = documentAssociated.DocumentHtpriceWithCurrency + documentAssociated.DocumentTotalVatTaxesWithCurrency
                    + documentAssociated.DocumentTotalExcVatTaxesWithCurrency + documentAssociated.DocumentOtherTaxesWithCurrency;

                var createdDocument = (CreatedDataViewModel)AddDocumentWithoutTransaction(null, _builder.BuildEntity(documentAssociated),
                    documentType.DefaultCodeDocumentTypeAssociatedNavigation, userMail, null);
                UpdateIdDocumentLineAssociated(createdDocument.Id, document.Id);
                ValidateDocumentWithoutTransaction(createdDocument.Id, userMail, (int)DocumentStatusEnumerator.Valid, true);
            }
        }
        private void UpdateIdDocumentLineAssociated(int idAssociatedDocument, int idDocument)
        {
            // affect Id of new document line to IdDocumentLineAssociated
            Document addedDocument = _entityRepo.GetSingleWithRelationsNotTracked(c => c.Id == idAssociatedDocument,
                c => c.DocumentLine);
            Document baseDocument = _entityRepo.GetSingleWithRelationsNotTracked(c => c.Id == idDocument, c => c.DocumentLine);
            var ctx = _unitOfWork.GetContext();
            baseDocument.DocumentLine.Where(x => x.IdDocumentLineAssociated == null).ToList()
                .ForEach(line =>
                {
                    line.IdDocumentLineAssociated = addedDocument.DocumentLine.FirstOrDefault(p => p.IdDocumentLineAssociated == line.Id).Id;
                    var attachedDL = ctx.ChangeTracker.Entries<DocumentLine>().FirstOrDefault(e => e.Entity.Id == line.Id);
                    if (attachedDL != null)
                    {
                        ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                    }
                    line.IdDocumentNavigation = null;
                    _entityDocumentLineRepo.Update(line);
                    _unitOfWork.Commit();
                });
            addedDocument.DocumentLine.ToList().ForEach(x =>
            {
                x.IdDocumentLineAssociated = null;
                var attachedDL = ctx.ChangeTracker.Entries<DocumentLine>().FirstOrDefault(e => e.Entity.Id == x.Id);
                if (attachedDL != null)
                {
                    ctx.Entry(attachedDL.Entity).State = EntityState.Detached;
                }
                x.IdDocumentNavigation = null;
                _entityDocumentLineRepo.Update(x);
                _unitOfWork.Commit();
            });
        }
        public void SoldeDocumentAssociated(int idDocument, string userMail)
        {
            List<DocumentViewModel> listOfBtoBDocumentAssociated = new List<DocumentViewModel>();
            Document baseDocument = _entityRepo.QuerableGetAll().Include(x => x.DocumentLine).Where(c => c.Id == idDocument).FirstOrDefault();
            if (baseDocument.DocumentLine.Any(x => x.IdDocumentLineAssociated != null) &&
                baseDocument.DocumentTypeCode != DocumentEnumerator.SalesAsset && baseDocument.DocumentTypeCode != DocumentEnumerator.PurchaseAsset)
            {
                List<int> idsDocLineAssoOfBaseDoc = baseDocument.DocumentLine.Where(x => x.IdDocumentLineAssociated != null).Select(y => (int)y.IdDocumentLineAssociated).ToList();
                List<DocumentLineViewModel> documentLineAssociateds = _serviceDocumentLine.FindModelsByNoTracked(x =>
                idsDocLineAssoOfBaseDoc.Contains(x.Id)).ToList();


                var idDocumentAssocieted = documentLineAssociateds.Select(x => x.Id).Distinct().ToList();
                List<DocumentLine> LinesAssocieted = _entityDocumentLineRepo.GetAllAsNoTracking()
                    .Where(c => idDocumentAssocieted.Contains(c.IdDocumentLineAssociated ?? 0) && c.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Provisional)
                    .ToList();


                List<int> idDocumentAssociateds = new List<int>();
                List<int> documentsToBalanced = new List<int>();
                List<int> documentsToPartiallySatisfied = new List<int>();
                List<int> documentsToValidate = new List<int>();

                List<int> documentLineToBalanced = new List<int>();
                List<int> documentLineToValidate = new List<int>();
                List<int> documentLineToPartiallySatisfied = new List<int>();
                List<int> documentLinesSalesInvoiceToPartiallySatisfied = new List<int>();
                foreach (DocumentLineViewModel documentLineAssoc in documentLineAssociateds)
                {
                    if (!idDocumentAssociateds.Contains(documentLineAssoc.IdDocument))
                    {
                        idDocumentAssociateds.Add(documentLineAssoc.IdDocument);
                    }
                    documentLineAssoc.StockMovement = null;
                    List<DocumentLine> docLineViewModel = LinesAssocieted.Where(c => c.IdDocumentLineAssociated !=null  && c.IdDocumentLineAssociated.Value == documentLineAssoc.Id && !c.IsDeleted).ToList();
                    double remaingQuantity = documentLineAssoc.MovementQty - docLineViewModel.Sum(c => c.MovementQty);
                    if (remaingQuantity <= 0)
                    {
                        documentLineToBalanced.Add(documentLineAssoc.Id);
                    }
                    else if (baseDocument.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                      baseDocument.InoicingType == (int)InvoicingTypeEnumerator.Other &&
                      remaingQuantity < documentLineAssoc.MovementQty)
                    {
                        documentLinesSalesInvoiceToPartiallySatisfied.Add(documentLineAssoc.Id);
                    }
                    else if (remaingQuantity > 0 && docLineViewModel.Any())
                    {
                        documentLineToPartiallySatisfied.Add(documentLineAssoc.Id);
                    }
                    else if (remaingQuantity > 0 && !docLineViewModel.Any())
                    {
                        documentLineToValidate.Add(documentLineAssoc.Id);
                    }
                }

                if (documentLineToBalanced.Any())
                {
                    _entityDocumentLineRepo.QuerableGetAll().Where(x => documentLineToBalanced.Contains(x.Id)).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Balanced });

                }
                if (documentLineToValidate.Any())
                {
                    _entityDocumentLineRepo.QuerableGetAll().Where(x => documentLineToValidate.Contains(x.Id)).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Valid });

                }
                if (documentLineToPartiallySatisfied.Any())
                {
                    _entityDocumentLineRepo.QuerableGetAll().Where(x => documentLineToPartiallySatisfied.Contains(x.Id)).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.PartiallySatisfied });

                }
                if (documentLinesSalesInvoiceToPartiallySatisfied.Any())
                {
                    _entityDocumentLineRepo.QuerableGetAll().Where(x => documentLinesSalesInvoiceToPartiallySatisfied.Contains(x.Id)).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.PartiallySatisfied });

                }

                List<DocumentViewModel> DocumentAssociateds = FindModelsByNoTracked(x =>
                   idDocumentAssociateds.Contains(x.Id), x => x.DocumentLine).ToList();
                if (DocumentAssociateds != null && DocumentAssociateds.Any())
                {
                    int idDiscountProduct = _itemEntityRepo.GetSingleNotTracked(x => x.Code == "Remise" && x.Description == "Remise").Id;
                    foreach (DocumentViewModel documentAssociated in DocumentAssociateds)
                    {
                        documentAssociated.DocumentLine = documentAssociated.DocumentLine.Where(x => x.IdItem != idDiscountProduct).ToList();
                        if (documentAssociated.DocumentLine.All(x => x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Balanced))
                        {
                            documentAssociated.IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced;
                            documentsToBalanced.Add(documentAssociated.Id);
                        }
                        else if (documentAssociated.DocumentLine.All(x => x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid))
                        {
                            documentAssociated.IdDocumentStatus = (int)DocumentStatusEnumerator.Valid;
                            documentsToValidate.Add(documentAssociated.Id);
                        }
                        else
                        {
                            //if (documentAssociated.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder || documentAssociated.DocumentTypeCode == DocumentEnumerator.PurchaseOrder
                            //    || documentAssociated.DocumentTypeCode == DocumentEnumerator.SalesOrder || documentAssociated.DocumentTypeCode == DocumentEnumerator.SalesQuotation)
                            //{
                                documentAssociated.IdDocumentStatus = (int)DocumentStatusEnumerator.PartiallySatisfied;
                                documentsToPartiallySatisfied.Add(documentAssociated.Id);
                           // }
                        }
                        if (documentAssociated.IsBToB != null && documentAssociated.IsBToB == true)
                        {
                            listOfBtoBDocumentAssociated.Add(documentAssociated);
                        }
                    }
                    if (documentsToBalanced.Any())
                    {
                        _entityRepo.QuerableGetAll().Where(x => documentsToBalanced.Contains(x.Id)).UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced });
                    }
                    if (documentsToValidate.Any())
                    {
                        _entityRepo.QuerableGetAll().Where(x => documentsToValidate.Contains(x.Id)).UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Valid });
                    }
                    if (documentsToPartiallySatisfied.Any())
                    {
                        _entityRepo.QuerableGetAll().Where(x => documentsToPartiallySatisfied.Contains(x.Id)).UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.PartiallySatisfied });
                    }
                }
            }
            if (listOfBtoBDocumentAssociated.Any())
            {
                SynchronizeBLStatusWithBToB(listOfBtoBDocumentAssociated);
            }
        }
        public void SynchronizeBLStatusWithBToB(List<DocumentViewModel> listOfBtoBDocument)
        {
            string response = SendDocumentStatusToBtoB(listOfBtoBDocument);
            BToBResponseStatusCodeViewModel responseFromBtoB = JsonConvert.DeserializeObject<BToBResponseStatusCodeViewModel>(response);
            if (responseFromBtoB.ListOfSuccess.Any())
            {
                List<string> listOfCode = responseFromBtoB.ListOfSuccess.Select(x => x.Code).ToList();
                listOfBtoBDocument.Where(x => listOfCode.Contains(x.Code)).ToList().ForEach(x => {
                    x.IsSynchronizedBtoB = true;
                });
                BulkUpdateModelWithoutTransaction(listOfBtoBDocument, null);
            }
            if (responseFromBtoB.ListOfError.Any())
            {
                List<string> listOfCode = responseFromBtoB.ListOfError.Select(x => x.Code).ToList();
                listOfBtoBDocument.Where(x => listOfCode.Contains(x.Code)).ToList().ForEach(x => {
                    x.IsSynchronizedBtoB = false;
                });
                BulkUpdateModelWithoutTransaction(listOfBtoBDocument, null);
            }
        }
        public void SoldeDocumentAssociated1(int idDocument, string userMail)
        {
            Document baseDocument = _entityRepo.QuerableGetAll().Include(x => x.DocumentLine).ThenInclude(x => x.IdDocumentLineAssociatedNavigation)
                 .Where(c => c.Id == idDocument).FirstOrDefault();
            if (baseDocument.DocumentLine.Any(x => x.IdDocumentLineAssociated != null))
            {
                List<DocumentLineViewModel> documentLineAssociateds = baseDocument.DocumentLine.Where(x => x.IdDocumentLineAssociatedNavigation != null).
                    Select(x => x.IdDocumentLineAssociatedNavigation)
                    .Select(x => _documentLineBuilder.BuildEntity(x))
                    .ToList();

                var idDocumentAssocieted = documentLineAssociateds.Select(x => x.Id).Distinct().ToList();
                List<DocumentLine> LinesAssocieted = _entityDocumentLineRepo.GetAllAsNoTracking()
                    .Where(c => idDocumentAssocieted.Contains(c.IdDocumentLineAssociated ?? 0) && c.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)
                    .ToList();


                List<int> idDocumentAssociateds = new List<int>();
                List<int> documentLineToUpdate = new List<int>();
                List<int> documentsToBalanced = new List<int>();
                List<int> documentsToPartiallySatisfied = new List<int>();
                List<int> documentLinesSalesInvoiceToPartiallySatisfied = new List<int>();
                foreach (DocumentLineViewModel documentline in documentLineAssociateds)
                {
                    if (!idDocumentAssociateds.Contains(documentline.IdDocument))
                    {
                        idDocumentAssociateds.Add(documentline.IdDocument);
                    }
                    documentline.StockMovement = null;
                    double remaingQuantity = documentline.MovementQty - LinesAssocieted.Where(c => c.IdDocumentLineAssociated == documentline.Id).Sum(c => c.MovementQty);

                    if (remaingQuantity <= 0)
                    {
                        documentLineToUpdate.Add(documentline.Id);
                    }
                    else if (baseDocument.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                       baseDocument.InoicingType == (int)InvoicingTypeEnumerator.Other &&
                       remaingQuantity < documentline.MovementQty)
                    {
                        documentLinesSalesInvoiceToPartiallySatisfied.Add(documentline.Id);
                    }
                    else if (remaingQuantity > 0 && documentline.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Balanced)
                    {
                        _entityDocumentLineRepo.QuerableGetAll().Where(x => x.Id == documentline.Id).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.PartiallySatisfied });
                    }

                }
                _entityDocumentLineRepo.QuerableGetAll().Where(x => documentLineToUpdate.Contains(x.Id)).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.Balanced });
                if (documentLinesSalesInvoiceToPartiallySatisfied.Any())
                {
                    _entityDocumentLineRepo.QuerableGetAll().Where(x => documentLinesSalesInvoiceToPartiallySatisfied.Contains(x.Id)).UpdateFromQuery(x => new DocumentLine { IdDocumentLineStatus = (int)DocumentStatusEnumerator.PartiallySatisfied });

                }
                List<DocumentViewModel> DocumentAssociateds = FindModelsByNoTracked(x =>
                   idDocumentAssociateds.Contains(x.Id), x => x.DocumentLine).ToList();
                if (DocumentAssociateds != null && DocumentAssociateds.Any() &&
                    baseDocument.DocumentTypeCode != DocumentEnumerator.SalesAsset && baseDocument.DocumentTypeCode != DocumentEnumerator.PurchaseAsset)
                {
                    foreach (DocumentViewModel documentAssociated in DocumentAssociateds)
                    {
                        if (documentAssociated.DocumentLine.All(x => x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Balanced))
                        {
                            documentAssociated.IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced;
                            documentsToBalanced.Add(documentAssociated.Id);
                        }
                        else
                        {
                            if (documentAssociated.DocumentTypeCode == DocumentEnumerator.PurchaseFinalOrder || documentAssociated.DocumentTypeCode == DocumentEnumerator.PurchaseOrder
                                || documentAssociated.DocumentTypeCode == DocumentEnumerator.SalesOrder || documentAssociated.DocumentTypeCode == DocumentEnumerator.SalesQuotation)
                            {
                                documentAssociated.IdDocumentStatus = (int)DocumentStatusEnumerator.PartiallySatisfied;
                                documentsToPartiallySatisfied.Add(documentAssociated.Id);
                            }
                        }
                    }
                    if (documentsToBalanced.Any())
                    {
                        _entityRepo.QuerableGetAll().Where(x => documentsToBalanced.Contains(x.Id)).UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.Balanced });
                    }
                    if (documentsToPartiallySatisfied.Any())
                    {
                        _entityRepo.QuerableGetAll().Where(x => documentsToPartiallySatisfied.Contains(x.Id)).UpdateFromQuery(x => new Document { IdDocumentStatus = (int)DocumentStatusEnumerator.PartiallySatisfied });
                    }
                }
            }
        }

    }
}
