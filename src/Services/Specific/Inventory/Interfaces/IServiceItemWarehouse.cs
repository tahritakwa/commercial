using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceItemWarehouse : IService<ItemWarehouseViewModel, ItemWarehouse>
    {
        ItemViewModel GetItemWarehouseInventory(ItemViewModel itemViewModel, List<int> listOfIdWarehouses = null, ProvisioningViewModel models = null, IList<DocumentLineViewModel> documentLine = null);
        double GetItemQtyInAllWarehouses(int idItem, DateTime startDate);
        bool IsAvailableQuantityOnlyInProvisionalStock(int idItem, int idWarehouse, double movementQty, int idDocumentLine);
        double GetItemQtyInWarehouse(int idItem, int idWarehouse);
        double GetItemQtyInWarehouse(int idItem, ItemWarehouse itemWarehouse);
        double GetItemQtyInWarehouseWithCountingReservationOutputs(int idItem, int idWarehouse);
        void UpdateItemWarehouseCollection(ItemViewModel model);
        void UpdateAvailebelQuantity(StockMovementViewModel stockMovement);
        void GetAllAvailbleQuantityFolAllItem(List<ItemViewModel> itemList, bool isB2b = false,
            double? idWarehouse = null);
        void GetAvailbleQuantityForItem(Item itemQty);
        void LogEroor(int idItem);
        void UpdateAvailableQuantityOfItemWarehouse(StockMovement stockMovement, ItemWarehouse itemwarehouse);
        void UpdateAvailableQuantityForSales(StockMovement stockMovement, ItemWarehouse itemWarehouse);
        List<string> getStorageDataSourceFromWarhouse(ItemWarehouseViewModel itemWarehouse);
        List<string> getShelfDataSourceFromWarhouse(int idWarehouse);
        void GetAllAvailbleQuantityFolAllItem(List<Item> itemList);
        DataSourceResult<ShelfStorageManagementViewModel> GenerateItemsFromShelfAndStorage(object dataObject);
        void ChangeItemStorage(List<ShelfStorageManagementViewModel> itemWarehouseViewModel);
        void ChangeItemStorage(ShelfStorageManagementViewModel itemWarehouseViewModel);
        ShelfStorageManagementViewModel GetItemWarehouseData(ShelfStorageManagementViewModel itemWarehouseViewModel);
        void UpdateOrderedQuantityOfItemWarehouse(double movementQty, ItemWarehouse itemwarehouse, DocumentType documentType, bool hasDocumentAssociated = false);
        void GetAllRealQuantityFolAllItem(List<Item> itemList, double? idWarehouse = null);
        List<WarehouseViewModel> GetDataWarehouseWithSpecificFilter(List<PredicateFormatViewModel> predicateModel);
        void CalculatQuantity(int idItem, ICollection<ItemWarehouseViewModel> itemWarehouses, List<DocumentLine> listPurchaseDeliveryProvByItem);
        void MangeStateCentral(ItemWarehouseViewModel itemWarehoouse);
    }
}
