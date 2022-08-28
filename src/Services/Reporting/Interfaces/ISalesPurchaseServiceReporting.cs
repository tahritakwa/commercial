using System.Collections.Generic;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;

namespace Services.Reporting.Interfaces
{
    public interface ISalesPurchaseServiceReporting
    {
        IEnumerable<DocumentLineViewModel> ListReportDocumentLines(int idDocument);
        DocumentReportInformationsViewModel GetDocumentReportInformations(int idDocument);
        ReportInformationsForDocumentViewModel GetReportInformationsOfDocument(int idDocument, int printType, bool isBtoB);
        IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLine(int idDocument);
        IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineInvoice(int idDocument, int isfrombl);
        ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentCost(int idDocument, int printType, bool isBtoB);
        ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentExpense(int idDocument, int printType, bool isBtoB);
        IList<DocumentLineCostReportingViewModel> GetReportInformationOfDocumentLineCost(int idDocument, int isfrombl);
        IList<DocumentLineExpenseReportingViewModel> GetReportInformationOfDocumentLineExpense(int idDocument, int isfrombl);
        ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentWithoutDiscount(int idDocument, int printType, bool isBtoB);
        IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineWithoutDiscount(int idDocument);
        IList<PurchaseDeliveryTagViewModel> GetTagListOfPurchaseDelivery(string DataToPrint);
    }
}
