using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        private void ValidateStockMovementFromSalesDelivery(DocumentViewModel document)
        {
            bool isAllDocumentLineisReserved = true;
            // check for Validation Of Document With Stock Reservation exception

            var idItemList = document.DocumentLine.Select(x => x.IdItem).ToList();
            List<Item> itemList = _itemEntityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => idItemList.Contains(x.Id), x => x.IdNatureNavigation).ToList();

            List<StockMovement> stockMovementList = _entityStockMovementRepo
                .GetAllWithConditionsRelationsQueryableAsNoTracking(x => document.DocumentLine.Select(y => y.Id).Contains(x.IdDocumentLine ?? 0)).ToList();

            List<ItemWarehouse> itemWarehouseList = _entityItemWarehouseRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(p => idItemList.Contains(p.IdItem)).ToList();

            List<int> idDocumentLineAssociated = document.DocumentLine.Where(x => x.IdDocumentLineAssociated != null)
               .Select(x => (int)x.IdDocumentLineAssociated).Distinct().ToList();
            List<StockMovement> stockMovementAssociatedList = _entityStockMovementRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => idDocumentLineAssociated.Contains(x.IdDocumentLine ?? 0)).ToList();

            List<StockMovement> stockMovementListToAdd = new List<StockMovement>();
            List<StockMovement> stockMovementListToUpdate = new List<StockMovement>();

            foreach (DocumentLineViewModel documentLine in document.DocumentLine)
            {
                Item item = itemList.First(x => x.Id == documentLine.IdItem);
                // if item is stock managed
                if (item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
                {
                    if (documentLine.IdWarehouse == null)
                    {   // Depot Required error
                        throw new CustomException(CustomStatusCode.DepotObligatoire);
                    }

                    StockMovement documentLineStockMovment = stockMovementList.FirstOrDefault(y => y.IdDocumentLine == documentLine.Id);
                    ItemWarehouse itemWarehouse = itemWarehouseList.FirstOrDefault(p => p.IdItem == documentLine.IdItem && p.IdWarehouse == (int)documentLine.IdWarehouse);
                    if (documentLineStockMovment != null)
                    {
                        if (documentLineStockMovment.Status != DocumentEnumerator.Reservation)
                        {
                            isAllDocumentLineisReserved = false;
                            documentLineStockMovment.Status = DocumentEnumerator.Real;
                            _serviceItemWarehouse.UpdateAvailableQuantityForSales(documentLineStockMovment, itemWarehouse);
                            stockMovementListToUpdate.Add(documentLineStockMovment);
                        }
                    }
                    else
                    {
                        isAllDocumentLineisReserved = false;
                        // create a new stock movement
                        StockMovement stockMovement = new StockMovement
                        {
                            IdDocumentLine = documentLine.Id,
                            MovementQty = documentLine.MovementQty,
                            IdItem = documentLine.IdItem,
                            IdWarehouse = (int)documentLine.IdWarehouse,
                            Operation = "O",
                            Status = DocumentEnumerator.Real,
                            CreationDate = document.DocumentDate
                        };

                        stockMovementListToAdd.Add(stockMovement);
                        _serviceItemWarehouse.UpdateAvailableQuantityOfItemWarehouse(stockMovement, itemWarehouse);
                        StockMovement stockMovementAssociated = stockMovementAssociatedList.FirstOrDefault(p => p.IdDocumentLine == documentLine.IdDocumentLineAssociated);
                        IncreaseStockMovmentDocumentLine(stockMovementAssociated, documentLine.MovementQty);
                    }
                }
                else
                {
                    isAllDocumentLineisReserved = false;
                }
            }

            if (isAllDocumentLineisReserved)
            {
                throw new CustomException(CustomStatusCode.ValidationOfDocumentWithStockReservation);
            }
            _entityStockMovementRepo.BulkAdd(stockMovementListToAdd);
            _entityStockMovementRepo.BulkUpdate(stockMovementListToUpdate);
            _entityItemWarehouseRepo.BulkUpdate(itemWarehouseList);
            _entityStockMovementRepo.BulkUpdate(stockMovementAssociatedList);
            _unitOfWork.Commit();

        }

        /// <summary>
        /// ckeck availeb quantitu for validation 
        /// </summary>
        /// <param name="documentLineDocument"></param>
        /// <param name="itemListViewModel"></param>
        private void CheckAvailebelQuantity(IList<DocumentLineViewModel> documentLineDocument, List<Item> itemList,
            List<ItemWarehouse> itemWarehouses)
        {

            foreach (var documentLine in documentLineDocument)
            {
                var item = itemList.First(x => x.Id == documentLine.IdItem);
                var mvtQuantity = documentLineDocument.Where(x => x.IdItem == documentLine.IdItem).Sum(x => x.MovementQty);
                // if item is stock managed
                if (item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
                {
                    if (documentLine.IdWarehouse == null)
                    {   // Depot Required error
                        throw new CustomException(CustomStatusCode.DepotObligatoire);
                    }
                    var itemWarhouse = itemWarehouses.First(x => x.IdItem == documentLine.IdItem && x.IdWarehouse == documentLine.IdWarehouse);
                    if (itemWarhouse.AvailableQuantity - itemWarhouse.ReservedQuantity < mvtQuantity)
                    {
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { "Code", item.Code }
                        };
                        throw new CustomException(CustomStatusCode.InsufficientQuantityForItem, paramtrs);
                    }
                }
            }
        }


        /// <summary>
        /// Make Zero A DocumentLine StockMovment
        /// </summary>
        /// <param name="idDocumentLine"></param>
        private void IncreaseStockMovmentDocumentLine(int idDocumentLine, double movementQty)
        {
            StockMovementViewModel documentLineStockMovment = _serviceStockMovement.GetModelAsNoTracked(y => y.IdDocumentLine == idDocumentLine);
            if (documentLineStockMovment != null)
            {
                documentLineStockMovment.MovementQty -= movementQty;
                if (documentLineStockMovment.MovementQty < 0)
                {
                    documentLineStockMovment.MovementQty = 0;
                }
                _entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(documentLineStockMovment));
            }
        }

        private void IncreaseStockMovmentDocumentLine(StockMovement stockMovement, double movementQty)
        {
            if (stockMovement != null)
            {
                stockMovement.MovementQty -= movementQty;
                if (stockMovement.MovementQty < 0)
                {
                    stockMovement.MovementQty = 0;
                }
                //_entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(documentLineStockMovment));
            }
        }
        private void UpdateDocumentLineStockMovment(DocumentLineViewModel documentLine, StockMovement documentLineStockMovment, ItemWarehouse itemWarhouse)
        {
            if (documentLineStockMovment != null)
            {
                var context = _unitOfWork.GetContext();

                var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == documentLineStockMovment.IdItem
                    && e.Entity.IdWarehouse == documentLineStockMovment.IdWarehouse);
                if (attachedItemwarehouse != null)
                {
                    context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
                }

                if (documentLine.IsValidReservationFromProvisionalStock)
                {
                    if (documentLineStockMovment.Status == DocumentEnumerator.Provisional)
                    {
                        itemWarhouse.ReservedQuantity -= (documentLineStockMovment.MovementQty ?? 0);

                    }
                    documentLineStockMovment.Status = DocumentEnumerator.Reservation;
                }
                else
                {
                    if (documentLineStockMovment.Status == DocumentEnumerator.Provisional)
                    {
                        double diffQuantity = documentLine.MovementQty - (documentLineStockMovment.MovementQty ?? 0);
                        itemWarhouse.ReservedQuantity += diffQuantity;
                        documentLineStockMovment.Status = DocumentEnumerator.Provisional;
                    }
                    else if (documentLineStockMovment.Status == DocumentEnumerator.Real)
                    {
                        var diffQuantity = documentLine.MovementQty - documentLineStockMovment.MovementQty;
                        itemWarhouse.AvailableQuantity -= diffQuantity ?? 0;
                    }
                    else
                    {
                        itemWarhouse.ReservedQuantity += documentLine.MovementQty;
                        documentLineStockMovment.Status = DocumentEnumerator.Provisional;
                    }

                }
                //_serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);
                documentLineStockMovment.MovementQty = documentLine.MovementQty;
                //_entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(documentLineStockMovment));
                //_unitOfWork.Commit();
            }


        }

        /// <summary>
        /// Make Zero A DocumentLine StockMovment
        /// </summary>
        /// <param name="idDocumentLine"></param>
        private void UpdateDocumentLineStockMovment(DocumentLineViewModel documentLine, string documentType)
        {
            StockMovementViewModel documentLineStockMovment = _serviceStockMovement.GetModelAsNoTracked(y => y.IdDocumentLine == documentLine.Id);
            if (documentLineStockMovment != null)
            {
                var context = _unitOfWork.GetContext();

                var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == documentLineStockMovment.IdItem
                    && e.Entity.IdWarehouse == documentLineStockMovment.IdWarehouse);
                if (attachedItemwarehouse != null)
                {
                    context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
                }
                var itemWarhouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == documentLineStockMovment.IdItem
                                                                    && x.IdWarehouse == documentLineStockMovment.IdWarehouse);

                if (documentLine.IsValidReservationFromProvisionalStock)
                {
                    if (documentLineStockMovment.Status == DocumentEnumerator.Provisional)
                    {
                        itemWarhouse.ReservedQuantity -= documentLineStockMovment.MovementQty;

                    }
                    documentLineStockMovment.Status = DocumentEnumerator.Reservation;
                }
                else
                {
                    if (documentLineStockMovment.Status == DocumentEnumerator.Provisional)
                    {
                        var diffQuantity = documentLine.MovementQty - documentLineStockMovment.MovementQty;
                        itemWarhouse.ReservedQuantity += diffQuantity;
                        documentLineStockMovment.Status = DocumentEnumerator.Provisional;
                    }
                    else if (documentLineStockMovment.Status == DocumentEnumerator.Real)
                    {
                        var diffQuantity = documentLine.MovementQty - documentLineStockMovment.MovementQty;
                        if (documentType == DocumentEnumerator.BE)
                        {
                            diffQuantity = documentLineStockMovment.MovementQty - documentLine.MovementQty;
                        }

                        itemWarhouse.AvailableQuantity -= diffQuantity;
                    }
                    else
                    {
                        itemWarhouse.ReservedQuantity += documentLine.MovementQty;
                        documentLineStockMovment.Status = DocumentEnumerator.Provisional;
                    }

                }
                _serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);
                documentLineStockMovment.MovementQty = documentLine.MovementQty;
                _entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(documentLineStockMovment));
                _unitOfWork.Commit();
            }


        }


        /// <summary>
        /// Make Zero A DocumentLine StockMovment
        /// </summary>
        /// <param name="idDocumentLine"></param>
        private void UpdateDocumentLineStockMovmentForasset(DocumentLineViewModel documentLine)
        {
            StockMovementViewModel documentLineStockMovment = _serviceStockMovement.GetModelAsNoTracked(y => y.IdDocumentLine == documentLine.Id);
            if (documentLineStockMovment != null)
            {
                var itemWarhouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == documentLineStockMovment.IdItem && x.IdWarehouse == documentLineStockMovment.IdWarehouse);
                if (documentLineStockMovment.Status == DocumentEnumerator.Real)
                {
                    var diffQuantity = documentLine.MovementQty - documentLineStockMovment.MovementQty;
                    itemWarhouse.AvailableQuantity += diffQuantity;
                    if (itemWarhouse.AvailableQuantity - itemWarhouse.ReservedQuantity < 0)
                    {
                        throw new CustomException(CustomStatusCode.InsufficientQuantity);
                    }
                }
                _serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);
                documentLineStockMovment.MovementQty = documentLine.MovementQty;
                _entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(documentLineStockMovment));
                _unitOfWork.Commit();
            }
        }

        /// <summary>
        /// Make Zero A DocumentLine StockMovment
        /// </summary>
        /// <param name="idDocumentLine"></param>
        private void DeleteDocumentLineStockMovmentUpdateReservedQuantity(int idDocumentLine, ItemWarehouse itemWarehouse, string documentType)
        {
            StockMovement documentLineStockMovment = _entityStockMovementRepo.GetSingleNotTracked(y => y.IdDocumentLine == idDocumentLine);
            if (documentLineStockMovment != null)
            {
                documentLineStockMovment.IsDeleted = true;
                documentLineStockMovment.DeletedToken = Guid.NewGuid().ToString();
                
                    var ctx = _unitOfWork.GetContext();
                    var attachedEntity = ctx.ChangeTracker.Entries<StockMovement>();
                    if (attachedEntity != null)
                    {
                        attachedEntity.Select(p => p.Entity).ToList().ForEach(y => {
                            ctx.Entry(y).State = EntityState.Detached;
                        });
                    }
                _entityStockMovementRepo.Update(documentLineStockMovment);

                if (documentLineStockMovment.Status != DocumentEnumerator.Reservation)
                {
                    double qty = documentLineStockMovment.MovementQty ?? 0;
                    if (documentLineStockMovment.Status == DocumentEnumerator.Provisional)
                    {
                        var reservedQty = itemWarehouse.ReservedQuantity - qty;
                        _entityItemWarehouseRepo.GetAllAsNoTracking().Where(x => x.IdItem == documentLineStockMovment.IdItem
                                    && x.IdWarehouse == documentLineStockMovment.IdWarehouse)
                            .UpdateFromQuery(x => new ItemWarehouse { ReservedQuantity = reservedQty });
                    }
                    else
                    {
                        var availableQty = documentType == DocumentEnumerator.BE ? itemWarehouse.AvailableQuantity - qty : itemWarehouse.AvailableQuantity + qty;
                        _entityItemWarehouseRepo.GetAllAsNoTracking().Where(x => x.IdItem == documentLineStockMovment.IdItem
                                    && x.IdWarehouse == documentLineStockMovment.IdWarehouse)
                            .UpdateFromQuery(x => new ItemWarehouse { AvailableQuantity = availableQty });
                    }
                }
                _unitOfWork.Commit();

            }
        }


        /// <summary>
        /// Make Zero A DocumentLine StockMovment
        /// </summary>
        /// <param name="idDocumentLine"></param>
        private void DeleteDocumentLineStockMovmentAssetQuatityQuantity(int idDocumentLine)
        {
            StockMovement documentLineStockMovment = _entityStockMovementRepo.GetSingleNotTracked(y => y.IdDocumentLine == idDocumentLine);
            if (documentLineStockMovment != null)
            {
                documentLineStockMovment.IsDeleted = true;
                documentLineStockMovment.DeletedToken = Guid.NewGuid().ToString();
                _entityStockMovementRepo.Update(documentLineStockMovment);
                _unitOfWork.Commit();

                var itemWarhouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == documentLineStockMovment.IdItem
                && x.IdWarehouse == documentLineStockMovment.IdWarehouse);
                itemWarhouse.AvailableQuantity -= documentLineStockMovment.MovementQty ?? 0;
                if (itemWarhouse.AvailableQuantity - itemWarhouse.ReservedQuantity < 0)
                {
                    throw new CustomException(CustomStatusCode.InsufficientQuantity);
                }
                _serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);
            }
        }


        /// <summary>
        /// CheckAndSplietDocumentLine
        /// </summary>
        /// <param name="itemPricesViewModel"></param>
        private void CheckAndSplietDocumentLine(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentType != DocumentEnumerator.SalesDelivery || itemPricesViewModel.DocumentLineViewModel.IsDeleted)
            {
                return;
            }
            if (itemPricesViewModel.DocumentLineViewModel.IsValidReservationFromProvisionalStock)
            {
                double oldQuantity = 0;
                if (itemPricesViewModel.DocumentLineViewModel.Id > 0)
                {
                    var stockMovment = _serviceStockMovement.GetModelAsNoTracked(x => x.IdDocumentLine == itemPricesViewModel.DocumentLineViewModel.Id
                    && x.Status == DocumentEnumerator.Provisional);
                    if (stockMovment != null)
                    {
                        oldQuantity = stockMovment.MovementQty;
                    }
                }
                var availbleQuantity = _serviceItemWarehouse.GetItemQtyInWarehouse(itemPricesViewModel.DocumentLineViewModel.IdItem, itemPricesViewModel.DocumentLineViewModel.IdWarehouse ?? 0);
                if (availbleQuantity + oldQuantity > 0 && (availbleQuantity + oldQuantity) < itemPricesViewModel.DocumentLineViewModel.MovementQty)
                {
                    SplietDocumentLine(itemPricesViewModel, availbleQuantity + oldQuantity, 0);
                    itemPricesViewModel.DocumentLineViewModel.MovementQty -= (availbleQuantity + oldQuantity);
                    itemPricesViewModel.DocumentLineViewModel.DocumentLineTaxe = null;
                }
            }
        }

        private void MangeStockSalesDeliveryMultiDocumentLinesInsert(DocumentViewModel document)
        {
            if (document.DocumentTypeCode != DocumentEnumerator.SalesDelivery || document.IdDocumentStatus != (int)DocumentStatusEnumerator.Valid)
            {
                return;
            }

            List<ItemViewModel> itemList = _serviceItem.GetItemsInventoryDetails(document.DocumentLine.Select(x => x.IdItem).ToList()).Distinct().ToList();

            foreach (var documentLine in document.DocumentLine)
            {
                var movementQuantity = document.DocumentLine.Where(x => x.IdItem == documentLine.IdItem).Sum(x => x.MovementQty);
                var item = itemList.First(x => x.Id == documentLine.IdItem);
                if (!item.IdNatureNavigation.IsStockManaged)
                {
                    continue;
                }
                CheckAvalibQuatityForItem(item, documentLine.IdWarehouse, movementQuantity);
                // create a new stock movement
                StockMovement stockMovement = new StockMovement
                {
                    IdDocumentLine = documentLine.Id,
                    MovementQty = documentLine.MovementQty,
                    IdItem = documentLine.IdItem,
                    IdWarehouse = (int)documentLine.IdWarehouse,
                    Operation = OperationEnumerator.Output,
                    Status = DocumentEnumerator.Real,
                    CreationDate = document.DocumentDate
                };
                documentLine.StockMovement = new List<StockMovementViewModel>
                                {
                                    _stockMovementBuilder.BuildEntity(stockMovement)
                                };
                var itemWarhouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == stockMovement.IdItem
                                                                   && x.IdWarehouse == stockMovement.IdWarehouse);
                itemWarhouse.AvailableQuantity -= stockMovement.MovementQty ?? 0;
                _serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);

            }

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="item"></param>
        /// <param name="idWarehouse"></param>
        /// <param name="movementQuantity"></param>
        private void CheckAvalibQuatityForItem(ItemViewModel item, int? idWarehouse, double movementQuantity)
        {
            if (idWarehouse == null)
            {   // Depot Required error
                throw new CustomException(CustomStatusCode.DepotObligatoire);
            }
            var itemWarehouse = item.ItemWarehouse.First(x => x.IdWarehouse == idWarehouse);
            var availebelquantity = itemWarehouse.AvailableQuantity - itemWarehouse.ReservedQuantity;
            if (availebelquantity < movementQuantity)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { "Code", item.Code }
                        };
                throw new CustomException(CustomStatusCode.InsufficientQuantityForItem, paramtrs);
            }
        }

        private void MangeStockSalesDeliveryDocumentInsertUpdate(ItemPriceViewModel itemPricesViewModel, Item item, ItemWarehouse itemWarehouse)
        {
            if (itemPricesViewModel.DocumentType != DocumentEnumerator.SalesDelivery && itemPricesViewModel.DocumentType != DocumentEnumerator.BS
                && (itemPricesViewModel.DocumentType != DocumentEnumerator.BE || (itemPricesViewModel.DocumentType == DocumentEnumerator.BE
                && itemPricesViewModel.DocumentLineViewModel.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Provisional)))

            {
                return;
            }
            var documentLine = itemPricesViewModel.DocumentLineViewModel;

            //ItemViewModel item = _serviceItem.GetModelWithRelationsAsNoTracked(x => x.Id == documentLine.IdItem, x => x.IdNatureNavigation);
            if (item == null)
            {
                // Item Required error
                throw new CustomException(CustomStatusCode.BadRequest);
            }
            // if item is stock managed
            if (item.IdNatureNavigation == null || !item.IdNatureNavigation.IsStockManaged)
            {
                return;
            }
            if (documentLine.IdWarehouse == null)
            {   // Depot Required error
                throw new CustomException(CustomStatusCode.DepotObligatoire);
            }

            if (documentLine.IsDeleted)
            {
                DeleteDocumentLineStockMovmentUpdateReservedQuantity(documentLine.Id, itemWarehouse, itemPricesViewModel.DocumentType);
                return;
            }

            string stockMovementStatus = "";

            if (documentLine.IsValidReservationFromProvisionalStock)
            {
                stockMovementStatus = DocumentEnumerator.Reservation;
            }
            else if (documentLine.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)
            {
                if (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery || itemPricesViewModel.DocumentType == DocumentEnumerator.BS
                    || itemPricesViewModel.DocumentType == DocumentEnumerator.BE)

                {
                    stockMovementStatus = DocumentEnumerator.Real;
                }
            }
            else
            {
                stockMovementStatus = DocumentEnumerator.Provisional;
            }

            // created new stock Movement 
            if (documentLine.Id == 0)
            {
                // create a new stock movement
                StockMovement stockMovement = new StockMovement
                {
                    IdDocumentLine = documentLine.Id,
                    MovementQty = documentLine.MovementQty,
                    IdItem = documentLine.IdItem,
                    IdWarehouse = (int)documentLine.IdWarehouse,
                    Operation = itemPricesViewModel.DocumentType == DocumentEnumerator.BE ? OperationEnumerator.Input : OperationEnumerator.Output,
                    Status = stockMovementStatus,
                    CreationDate = itemPricesViewModel.DocumentDate
                };
                documentLine.StockMovement = new List<StockMovementViewModel>
                                {
                                    _stockMovementBuilder.BuildEntity(stockMovement)
                                };

                if (!documentLine.IsValidReservationFromProvisionalStock)
                {
                    //var itemWarhouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == stockMovement.IdItem
                    //&& x.IdWarehouse == stockMovement.IdWarehouse);
                    if (documentLine.IdDocumentLineStatus == (int)DocumentStatusEnumerator.Valid)
                    {
                        if (itemPricesViewModel.DocumentType == DocumentEnumerator.SalesDelivery ||
                            itemPricesViewModel.DocumentType == DocumentEnumerator.BS)
                        {
                            itemWarehouse.AvailableQuantity -= stockMovement.MovementQty ?? 0;
                        }
                        else if (itemPricesViewModel.DocumentType == DocumentEnumerator.BE)
                        {
                            itemWarehouse.AvailableQuantity += stockMovement.MovementQty ?? 0;
                        }
                    }
                    else
                    {
                        itemWarehouse.ReservedQuantity += stockMovement.MovementQty ?? 0;
                    }
                    itemWarehouse.IdItemNavigation = null;
                    _entityItemWarehouseRepo.Update(itemWarehouse);
                    //_serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);

                }
            }
            else
            {
                // get old DL
                DocumentLine oldDocumentLine = _entityDocumentLineRepo.GetAllAsNoTracking().Include(r => r.StockMovement).FirstOrDefault(p => p.Id == documentLine.Id);

                if (oldDocumentLine.IdWarehouse == documentLine.IdWarehouse)
                {
                    UpdateDocumentLineStockMovment(documentLine, itemPricesViewModel.DocumentType);
                }
                else
                {
                    UpdateDocumentLineStockMovmentWhenChangeWarehouse(documentLine, oldDocumentLine, stockMovementStatus);
                }
            }

        }

        private void UpdateDocumentLineStockMovmentWhenChangeWarehouse(DocumentLineViewModel documentLine, DocumentLine oldDocumentLine, string stockMovementStatus)
        {
            string oldStatus = _entityStockMovementRepo.GetAllAsNoTracking().FirstOrDefault(p => p.IdDocumentLine == documentLine.Id).Status;

            _entityStockMovementRepo.GetAllAsNoTracking().Where(p => p.IdDocumentLine == documentLine.Id).UpdateFromQuery(p => new StockMovement
            {
                IdWarehouse = documentLine.IdWarehouse.Value,
                MovementQty = documentLine.MovementQty,
                Status = stockMovementStatus
            });
            ItemWarehouse oldItemWarehouse = _entityItemWarehouseRepo.GetAllAsNoTracking().FirstOrDefault(p => p.IdWarehouse == oldDocumentLine.IdWarehouse
            && p.IdItem == documentLine.IdItem);

            if (oldStatus == DocumentEnumerator.Provisional)
            {
                oldItemWarehouse.ReservedQuantity -= oldDocumentLine.MovementQty;
            }
            if (oldStatus == DocumentEnumerator.Real)
            {
                oldItemWarehouse.AvailableQuantity += oldDocumentLine.MovementQty;
            }

            ItemWarehouse newItemWarehouse = _entityItemWarehouseRepo.GetAllAsNoTracking().FirstOrDefault(p => p.IdWarehouse == documentLine.IdWarehouse
            && p.IdItem == documentLine.IdItem);
            if (stockMovementStatus == DocumentEnumerator.Provisional)
            {
                newItemWarehouse.ReservedQuantity += documentLine.MovementQty;
            }
            if (stockMovementStatus == DocumentEnumerator.Real)
            {
                newItemWarehouse.AvailableQuantity -= documentLine.MovementQty;
            }
            _entityItemWarehouseRepo.Update(oldItemWarehouse);
            _entityItemWarehouseRepo.Update(newItemWarehouse);
        }

        private void MangeStockSalesDeliveryForValidSalesAssetDocument(ItemPriceViewModel itemPricesViewModel)
        {
            if (itemPricesViewModel.DocumentType != DocumentEnumerator.SalesAsset)
            {
                return;
            }
            var documentId = itemPricesViewModel.DocumentLineViewModel.IdDocument;
            Document document = itemPricesViewModel.Document;
            if (document.IdDocumentStatus != (int)DocumentStatusEnumerator.Valid)
            {
                return;
            }

            var documentLine = itemPricesViewModel.DocumentLineViewModel;

            var item = itemPricesViewModel.Item;
            // if item is stock managed
            if (item.IdNatureNavigation == null || !item.IdNatureNavigation.IsStockManaged)
            {
                return;
            }
            if (documentLine.IdWarehouse == null)
            {   // Depot Required error
                throw new CustomException(CustomStatusCode.DepotObligatoire);
            }

            if (documentLine.IsDeleted)
            {
                DeleteDocumentLineStockMovmentAssetQuatityQuantity(documentLine.Id);
                return;
            }

            // created new stock Movement 
            if (documentLine.Id == 0)
            {
                // create a new stock movement
                StockMovement stockMovement = new StockMovement
                {
                    IdDocumentLine = documentLine.Id,
                    MovementQty = documentLine.MovementQty,
                    IdItem = documentLine.IdItem,
                    IdWarehouse = (int)documentLine.IdWarehouse,
                    Operation = OperationEnumerator.Input,
                    Status = DocumentEnumerator.Real,
                    CreationDate = itemPricesViewModel.DocumentDate
                };
                documentLine.StockMovement = new List<StockMovementViewModel>
                                {
                                    _stockMovementBuilder.BuildEntity(stockMovement)
                                };
                var itemWarhouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == stockMovement.IdItem
                                                                && x.IdWarehouse == stockMovement.IdWarehouse);
                itemWarhouse.AvailableQuantity += stockMovement.MovementQty ?? 0;
                _serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);
            }
            else
            {
                UpdateDocumentLineStockMovmentForasset(documentLine);
            }

        }



        private void MangeSaleDeliveryImportedAdd(DocumentLineViewModel documentLine, ItemWarehouse itemWarehouse)
        {
            StockMovementViewModel stockMovement = new StockMovementViewModel
            {
                IdDocumentLine = documentLine.Id,
                MovementQty = documentLine.MovementQty,
                IdItem = documentLine.IdItem,
                IdWarehouse = (int)documentLine.IdWarehouse,
                Operation = OperationEnumerator.Output,
                Status = DocumentEnumerator.Provisional,
                CreationDate = DateTime.Now
            };
            //_serviceStockMovement.AddWithoutTransaction(stockMovement);
            documentLine.StockMovement = new List<StockMovementViewModel>();
            documentLine.StockMovement.Add(stockMovement);
            var context = _unitOfWork.GetContext();
            var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == documentLine.IdItem
                   && e.Entity.IdWarehouse == documentLine.IdWarehouse);
            if (attachedItemwarehouse != null)
            {
                context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
            }
            //var itemWarehouse = _serviceItemWarehouse.GetModelAsNoTracked(x => x.IdItem == documentLine.IdItem
            //                                                        && x.IdWarehouse == documentLine.IdWarehouse);
            itemWarehouse.ReservedQuantity += documentLine.MovementQty;
            //_serviceItemWarehouse.UpdateWithoutCollectionsWithoutTransaction(itemWarhouse);
        }

        private void MangeAssetDeliveryImportedAdd(DocumentLineViewModel documentLine, ItemWarehouse itemWarehouse)
        {
            StockMovementViewModel stockMovement = new StockMovementViewModel
            {
                IdDocumentLine = documentLine.Id,
                MovementQty = documentLine.MovementQty,
                IdItem = documentLine.IdItem,
                IdWarehouse = (int)documentLine.IdWarehouse,
                Operation = OperationEnumerator.Input,
                Status = DocumentEnumerator.Real,
                CreationDate = DateTime.Now
            };
            //_serviceStockMovement.AddWithoutTransaction(stockMovement);
            documentLine.StockMovement = new List<StockMovementViewModel>();
            documentLine.StockMovement.Add(stockMovement);
            var context = _unitOfWork.GetContext();
            var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == documentLine.IdItem
                   && e.Entity.IdWarehouse == documentLine.IdWarehouse);
            if (attachedItemwarehouse != null)
            {
                context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
            }
            itemWarehouse.AvailableQuantity += documentLine.MovementQty;
        }


        /// <summary>
        /// Manage Stock Movement For Validation
        /// </summary>
        /// <param name="document"></param>
        private void ManageStockMovementForValidation(DocumentViewModel document, DocumentType documentType)
        {
            List<int> itemList = document.DocumentLine.Select(x => x.IdItem).ToList();
            List<int> idDocumentLineAssociated = document.DocumentLine.Where(x => x.IdDocumentLineAssociated != null)
                .Select(x => (int)x.IdDocumentLineAssociated).Distinct().ToList();
            List<int> documentLineList = document.DocumentLine.Select(y => y.Id).ToList();
            List<ItemWarehouse> itemWarehouses = _entityItemWarehouseRepo.QuerableGetAll().Where(p => itemList.Contains(p.IdItem)).ToList();
            List<ItemWarehouse> itemWarehouseToUpdate = new List<ItemWarehouse>();

            List<Item> items = _itemEntityRepo.GetAllAsNoTracking().Include(x => x.IdNatureNavigation)
                .Where(x => itemList.Contains(x.Id)).ToList();
            List<StockMovement> stockMovementList = _entityStockMovementRepo.QuerableGetAll().Where(x => documentLineList.Contains(x.IdDocumentLine ?? 0)).ToList();

            List<StockMovement> stockMovementAssociatedList = _entityStockMovementRepo.QuerableGetAll().Where(x => idDocumentLineAssociated.Contains(x.IdDocumentLine ?? 0)).ToList();

            if (documentType.StockOperation == OperationEnumerator.Output)
            {
                CheckAvailebelQuantity(document.DocumentLine.ToList(), items, itemWarehouses);
            }
            List<StockMovement> stockMovementListToAdd = new List<StockMovement>();
            List<StockMovement> stockMovementListToUpdate = new List<StockMovement>();

            foreach (DocumentLineViewModel documentLine in document.DocumentLine)
            {
                var item = items.First(x => x.Id == documentLine.IdItem);
                // if item is stock managed
                if (item.IdNatureNavigation != null && item.IdNatureNavigation.IsStockManaged)
                {
                    if (documentLine.IdWarehouse == null)
                    {   // Depot Required error
                        throw new CustomException(CustomStatusCode.DepotObligatoire);
                    }

                    StockMovement stockMovement = stockMovementList.FirstOrDefault(x => x.IdDocumentLine == documentLine.Id);
                    ItemWarehouse itemWarehouse = itemWarehouses.FirstOrDefault(p => p.IdItem == documentLine.IdItem && p.IdWarehouse == (int)documentLine.IdWarehouse);
                    // case add Not added stock Movement 
                    if (stockMovement == null)
                    {
                        // create a new stock movement
                        StockMovement newStockMovement = new StockMovement
                        {
                            IdDocumentLine = documentLine.Id,
                            MovementQty = documentLine.MovementQty,
                            IdItem = documentLine.IdItem,
                            IdWarehouse = (int)documentLine.IdWarehouse,
                            Operation = documentType.StockOperation,
                            Status = documentType.StockOperationStatus,
                            CreationDate = document.DocumentDate
                        };
                        stockMovementListToAdd.Add(newStockMovement);
                        _serviceItemWarehouse.UpdateAvailableQuantityOfItemWarehouse(newStockMovement, itemWarehouse);
                        _serviceItemWarehouse.UpdateOrderedQuantityOfItemWarehouse(documentLine.MovementQty, itemWarehouse,
                            documentType, documentLine.IdDocumentLineAssociated != null);
                        StockMovement stockMovementAssociated = stockMovementAssociatedList.FirstOrDefault(p => p.IdDocumentLine == documentLine.IdDocumentLineAssociated);
                        IncreaseStockMovmentDocumentLine(stockMovementAssociated, documentLine.MovementQty);
                    }
                    else
                    {
                        stockMovement.Status = DocumentEnumerator.Real;
                        // Changing documentLine StockMovment from Reservation/provisional to real
                        _serviceItemWarehouse.UpdateAvailableQuantityOfItemWarehouse(stockMovement, itemWarehouse);
                        stockMovementListToUpdate.Add(stockMovement);
                    }
                    // Set details stock date of item

                    itemWarehouseToUpdate.Add(itemWarehouse);
                }
            }

            _entityStockMovementRepo.BulkAdd(stockMovementListToAdd);

            _entityStockMovementRepo.BulkUpdate(stockMovementListToUpdate);

            _entityItemWarehouseRepo.BulkUpdate(itemWarehouseToUpdate);

            _entityStockMovementRepo.BulkUpdate(stockMovementAssociatedList);

            _unitOfWork.Commit();

        }

        /// <summary>
        /// CheckStock
        /// </summary>
        public void CheckStock(string connectionstring, string dataBaseName)
        {
            try
            {
                SetConnectionstring(connectionstring);
                DateTime now = DateTime.Now;

                _logger.LogError(new StringBuilder().Append("Info : <<Begin check Inventory>>").Append(now).ToString());
                var startQuantity = _entityStockMovementRepo.GetAllAsNoTracking().Where(x => x.Status == "INV")
                    .Select(x => new ItemQuantity { IdItem = x.IdItem ?? 0, IdWarehouse = x.IdWarehouse, Quantity = x.MovementQty ?? 0 }).ToList();

                var endQuantity = _entityItemWarehouseRepo.GetAllAsNoTracking()
                    .Select(x => new ItemQuantity { IdItem = x.IdItem, IdWarehouse = x.IdWarehouse, Quantity = x.AvailableQuantity }).ToList();

                var inAllQuantity = _entityDocumentLineRepo.GetAllAsNoTracking().
                    Where(x => (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesAsset || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BE ||
                    x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery) &&
                    (x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional))
                    .Select(x => new ItemQuantity { IdItem = x.IdItem, IdWarehouse = x.IdWarehouse, Quantity = x.MovementQty }).ToList();

                var inTransfer = _entityStockDocumentLineRepo.GetAllAsNoTracking().
                    Where(x => x.IdStockDocumentNavigation.TypeStockDocument == "TM" && x.IdStockDocumentNavigation.IdDocumentStatus == 10)
                    .Select(x => new ItemQuantity { IdItem = x.IdItem, IdWarehouse = x.IdStockDocumentNavigation.IdWarehouseDestination, Quantity = x.ActualQuantity ?? 0 }).ToList();

                var outTransfer = _entityStockDocumentLineRepo.GetAllAsNoTracking().
                 Where(x => x.IdStockDocumentNavigation.TypeStockDocument == "TM" && x.IdStockDocumentNavigation.IdDocumentStatus == 10)
                 .Select(x => new ItemQuantity { IdItem = x.IdItem, IdWarehouse = x.IdStockDocumentNavigation.IdWarehouseSource, Quantity = x.ActualQuantity ?? 0 }).ToList();


                var outAllQuantity = _entityDocumentLineRepo.GetAllAsNoTracking().
                 Where(x => (x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseAsset || x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.BS ||
                 x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery) &&
                 (x.IdDocumentNavigation.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional))
                 .Select(x => new ItemQuantity { IdItem = x.IdItem, IdWarehouse = x.IdWarehouse, Quantity = x.MovementQty }).ToList();

                List<int> unavialbleQuantity = new List<int>();
                foreach (var item in endQuantity)
                {
                    var itemStartQuatity = startQuantity.FirstOrDefault(x => x.IdItem == item.IdItem && x.IdWarehouse == item.IdWarehouse);
                    var inQuantity = inAllQuantity.Where(x => x.IdItem == item.IdItem && x.IdWarehouse == item.IdWarehouse).Sum(x => x.Quantity);
                    var outQuantity = outAllQuantity.Where(x => x.IdItem == item.IdItem && x.IdWarehouse == item.IdWarehouse).Sum(x => x.Quantity);
                    var InTrans = inTransfer.Where(x => x.IdItem == item.IdItem && x.IdWarehouse == item.IdWarehouse).Sum(x => x.Quantity);
                    var outTrans = outTransfer.Where(x => x.IdItem == item.IdItem && x.IdWarehouse == item.IdWarehouse).Sum(x => x.Quantity);
                    if (item.Quantity != (itemStartQuatity != null ? itemStartQuatity.Quantity : 0) + inQuantity + InTrans - outQuantity - outTrans)
                    {
                        unavialbleQuantity.Add(item.IdItem);
                    }
                }
                LogError(unavialbleQuantity, dataBaseName);
                _logger.LogError("Info : <<End check Inventory>> Delay excuted Milsecond : " + ((DateTime.Now - now).Milliseconds + (DateTime.Now - now).Minutes * 1000));

            }
            catch (Exception e)
            {
                RollBackTransaction();
                SalesInvoiceLog invoiceLog = new SalesInvoiceLog
                {
                    
                    Message =new StringBuilder().Append("Error At ").Append(DateTime.Now.ToString()).Append(":")
                    .Append(e.Message).Append(e.StackTrace).ToString()
            };
                BeginTransaction();
                _entityRepoInvoiceLog.Add(invoiceLog);
                _unitOfWork.Commit();
                EndTransaction();
            }
        }

        private void LogError(List<int> unavialbleQuantity, string dataBaseName)
        {
            if (unavialbleQuantity.Any())
            {
                string path = Path.Combine(".", "Env", new StringBuilder().Append(dataBaseName).Append("-FatalError.txt").ToString());
                using (StreamWriter sw = File.AppendText(path))
                {
                    foreach (var line in unavialbleQuantity)
                    {
                        sw.WriteLine(new StringBuilder().Append("UnvalidQuatity For Item : ").Append(line).ToString());
                    }
                }
            }
        }
    }
}

