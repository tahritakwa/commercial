using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceStockDocumentLine : IService<StockDocumentLineViewModel, StockDocumentLine>
    {
        DataSourceResult<StockDocumentLineViewModel> GetStockDocumentLineList(InventoryDocumentViewModel inventoryDocument);
        DataSourceResult<StockDocumentLineViewModel> GetStockDocumentLineList(InventoryDocumentLineViewModel inventoryDocument, bool isUserInInventoryListRole);
        IList<DailySalesLineViewModel> GetStockDailyDocumentLineList(List<PredicateFormatViewModel> predicateModel, bool isUserInInventoryListRole);
        IList<DailySalesLineViewModel> GetStockDailyDocumentLineList(int? idwarehouse, DateTime startdate, DateTime endate, bool isUserInInventoryListRole);
        //IList<DailySalesDeliveryLineReportViewModel> GetSalesDeliveryDailyDocumentLineList(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        DataSourceResult<StockDocumentLineViewModel>  GetStockInventoryDocumentLine(InventoryDocumentViewModel model, bool isUserInInventoryListRole);
        DataSourceResult<StockDocumentLineViewModel> GetStockDocumentLineByIdItem(PredicateFormatViewModel predicateModel);

    }
}
