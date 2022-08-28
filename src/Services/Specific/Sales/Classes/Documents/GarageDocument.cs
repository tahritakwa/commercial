using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using System.Numerics;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
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
        #region Generate_Garage_Document
        public CreatedDataViewModel GenerateDocumentForGarageWithoutTransaction(DocumentViewModel document)
        {
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == document.DocumentTypeCode);
            CreatedDataViewModel createdDataViewModel = (CreatedDataViewModel)AddDocumentWithoutTransaction(null, document, documentType, null, null);
            return createdDataViewModel;
        }

        /// <summary>
        /// Generate delivery for garage intervention order
        /// </summary>
        /// <param name="reducedItemForGarages"></param>
        /// <returns></returns>
        public CreatedDataViewModel GenerateDeliveryForGarageInterventionOrder(int idTiers, IList<ReducedItemForGarage> reducedItemForGarages)
        {
            try
            {
                BeginTransaction();
                string documentTypeCode = DocumentEnumerator.SalesDelivery;
                int idDocumentStatus = (int)DocumentStatusEnumerator.Valid;
                ReducedDocumentForGarage reducedDocumentForGarage = CreateReducedDocumentForGarage(idTiers, documentTypeCode, idDocumentStatus, reducedItemForGarages);
                reducedDocumentForGarage.ValidationDate = DateTime.Now;
                DocumentViewModel createdDocument = CreateDocumentFromGarageReducedDocument(reducedDocumentForGarage);
                CreatedDataViewModel createdDataViewModel = GenerateDocumentForGarageWithoutTransaction(createdDocument);
                EndTransaction();
                return createdDataViewModel;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        public CreatedDataViewModel GenerateQuotationForGarageRepairOrder(int idTiers, IList<ReducedItemForGarage> reducedItemForGarages)
        {
            try
            {
                BeginTransaction();
                string documentTypeCode = DocumentEnumerator.SalesQuotation;
                int idDocumentStatus = (int)DocumentStatusEnumerator.Provisional;
                ReducedDocumentForGarage reducedDocumentForGarage = CreateReducedDocumentForGarage(idTiers, documentTypeCode, idDocumentStatus, reducedItemForGarages);
                DocumentViewModel createdDocument = CreateDocumentFromGarageReducedDocument(reducedDocumentForGarage);
                CreatedDataViewModel createdDataViewModel = GenerateDocumentForGarageWithoutTransaction(createdDocument);
                EndTransaction();
                return createdDataViewModel;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// CreateEmptyInvoiceFromDeliveryWithoutTransaction
        /// </summary>
        /// <param name="deliveryDocument"></param>
        /// <returns></returns>
        private CreatedDataViewModel CreateEmptyInvoiceFromDeliveryWithoutTransaction(DocumentViewModel deliveryDocument, TiersViewModel tiers)
        {
            // Set the invoice taxeGroup 
            bool isExempt = tiers?.IdTaxeGroupTiers == (int)TaxeGroupEnumerator.Exempt;
            CompanyViewModel company = _serviceCompany.GetCurrentCompany();
            double? invoiceTaxeGroup = isExempt ? 0 :
                        (company?.IdCurrency != tiers?.IdCurrency) ? 0 : company.FiscalStamp;
            DocumentViewModel createdDocument = new DocumentViewModel()
            {
                CreationDate = DateTime.Now,
                DocumentDate = deliveryDocument.DocumentDate,
                ValidationDate = DateTime.Now,
                DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                IdDocumentStatus = (int)DocumentStatusEnumerator.Provisional,
                IdTiers = deliveryDocument.IdTiers,
                IdUsedCurrency = deliveryDocument.IdUsedCurrency,
                IsTermBilling = false,
                IdPaymentMethod = tiers.IdPaymentMethod,
                IsFromGarage = true,
                DocumentOtherTaxes = invoiceTaxeGroup,
                DocumentOtherTaxesWithCurrency = invoiceTaxeGroup,
                DocumentLine = new List<DocumentLineViewModel>(),
            };

            CreatedDataViewModel addDocument = GenerateDocumentForGarageWithoutTransaction(createdDocument);
            return addDocument;
        }
        #endregion

        #region Update_Garage_Document
        /// <summary>
        /// Update delivery and generate empty invoice for garage intervention order
        /// </summary>
        /// <param name="idDocumentDelivery"></param>
        /// <param name="reducedItemForGarages"></param>
        /// <returns></returns>
        public CreatedDataViewModel UpdateDeliveryAndGenerateEmptyInvoiceForGarageInterventionOrder(int idDocumentDelivery, IList<ReducedItemForGarage> reducedItemForGarages)
        {
            try
            {
                BeginTransaction();
                // Update the delivery
                DocumentViewModel documentViewModelDelivery = GetModelAsNoTracked(x => x.Id == idDocumentDelivery,
                                                                r => r.IdTiersNavigation, r => r.DocumentLine);
                TiersViewModel tiers = documentViewModelDelivery.IdTiersNavigation;
                IList<ReducedDocumentLineForGarage> reducedDocumentLineForGarage = new List<ReducedDocumentLineForGarage>();
                reducedItemForGarages.ToList().ForEach((reducedItem) =>
                {
                    reducedDocumentLineForGarage.Add(new ReducedDocumentLineForGarage(reducedItem));
                });

                DocumentViewModel updatedDelivery = UpdateCreatedDocument(documentViewModelDelivery, null, reducedDocumentLineForGarage);

                // Get all documentLines of the delivery
                List<int> idDocumentLinesOfDelivery = _entityDocumentLineRepo.GetAllAsNoTracking()
                                                    .Where(y => y.IdDocument == updatedDelivery.Id)
                                                    .Select(z => z.Id).ToList();

                // Verify if there are a documentLine imported to other invoice
                var isImported = _entityDocumentLineRepo.GetAllAsNoTracking()
                                        .Any(x => idDocumentLinesOfDelivery.Contains(x.IdDocumentLineAssociated ?? 0));
                CreatedDataViewModel invoice;

                if (isImported)
                {
                    // If the invoice status is provisional retrieve the invoice; else create an empty invoice
                    DocumentLine documentLineNavigation = _entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.IdDocumentNavigation)
                                          .FirstOrDefault(x => idDocumentLinesOfDelivery.Contains(x.IdDocumentLineAssociated ?? 0)
                                          && x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional
                                          );

                    if (documentLineNavigation != null)
                    {
                        Document documentNavigation = documentLineNavigation.IdDocumentNavigation;
                        invoice = new CreatedDataViewModel { Id = documentNavigation.Id, Code = documentNavigation.Code };
                    }
                    else
                    {
                        invoice = CreateEmptyInvoiceFromDeliveryWithoutTransaction(updatedDelivery, tiers);
                    }

                    // Get documentLines which are notImported
                    IQueryable<DocumentLine> documentLineNotImported = _entityDocumentLineRepo.GetAllAsNoTracking()
                                         .Where(x => x.IdDocument == documentViewModelDelivery.Id
                                         && (x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid
                                         || x.IdDocumentLineStatus == (int)DocumentStatusEnumerator.PartiallySatisfied));

                    invoice.ListInt = documentLineNotImported.Select(x => x.Id).ToList();
                }
                else
                {
                    invoice = CreateEmptyInvoiceFromDeliveryWithoutTransaction(updatedDelivery, tiers);
                }
                EndTransaction();
                return invoice;
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// UpdateQuotationForGarageRepairOrder
        /// </summary>
        /// <param name="idQuotationDocument"></param>
        /// <param name="reducedItemForGarages"></param>
        /// <returns></returns>
        public CreatedDataViewModel UpdateQuotationForGarageRepairOrder(int idQuotationDocument, bool validateDocument, IList<ReducedItemForGarage> reducedItemForGarages)
        {
            try
            {
                BeginTransaction();

                // Get the quotation
                DocumentViewModel quotationDocumentViewModel = GetModelAsNoTracked(x => x.Id == idQuotationDocument,
                                                                r => r.IdTiersNavigation, r => r.DocumentLine);
                // Get old document lines
                List<DocumentLineViewModel> oldDocumentLines = quotationDocumentViewModel?.DocumentLine?.ToList();
                oldDocumentLines = oldDocumentLines ?? new List<DocumentLineViewModel>();

                // Get all documentLines of the quotation
                List<int> idsDocumentLineOfQuotation = _entityDocumentLineRepo.GetAllAsNoTracking()
                                                    .Where(y => y.IdDocument == quotationDocumentViewModel.Id)
                                                    .Select(z => z.Id).ToList();

                // Get the document lines which are belong to orders
                IQueryable<DocumentLine> orderDocumentLines = _entityDocumentLineRepo.GetAllAsNoTracking()
                                        .Where(x => idsDocumentLineOfQuotation.Contains(x.IdDocumentLineAssociated ?? 0));

                // if there are imported document lines to orders, update the quotation and conserve the imported documentLines
                // else update quotation to be same like the repair order
                if ((orderDocumentLines != null) && orderDocumentLines.Any())
                {
                    // Get documentLines which are imported
                    var documentLinesImported = orderDocumentLines.Select(s => new
                    {
                        Id = s.IdDocumentLineAssociated.Value,
                        IdItem = s.IdItem
                    }).ToList();
                    // Remove imported docLines from oldDocumentLines
                    oldDocumentLines = oldDocumentLines.Where(x => !documentLinesImported.Select(s => s.Id).Contains(x.Id)).ToList();
                    // Remove imported docLines from reducedItemForGarages
                    reducedItemForGarages = reducedItemForGarages.Where(x => !documentLinesImported.Select(s => s.IdItem).Contains(x.IdItem)).ToList();
                }

                IList<ReducedDocumentLineForGarage> reducedDocumentLineForGarage = new List<ReducedDocumentLineForGarage>();
                List<DocumentLineViewModel> docLinesToDelete = new List<DocumentLineViewModel>();
                docLinesToDelete = oldDocumentLines.Where(p => !reducedItemForGarages.Select(s => s.IdItem).Contains(p.IdItem)).ToList();
                docLinesToDelete.ForEach(docLine =>
                {
                    docLine.IsDeleted = true;
                });
                reducedItemForGarages.ToList().ForEach((reducedItem) =>
                {
                    // DocumentLine to update
                    if (oldDocumentLines.Any(p => p.IdItem == reducedItem.IdItem))
                    {
                        reducedDocumentLineForGarage.Add(new ReducedDocumentLineForGarage
                        {
                            Id = oldDocumentLines.FirstOrDefault(p => p.IdItem == reducedItem.IdItem).Id,
                            IdItem = reducedItem.IdItem,
                            IdDocument = quotationDocumentViewModel.Id,
                            IsDeleted = false,
                            IdWarehouse = reducedItem.IdWarehouse,
                            Quantity = reducedItem.Quantity
                        });
                    }
                    else
                    { // DocumentLine to add
                        reducedDocumentLineForGarage.Add(new ReducedDocumentLineForGarage(reducedItem));
                    }
                });

                quotationDocumentViewModel.DocumentLine = null;
                quotationDocumentViewModel.IdDocumentStatus = validateDocument &&
                                        (quotationDocumentViewModel.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional) ?
                                        (int)DocumentStatusEnumerator.Valid : quotationDocumentViewModel.IdDocumentStatus;
                DocumentViewModel updatedQuotation = UpdateCreatedDocument(quotationDocumentViewModel, docLinesToDelete, reducedDocumentLineForGarage);

                EndTransaction();
                return new CreatedDataViewModel { Id = updatedQuotation.Id, Code = updatedQuotation.Code };
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        private DocumentViewModel UpdateCreatedDocument(DocumentViewModel document, IList<DocumentLineViewModel> docLineToDelete, IList<ReducedDocumentLineForGarage> reducedDocumentLineForGarage)
        {
            TiersViewModel tiers = document.IdTiersNavigation;
            DocumentViewModel createdDocument = document;
            createdDocument.DocumentLine = document.DocumentLine ?? new List<DocumentLineViewModel>();
            foreach (var reducedDocumentLine in reducedDocumentLineForGarage)
            {
                reducedDocumentLine.IdTiers = tiers.Id;
                reducedDocumentLine.IdCurrency = tiers.IdCurrency ?? 0;
                DocumentLineViewModel documentLine = CreateDocumentLineFromGarageReducedDocumentLine(reducedDocumentLine);
                createdDocument.DocumentLine.Add(documentLine);
            }
            foreach (var docLine in docLineToDelete ?? new List<DocumentLineViewModel>())
            {
                createdDocument.DocumentLine.Add(docLine);
            }
            DocumentViewModel updatedDocument = UpdateDocumentWithoutTransaction(null, createdDocument, null, null);
            return updatedDocument;
        }

        #endregion

        #region Create_Models 
        private ReducedDocumentForGarage CreateReducedDocumentForGarage(int idTiers, string documentTypeCode, int IdDocumentStatus, IList<ReducedItemForGarage> reducedItemForGarages)
        {
            ReducedDocumentForGarage reducedDocumentForGarage = new ReducedDocumentForGarage
            {
                IdTiers = idTiers,
                DocumentDate = DateTime.Now,
                DocumentTypeCode = documentTypeCode,
                IdDocumentStatus = IdDocumentStatus,
                ReducedDocumentLineForGarage = new List<ReducedDocumentLineForGarage>()
            };

            reducedItemForGarages.ToList().ForEach((reducedItem) =>
            {
                reducedDocumentForGarage.ReducedDocumentLineForGarage
                                        .Add(new ReducedDocumentLineForGarage(reducedItem));
            });
            return reducedDocumentForGarage;
        }

        /// <summary>
        /// // Create a new document and associated documentLines.
        /// </summary>
        /// <param name="reducedGarageDocument"></param>
        /// <returns></returns>
        private DocumentViewModel CreateDocumentFromGarageReducedDocument(ReducedDocumentForGarage reducedGarageDocument)
        {
            Tiers tiers = _entityRepoTiers.GetSingleNotTracked(x => x.Id == reducedGarageDocument.IdTiers);
            DocumentViewModel createdDocument = new DocumentViewModel()
            {
                CreationDate = DateTime.Now,
                DocumentDate = reducedGarageDocument.DocumentDate ?? DateTime.Now,
                ValidationDate = reducedGarageDocument.ValidationDate,
                DocumentTypeCode = reducedGarageDocument.DocumentTypeCode,
                IdDocumentStatus = reducedGarageDocument.IdDocumentStatus,
                IdTiers = reducedGarageDocument.IdTiers,
                IdUsedCurrency = tiers.IdCurrency,
                IsTermBilling = false,
                IsFromGarage = true,
                IdDeliveryType = tiers.IdDeliveryType,
                DocumentLine = new List<DocumentLineViewModel>(),
            };

            foreach (var reducedGarageDocumentLine in reducedGarageDocument.ReducedDocumentLineForGarage)
            {
                reducedGarageDocumentLine.IdTiers = tiers.Id;
                reducedGarageDocumentLine.IdCurrency = tiers.IdCurrency ?? 0;
                DocumentLineViewModel documentLine = CreateDocumentLineFromGarageReducedDocumentLine(reducedGarageDocumentLine);
                createdDocument.DocumentLine.Add(documentLine);
            }
            return createdDocument;
        }

        /// <summary>
        /// Create document line from itemPrice model
        /// </summary>
        /// <param name="reduceItem"></param>
        /// <returns></returns>
        private DocumentLineViewModel CreateDocumentLineFromGarageReducedDocumentLine(ReducedDocumentLineForGarage reduceDocLine)
        {
            Item item = _itemEntityRepo.GetSingleWithRelationsNotTracked(x => x.Id == reduceDocLine.IdItem, r => r.IdUnitSalesNavigation,
                                r => r.IdUnitStockNavigation, r => r.IdNatureNavigation);
            // If the item doesn't exist => it's an operation  so create the corresponding item
            if (item == null || (item != null && item.Id == 0))
            {
                reduceDocLine.IdItemNavigation.Id = 0;
                int itemId = ((CreatedDataViewModel)_serviceItem.AddOperationAsItem(reduceDocLine.IdItemNavigation, null)).Id;
                item = _itemEntityRepo.GetSingleWithRelationsNotTracked(x => x.Id == itemId, r => r.IdUnitSalesNavigation,
                                r => r.IdUnitStockNavigation, r => r.IdNatureNavigation);
            }
            if (item.IdNatureNavigation.IsStockManaged)
            {
                string[] nombre1;
                if (reduceDocLine.Quantity > Int64.MaxValue)
                {
                    BigInteger number = (BigInteger)reduceDocLine.Quantity;
                    nombre1 = number.ToString(CultureInfo.InvariantCulture).Split(',');
                }
                else
                {
                    nombre1 = reduceDocLine.Quantity.ToString(CultureInfo.InvariantCulture).Split(',');
                }
                int length1;
                if (nombre1.Length == 2)
                {
                    length1 = nombre1[1].Length;
                }
                else
                {
                    length1 = 0;
                }
                if (item.IdUnitSalesNavigation != null && length1 > item.IdUnitSalesNavigation.DigitsAfterComma)
                {
                    throw new CustomException(CustomStatusCode.WrongQty);
                }
            }

            ItemForGarageToGenerateDocumentViewModel itemForGarageToGenerateDocument = new ItemForGarageToGenerateDocumentViewModel
            {
                IdDocumentLine = reduceDocLine.Id,
                IdDocument = reduceDocLine.IdDocument,
                IdUsedCurrency = reduceDocLine.IdCurrency,
                IdTiers = reduceDocLine.IdTiers,
                IdItem = item.Id,
                QuantityForDocumentLine = reduceDocLine.Quantity,
                IdDocumentStatus = (int)DocumentStatusEnumerator.Valid,
                DocumentTypeCode = DocumentEnumerator.SalesInvoice,
                IsRestaurn = false,
                IsFromGarage = reduceDocLine.IsFromGarage,
                IdWarehouse = reduceDocLine.IdWarehouse,
                IsDeleted = reduceDocLine.IsDeleted
            };

            ItemPriceViewModel itemPrice = GenerateItemPriceModel(itemForGarageToGenerateDocument);
            DocumentLineViewModel documentLineViewModel = GetItemPrice(itemPrice);
            documentLineViewModel.DocumentLineTaxe = null;
            documentLineViewModel.Taxe = null;
            return documentLineViewModel;
        }

        /// <summary>
        /// GenerateItemPriceModel
        /// </summary>
        /// <param name="itemForGarageToGenerateDocument"></param>
        /// <returns></returns>
        private ItemPriceViewModel GenerateItemPriceModel(ItemForGarageToGenerateDocumentViewModel itemForGarageToGenerateDocument)
        {
            DocumentType documentType = _entityDocumentTypeRepo.GetSingleNotTracked(c => c.CodeType == itemForGarageToGenerateDocument.DocumentTypeCode);
            ItemPriceViewModel itemPriceViewModel = new ItemPriceViewModel
            {
                DocumentDate = DateTime.Now,
                IdCurrency = itemForGarageToGenerateDocument.IdUsedCurrency ?? 0,
                IdTiers = itemForGarageToGenerateDocument.IdTiers ?? 0,
                DocumentType = itemForGarageToGenerateDocument.DocumentTypeCode,
                DocumentLineViewModel = new DocumentLineViewModel
                {
                    Id = itemForGarageToGenerateDocument.IdDocumentLine ?? 0,
                    IdDocument = itemForGarageToGenerateDocument.IdDocument ?? 0,
                    IsValidReservationFromProvisionalStock = itemForGarageToGenerateDocument.IsValidReservationFromProvisionalStock,
                    IdItem = itemForGarageToGenerateDocument.IdItem,
                    MovementQty = itemForGarageToGenerateDocument.QuantityForDocumentLine,
                    DiscountPercentage = 0,
                    IdWarehouse = itemForGarageToGenerateDocument.IdWarehouse,
                    IdDocumentLineStatus = itemForGarageToGenerateDocument.IdDocumentStatus,
                    CodeDocumentLine = "",
                    IsDeleted = itemForGarageToGenerateDocument.IsDeleted,
                    IsFromGarage = itemForGarageToGenerateDocument.IsFromGarage
                }
            };
            return itemPriceViewModel;
        }
        #endregion 

        /// <summary>
        /// Get tiers, items and document for garage intervention
        /// </summary>IServiceDocument.cs
        /// <param name="idTiers"></param>
        /// <param name="model"></param>
        /// <param name="idWarehouse"></param>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        public dynamic GetTiersAndItemAndDocumentForGarage(int idTiers, List<int> idItems, int? idWarehouse, int? idDocument)
        {
            DataSourceResult<ItemViewModel> itemList = _serviceItem.GetItemListForGarage(idItems, idWarehouse);
            Tiers tiers = _entityRepoTiers.GetSingleWithRelationsNotTracked(x => x.Id == idTiers, r => r.IdPhoneNavigation);
            DocumentViewModel document = null;
            if (idDocument != null && idDocument > 0)
            {
                document = GetModelAsNoTracked(x => x.Id == idDocument);
            }
            dynamic result = new ExpandoObject();
            if (itemList.data != null)
            {
                result.ItemList = itemList.data;
            }
            if (document != null)
            {
                result.Document = document;
            }
            result.Tiers = _tiersBuilder.BuildEntity(tiers);
            return result;
        }

    }
}
