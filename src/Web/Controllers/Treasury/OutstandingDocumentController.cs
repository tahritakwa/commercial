using Infrastruture.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Services.Specific.Payment.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Treasury;
using Web.Controllers.GenericController;

namespace Web.Controllers.Treasury
{
    [Route("api/outstandingDocument")]
    public class OutstandingDocumentController : BaseController
    {
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceSettlement _serviceSettlement;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceTiers _serviceTiers;
        public OutstandingDocumentController(IServiceProvider serviceProvider,
            ILogger<OutstandingDocumentController> logger,
            IServiceDocument serviceDocument, IServiceSettlement serviceSettlement,
            IOptions<SmtpSettings> smtpSettings, IServiceTiers serviceTiers)
           : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceDocument = serviceDocument;
            _serviceSettlement = serviceSettlement;
            _smtpSettings = smtpSettings.Value;
            _serviceTiers = serviceTiers;
        }

        /// <summary>
        /// GetCustomerOutstandingList
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getDeliverFormCustomerOutstandingList"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT")]
        public ResponseData GetCustomerOutstandingList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)

            {
                throw new ArgumentNullException(nameof(model));
            }
            ResponseData result = new ResponseData();
            var outstandingDocumentResultViewModel = _serviceDocument.GetCustomerDeliverFormOutstandingList(model);
            result.objectData = outstandingDocumentResultViewModel;
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getDeliverFormOutstandingDocumentForExport"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT")]
        public ResponseData GetDeliverFormOutstandingDocumentForExport([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            DataSourceResult<OutstandingDeliveryFormForExportViewModel> dataSourceResult = _serviceDocument.GetCustomerDeliverFormOutstandingForExport(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getFinancialCommitmentForOutstandingList"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public ResponseData GetFinancialCommitmentForOutstandingList([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            int tiersType = objectToSave.model.tiersType != null ? (int)objectToSave.model.tiersType : 1;
            bool hasRole;
            if (tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("LIST_CUSTOMER_OUTSTANDING_DOCUMENT");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("LIST_SUPPLIER_OUTSTANDING_DOCUMENT");
            }
            if (hasRole)
            {
                int documentType = objectToSave.model.documentType != null ? (int)objectToSave.model.documentType : (int)OutstandingDocumentTypeEnumerator.InvoiceFinancialCommitment;
                ResponseData result = new ResponseData();
                result.objectData = _serviceDocument.GetFinancialCommitmentOrAssetsOutstandingDocumentList(predicateFormatViewModel, tiersType, documentType);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            else
            {
                return new ResponseData()
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }

        /// <summary>
        /// FinancialCommitmentInReceivableExpandedRows
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("financialCommitmentInReceivableExpandedRows")]
        public ResponseData FinancialCommitmentInReceivableExpandedRows([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            int tiersType = objectToSave.model.tiersType != null ? (int)objectToSave.model.tiersType : 1;
            bool hasRole;
            if (tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("ADD_CUSTOMER_SETTLEMENT");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("ADD_SUPPLIER_SETTLEMENT");
            }
            if (hasRole)
            {
                int documentType = objectToSave.model.documentType != null ? (int)objectToSave.model.documentType : (int)OutstandingDocumentTypeEnumerator.InvoiceFinancialCommitment;
                ResponseData result = new ResponseData();
                result.objectData = _serviceDocument.FinancialCommitmentInReceivableExpandedRows(predicateFormatViewModel, tiersType, documentType);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            else
            {
                return new ResponseData()
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        [HttpPost("getFinancialCommitmentForOutstandingForExport"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public ResponseData GetFinancialCommitmentOrAssetsOutstandingDocumentForExport([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            DataSourceResult<OutstandingFinancialCommitmentForExportViewModel> dataSourceResult = _serviceDocument.GetFinancialCommitmentOrAssetsOutstandingDocumentForExport(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }


        /// <summary>
        /// GetInvoicesNotTotallyPayed
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getInvoicesNotTotallyPayed"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public ResponseData GetInvoicesNotTotallyPayed([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            int tiersType = objectToSave.model.tiersType != null ? (int)objectToSave.model.tiersType : 1;
            bool hasRole;
            if (tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("LIST_CUSTOMER_OUTSTANDING_DOCUMENT");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("LIST_SUPPLIER_OUTSTANDING_DOCUMENT");
            }
            if (hasRole)
            {
                ResponseData result = new ResponseData();
                result.objectData = _serviceDocument.GetInvoicesOutstandingDocumentList(predicateFormatViewModel, tiersType);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            else
            {
                return new ResponseData()
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }

        [HttpPost("getInvoicesNotTotallyPayedForExport"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public ResponseData GetInvoicesNotTotallyPayedForExport([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            DataSourceResult<OutstandinngInvoiceForExportViewModel> dataSourceResult = _serviceDocument.GetInvoiceOutstandingDocumentForExport(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        /// <summary>
        /// GenerateSettlementFromCustomerOutstanding
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("generateSettlementFromCustomerOutstanding"), Authorize("ADD_CUSTOMER_SETTLEMENT,ADD_SUPPLIER_SETTLEMENT")]
        public async Task<ResponseData> GenerateSettlementFromCustomerOutstanding([FromBody] ObjectToSaveViewModel objectToSave)
        {
            IntermediateSettlementGeneration intermediateSettlementGeneration = JsonConvert.DeserializeObject<IntermediateSettlementGeneration>(objectToSave.model.ToString());

            if (intermediateSettlementGeneration == null)
            {
                throw new ArgumentNullException();
            }
            bool hasRole;
            int idTypeTiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == intermediateSettlementGeneration.Settlement.IdTiers).IdTypeTiers;
            if (idTypeTiers == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("ADD_CUSTOMER_SETTLEMENT");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("ADD_SUPPLIER_SETTLEMENT");
            }
            if (hasRole)
            {
                ResponseData result = new ResponseData();
                GetUserMail();
                result.objectData = await _serviceSettlement.GenerateSettlementFromCustomerOutstanding(intermediateSettlementGeneration, userMail);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            else
            {
                return new ResponseData()
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }

        /// <summary>
        /// GenerateSettlementFromCustomerOutstanding
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("generateSettlementFromTickets")]
        public async Task<ResponseData> GenerateSettlementFromTickets([FromBody] ObjectToSaveViewModel objectToSave)
        {
            IntermediateSettlementGeneration intermediateSettlementGeneration = JsonConvert.DeserializeObject<IntermediateSettlementGeneration>(objectToSave.model.ToString());

            if (intermediateSettlementGeneration == null)
            {
                throw new ArgumentNullException();
            }
            bool hasRole;
            int idTypeTiers = _serviceTiers.GetModelAsNoTracked(x => x.Id == intermediateSettlementGeneration.Settlement.IdTiers).IdTypeTiers;
            if (idTypeTiers == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("ADD_CUSTOMER_SETTLEMENT");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("ADD_SUPPLIER_SETTLEMENT");
            }
            if (hasRole)
            {
                ResponseData result = new ResponseData();
                GetUserMail();
                result.objectData = await _serviceSettlement.GenerateSettlementFromTicket(intermediateSettlementGeneration, userMail);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            else
            {
                return new ResponseData()
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }
        /// <summary>
        /// GetTiersReceivables
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getTiersReceivables")]
        public ResponseData GetTiersReceivables([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            DateTime? startDate = objectToSave.model.StartDate != null ? Convert.ToDateTime(objectToSave.model.StartDate) : null;
            DateTime? endDate = objectToSave.model.EndDate != null ? Convert.ToDateTime(objectToSave.model.EndDate) : null;
            bool hasRole = false;
            int? tiersType = objectToSave.model.TiersType != null ? objectToSave.model.TiersType : null;
            int? idTiers = objectToSave.model.IdTiers != null ? objectToSave.model.IdTiers : null;
            if (tiersType != null && tiersType == (int)TiersType.Customer)
            {
                hasRole = RoleHelper.HasPermission("LIST_CUSTOMER_RECEIVABLES_STATE");
            }
            else if (tiersType != null)
            {
                hasRole = RoleHelper.HasPermission("LIST_SUPPLIER_RECEIVABLES_STATE");
            }
            if (hasRole)
            {
                bool deliveryFormNotBilled = objectToSave.model.deliveryFormNotBilled != null ? objectToSave.model.deliveryFormNotBilled : true;
                bool unpaidFinancialCommitment = objectToSave.model.unpaidFinancialCommitment != null ? objectToSave.model.unpaidFinancialCommitment : true;
                TiersTreasuryReportResultViewModel tiersTreasuryReportResultViewModel = _serviceDocument.GetReceivablesReports(idTiers, startDate, endDate,
                    (int)objectToSave.model.Page, (int)objectToSave.model.PageSize, (int)objectToSave.model.TiersType, deliveryFormNotBilled, unpaidFinancialCommitment);
                result.objectData = tiersTreasuryReportResultViewModel;
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            else
            {
                return new ResponseData()
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
        }

        /// <summary>
        /// GetTiersReceivablesForExport
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getTiersReceivablesForExport"), Authorize("LIST_CUSTOMER_RECEIVABLES_STATE,LIST_SUPPLIER_RECEIVABLES_STATE")]
        public ResponseData GetTiersReceivablesForExport([FromBody] PredicateFormatViewModel predicateModel)
        {
            ResponseData result = new ResponseData();
            DataSourceResult<TiersTreasuryReportForExportViewModel> dataSourceResult =
                                            _serviceDocument.GetReceivablesReportsForExport(predicateModel);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("sendInvoiceRevivalMail"), Authorize("SEND_REMINDER_MAIL")]
        public ResponseData SendInvoiceRevivalMail([FromBody] List<FinancialCommitmentViewModel> invoiceFinancialCommitments)
        {
            GetUserMail();
            if (invoiceFinancialCommitments == null)
            {
                throw new ArgumentException("");
            }
            _serviceDocument.SendInvoiceRevivalMail(invoiceFinancialCommitments, userMail, _smtpSettings);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("downloadJasperDocumentReport"), Authorize("ADD_SUPPLIER_SETTLEMENT,ADD_CUSTOMER_SETTLEMENT")]
        public override async Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {

            return await base.DownloadJasperDocumentReport(data);
        }
    }
}
