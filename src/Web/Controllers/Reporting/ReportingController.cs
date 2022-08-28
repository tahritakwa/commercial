using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Reporting.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    /// <summary>
    /// Telerik report API
    /// </summary>
    [Route("api/reporting")]
    [AllowAnonymous]
    public class ReportingController : BaseController
    {
        #region Fields
        private readonly IServiceReporting _serviceReporting;
        private readonly IDailySalesServiceReporting _serviceDailySalesReporting;
        #endregion
        #region Constructor
        public ReportingController(IServiceProvider serviceProvider, ILogger<ReportingController> logger,
            IServiceReporting serviceReporting, IDailySalesServiceReporting serviceDailySalesReporting)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceReporting = serviceReporting;
            _serviceDailySalesReporting = serviceDailySalesReporting;
        }
        #endregion
        #region Methodes
        /// <summary>
        /// Get document Lines.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns>Document lines or an error code message</returns>
        [HttpGet("getreportdocumentlines/{idDocument}")]
        public IEnumerable<DocumentLineViewModel> GetReportDocumentLines(int idDocument)
        {
            return _serviceReporting.ListReportDocumentLines(idDocument);
        }
        /// <summary>
        /// Get informations for document.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [HttpGet("getreportdocumentinformations/{idDocument}")]
        public DocumentReportInformationsViewModel GetReportDocumentInformations(int idDocument)
        {
            return _serviceReporting.GetDocumentReportInformations(idDocument);
        }

        /// <summary>
        /// Get Cnss declaration Summary
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        [HttpGet("getStockDocumentLines/{idStockDocument}")]
        public IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentInformationLines(int idStockDocument)
        {
            return _serviceReporting.GetStockDocumentInformationLines(idStockDocument);
        }
        /// <summary>
        /// Get gain StockDocumentLines
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        [HttpGet("getStockDocumentLinesEcart/{idStockDocument}")]
        public IList<StockDocumentLineInventoryReportViewModel> GetStockDocumentLinesEcart(int idStockDocument)
        {
            return _serviceReporting.GetStockDocumentLinesEcart(idStockDocument);
        }

        /// <summary>
        /// Get Cnss declaration Summary
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        [HttpGet("getStockDocumentInfo/{idStockDocument}")]
        public StockDocumentInventoryReportViewModel GetStockDocumentInformation(int idStockDocument)
        {
            return _serviceReporting.GetStockDocumentInformation(idStockDocument);
        }

        /// <summary>
        /// Get Daily Sales Information Line
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getDailySalesLines/{idwarehouse}/{startdate}/{enddate}")]
        public IList<DailySalesLineViewModel> GetDailySalesLines(int idwarehouse, string startdate, string enddate)
        {
            var sdate = _serviceReporting.GenerateDate(startdate);
            var edate = _serviceReporting.GenerateDate(enddate);
            var resultData = _serviceDailySalesReporting.GetDailySalesLines(idwarehouse, sdate, edate);
            return resultData;
        }


        /// <summary>
        /// Get Daily Sales Information
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getDailySalesInfo/{idwarehouse}/{startdate}/{enddate}")]
        public DailySalesReportViewModel GetDailySalesInfo(int idwarehouse, string startdate, string enddate)
        {
            var sdate = _serviceReporting.GenerateDate(startdate);
            var edate = _serviceReporting.GenerateDate(enddate);
            var resultData = _serviceReporting.GetDailySalesInformation(idwarehouse, sdate, edate);
            return resultData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getDailySalesDeliveryLines/{idtiers}/{idstatus}/{startdate}/{enddate}")]
        public IList<DailySalesDeliveryLineReportViewModel> GetDailySalesDeliveryLines(int idtiers, int idstatus, string startdate, string enddate)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, 0, string.Empty);
            return _serviceReporting.GetDailySalesDeliveryLines(queryViewModel);
        }

        /// <summary>
        /// Get Daily Sales delivery Information line with few informations
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getDailySalesDeliveryList/{idtiers}/{idstatus}/{startdate}/{enddate}")]
        public IList<DailySalesDeliveryListReportViewModel> GetDailySalesDeliveryList(int idtiers, int idstatus, string startdate, string enddate)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, 0, string.Empty);
            return _serviceReporting.GetDailySalesDeliveryList(queryViewModel);
        }
                     
        /// <summary>
        /// Get Daily Sales delivery Information
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getDailySalesDeliveryInfo/{idtiers}/{idstatus}/{startdate}/{enddate}")]
        public DailySalesDeliveryReportViewModel GetDailySalesDeliveryInfo(int idtiers, int idstatus, string startdate, string enddate)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, 0, string.Empty);
            return _serviceReporting.GetDailySalesDeliveryInformation(queryViewModel);
        }

        /// <summary>
        /// Get Daily Sales delivery Information
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getDocumentControlStatusInfo/{idtiers}/{idstatus}/{startdate}/{enddate}/{groupbytiers}/{idtype}")]
        public DocumentControlStatusReportViewModel GetDocumentControlStatusInfo(int idtiers, int idstatus, string startdate, string enddate, int groupbytiers, string idtype)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, groupbytiers, idtype);
            var resultData = _serviceReporting.GetDocumentControlStatusInformation(queryViewModel);
            return resultData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>GroupByTiers
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getDocumentControlStatusLines/{idtiers}/{idstatus}/{startdate}/{enddate}/{groupbytiers}/{idtype}")]
        public IList<DocumentControlStatusLineReportViewModel> GetDocumentControlStatusLines(int idtiers, int idstatus, string startdate, string enddate, int groupbytiers, string idtype)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, groupbytiers, idtype);
            return _serviceReporting.GetDocumentControlStatusLines(queryViewModel);
        }

        /// <summary>
        /// Get Daily Sales delivery Information
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getInvoiceDocumentControlStatusInfo/{idtiers}/{idstatus}/{startdate}/{enddate}/{groupbytiers}/{idtype}")]
        public DocumentControlStatusReportViewModel GetInvoiceDocumentControlStatusInfo(int idtiers, int idstatus, string startdate, string enddate, int groupbytiers, string idtype)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, groupbytiers, idtype);
            return _serviceReporting.GetInvoiceDocumentControlStatusInformation(queryViewModel);
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>GroupByTiers
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getInvoiceDocumentControlStatusLines/{idtiers}/{idstatus}/{startdate}/{enddate}/{groupbytiers}/{idtype}")]
        public IList<DocumentControlStatusLineReportViewModel> GetInvoiceDocumentControlStatusLines(int idtiers, int idstatus, string startdate, string enddate, int groupbytiers, string idtype)
        {
            var queryViewModel = _serviceReporting.GenerateQueryViewModel(idtiers, idstatus, startdate, enddate, groupbytiers, idtype);
            return _serviceReporting.GetInvoiceDocumentControlStatusLines(queryViewModel);
        }

        /// <summary>
        /// Get Daily Sales delivery Information
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getInventoryDocumentInformations/{idinventory}/{idwarehouse}/{startdate}/{enddate}")]
        public InventoryDocumentReportViewModel GetInventoryDocumentInformations(int idinventory, int idwarehouse, string startdate, string enddate)
        {
            var queryViewModel = _serviceReporting.GetInventoryDocumentInformationsQueryVM(idinventory, idwarehouse, startdate, enddate);
            return _serviceReporting.GetInventoryDocumentInformations(queryViewModel);
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>GroupByTiers
        /// <param name="idinventory"></param>
        /// <param name="idwarehouse"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getInventoryDocumentLines/{idinventory}/{idwarehouse}/{startdate}/{enddate}")]
        public IList<InventoryDocumentLineReportViewModel> GetInventoryDocumentLines(int idinventory, int idwarehouse, string startdate, string enddate)
        {
            var queryViewModel = _serviceReporting.GetInventoryDocumentInformationsQueryVM(idinventory, idwarehouse, startdate, enddate);
            return _serviceReporting.GetInventoryDocumentLines(queryViewModel);
        }

        /// <summary>
        /// Get multi inventories informations
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        [HttpGet("getMultiStockDocumentsInfo/{idStockDocument}")]
        public StockDocumentInventoryReportViewModel GetMultiStockDocumentInformation(string idStockDocument)
        {            
            return _serviceReporting.GetMultiStockDocumentsInformations(idStockDocument);
        }

        /// <summary>
        /// Get gain multi inventories
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        [HttpGet("getMultiStockDocumentLinesGain/{idStockDocument}")]
        public IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLinesGain(string idStockDocument)
        {
            return _serviceReporting.GetMultiStockDocumentLinesGain(idStockDocument);
        }
        /// <summary>
        /// Get loss multi inventories
        /// </summary>
        /// <param name="idStockDocument"></param>
        /// <returns></returns>
        [HttpGet("getMultiStockDocumentLinesLoss/{idStockDocument}")]
        public IList<StockDocumentLineInventoryReportViewModel> GetMultiStockDocumentLinesLoss(string idStockDocument)
        {
            return _serviceReporting.GetMultiStockDocumentLinesLoss(idStockDocument);
        }

        /// <summary>
        /// Get Stock Valuation Informations
        /// </summary>
        /// <param name="idwarehouse"></param>
        /// <returns></returns>
        [HttpGet("getStockValuationInformations/{idwarehouse}")]
        public StockValuationReportInformationsViewModel GetStockValuationInformations(int idwarehouse)
        {            
            return _serviceReporting.GetStockValuationInformations(idwarehouse);
        }

        /// <summary>
        /// Get Stock Valuation Lines
        /// </summary>
        /// <param name="idwarehouse"></param>
        /// <returns></returns>
        [HttpGet("getStockValuationLines/{idwarehouse}"), Authorize("LIST_STOCK_VALUATION")]
        public IList<StockValuationReportLinesViewModel> GetStockValuationLines(int idwarehouse)
        {            
            return _serviceReporting.GetStockValuationLines(idwarehouse);
        }

        /// <summary>
        /// Get Tiers Extract Informations
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="startdate"></param>
        /// <returns></returns>
        [HttpGet("getTiersExtractInformations/{idtiers}/{startdate}")]
        public TiersExtractReportInformationsViewModel GetTiersExtractInformations(int idtiers, string startdate)
        {            
            return _serviceReporting.GetTiersExtractInformations(idtiers, startdate);
        }

        /// <summary>
        /// Get Tiers Extract Lines
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="startdate"></param>        
        /// <returns></returns>
        [HttpGet("getTiersExtractLines/{idtiers}/{startdate}"),Authorize("LIST_TIERS_EXTRACT")]
        public IList<TiersExtractReportLinesViewModel> GetTiersExtractLines(int idtiers, string startdate)
        {            
            return _serviceReporting.GetTiersExtractLines(idtiers, startdate);
        }

        /// <summary>
        /// Get VAT Declaration Informations
        /// </summary>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getVatDeclarationInformations/{startdate}/{enddate}/{idCurrency}")]
        public VatDeclarationInformationsViewModel GetVatDeclarationInformations(string startdate, string enddate, int idCurrency)
        {
            return _serviceReporting.GetVatDeclarationInformations(startdate, enddate, idCurrency);
        }


        /// <summary>
        /// Get VAT Declaration Lines
        /// </summary>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>   
        /// <param name="isPurchaseType"></param>
        /// <param name="idTier"></param>   
        /// <returns></returns>

        [HttpGet("getVatDeclarationLines/{startdate}/{enddate}/{isPurchaseType}/{idTier}"), Authorize("LIST_VAT_DECLARATION")]
        public IList<VatDeclarationLinesViewModel> GetVatDeclarationLines(string startdate, string enddate, bool isPurchaseType, int idTier)
        {
            return _serviceReporting.GetVatDeclarationLines(startdate, enddate, isPurchaseType, idTier);
        }

        /// <summary>
        /// get stock movement information for report
        /// </summary>
        /// <param name="idStockMovement"></param>
        /// <returns></returns>
        [HttpGet("getStockMovementInfo/{idStockMovement}")]
        public StockMovementInformationViewModel GetStockMovementInformation(int idStockMovement)
        {
            return _serviceReporting.GetStockMovementInformation(idStockMovement);
        }

        /// <summary>
        /// get stock movement lines for report
        /// </summary>
        /// <param name="idStockMovement"></param>
        /// <returns></returns>
        [HttpGet("getStockMovementLines/{idStockMovement}")]
        public IList<ReportStockMovementViewModel> GetStockMovementLines(int idStockMovement)
        {
            return _serviceReporting.GetStockMovementLines(idStockMovement);
        }

        [HttpGet("GetVatDeclarationReport/{startdate}/{enddate}/{isPurchaseType}/{idTier}/{idCurrency}"), Authorize("LIST_VAT_DECLARATION")]
        public IList<VatDeclarationReportViewModel> GetVatDeclarationReport(string startdate, string enddate, bool isPurchaseType, int idTier, int idCurrency)
        {
            return _serviceReporting.GetVatDeclarationReport(startdate, enddate, isPurchaseType, idTier, idCurrency);
        }
        /// <summary>
        /// ge note on turnover informations
        /// </summary>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getNoteOnTurnoverInformations/{startdate}/{enddate}")]
        public NoteOnTurnoverReportViewModel GetNoteOnTurnoverInformations(string startdate, string enddate)
        {
            return _serviceReporting.GetNoteOnTurnoverInformations(startdate, enddate);
        }
        /// <summary>
        /// get note on turnover lines
        /// </summary>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpGet("getNoteOnTurnoverLines/{startdate}/{enddate}/{idItem}")]
        public List<NoteOnTurnoverLineReportViewModel> GetNoteOnTurnoverLines(string startdate, string enddate, int idItem)
        {
            return _serviceReporting.GetNoteOnTurnoverLines(startdate, enddate, idItem);
        }
        #endregion
    }
}
