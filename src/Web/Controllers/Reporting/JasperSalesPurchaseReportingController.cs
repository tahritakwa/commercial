using IdentityModel.Client;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Reporting.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    /// <summary>
    /// Telerik report API
    /// </summary>
    [Route("api/jasperSalesPurchaseReporting")]
    [AllowAnonymous]
    public class JasperSalesPurchaseReportingController : BaseController
    {
        #region Fields
        protected const string jsonHeaderType = "application/json";
        protected const string dateFormat = "yyyyMMddHHmmssfffffff";
        protected const string connectionString = "connectionString";
        protected const string downloadReportsApi = "starkreports/purchasedoc.pdf";
        protected const string downloadReportsApiAsync = "starkreports/purchasedoc";
        private const string printReportsApi = "api/customReports/printReportsApi";
        protected const string multidownloadReportsApi = "api/customReports/multiDownloadDocument";
        private const string multiprintReportsApi = "api/customReports/multiPrintDocument";
        private readonly ISalesPurchaseServiceReporting _serviceReporting;
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceJasperReporting _serviceJasperReporting;
        protected readonly AppSettings _appSettings;

        #endregion
        #region Constructor
        public JasperSalesPurchaseReportingController(IServiceProvider serviceProvider, IOptions<AppSettings> appSettings, ILogger<SalesPurchaseReportingController> logger,
            ISalesPurchaseServiceReporting serviceReporting, IServiceDocument serviceDocument, IServiceJasperReporting serviceJasperReporting) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceReporting = serviceReporting;
            _serviceDocument = serviceDocument;
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
            _serviceJasperReporting = serviceJasperReporting;
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
            return _serviceReporting.GetReportInformationsOfDocument(idDocument, -1, false);
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
            var dataresult = _serviceReporting.GetReportInformationOfDocumentLine(idDocument);
            return dataresult;
        }


        /// <summary>
        /// Get informations for documentLine.
        /// </summary>
        /// <param name="idDocument" type="unsigned int"></param>
        /// <returns></returns>
        [HttpGet("GetReportInformationOfDocumentLineInvoice/{idDocument}/{isfrombl}")]
        public IList<DocumentLineReportingViewModel> GetReportInformationOfDocumentLineInvoice(int idDocument, int isfrombl, int printType)
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

        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_ORDER_QUOTATION_PURCHASE,PRINT_FINAL_ORDER_PURCHASE,PRINT_INVOICE_PURCHASE,PRINT_ASSET_PURCHASE,PRINT_QUOTATION_SALES,PRINT_RECEIPT_PURCHASE," +
            "PRINT_EXPENSE_PURCHASE,PRINT_COST_PRICE_PURCHASE,PRINT_FINANCIAL_ASSET_SALES,PRINT_INVOICE_ASSET_SALES,PRINT_ORDER_SALES,PRINT_ASSET_SALES,PRINT_DELIVERY_SALES")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }


        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("downloadJasperDocumentReportAsync")]
        public async Task<ResponseData> DownloadDocumentJasperReportAsync([FromBody] DownloadReportDataViewModel data)
        {


            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();

            ReportSettings reportSetting = _serviceDocument.GetDocumentReportSettings(data, HttpContext, userMail, _printerSettings);

            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.JasperReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();

                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));

                client.SetBasicAuthentication("jasperadmin", "jasperadmin");
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(downloadReportsApiAsync, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };

                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        #endregion
    }
}
