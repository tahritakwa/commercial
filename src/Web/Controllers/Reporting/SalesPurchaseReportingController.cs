using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Reporting.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    /// <summary>
    /// Telerik report API
    /// </summary>
    [Route("api/salesPurchaseReporting")]
    [AllowAnonymous]
    public class SalesPurchaseReportingController : BaseController
    {
        #region Fields
        private readonly ISalesPurchaseServiceReporting _serviceReporting;

        #endregion
        #region Constructor
        public SalesPurchaseReportingController(IServiceProvider serviceProvider, ILogger<SalesPurchaseReportingController> logger,
            ISalesPurchaseServiceReporting serviceReporting) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceReporting = serviceReporting;
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
        [AllowAnonymous]
        [HttpGet("getreportdocumentinformations/{idDocument}")]
        public DocumentReportInformationsViewModel GetReportDocumentInformations(int idDocument)
        {
            return _serviceReporting.GetDocumentReportInformations(idDocument);
        }

        /// <summary>
        /// Get informations for document without discount.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationsOfDocumentWithoutDiscount/{idDocument}/{printType}")]
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentWithoutDiscount(int idDocument, int printType)
        {
            return _serviceReporting.GetReportInformationsOfDocumentWithoutDiscount(idDocument, printType, false);
        }

        /// <summary>
        /// Get informations for document.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationsOfDocument/{idDocument}/{printType}")]
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocument(int idDocument, int printType)
        {
            return _serviceReporting.GetReportInformationsOfDocument(idDocument, printType, false);
        }

        /// <summary>
        /// Get informations for document.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationsOfDocument/{idDocument}")]
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocument2(int idDocument)
        {
            return _serviceReporting.GetReportInformationsOfDocument(idDocument,-1, false);
        }

        /// <summary>
        /// Get informations for documentLine without discount.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationOfDocumentLineWithoutDiscount/{idDocument}")]
        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineWithoutDiscount(int idDocument)
        {
            return _serviceReporting.GetReportInformationOfDocumentLineWithoutDiscount(idDocument);
        }

        /// <summary>
        /// Get informations for documentLine.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationOfDocumentLine/{idDocument}")]
        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLine(int idDocument)
        {
            return _serviceReporting.GetReportInformationOfDocumentLine(idDocument);
        }

        /// <summary>
        /// Get informations for documentLine.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [HttpGet("GetReportInformationOfDocumentLineInvoice/{idDocument}/{isfrombl}")]
        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineInvoice(int idDocument,int isfrombl, int printType)
        {
            return _serviceReporting.GetReportInformationOfDocumentLineInvoice(idDocument, isfrombl);
        }

        

        /// <summary>
        /// Get informations for document.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationsOfBtotDocument/{idDocument}/{printType}")]
        public ReportInformationsForDocumentViewModel GetReportInformationsOfBtobDocument(int idDocument, int printType)
        {
            return _serviceReporting.GetReportInformationsOfDocument(idDocument, printType, true);
        }

        /// <summary>
        /// Get informations for documentLine.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationOfBtobDocumentLine/{idDocument}")]
        public IList<DocumentLineReportingViewModel> GetReportInformationOfBtoBDocumentLine(int idDocument)
        {
            return _serviceReporting.GetReportInformationOfDocumentLine(idDocument);
        }

        /// <summary>
        /// Get informations for document.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationsOfDocumentCost/{idDocument}/{printType}")]
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentCost(int idDocument, int printType)
        {
            return _serviceReporting.GetReportInformationsOfDocumentCost(idDocument, printType, false);
        }
        
        /// <summary>
        /// Get informations for document.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("getReportInformationsOfDocumentExpense/{idDocument}/{printType}")]
        public ReportInformationsForDocumentViewModel GetReportInformationsOfDocumentExpense(int idDocument, int printType)
        {
            return _serviceReporting.GetReportInformationsOfDocumentExpense(idDocument, printType, false);
        }

        /// <summary>
        /// Get informations for documentLine.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [HttpGet("GetReportInformationOfDocumentLineExpense/{idDocument}/{isfrombl}")]
        public IList<DocumentLineExpenseReportingViewModel> GetReportInformationOfDocumentLineExpense(int idDocument, int isfrombl)
        {
            return _serviceReporting.GetReportInformationOfDocumentLineExpense(idDocument, isfrombl);
        }

        /// <summary>
        /// Get informations for documentLine.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [HttpGet("getReportInformationOfDocumentLineCost/{idDocument}/{isfrombl}")]
        public IList<DocumentLineCostReportingViewModel> GetReportInformationOfDocumentLineCost(int idDocument, int isfrombl)
        {
            return _serviceReporting.GetReportInformationOfDocumentLineCost(idDocument, isfrombl);
        }

        [HttpGet("getTagListOfPurchaseDelivery/{DataToPrint}")]
        public IList<PurchaseDeliveryTagViewModel> GetTagListOfPurchaseDelivery(string DataToPrint)
        {
            return _serviceReporting.GetTagListOfPurchaseDelivery(DataToPrint);
        }

        #endregion
    }
}
