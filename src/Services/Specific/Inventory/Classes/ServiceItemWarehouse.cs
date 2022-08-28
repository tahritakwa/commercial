using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceItemWarehouse : Service<ItemWarehouseViewModel, ItemWarehouse>, IServiceItemWarehouse
    {
        private readonly ILogger<ServiceItemWarehouse> _logger;
        private readonly IServiceStockMovement _serviceStockMovement;
        private readonly IRepository<StockMovement> _repoStockMovement;
        private readonly IRepository<Storage> _repoStorage;
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IRepository<DocumentLine> _repoDocLine;
        public ServiceItemWarehouse(IRepository<ItemWarehouse> entityRepo,
           IUnitOfWork unitOfWork, IItemWarehouseBuilder builder,
           ILogger<ServiceItemWarehouse> logger, IRepository<StockMovement> repoStockMovement,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IServiceWarehouse serviceWarehouse,
           IServiceStockMovement serviceStockMovement, IRepository<DocumentLine> repoDocLine, 
           IRepository<Storage> repoStorage)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _logger = logger;
            _serviceStockMovement = serviceStockMovement;
            _serviceWarehouse = serviceWarehouse;
            _repoStockMovement = repoStockMovement;
            _repoDocLine = repoDocLine;
            _repoStorage = repoStorage;
        }

        public List<WarehouseViewModel> GetDataWarehouseWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            DataSourceResult<ItemWarehouseViewModel> result = base.GetDataWithSpecificFilter(predicateModel);
            List<WarehouseViewModel> listOfAllWarehouses = _serviceWarehouse.GetAllModels().ToList();
            List<int> ids = result.data.Select(x => x.IdWarehouse).Distinct().ToList();
            List<WarehouseViewModel> listFilt = listOfAllWarehouses.Where(x => ids.Contains(x.Id)).ToList();
            return GetChildrensFiltredtest(listOfAllWarehouses, listFilt, new List<WarehouseViewModel>());
        }

        public List<WarehouseViewModel> GetChildrensFiltredtest(List<WarehouseViewModel> listGlobal, List<WarehouseViewModel> listFiltred, List<WarehouseViewModel> finalList)
        {
            List<WarehouseViewModel> finishList = new List<WarehouseViewModel>();
            foreach (WarehouseViewModel warehouse in listFiltred)
            {
                GetWarehouseParent(listGlobal, warehouse, finishList);
            }

            List<WarehouseViewModel> listWarehouse = _serviceWarehouse.GetChildrens(finishList.Where(x => x.IdWarehouseParent == null).ToList(), finishList, null);
            return listWarehouse;
        }

        private void GetWarehouseParent(List<WarehouseViewModel> listGlobal, WarehouseViewModel currentWarehouse, List<WarehouseViewModel> finishList)
        {
            if (!finishList.Contains(currentWarehouse))
            {
                finishList.Add(currentWarehouse);
            }
            WarehouseViewModel currentWarehouseParent = currentWarehouse;
            while (currentWarehouseParent.IdWarehouseParent != null && currentWarehouseParent.IdWarehouseParent > 0)
            {
                currentWarehouseParent = listGlobal.Where(x => x.Id == currentWarehouse.IdWarehouseParent).FirstOrDefault();
                if (currentWarehouseParent != null)
                {
                    if (currentWarehouseParent.Items == null)
                    {
                        currentWarehouseParent.Items = new List<WarehouseViewModel>();
                    }
                    currentWarehouseParent.Items.Add(currentWarehouse);
                    GetWarehouseParent(listGlobal, currentWarehouseParent, finishList);
                }
            }

        }
        public ItemViewModel GetItemWarehouseInventory(ItemViewModel itemViewModel, List<int> listOfIdWarehouses = null, ProvisioningViewModel models = null, IList<DocumentLineViewModel> documentLine = null)
        {
            // If list of Id warehouse get item warehouse where IdWarehouse exist in listOfIdWarehouses
            if (listOfIdWarehouses != null && listOfIdWarehouses.Any())
            {
                itemViewModel.ItemWarehouse = GetModelsWithConditionsRelations(x => x.IdItem == itemViewModel.Id && listOfIdWarehouses.Contains(x.IdWarehouse),
                x => x.IdWarehouseNavigation).OrderBy(x => x.IdWarehouseNavigation.WarehouseName).ToList();
            }
            else
            {
                itemViewModel.ItemWarehouse = GetModelsWithConditionsRelations(x => x.IdItem == itemViewModel.Id,
                x => x.IdWarehouseNavigation).OrderBy(x => x.IdWarehouseNavigation.WarehouseName).ToList();
            }

            if (itemViewModel.ItemWarehouse.Any())
            {
                if (models != null)
                {
                    foreach (var item in itemViewModel.ItemWarehouse)
                    {
                        item.IdItemNavigation.CreatedByDocumentLine = itemViewModel.CreatedByDocumentLine;
                    }
                }
                else
                {
                    List<DocumentLine> listPurchaseDeliveryProvByItem = _repoDocLine.QuerableGetAll().Where(x =>
                x.IdItem == itemViewModel.Id &&
                x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
                x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).
                Include(x => x.IdDocumentNavigation).ToList();

                    CalculatQuantity(itemViewModel.Id, itemViewModel.ItemWarehouse, listPurchaseDeliveryProvByItem);
                }

                ItemWarehouseViewModel central = itemViewModel.ItemWarehouse.FirstOrDefault(x => x.IdWarehouseNavigation.IsCentral);
                if (central != null)
                {
                    central.SumOfAvailableQuantity = itemViewModel.ItemWarehouse.Sum(x => x.AvailableQuantity);
                    MangeStateCentral(central);
                }
            }
            return itemViewModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="stockMovement"></param>
        public void UpdateAvailableQuantityOfItemWarehouse(StockMovement stockMovement, ItemWarehouse itemwarehouse)
        {
            if (stockMovement.Status == DocumentEnumerator.Real)
            {
                //var context = _unitOfWork.GetContext();
                //var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == itemwarehouse.IdItem
                //&& e.Entity.IdWarehouse == itemwarehouse.IdWarehouse);
                //if (attachedItemwarehouse != null)
                //{
                //    context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
                //}
                if (stockMovement.Operation == "I")
                {
                    itemwarehouse.AvailableQuantity += stockMovement.MovementQty ?? 0;
                }
                else
                {
                    itemwarehouse.AvailableQuantity -= stockMovement.MovementQty ?? 0;
                }
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="item"></param>
        /// <param name="stockMovement"></param>
        public void UpdateAvailebelQuantity(StockMovementViewModel stockMovement)
        {
            if (stockMovement.Status == DocumentEnumerator.Real)
            {
                var context = _unitOfWork.GetContext();
                var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == stockMovement.IdItem
                && e.Entity.IdWarehouse == stockMovement.IdWarehouse);
                if (attachedItemwarehouse != null)
                {
                    context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
                }
                var itemwarehouse = GetModelAsNoTracked(x => x.IdItem == stockMovement.IdItem && x.IdWarehouse == stockMovement.IdWarehouse);

                //   if (itemwarehouse.IdWarehouseNavigation.IsCentral == false)
                //   {
                if (stockMovement.Operation == "I")
                {
                    itemwarehouse.AvailableQuantity += stockMovement.MovementQty;
                }
                else
                {
                    itemwarehouse.AvailableQuantity -= stockMovement.MovementQty;
                }
                // }
                UpdateWithoutCollectionsWithoutTransaction(itemwarehouse);
            }
        }

        public void UpdateAvailableQuantityForSales(StockMovement stockMovement, ItemWarehouse itemWarehouse)
        {
            //var context = _unitOfWork.GetContext();
            //var attachedItemwarehouse = context.ChangeTracker.Entries<ItemWarehouse>().FirstOrDefault(e => e.Entity.IdItem == stockMovement.IdItem
            //&& e.Entity.IdWarehouse == stockMovement.IdWarehouse);
            //if (attachedItemwarehouse != null)
            //{
            //    context.Entry(attachedItemwarehouse.Entity).State = EntityState.Detached;
            //}
            //var itemwarehouse = GetModelAsNoTracked(x => x.IdItem == stockMovement.IdItem && x.IdWarehouse == stockMovement.IdWarehouse);
            itemWarehouse.AvailableQuantity -= stockMovement.MovementQty ?? 0;
            itemWarehouse.ReservedQuantity -= stockMovement.MovementQty ?? 0;
            //UpdateWithoutCollectionsWithoutTransaction(itemWarehouse);
        }


        public void CalculatQuantity(int idItem, ICollection<ItemWarehouseViewModel> itemWarehouses, List<DocumentLine> listPurchaseDeliveryProvByItem)
        {
            var stockMovementViewModels = _serviceStockMovement.FindModelsByNoTracked(p => p.IdItem == idItem &&
            (p.Status == DocumentEnumerator.Provisional || p.Status == DocumentEnumerator.Reservation)).ToList();
            List<int> listIdsStorages = itemWarehouses.Where(y => y.IdStorage != null && y.IdStorage > 0)
                .Select(x => (int)x.IdStorage).ToList();
            List<Storage> listOfStorages = _repoStorage.GetAllWithConditionsRelations(x=> 
            listIdsStorages.Contains(x.Id), x=>x.IdShelfNavigation).ToList();
            foreach (var itemWarehouse in itemWarehouses)
            {
                // affect shelf and storage
                if(itemWarehouse.IdStorage!=null && itemWarehouse.IdStorage > 0)
                {
                    Storage storage = listOfStorages.Single(y => y.Id == itemWarehouse.IdStorage);
                    itemWarehouse.Shelf = storage.IdShelfNavigation.Label;
                    itemWarehouse.Storage = storage.Label;
                }
                // Calculate CMD
                var itemWarehouseMVT = stockMovementViewModels.Where(c => c.IdWarehouse == itemWarehouse.IdWarehouse);


                itemWarehouse.ToOrderQuantity = itemWarehouseMVT
                    .Where(c => c.Operation == OperationEnumerator.Output && (c.Status == DocumentEnumerator.Provisional) && !c.IdStockDocumentLine.HasValue)
                    .Sum(x => x.MovementQty);
                if (itemWarehouse.ToOrderQuantity < 0)
                {
                    itemWarehouse.ToOrderQuantity = 0;
                    LogEroor(itemWarehouse.IdItem);
                }

                itemWarehouse.AvailableQuantity = itemWarehouse.AvailableQuantity - itemWarehouse.ReservedQuantity;
                if (itemWarehouse.AvailableQuantity < 0)
                {
                    itemWarehouse.AvailableQuantity = 0;
                    LogEroor(itemWarehouse.IdItem);
                }

                itemWarehouse.ReservedQuantityInDelivery = itemWarehouseMVT
                   .Where(c => c.Operation == OperationEnumerator.Output && c.Status == DocumentEnumerator.Reservation)
                   .Sum(x => x.MovementQty);


                itemWarehouse.OnOrderQuantity = itemWarehouseMVT
                    .Where(c => c.Operation == OperationEnumerator.Input && c.Status == DocumentEnumerator.Provisional && !c.IdStockDocumentLine.HasValue)
                    .Sum(x => x.MovementQty);
                if (itemWarehouse.OnOrderQuantity < 0)
                {
                    itemWarehouse.OnOrderQuantity = 0;
                    LogEroor(itemWarehouse.IdItem);
                }

                itemWarehouse.SumOnOrderedReservedQuantity = itemWarehouse.ToOrderQuantity + itemWarehouse.ReservedQuantityInDelivery;
                if (itemWarehouse.SumOnOrderedReservedQuantity < 0)
                {
                    itemWarehouse.SumOnOrderedReservedQuantity = 0;
                    LogEroor(itemWarehouse.IdItem);
                }
                itemWarehouse.InTransferedQuantity = itemWarehouseMVT
                    .Where(c => c.Operation == OperationEnumerator.Input && c.Status == DocumentEnumerator.Provisional && c.IdStockDocumentLine.HasValue)
                    .Sum(x => x.MovementQty);
                if (itemWarehouse.InTransferedQuantity < 0)
                {
                    itemWarehouse.InTransferedQuantity = 0;
                    LogEroor(itemWarehouse.IdItem);
                }

                itemWarehouse.OutTransferedQuantity = itemWarehouseMVT
                    .Where(c => c.Operation == OperationEnumerator.Output && c.Status == DocumentEnumerator.Provisional && c.IdStockDocumentLine.HasValue)
                    .Sum(x => x.MovementQty);
                if (itemWarehouse.OutTransferedQuantity < 0)
                {
                    itemWarehouse.OutTransferedQuantity = 0;
                    LogEroor(itemWarehouse.IdItem);
                }
                itemWarehouse.TradedQuantity = Math.Abs(itemWarehouse.InTransferedQuantity - itemWarehouse.OutTransferedQuantity);
                //if (itemWarehouse.TradedQuantity < 0)
                //{
                //    itemWarehouse.TradedQuantity = 0;
                //    LogEroor(itemWarehouse.IdItem);
                //}


                itemWarehouse.CMD = itemWarehouse.OrderedQuantity;
                itemWarehouse.CRP = 0 + "/" + 0;
                if (listPurchaseDeliveryProvByItem != null && listPurchaseDeliveryProvByItem.Any())
                {
                    List<DocumentLine> listPurchaseDeliveryProvByItemByWarehouse = listPurchaseDeliveryProvByItem.Where(r => r.IdWarehouse == itemWarehouse.IdWarehouse).ToList();
                    if (listPurchaseDeliveryProvByItemByWarehouse != null && listPurchaseDeliveryProvByItemByWarehouse.Any())
                    {
                        double sumMvtQtePurchaseDeliveryP = listPurchaseDeliveryProvByItemByWarehouse.Sum(u => u.MovementQty);
                        double crp = sumMvtQtePurchaseDeliveryP - itemWarehouse.ReservedQuantityInDelivery;
                        itemWarehouse.CMD = itemWarehouse.CMD - sumMvtQtePurchaseDeliveryP;
                        //calculate CRP
                        itemWarehouse.CRP = crp + "/" + sumMvtQtePurchaseDeliveryP;

                    }

                }


                MangeState(itemWarehouse);
            }
        }



        private void MangeState(ItemWarehouseViewModel itemWarehoouse)
        {
            if (itemWarehoouse.AvailableQuantity >= itemWarehoouse.MinQuantity &&
                itemWarehoouse.AvailableQuantity > 0)
            {
                itemWarehoouse.State = WarehouseState.InStock;
            }
            else if (itemWarehoouse.AvailableQuantity > 0)
            {
                itemWarehoouse.State = WarehouseState.InStockButNotSuffisantQuantity;
            }
            else
            {
                itemWarehoouse.State = WarehouseState.SoldOut;
            }
        }

        public void MangeStateCentral(ItemWarehouseViewModel itemWarehoouse)
        {
            if (itemWarehoouse.SumOfAvailableQuantity >= itemWarehoouse.MinQuantity &&
                itemWarehoouse.SumOfAvailableQuantity > 0)
            {
                itemWarehoouse.State = WarehouseState.InStock;
            }
            else if (itemWarehoouse.SumOfAvailableQuantity > 0)
            {
                itemWarehoouse.State = WarehouseState.InStockButNotSuffisantQuantity;
            }
            else if (itemWarehoouse.OrderedQuantity > 0)
            {
                itemWarehoouse.State = WarehouseState.InCommand;
            }
            else
            {
                itemWarehoouse.State = WarehouseState.SoldOut;
            }
        }



        /// <summary>
        /// Is Available Quantity Only In Provisional Stock
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="idWarehouse"></param>
        /// <param name="movementQty"></param>
        /// <returns></returns>
        public bool IsAvailableQuantityOnlyInProvisionalStock(int idItem, int idWarehouse, double movementQty, int idDocumentLine)
        {
            double stockMovmentOldQty = 0;
            double provisionalQuantity = 0;
            if (idDocumentLine > 0)
            {
                var stockMovment = _serviceStockMovement.GetModelAsNoTracked(x => x.IdDocumentLine == idDocumentLine && x.IdWarehouse == idWarehouse);
                if (stockMovment != null)
                {
                    stockMovmentOldQty = stockMovment.MovementQty;
                    if (stockMovment.Status == DocumentEnumerator.Provisional)
                    {
                        provisionalQuantity = stockMovment.MovementQty;
                    }
                }
            }

            var availebelQuantity = GetItemQtyInWarehouse(idItem, idWarehouse);
            if (availebelQuantity + provisionalQuantity >= movementQty)
            {
                return false;
            }
            else
            {
                double qtyOfProvisionalInputInWarehouseAndnCentral = GetProvisonelInput(idItem, idWarehouse);
                double qtyOfReservationInWarehouseAndnCentral = GetReservationOutput(idItem);
                if (availebelQuantity + stockMovmentOldQty + qtyOfProvisionalInputInWarehouseAndnCentral - qtyOfReservationInWarehouseAndnCentral >= movementQty)
                {
                    return true;
                }
                return false;
            }

        }

        private double GetReservationOutput(int idItem)
        {
            return _repoStockMovement.QuerableGetAll().Where(c => c.Operation == OperationEnumerator.Output && c.IdItem == idItem && c.Status == DocumentEnumerator.Reservation)
               .Sum(x => x.MovementQty ?? 0);
        }

        private double GetProvisonelInput(int idItem, int idWarehouse)
        {
            return _repoDocLine.QuerableGetAll().Where(x => x.IdItem == idItem && x.IdWarehouse == idWarehouse &&
            x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseDelivery &&
            x.IdDocumentNavigation.IdDocumentStatus == (int)DocumentStatusEnumerator.Provisional).
            Include(x => x.IdDocumentNavigation).Sum(p => p.MovementQty);
        }


        /// <summary>
        /// Get Starting Stock in startDate for all Warehouses 
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public double GetItemQtyInAllWarehouses(int idItem, DateTime endDate)
        {
            double quantityInputInAllWarehousesAfterLastInventory = 0;
            double quantityOutputInAllWarehousesAfterLastInventory = 0;

            // Get all warehouses form ItemWarehouse List
            double availbelquatity = _entityRepo.QuerableGetAll().Where(x => x.IdItem == idItem).ToList().Sum(x => x.AvailableQuantity - x.ReservedQuantity);
            if (availbelquatity < 0)
            {
                availbelquatity = 0;
                LogEroor(idItem);
            }

            // Get list of Input movement
            quantityInputInAllWarehousesAfterLastInventory = _repoStockMovement.QuerableGetAll().Where(c =>
                        c.IdItem == idItem
                       && c.Operation == OperationEnumerator.Input
                       && ((c.IdDocumentLineNavigation != null && DateTime.Compare(c.IdDocumentLineNavigation.IdDocumentNavigation.DocumentDate.Date, endDate) > 0)
                       || (c.IdStockDocumentLineNavigation != null && DateTime.Compare(c.IdStockDocumentLineNavigation.IdStockDocumentNavigation.DocumentDate.Value.Date, endDate) > 0))
                       && c.Status == DocumentEnumerator.Real).Sum(x => x.MovementQty ?? 0);

            // Get list of Output movement
            quantityOutputInAllWarehousesAfterLastInventory = _repoStockMovement.QuerableGetAll().Where(c =>
                       c.IdItem == idItem
                       && c.Operation == OperationEnumerator.Output && ((c.IdDocumentLineNavigation != null && c.IdDocumentLineNavigation.IdDocumentNavigation != null &&
                       c.IdDocumentLineNavigation.IdDocumentNavigation.DocumentDate != null &&
                       DateTime.Compare(c.IdDocumentLineNavigation.IdDocumentNavigation.DocumentDate.Date, endDate) > 0)
                       || (c.IdStockDocumentLineNavigation != null && DateTime.Compare(c.IdStockDocumentLineNavigation.IdStockDocumentNavigation.DocumentDate.Value.Date, endDate) > 0))
                       && (c.Status == DocumentEnumerator.Real || c.Status == DocumentEnumerator.Provisional)).Sum(x => x.MovementQty ?? 0);
            return availbelquatity - quantityInputInAllWarehousesAfterLastInventory + quantityOutputInAllWarehousesAfterLastInventory;
        }

        public void LogEroor(int idItem)
        {
            _logger.LogError(new StringBuilder().Append("<Fatal error Stock Negative for id Article > ").Append(idItem).ToString());
        }

        public void UpdateItemWarehouseCollection(ItemViewModel model)
        {
            //recuperate collection before update
            List<ItemWarehouseViewModel> oldItemwarehouse = FindByAsNoTracking(x => x.IdItem == model.Id).ToList();

            List<ItemWarehouseViewModel> newItemWarehouse = model.ItemWarehouse.ToList();
            newItemWarehouse.ForEach(x => x.IdItem = model.Id);

            List<ItemWarehouseViewModel> addedItemWarehouse = newItemWarehouse.Where(x => x.Id == 0).ToList();


            List<ItemWarehouseViewModel> deletedItemWarehouse = new List<ItemWarehouseViewModel>();
            if(newItemWarehouse.Count == 0)
            {
                deletedItemWarehouse = oldItemwarehouse;
            }
            else
            {
                deletedItemWarehouse = newItemWarehouse.Where(x => x.IsDeleted).ToList();
            }

            foreach (ItemWarehouseViewModel itemwarehouse in addedItemWarehouse)
            {
                itemwarehouse.IdItem = model.Id;
                itemwarehouse.OnOrderQuantity = 0;
                itemwarehouse.AvailableQuantity = 0;
                itemwarehouse.ReservedQuantity = 0;
                itemwarehouse.OrderedQuantity = 0;
                AddModelWithoutTransaction(itemwarehouse, new List<EntityAxisValuesViewModel>(), null);
            }
            foreach (ItemWarehouseViewModel itemWarehouse in deletedItemWarehouse)
            {
                var oldValue = oldItemwarehouse.First(x => x.Id == itemWarehouse.Id);
                if (oldValue.AvailableQuantity != 0)
                {
                    throw new CustomException(CustomStatusCode.ItemAlreadyExistsInWarehouse);
                }
                else
                {
                    DeleteModelwithouTransaction(itemWarehouse.Id, nameof(ItemWarehouse), null);
                }
            }

            var updatedItemWarehouse = newItemWarehouse.Where(x => x.Id != 0 && !x.IsDeleted);
            foreach (ItemWarehouseViewModel itemWarehouse in updatedItemWarehouse)
            {
                var oldValue = oldItemwarehouse.First(x => x.Id == itemWarehouse.Id);
                itemWarehouse.OnOrderQuantity = oldValue.OnOrderQuantity;
                itemWarehouse.OrderedQuantity = oldValue.OrderedQuantity;
                itemWarehouse.AvailableQuantity = oldValue.AvailableQuantity;
                itemWarehouse.ReservedQuantity = oldValue.ReservedQuantity;
                _entityRepo.Update(_builder.BuildModel(itemWarehouse));
                _unitOfWork.Commit();
            }


        }

        public double GetItemQtyInWarehouse(int idItem, ItemWarehouse itemWarehouse)
        {
            if (itemWarehouse == null)
            {
                return 0;
            }
            // calcul qty
            var avalib = itemWarehouse.AvailableQuantity - (itemWarehouse.ReservedQuantity);
            if (avalib < 0)
            {
                avalib = 0;
                LogEroor(idItem);
            }
            return avalib;
        }


        //get Availble Quantity For Item warehouse
        public double GetItemQtyInWarehouse(int idItem, int idWarehouse)
        {
            IQueryable<ItemWarehouse> itemWarehouse = _entityRepo.GetAllAsNoTracking().Where(y => y.IdItem == idItem && y.IdWarehouse == idWarehouse).Include(z => z.IdItemNavigation).ThenInclude(x => x.IdUnitStockNavigation);

            if (itemWarehouse == null || !itemWarehouse.Any())
            {
                return 0;
            }
            if (itemWarehouse.FirstOrDefault().IdItemNavigation.IdUnitStock == null)
            {
                throw new CustomException(CustomStatusCode.ItemWithoutMeasureUnit);
            }
            // calcul qty
            var avalib = AmountMethods.FormatValue((itemWarehouse.FirstOrDefault().AvailableQuantity - itemWarehouse.FirstOrDefault().ReservedQuantity), itemWarehouse.FirstOrDefault().IdItemNavigation.IdUnitStockNavigation.DigitsAfterComma);
            if (avalib < 0)
            {
                avalib = 0;
                LogEroor(idItem);
            }
            return avalib;
        }



        /// <summary>
        /// Get item Quantity For item Qouting Reservation stock
        /// </summary>
        /// <param name="idItem"></param>
        /// <param name="idWarehouse"></param>
        /// <returns></returns>
        public double GetItemQtyInWarehouseWithCountingReservationOutputs(int idItem, int idWarehouse)
        {
            // get qty of reservation Movement
            double qtyOfReservation = _serviceStockMovement.GetReservationQuatity(idItem);
            // calcul qty
            return GetItemQtyInWarehouse(idItem, idWarehouse) - qtyOfReservation;
        }

        //get Availbel quatity For Multi Item 
        public void GetAllAvailbleQuantityFolAllItem(List<ItemViewModel> itemList, bool isB2b = false,
            double? idWarehouse = null)
        {
            var itemIds = itemList.Select(x => x.Id).ToList();
            List<ItemWarehouseViewModel> allItemWarehouse = GetModelsWithConditionsRelations(x => itemIds.Contains(x.IdItem), x => x.IdWarehouseNavigation).ToList();
            foreach (var item in itemList)
            {
                var allWarehouse = allItemWarehouse.Where(x => x.IdItem == item.Id);
                item.AllAvailableQuantity = allWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity);
                item.WarhouseAvailableQuantity = allWarehouse.Where(x => x.IdWarehouse == idWarehouse).Sum(x => x.AvailableQuantity - x.ReservedQuantity);
                if (idWarehouse != null)
                {
                    var itemWarehouse = allWarehouse.FirstOrDefault(p => p.IdWarehouse == idWarehouse);
                    item.OrderedQuantity = itemWarehouse != null ? itemWarehouse.OrderedQuantity : 0;
                }
                else
                {
                    item.OrderedQuantity = 0;
                }

                if (item.AllAvailableQuantity < 0)
                {
                    item.AllAvailableQuantity = 0;
                    LogEroor(item.Id);
                }
                if (item.WarhouseAvailableQuantity < 0)
                {
                    item.WarhouseAvailableQuantity = 0;
                    LogEroor(item.Id);
                }
                item.IsAvailable = item.AllAvailableQuantity > 0;
                var centralWarehouse = allWarehouse.FirstOrDefault(x => x.IdWarehouseNavigation.IsCentral);
                if (centralWarehouse != null)
                {
                    item.CentralMinQuantity = centralWarehouse.MinQuantity;
                }

            }
        }

        //get Available quatity For one Item 
        public void GetAvailbleQuantityForItem(Item itemQty)
        {
            if (itemQty != null)
            {
                var itemIds = itemQty.Id;
                itemQty.AllAvailableQuantity = GetModelsWithConditionsRelations(x => itemQty.Id == x.IdItem, x => x.IdWarehouseNavigation).Sum(x => x.AvailableQuantity - x.ReservedQuantity);
                if (itemQty.AllAvailableQuantity < 0)
                {
                    itemQty.AllAvailableQuantity = 0;
                    LogEroor(itemQty.Id);
                }
                itemQty.IsAvailable = itemQty.AllAvailableQuantity > 0;
            }
        }

        //get Availbel quatity For Multi Item 
        public void GetAllAvailbleQuantityFolAllItem(List<Item> itemList)
        {
            var itemIds = itemList.Select(x => x.Id).ToList();
            List<ItemWarehouseViewModel> allItemWarehouse;
            allItemWarehouse = GetModelsWithConditionsRelations(x => itemIds.Contains(x.IdItem), x => x.IdWarehouseNavigation).ToList();
            foreach (var item in itemList)
            {
                var allWarehouse = allItemWarehouse.Where(x => x.IdItem == item.Id);
                item.AllAvailableQuantity = allWarehouse.Sum(x => x.AvailableQuantity - x.ReservedQuantity);
                if (item.AllAvailableQuantity < 0)
                {
                    item.AllAvailableQuantity = 0;
                    LogEroor(item.Id);
                }
                item.IsAvailable = item.AllAvailableQuantity > 0;
            }
        }
        public List<string> getStorageDataSourceFromWarhouse(ItemWarehouseViewModel itemWarehouse)
        {
            return _entityRepo.QuerableGetAll().Where(x => x.IdWarehouse == itemWarehouse.IdWarehouse
            && !string.IsNullOrEmpty(x.Storage) && x.Storage != itemWarehouse.Storage
            && x.Shelf == itemWarehouse.Shelf).Select(x => x.Storage).Distinct().ToList();
        }
        public List<string> getShelfDataSourceFromWarhouse(int idWarehouse)
        {
            return _entityRepo.QuerableGetAll().Where(x => x.IdWarehouse == idWarehouse &&
            !string.IsNullOrEmpty(x.Shelf)).Select(x => x.Shelf).Distinct().OrderBy(x => x).ToList();
        }

        public DataSourceResult<ShelfStorageManagementViewModel> GenerateItemsFromShelfAndStorage(object dataObject)
        {
            IQueryable<ItemWarehouse> entity;
            dynamic dataObj = dataObject;
            ItemWarehouseViewModel itemWarehouseViewModel = JsonConvert.DeserializeObject<ItemWarehouseViewModel>(dataObj.itemWarehouseViewModel.ToString());
            if (dataObj.state != null)
            {
                ICollection<OrderByViewModel> orderByObject = JsonConvert.DeserializeObject<ICollection<OrderByViewModel>>(dataObj.state.OrderBy.ToString());
                if (string.IsNullOrEmpty(itemWarehouseViewModel.Shelf))
                {
                    entity = _entityRepo.GetAllAsNoTracking().Where(x => x.IdWarehouse == itemWarehouseViewModel.IdWarehouse &&
                (!string.IsNullOrEmpty(itemWarehouseViewModel.Storage) ? itemWarehouseViewModel.Storage == x.Storage : true)
                && (x.Shelf == null || x.Shelf == "")).OrderByRelation(orderByObject);
                }
                else
                {
                    entity = _entityRepo.GetAllAsNoTracking().Where(x => x.IdWarehouse == itemWarehouseViewModel.IdWarehouse &&
                (!string.IsNullOrEmpty(itemWarehouseViewModel.Storage) ? itemWarehouseViewModel.Storage == x.Storage : true)
                && (!string.IsNullOrEmpty(itemWarehouseViewModel.Shelf) ? itemWarehouseViewModel.Shelf == x.Shelf : true)).OrderByRelation(orderByObject);
                }
            }
            else
            {
                if (string.IsNullOrEmpty(itemWarehouseViewModel.Shelf))
                {
                    entity = _entityRepo.GetAllAsNoTracking().Where(x => x.IdWarehouse == itemWarehouseViewModel.IdWarehouse &&
                (!string.IsNullOrEmpty(itemWarehouseViewModel.Storage) ? itemWarehouseViewModel.Storage == x.Storage : true)
                && (x.Shelf == null || x.Shelf == ""));
                }
                else
                {
                    entity = _entityRepo.GetAllAsNoTracking().Where(x => x.IdWarehouse == itemWarehouseViewModel.IdWarehouse &&
                   (!string.IsNullOrEmpty(itemWarehouseViewModel.Storage) ? itemWarehouseViewModel.Storage == x.Storage : true)
                   && (!string.IsNullOrEmpty(itemWarehouseViewModel.Shelf) ? itemWarehouseViewModel.Shelf == x.Shelf : true));
                }
            }
            var total = entity.Count();
            var data = entity.Include(x => x.IdItemNavigation)
           .Include(x => x.IdWarehouseNavigation).Select(x => new ShelfStorageManagementViewModel
           {
               Id = x.Id,
               AvailableQuantity = x.AvailableQuantity - x.ReservedQuantity,
               IdItem = x.IdItem,
               IdWarehouse = x.IdWarehouse,
               Item = x.IdItemNavigation.Code + '-' + x.IdItemNavigation.Description,
               OrderedQuantity = x.OrderedQuantity,
               Shelf = x.Shelf,
               Storage = x.Storage,
               WarehouseName = x.IdWarehouseNavigation.WarehouseName
           }).ToList();
            return new DataSourceResult<ShelfStorageManagementViewModel> { data = data, total = total };

        }

        public void ChangeItemStorage(List<ShelfStorageManagementViewModel> itemWarehouseViewModel)
        {
            try
            {
                var results = from p in itemWarehouseViewModel
                              group p by p.NewStorage into g
                              select new { storage = g.Key, items = g.ToList() };

                BeginTransaction();
                foreach (var item in results)
                {
                    var items = item.items.Select(x => x.Id);
                    if (!string.IsNullOrEmpty(item.storage))
                    {
                        var storage = item.storage.Substring(item.storage.Length - 3);
                        var shelf = item.storage.Remove(item.storage.Length - 3);
                        _entityRepo.QuerableGetAll().Where(x => items.Contains(x.Id))
                            .UpdateFromQuery(x => new ItemWarehouse { Storage = storage, Shelf = shelf });
                    }
                    else
                    {
                        _entityRepo.QuerableGetAll().Where(x => items.Contains(x.Id))
                            .UpdateFromQuery(x => new ItemWarehouse { Storage = "", Shelf = "" });
                    }

                }
                _unitOfWork.Commit();
                EndTransaction();
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }

        }
        public void ChangeItemStorage(ShelfStorageManagementViewModel itemWarehouseViewModel)
        {
            try
            {
                BeginTransaction();
                if (!string.IsNullOrEmpty(itemWarehouseViewModel.NewStorage))
                {
                    var storage = itemWarehouseViewModel.NewStorage.Substring(itemWarehouseViewModel.NewStorage.Length - 3);
                    var shelf = itemWarehouseViewModel.NewStorage.Remove(itemWarehouseViewModel.NewStorage.Length - 3);
                    _entityRepo.QuerableGetAll().Where(x => itemWarehouseViewModel.Id == x.Id)
                        .UpdateFromQuery(x => new ItemWarehouse { Storage = storage, Shelf = shelf });
                }
                else
                {
                    _entityRepo.QuerableGetAll().Where(x => itemWarehouseViewModel.Id == x.Id)
                        .UpdateFromQuery(x => new ItemWarehouse { Storage = "", Shelf = "" });
                }
                _unitOfWork.Commit();
                EndTransaction();
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }

        }
        public ShelfStorageManagementViewModel GetItemWarehouseData(ShelfStorageManagementViewModel itemWarehouseViewModel)
        {
            var itemWarehouse = GetModel(x => x.IdItem == itemWarehouseViewModel.IdItem && x.IdWarehouse
             == itemWarehouseViewModel.IdWarehouse);
            if (itemWarehouse != null)
            {
                itemWarehouseViewModel.Id = itemWarehouse.Id;
                itemWarehouseViewModel.Shelf = itemWarehouse.Shelf;
                itemWarehouseViewModel.Storage = itemWarehouse.Storage;
                itemWarehouseViewModel.OrderedQuantity = itemWarehouse.OrderedQuantity;
                itemWarehouseViewModel.AvailableQuantity = itemWarehouse.AvailableQuantity - itemWarehouse.ReservedQuantity;
            }
            return itemWarehouseViewModel;
        }

        public void UpdateOrderedQuantityOfItemWarehouse(double movementQty, ItemWarehouse itemwarehouse,
            DocumentType documentType, bool hasDocumentAssociated = false)
        {
            if (documentType.Code == DocumentEnumerator.PurchaseFinalOrder)
            {
                itemwarehouse.OrderedQuantity += movementQty;
            }
            if (documentType.Code == DocumentEnumerator.PurchaseDelivery && hasDocumentAssociated)
            {
                itemwarehouse.OrderedQuantity -= movementQty;
            }
        }

        public void GetAllRealQuantityFolAllItem(List<Item> itemList, double? idWarehouse = null)
        {
            var itemIds = itemList.Select(x => x.Id).ToList();
            List<ItemWarehouseViewModel> allItemWarehouse = GetModelsWithConditionsRelations(x => itemIds.Contains(x.IdItem), x => x.IdWarehouseNavigation).ToList();
            foreach (var item in itemList)
            {
                var allWarehouse = allItemWarehouse.Where(x => x.IdItem == item.Id);
                if (idWarehouse != null)
                {
                    item.AllAvailableQuantity = allWarehouse.Where(x => x.IdWarehouse == idWarehouse).Sum(x => x.AvailableQuantity);
                }
                else
                {
                    item.AllAvailableQuantity = allWarehouse.Sum(x => x.AvailableQuantity);
                }
                if (item.AllAvailableQuantity < 0)
                {
                    item.AllAvailableQuantity = 0;
                    LogEroor(item.Id);
                }

            }
        }
    }
}
