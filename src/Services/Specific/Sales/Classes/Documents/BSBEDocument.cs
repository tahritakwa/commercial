using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        public void ImportDocumentsBS(ImportDocumentsBSViewModel importDocumentsViewModel)
        {
            try
            {
                BeginTransaction();
                var idDocumenLine = importDocumentsViewModel.ReducedImportLines.Select(x => x.Id).ToList();
                CheckIfDeliveryIsSales(idDocumenLine);

                List<DocumentLine> documentLines = _entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.StockMovement).Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdTiersNavigation)
                    .Where(x => idDocumenLine.Contains(x.Id)).ToList();

                int idBl = 0;
                List<DocumentLineViewModel> updatedDocumenLineForBS = new List<DocumentLineViewModel>();
                List<DocumentLineViewModel> addedDocumenLineForBS = new List<DocumentLineViewModel>();
                List<DocumentLineViewModel> updtaedDocumenLineForSalesDelivery = new List<DocumentLineViewModel>();
                Document bsDocument = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == importDocumentsViewModel.IdCurrentDocument, x => x.DocumentLine); ;
                foreach (var reducedDocumenLine in importDocumentsViewModel.ReducedImportLines)
                {

                    var documenLine = documentLines.FirstOrDefault(x => x.Id == reducedDocumenLine.Id);
                    idBl = documenLine.IdDocument;
                    if (reducedDocumenLine.MovementQty == documenLine.MovementQty)
                    {
                        documenLine.IdDocumentAssociated = idBl;
                        //documenLine.IdDeliveryAssociated = documenLine.Id;
                        documenLine.IdDocument = importDocumentsViewModel.IdCurrentDocument;
                        documenLine.IdDocumentNavigation = null;
                        documenLine.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;

                        ///////////////////////////////////////////////
                        DocumentLine docLines = bsDocument.DocumentLine.Where(y => y.IdDeliveryAssociated == documenLine.Id).FirstOrDefault();
                        if (docLines != null)
                        {
                            documenLine.MovementQty += docLines.MovementQty;
                            docLines.IsDeleted = true;
                            docLines.DeletedToken = Guid.NewGuid().ToString();
                            _entityDocumentLineRepo.Update(docLines);
                            _unitOfWork.Commit();
                        }

                        /////////////////////////////////////////////////
                        updatedDocumenLineForBS.Add(_documentLineBuilder.BuildEntity(documenLine));
                        continue;
                    }
                    else if (reducedDocumenLine.MovementQty > documenLine.MovementQty)
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "QUANTITY", documenLine.MovementQty}
                            };
                        throw new CustomException(CustomStatusCode.InvalidQuantity, paramtrs);
                    }
                    else
                    {
                        DocumentLineViewModel documenLineViewModel = _documentLineBuilder.BuildEntity(documenLine);
                        documenLineViewModel.MovementQty -= reducedDocumenLine.MovementQty;
                        documenLineViewModel.IdDocumentLineStatus = (int)DocumentStatusEnumerator.Provisional;
                        updtaedDocumenLineForSalesDelivery.Add(documenLineViewModel);
                        ///////////////////////////////// verif if Bs contains the line of article bl
                        DocumentLine docLines = bsDocument.DocumentLine.Where(y => y.IdDeliveryAssociated == documenLineViewModel.Id).FirstOrDefault();
                        if (docLines != null)
                        {
                            docLines.MovementQty += reducedDocumenLine.MovementQty;
                            updatedDocumenLineForBS.Add(_documentLineBuilder.BuildEntity(docLines));
                        }

                        ///////////////////////////////////////////////////////
                        else
                        {
                            var documenLineViewModelClone = (DocumentLineViewModel)documenLineViewModel.Clone();
                            documenLineViewModelClone.MovementQty = reducedDocumenLine.MovementQty;
                            documenLineViewModelClone.IdDeliveryAssociated = documenLineViewModel.Id;
                            documenLineViewModelClone.IdDocumentAssociated = idBl;
                            documenLineViewModelClone.Id = 0;
                            documenLineViewModelClone.IdDocument = importDocumentsViewModel.IdCurrentDocument;
                            addedDocumenLineForBS.Add(documenLineViewModelClone);
                        }
                    }
                }
                if (updatedDocumenLineForBS.FirstOrDefault() != null)
                {
                    updatedDocumenLineForBS.First().IdDocumentNavigation = _builder.BuildEntity(bsDocument);
                }

                UpdateDocumenLineValue(updatedDocumenLineForBS);
                _entityDocumentLineRepo.BulkUpdate(updatedDocumenLineForBS.Select(x => _documentLineBuilder.BuildModel(x)).ToList());

                UpdateDocumenLineValue(addedDocumenLineForBS);
                UpdateDocumenLineValue(updtaedDocumenLineForSalesDelivery);
                MangeAddedDocumentStockMovement(addedDocumenLineForBS);

                var updatedList = updtaedDocumenLineForSalesDelivery.Select(x => _documentLineBuilder.BuildModel(x)).ToList();
                foreach (var documentLine in updatedList)
                {
                    if (documentLine.StockMovement != null && documentLine.StockMovement.Any())
                    {
                        documentLine.StockMovement.FirstOrDefault().MovementQty = documentLine.MovementQty;
                    }
                }
                _entityDocumentLineRepo.BulkUpdate(updatedList);
                _unitOfWork.Commit();
                UpdateDocumentAmountsWithoutTransaction(importDocumentsViewModel.IdCurrentDocument, null);
                UpdateBlAssociated(importDocumentsViewModel.IdCurrentDocument);
                EndTransaction();

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

        private void UpdateBlAssociated(int idCurrentDocument)
        {
            var idBl = _entityDocumentLineRepo.GetAllAsNoTracking().Where(x => x.IdDocument == idCurrentDocument).Select(x => x.IdDocumentAssociated ?? 0).Distinct().ToList();
            idBl.ForEach(x => UpdateDocumentAmountsWithoutTransaction(x, null));
        }

        private List<DocumentLine> MangeAddedDocumentStockMovement(List<DocumentLineViewModel> addedDocumenLine)
        {
            var addedList = addedDocumenLine.Select(x => _documentLineBuilder.BuildModel(x)).ToList();
            foreach (var documentLine in addedList)
            {
                documentLine.StockMovement = new List<StockMovement>();
                // create a new stock movement
                StockMovement newStockMovement = new StockMovement
                {
                    IdDocumentLine = documentLine.Id,
                    MovementQty = documentLine.MovementQty,
                    IdItem = documentLine.IdItem,
                    IdWarehouse = (int)documentLine.IdWarehouse,
                    Operation = "O",
                    Status = DocumentEnumerator.Real,
                    CreationDate = DateTime.Now
                };
                documentLine.StockMovement.Add(newStockMovement);
            }
            _entityDocumentLineRepo.BulkAdd(addedList);
            _unitOfWork.Commit();
            return addedList;
        }

        public DocumentLineViewModel InsertUpdateBSDocumentLine(ItemPriceViewModel itemPricesViewModel)
        {
            try
            {
                BeginTransaction();
                CheckIfBSDocumentLineIsAssociated(itemPricesViewModel);
                var documenLine = InsertUpdateBSDocumentLineWithoutTransaction(itemPricesViewModel);
                EndTransaction();
                documenLine.IdDocumentNavigation.DocumentTaxsResume = documenLine.IdDocumentNavigation.DocumentTaxsResume.OrderBy(x => x.IdTaxNavigation.CodeTaxe).ToList();
                return documenLine;
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw (e);
            }


        }

        private void CheckIfBSDocumentLineIsAssociated(ItemPriceViewModel itemPricesViewModel)
        {
            if(itemPricesViewModel.DocumentType == DocumentEnumerator.BS)
            {
                DocumentLine documentLine = _entityDocumentLineRepo.QuerableGetAll().AsNoTracking()
                    .Include(x => x.IdItemNavigation).Include(x => x.InverseIdDocumentLineAssociatedNavigation)
                    .Where(x => x.Id == itemPricesViewModel.DocumentLineViewModel.Id).FirstOrDefault();

                if(documentLine != null && documentLine.InverseIdDocumentLineAssociatedNavigation != null
                     && documentLine.InverseIdDocumentLineAssociatedNavigation.Count > 0)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { Constants.ITEM_DESCRIPTION_UPPER_CASE, documentLine.IdItemNavigation.Description }
                        };
                    throw new CustomException(CustomStatusCode.BSDeleteOrEditLineViolation, paramtrs);
                }
                
            }
        }

        public DocumentLineViewModel InsertUpdateBSDocumentLineWithoutTransaction(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentLineViewModel.MovementQty < 0 && !itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                throw new CustomException(CustomStatusCode.PositiveQuantityViolation);
            }
            CheckitemPricesObject(itemPricesViewModel);
            Item item = itemPricesViewModel.Item;
            if (itemPricesViewModel.Item.ProvInventory)
            {
                IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => x.IdItem == item.Id &&
                     x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                     && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                     && (x.IdStockDocumentNavigation.IdTiers != null ||
                     x.IdStockDocumentNavigation.IdWarehouseSource == itemPricesViewModel.DocumentLineViewModel.IdWarehouse));

                if (inventaireList.Any())
                {
                    throw new CustomException(CustomStatusCode.ChosenItemExistInProvisionalInventory);
                }
            }
         

            if (itemPricesViewModel.DocumentLineViewModel.IdDeliveryAssociated != null)
            {
                List<Document> documents = _entityRepo.QuerableGetAll().Where(
              c => c.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
              c.DocumentLine.Select(v => (int)v.IdDocumentLineAssociated).Contains((int)itemPricesViewModel.DocumentLineViewModel.IdDeliveryAssociated)).ToList();
                if (documents != null && documents.Any())
                {
                    throw new CustomException(CustomStatusCode.DocumentAlReadyInvoiced);
                }
            }
            CheckUnicity(itemPricesViewModel);
            CheckHasRoleUpdateSA(itemPricesViewModel);
            return InsertUpdateBSDocumentLineProcess(itemPricesViewModel);
        }
        public DocumentLineViewModel InsertUpdateBSDocumentLineProcess(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)
            {
                DocumentType documentType = itemPricesViewModel.DocumentTypeObject;
                Item item = itemPricesViewModel.Item;
                StockMovement dbStockMovments = _entityStockMovementRepo.GetAllAsNoTracking().FirstOrDefault(x => x.IdDocumentLine == itemPricesViewModel.DocumentLineViewModel.Id);
                ItemWarehouse itemWarehouse = _entityItemWarehouseRepo.GetAllAsNoTracking().FirstOrDefault(p => p.IdItem == itemPricesViewModel.DocumentLineViewModel.IdItem
                 && p.IdWarehouse == itemPricesViewModel.DocumentLineViewModel.IdWarehouse);

                if (!CheckAvailableStock(itemPricesViewModel, item, itemWarehouse, dbStockMovments))
                {
                    throw new CustomException(CustomStatusCode.InsufficientQuantity);
                }
                if (itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)
                {
                    MangeStockSalesDeliveryDocumentInsertUpdate(itemPricesViewModel, item, itemWarehouse);
                }
            }
            if (itemPricesViewModel.DocumentLineViewModel.IsDeleted && itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Valid)
            {
                if (itemPricesViewModel.DocumentLineViewModel.IdDocumentAssociated != null)//from import
                {
                    MangeDeleteItemFromImport(itemPricesViewModel);
                }
                else
                {
                    _serviceDocumentLine.DeleteModelwithouTransaction(itemPricesViewModel.DocumentLineViewModel.Id, "DocumentLine", null);
                }
                DocumentViewModel documentViewModel = UpdateDocumentAmountsWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.IdDocument, null);
                itemPricesViewModel.DocumentLineViewModel.IdDocumentNavigation = documentViewModel;
                return itemPricesViewModel.DocumentLineViewModel;
            }



            if (!itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
               
                GetDocumentLinePrice(itemPricesViewModel);

                CalculateDocumentLine(itemPricesViewModel);

                if (itemPricesViewModel.DocumentLineViewModel.Id == 0)
                {
                    SetStatusSuperAdminUpdate(itemPricesViewModel);
                    var DocumentLineAfterSave = (CreatedDataViewModel)_serviceDocumentLine.AddModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel, null, null);
                    itemPricesViewModel.DocumentLineViewModel.Id = DocumentLineAfterSave.Id;
                }
                else
                {
                    if (itemPricesViewModel.DocumentLineViewModel.IdDocumentAssociated != null
                        && itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus != (int)DocumentStatusEnumerator.Valid)
                    {
                        MangeUpdatedItemFromImport(itemPricesViewModel.DocumentLineViewModel);
                    }
                    _serviceDocumentLineTaxe.BulkUpdateModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe.ToList(),null);
                    itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = null;
                    _serviceDocumentLine.UpdateModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel);
                }
            }
            else
            {
                itemPricesViewModel.DocumentLineViewModel.StockMovement = null;
                _serviceDocumentLine.UpdateModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel);
            }

            _unitOfWork.Commit();
            var document = UpdateDocumentAmountsWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.IdDocument, null);
            itemPricesViewModel.DocumentLineViewModel.IdDocumentNavigation = document;
            if (itemPricesViewModel.DocumentLineViewModel.IdDocumentAssociated > 0)
            {
                UpdateDocumentAmountsWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.IdDocumentAssociated ?? 0, null);
            }
            return itemPricesViewModel.DocumentLineViewModel;
        }

        private void MangeUpdatedItemFromImport(DocumentLineViewModel documentLineViewModel)
        {
            var oldQuantity = _entityDocumentLineRepo.GetAllAsNoTracking().First(x => x.Id == documentLineViewModel.Id).MovementQty;
            var diffQuantity = documentLineViewModel.MovementQty - oldQuantity;
            if (diffQuantity == 0)
            {
                return;
            }
            if (documentLineViewModel.IdDeliveryAssociated != null)
            {
                var SalesDeiveryQuantity = _entityDocumentLineRepo.GetAllAsNoTracking().First(x => x.Id == documentLineViewModel.IdDeliveryAssociated).MovementQty;
                if (diffQuantity > 0)
                {
                    if (SalesDeiveryQuantity < diffQuantity)
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "QUANTITY", oldQuantity+SalesDeiveryQuantity}
                            };
                        throw new CustomException(CustomStatusCode.InvalidQuantity, paramtrs);
                    }
                }
                MangeUpdateQuantityfromDelivery(documentLineViewModel, diffQuantity * -1);
                MangeUpdateStockMovement(documentLineViewModel);
            }
            else
            {
                if (diffQuantity > 0)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { "QUANTITY", oldQuantity}
                            };
                    throw new CustomException(CustomStatusCode.InvalidQuantity, paramtrs);
                }
                else
                {
                    var itemClone = _documentLineBuilder.BuildEntity(_entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdTiersNavigation)
                        .First(x => x.Id == documentLineViewModel.Id));
                    itemClone.MovementQty = diffQuantity * -1;
                    itemClone.IdDocument = documentLineViewModel.IdDocumentAssociated.Value;
                    itemClone.Id = 0;
                    itemClone.IdDocumentAssociated = null;
                    itemClone.IdDeliveryAssociated = null;
                    var listtoAdd = new List<DocumentLineViewModel>();
                    listtoAdd.Add(itemClone);
                    UpdateDocumenLineValue(listtoAdd);
                    List<DocumentLine> listDocLine = MangeAddedDocumentStockMovement(listtoAdd);
                    if (listDocLine != null && listDocLine.Any())
                    {
                        documentLineViewModel.IdDeliveryAssociated = listDocLine[0].Id;
                    }
                }
            }
        }

        private void MangeUpdateStockMovement(DocumentLineViewModel documentLineViewModel)
        {
            StockMovementViewModel documentLineStockMovment = _serviceStockMovement.GetModelAsNoTracked(y => y.IdDocumentLine == documentLineViewModel.Id);
            if (documentLineStockMovment != null)
            {
                documentLineStockMovment.MovementQty = documentLineViewModel.MovementQty;
                _entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(documentLineStockMovment));
                _unitOfWork.Commit();
            }
        }

        private void MangeDeleteItemFromImport(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentLineViewModel.IdDeliveryAssociated != null)
            {
                MangeUpdateQuantityfromDelivery(itemPricesViewModel.DocumentLineViewModel, itemPricesViewModel.DocumentLineViewModel.MovementQty);
                _serviceDocumentLine.UpdateModelWithoutTransaction(itemPricesViewModel.DocumentLineViewModel);
            }
            else
            {
                _entityDocumentLineRepo.QuerableGetAll().Where(x => x.Id == itemPricesViewModel.DocumentLineViewModel.Id)
                    .UpdateFromQuery(x => new DocumentLine
                    {
                        IdDocument = itemPricesViewModel.DocumentLineViewModel.IdDocumentAssociated ?? 0,
                        IdDocumentAssociated = null,
                        IsDeleted = false
                    });
            }

            _unitOfWork.Commit();
            UpdateDocumentAmountsWithoutTransaction(itemPricesViewModel.DocumentLineViewModel.IdDocumentAssociated ?? 0, null);
        }

        private void MangeUpdateQuantityfromDelivery(DocumentLineViewModel documentLineViewModel, double diff)
        {
            List<DocumentLine> documentLines = _entityDocumentLineRepo.GetAllAsNoTracking().Include(x => x.IdDocumentNavigation).ThenInclude(x => x.IdTiersNavigation)
                .Include(x => x.StockMovement).Where(x => x.Id == documentLineViewModel.IdDeliveryAssociated).ToList();

            documentLines.ForEach(x => x.MovementQty += diff);
            foreach (var documentLine in documentLines)
            {
                if (documentLine.MovementQty == 0)
                {
                    documentLineViewModel.IdDeliveryAssociated = null;
                    documentLine.IsDeleted = true;
                    documentLine.DeletedToken = Guid.NewGuid().ToString();
                }
                if (documentLine.StockMovement != null && documentLine.StockMovement.Any())
                {
                    documentLine.StockMovement.FirstOrDefault().MovementQty = documentLine.MovementQty;
                    if (documentLine.MovementQty == 0)
                    {
                        documentLine.StockMovement.FirstOrDefault().IsDeleted = true;
                        documentLine.StockMovement.FirstOrDefault().DeletedToken = Guid.NewGuid().ToString();
                    }
                }
            }
            var updatedList = documentLines.Select(x => _documentLineBuilder.BuildEntity(x)).ToList();
            UpdateDocumenLineValue(updatedList);
            var updatedListModel = updatedList.Select(x => _documentLineBuilder.BuildModel(x)).ToList();
            _entityDocumentLineRepo.BulkUpdate(updatedListModel);
        }

        private void CheckIfDeliveryIsSales(IList<int> idsDocumentLine)
        {
            if (idsDocumentLine != null && idsDocumentLine.Any())
            {
                DocumentViewModel blViewModel = GetModelAsNoTracked(x => x.DocumentLine.Select(y => y.Id).Contains(idsDocumentLine[0]), x => x.DocumentLine);

                if (blViewModel.DocumentLine != null && blViewModel.DocumentLine.Any())
                {
                    List<DocumentLineViewModel> listOfDocumentLineAssociated = _serviceDocumentLine.FindByAsNoTracking(x => x.IdDocumentLineAssociated != null && blViewModel.DocumentLine.Select(y => y.Id).Contains((int)x.IdDocumentLineAssociated) && x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice).ToList();
                    if (listOfDocumentLineAssociated != null && listOfDocumentLineAssociated.Any())
                    {
                        throw new CustomException(CustomStatusCode.DocumentAlReadyInvoiced);
                    }
                }

            }
        }

        public List<ReducedDocumentLineViewModel> GetDocumentLineOfBlNotAssociated(int idTiersBS)
        {
            List<ReducedDocumentLineViewModel> lineDocuments = new List<ReducedDocumentLineViewModel>();
            var idsDocAssc = _entityDocumentLineRepo.QuerableGetAll().
                     Include(x => x.IdDocumentNavigation).
                     Where(x => x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
                     x.IdDocumentLineAssociated != null).Select(y => (int)y.IdDocumentLineAssociated).ToList();
            List<Document> documents = _entityRepo.QuerableGetAll().Include(x => x.DocumentLine)
                .ThenInclude(x => x.IdItemNavigation).Include(x => x.DocumentLine)
                .ThenInclude(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation).Where(
               c => c.DocumentTypeCode == DocumentEnumerator.SalesDelivery &&
               c.IdTiers == idTiersBS &&
               c.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional).OrderByDescending(x => x.Id).ToList();
            documents = documents.Where(z => z.DocumentLine.All(y => !idsDocAssc.Contains(y.Id))).ToList();
            documents.ForEach(x =>
            {
                lineDocuments.AddRange(x.DocumentLine.Select(y => _documentLineReducedBuilder.BuildEntity(y)));
            });
            return lineDocuments;
        }

        public void UpdateBlsInRealTime(List<int> idsBls)
        {
            idsBls.ForEach(x => UpdateDocumentAmounts(x, null));
        }



    }
}
