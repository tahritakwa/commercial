using System;
using System.Collections.Generic;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;

namespace Services.Reporting.Interfaces
{
    public interface IServiceReporting
    {
        IEnumerable<DocumentLineViewModel> ListReportDocumentLines(int idDocument);
        DocumentReportInformationsViewModel GetDocumentReportInformations(int idDocument);
        IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentInformationLines(int idStockDocument);
        IList<DailySalesDeliveryLineReportViewModel> GetDailySalesDeliveryLines(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        IList<DocumentControlStatusLineReportViewModel> GetDocumentControlStatusLines(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        IList<DocumentControlStatusLineReportViewModel> GetInvoiceDocumentControlStatusLines(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        
        DailySalesDeliveryReportQueryViewModel GenerateQueryViewModel(int idtiers, int idstatus, string startdate, string enddate, int groupbytiers, string idtype);
        
        
        StockDocumentInventoryReportViewModel GetStockDocumentInformation(int idStockDocument);
        StockDocumentInventoryReportViewModel GetMultiStockDocumentsInformations(string idStockDocument);
        DailySalesReportViewModel GetDailySalesInformation(int idwarehouse, DateTime? startdate, DateTime? endate);
        DailySalesDeliveryReportViewModel GetDailySalesDeliveryInformation(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        DocumentControlStatusReportViewModel GetDocumentControlStatusInformation(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        DocumentControlStatusReportViewModel GetInvoiceDocumentControlStatusInformation(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        InventoryDocumentReportViewModel GetInventoryDocumentInformations(InventoryDocumentReportQueryViewModel DailySalesQuery);
        IList<InventoryDocumentLineReportViewModel> GetInventoryDocumentLines(InventoryDocumentReportQueryViewModel DailySalesQuery);
        InventoryDocumentReportQueryViewModel GetInventoryDocumentInformationsQueryVM(int idinventory, int idwarehouse, string startdate, string enddate);

        IList<DailySalesDeliveryListReportViewModel> GetDailySalesDeliveryList(DailySalesDeliveryReportQueryViewModel DailySalesQuery);
        IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentLinesEcart(int idStockDocument);
        IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLinesGain(string idStockDocument);
        IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLinesLoss(string idStockDocument);
        StockValuationReportInformationsViewModel GetStockValuationInformations(int idwarehouse);        
        IList<StockValuationReportLinesViewModel> GetStockValuationLines(int idwarehouse);
        TiersExtractReportInformationsViewModel GetTiersExtractInformations(int idtiers, string startdate);
        IList<TiersExtractReportLinesViewModel> GetTiersExtractLines(int idtiers, string startdate);
        VatDeclarationInformationsViewModel GetVatDeclarationInformations(string startdate, string enddate, int idCurrency);
        IList<VatDeclarationReportViewModel> GetVatDeclarationReport(string startdate, string enddate, bool isPurchaseType, int idTier, int idCurrency);
        DateTime? GenerateDate(string startdate);
        StockMovementInformationViewModel GetStockMovementInformation(int idIStockMovemment);
        IList<ReportStockMovementViewModel> GetStockMovementLines(int idStockDocument);
        IList<VatDeclarationLinesViewModel> GetVatDeclarationLines(string startdate, string enddate, bool isPurchaseType, int idTier);
        NoteOnTurnoverReportViewModel GetNoteOnTurnoverInformations(string StartDate, string EndDate);
        List<NoteOnTurnoverLineReportViewModel> GetNoteOnTurnoverLines(string StartDate, string EndDate, int IdItem);
    }
}
