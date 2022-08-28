using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes.StockDocuments
{
    public partial class ServiceStockDocument
    {
        public void CreateTransfertMovementDocument(List<StockDocumentLineViewModel> stockDocumentLineViewModels, DateTime DocumentDate, int idWarehouseSource, int idWarehouseDestination, string statusOfLine=null)
        {
            CreateOutputMovementDocument(stockDocumentLineViewModels, DocumentDate, idWarehouseSource, statusOfLine);
            CreateInputMovementDocument(stockDocumentLineViewModels, DocumentDate, idWarehouseDestination, statusOfLine);
        }


        public object TransfertValidateStockDocument(int id)
        {
            try
            {
                BeginTransaction();
                // Get stockDocument  by Id
                StockDocument stockDocument = _entityRepo.QuerableGetAll().Where(c => c.Id == id).Include(y=>y.StockDocumentLine).ThenInclude(z=>z.IdItemNavigation).FirstOrDefault();
                StockDocumentViewModel stockDocumentViewModel = _builder.BuildEntity(stockDocument);

                if (stockDocument.StockDocumentLine!=null && stockDocument.StockDocumentLine.Any())
                {
                    List<int> ids = stockDocument.StockDocumentLine.Select(x => x.IdItem).ToList();
                    IQueryable<Item> itemsWithoutUnit = _entityRepoItem.GetAllWithConditionsRelationsQueryableAsNoTracking(x => ids.Contains(x.Id) && x.IdUnitStock == null);
                    if (itemsWithoutUnit.Any())
                    {
                        throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                    }
                    List<int> idsItems = stockDocument.StockDocumentLine.Where(z=>z.IdItemNavigation.ProvInventory).Select(x => x.IdItem).Distinct().ToList();
                    if (idsItems.Any())
                    {
                        IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                         x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                         && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                         && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseSource));
                        if (inventaireList.Any())
                        {
                            throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                        }
                    }
                }
               
                
               
                // Change status of Stock movement
                ChangeStatusOfStockMovement(stockDocumentViewModel, OperationEnumerator.Output);
                // Change status of stock document to Valide
                stockDocument.IdDocumentStatus = (int)DocumentStatusEnumerator.Transferred;
                _entityRepo.Update(stockDocument);
                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel() { Id = stockDocumentViewModel.Id, Code = stockDocumentViewModel.Code };
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw;
            }
        }

        public object ReceiveValidateStockDocument(int id)
        {
            try
            {
                BeginTransaction();
                // Get stockDocument  by Id
                StockDocument stockDocument = _entityRepo.QuerableGetAll().Where(c => c.Id == id).Include(y => y.StockDocumentLine).ThenInclude(z => z.IdItemNavigation).FirstOrDefault();
                StockDocumentViewModel stockDocumentViewModel = _builder.BuildEntity(stockDocument);
                if (stockDocument.StockDocumentLine != null && stockDocument.StockDocumentLine.Any())
                {
                    List<int> ids = stockDocument.StockDocumentLine.Select(x => x.IdItem).ToList();
                    IQueryable<Item> itemsWithoutUnit = _entityRepoItem.GetAllWithConditionsRelationsQueryableAsNoTracking(x => ids.Contains(x.Id) && x.IdUnitStock == null);
                    if (itemsWithoutUnit.Any())
                    {
                        throw new CustomException(CustomStatusCode.ThereAreItemsWithoutMeasureUnit);
                    }
                    List<int> idsItems = stockDocument.StockDocumentLine.Where(z => z.IdItemNavigation.ProvInventory).Select(x => x.IdItem).Distinct().ToList();
                    if (idsItems.Any())
                    {
                        IQueryable<StockDocumentLine> inventaireList = _entityStockDocumentLineRepo.GetAllWithConditionsRelationsQueryable(x => idsItems.Contains(x.IdItem) &&
                         x.IdItemNavigation.ProvInventory && x.IdStockDocumentNavigation.TypeStockDocument == DocumentEnumerator.InventoryMovement
                         && (x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional || x.IdStockDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Draft)
                         && (x.IdStockDocumentNavigation.IdTiers != null || x.IdStockDocumentNavigation.IdWarehouseSource == stockDocument.IdWarehouseDestination));
                        if (inventaireList.Any())
                        {
                            throw new CustomException(CustomStatusCode.SomeItemExistInProvisionalInventory);
                        }
                    }
                }
                // Change status of Stock movement
                ChangeStatusOfStockMovement(stockDocumentViewModel, OperationEnumerator.Input);
                // Change status of stock document to Valide
                stockDocument.IdDocumentStatus = (int)DocumentStatusEnumerator.Received;
                VerifyAndUpdateReservedStockMovementFromTransferMovement(stockDocumentViewModel);
                _entityRepo.Update(stockDocument);
                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel() { Id = stockDocumentViewModel.Id, Code = stockDocumentViewModel.Code };
            }
            catch
            {
                // rollback transaction
                RollBackTransaction();
                // thorw the original exception
                throw;
            }
        }
        /// <summary>
        /// Verify And Update Reserved Stock Movement
        /// </summary>
        /// <param name="stockDocumentViewModel"></param>
        public void VerifyAndUpdateReservedStockMovementFromTransferMovement(StockDocumentViewModel stockDocumentViewModel)
        {
            if (stockDocumentViewModel == null)
            {
                throw new NotImplementedException();
            }

            foreach (StockDocumentLineViewModel currentStockDocumentLine in stockDocumentViewModel.StockDocumentLine)
            {
                // get Reservation stock movment of item in warehouse
                List<StockMovementViewModel> reservedDocumentLineStockMovmentList = _serviceStockMovement.FindModelsByNoTracked(y =>
                y.IdItem == currentStockDocumentLine.IdItem &&
                y.IdWarehouse == stockDocumentViewModel.IdWarehouseDestination &&
                y.Status == DocumentEnumerator.Reservation).ToList();

                foreach (StockMovementViewModel currentReservedDocumentLineStockMovment in reservedDocumentLineStockMovmentList)
                {
                    if ((currentReservedDocumentLineStockMovment != null)) // If the quantity  cover the document line Stock Movment
                    {

                        //// Changing documentLine StockMovment from Reservation to Provisional
                        //currentReservedDocumentLineStockMovment.Status = DocumentEnumerator.Provisional;
                        //_entityStockMovementRepo.Update(_stockMovementBuilder.BuildModel(currentReservedDocumentLineStockMovment));
                        //_unitOfWork.Commit();

                        ItemViewModel item = _serviceItem.GetModelAsNoTracked(x => x.Id == currentStockDocumentLine.IdItem, x => x.IdUnitStockNavigation);
                        int idDocumentOfCurrentResrvedStockMovement = _repoEntityDocumentLine.GetSingle(x => x.Id == currentReservedDocumentLineStockMovment.IdDocumentLine).IdDocument;

                        Warehouse centralWarehouse = _repoEntityWarehouse.GetSingleNotTracked(x => x.IsCentral);
                        Warehouse currentReservedDocumentLineStockMovmentIsWarehouse = _repoEntityWarehouse.GetSingleNotTracked(x =>
                            x.Id == currentReservedDocumentLineStockMovment.IdWarehouse);

                        Document reservedStockIsDocument = _repoEntityDocument.GetSingleNotTracked(x => x.Id == idDocumentOfCurrentResrvedStockMovement);

                        IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
                            {
                                { Constants.RESERVED_QUANTITY_UPPER_CASE, currentReservedDocumentLineStockMovment.MovementQty },
                                { Constants.RECEIVED_QUANTITY_UPPER_CASE, currentStockDocumentLine.ActualQuantity },
                                { Constants.UNITY_UPPER_CASE, item.IdUnitStockNavigation.Description },
                                { Constants.ITEM_DESCRIPTION_UPPER_CASE, item.Description },
                                { Constants.CENTRAL_WAREHOUSE_UPPER_CASE, centralWarehouse.WarehouseName },
                                { Constants.ITEM_IS_WAREHOUSE_UPPER_CASE, currentReservedDocumentLineStockMovmentIsWarehouse.WarehouseName },
                                { Constants.DOCUMENT_REFERENCE_UPPER_CASE, reservedStockIsDocument.Code },
                                { Constants.RECEPTION_DOCUMENT_REFERENCE_UPPER_CASE, reservedStockIsDocument.Code },
                                { Constants.STATUS, reservedStockIsDocument.IdDocumentStatus }

                            };
                        string companyCode = GetCurrentCompany().Code;
                        _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE,
                            reservedStockIsDocument.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertAvailableProduct, "", parameters, null, companyCode);

                    }
                }


            }

        }
    }
}
