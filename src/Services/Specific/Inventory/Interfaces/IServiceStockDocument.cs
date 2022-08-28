using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales.Document;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceStockDocument : IService<StockDocumentViewModel, StockDocument>
    {
        object ValidateDocument(int id, string userMail);
        object ValidateInventoryDocument(int id, string userMail);
        StockDocumentViewModel AddInventoryDocument(StockDocumentViewModel stockDocumentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        void AddPlannedInventoryDocumentLines(string connectionString);
        StockDocumentViewModel SavePlannedInventoryDocument(StockDocumentViewModel stockDocumentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        StockDocumentLineViewModel AddInventoryDocumentLine(StockDocumentLineViewModel model, PredicateFormatViewModel predicate, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        StockDocumentLineViewModel UpdateInventoryDocumentLine(StockDocumentLineViewModel model, PredicateFormatViewModel predicate, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        double GetItemQtyInWarehouse(int idItem, int idWarehouse, int idStockDocumentLine);
        object TransfertValidateStockDocument(int id);
        object ReceiveValidateStockDocument(int id);
        StockDocumentViewModel AddModelInRealTime(StockDocumentViewModel stockDocumentViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        object AddLineInRealTime(StockDocumentLineViewModel stockDocumentLineViewModel);
        object DeleteLineInRealTime(int id);
        List<StockDocumentLineViewModel> GetStockDocumentWithStockDocumentLine(DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel, out int total);
        DataSourceResult<StockDocumentViewModel> GetInventoryMovementList(PredicateWithDateFilterInformationViewModel model);
        DataSourceResult<StockDocumentViewModel> GetStockDocumentList(PredicateFormatViewModel predicateModel);
        object ValidateStockDocumentById(int stockDocumentId, string userMail);
        InventoryDocumentReportViewModel GetInventoryDocumentInformations(InventoryDocumentReportQueryViewModel DailySalesQuery);
        object UnvalidateInventoryDocument(int id, string userMail);
        
        void ChangeStatusOfStockMovement(StockDocumentViewModel stockDocumentViewModel, string operation);
        void VerifyAndUpdateReservedStockMovementFromTransferMovement(StockDocumentViewModel stockDocumentViewModel);
        object ValidatestorageMovementDocument(int id, string userMail);
    }
}
