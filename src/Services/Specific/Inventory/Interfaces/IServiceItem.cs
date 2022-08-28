using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.IO;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.B2B;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Inventory.TecDoc;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.Shared;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceItem : IService<ItemViewModel, Item>
    {
        DataSourceResult<ItemViewModel> GetItemsDataSourceModel(PredicateFormatViewModel predicateModel);
        DataSourceResult<ItemViewModel> GetItemsInventoryList(PredicateFormatViewModel model);
        ItemViewModel GetItemsInventoryList(ItemViewModel model);
        IList<ItemViewModel> GetItemEquivalence(ItemToGetEquivalentList model);
        List<int> CheckWarehouseUnicity(IList<ItemWarehouseViewModel> itemWarehouse);
        DataSourceResult<ItemViewModel> GetItemsListByWarehouse(PredicateFormatViewModel predicateModel);
        DataSourceResult<ItemViewModel> GetAllItemsListByWarehouse(PredicateFormatViewModel predicateModel);
        ItemViewModel GetItemWarhouseBySelectedWarehouse(ItemViewModel item, int idWarehouse);
        List<AvailableQuantity> GetAvailbleQuantity(List<int> listItems);
        List<AmountPerItemDetails> GetAmountPerItem(List<ItemQuantity> listItems);
        List<TecDocArticleViewModel> ExistsInDataBase(List<TecDocArticleViewModel> Articles, TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        DataSourceResult<ItemListViewModel> FilterItemsByWarehouse(ItemFilterPeerWarehouseViewModel predicateModel);
        List<ItemViewModel> GetItemDetails(IEnumerable<int> itemsList);
        DataSourceResult<ItemViewModel> GetItemsAfterFilter(List<int> listId);
        DataSourceResult<ItemForDataGrid> GetItemDropDownListForDataGrid(FiltersItemDropdown model);
        int FindIndiceFromDataSourceForGrid(FiltersItemDropdown model, ValueMapperViewModel valueMapperModel);
        List<ReducedListItemViewModel> GetReplacementItems(int id, int? idWarehouse = null);
        List<ReducedListItemViewModel> GetReplacementItems(ItemToGetEquivalentList model);
        void RemoveEquivalentItem(int id);
        void RemoveReplacementItem(int id);
        void RemoveKitItem(int idSelectedKit, int id);
        List<ReducedListItemViewModel> GetReducedItemEquivalence(ItemViewModel model);
        DataSourceResult<OnOrderQuantityDetailsViewModel> GetOnOrderQuantityDetails(int idItem);
        void UpdateItemClaims(int idModelToCheck);
        void UpdateItemClaims(Item modelToCheck);
        void CheckItemClaims(List<Item> entities);
        List<ItemExportPdfViewModel> ExportPdf(ItemFilterPeerWarehouseViewModel model);
        DataSourceResult<ItemExportPdfViewModel> WarehouseFilterForB2B(ItemFilterPeerWarehouseViewModel filterByWarehouseDetails);
        List<TecDocArticleViewModel> ExistsInDataBaseForB2B(List<TecDocArticleViewModel> Articles, TeckDockWithWarehouseFilterViewModel teckDockWithFilter);
        List<ReducedListItemViewModel> GetItemKit(ItemToGetEquivalentList model);
        List<ItemExportPdfViewModel> GetKitForB2b(int id);
        IList<ItemViewModel> GenerateItemListFromExcel(Stream excelDataStream, List<string> excelColumnsName);
        List<ItemViewModel> GetItemsInventoryDetails(IList<int> itemIdList);
        void UpdateItemEquivalentDesignation(ReducedEquivalentItem itemToUpdate);
        List<IdItemAndReliquatQtyViewModel> GetRemainingQty(List<int> listItemId);
        List<BalanceDocumentLine> GetBalancedList(int idTiers, List<int> idItems = null,
            string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false);
        void RestorItemListforDropDown();


        ItemViewModel AffectEquivalentItem(EquivalentItemsViewModel equivalentItems, string userMail);
        DataSourceResultWithSelections<ItemViewModel> GetItemsFillingIsAffected(PredicateFormatViewModel predicateModel, int idPrice);
        List<ItemTiersViewModel> GetItemTiers(int itemId);
        DataSourceResult<ItemViewModel> GetItemListForGarage(List<int> idItems, int? idWarehouse);        
        object AddOperationAsItem(ItemViewModel item, string userMail);
        object UpdateOperationAsItem(ItemViewModel item, string userMail);
        List<ItemViewModel> BulkUpdateOperationAsItem(List<ItemViewModel> itemViewModels, string userMail);
        DataSourceResult<ReducedListItemViewModel> GetListDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel);
        ItemSheetViewModel GetItemSheetData(int id);
        List<int> getNumberOfItemEquiKit(ItemToGetEquivalentList model);
        List<ItemWarehouseListItemViewModel> GetItemWarhouseOfSelectedItem(int idItem);
        ReducedListItemViewModel GetReducedItemData(int id);
        SynchronizeBToBItemViewModel SynchronizeBToBItems(DateTime searchDate, string connectionString);
        DataSourceResult<ReducedListItemViewModel> GetItemDataWithSpecificFilter(FilterSearchItemViewModel filterSearchItem);
        ItemViewModel GenerateItemFromEmployee(EmployeeViewModel employee, string labelInInvoice);
        IList<SynchronizeBtobPicturesViewModel> GetFilesContentsForBtoB(List<int> listOfIds);
        List<int> getByCodeAndDesignation(String pattern);
        List<ItemDetailsViewModel> GetItemDetailsProd(List<int> listItems);
        void AffectEquivalentItemWithoutResponse(EquivalentItemsViewModel equivalentItems, string userMail);
    }
}
