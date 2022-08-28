using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Treasury.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;

namespace Web.Controllers.Treasury
{
    [Route("api/ticket")]
    public class TicketController : BaseController
    {
        private readonly IServiceTicket _serviceTicket;

        public TicketController(IServiceProvider serviceProvider, ILogger<TicketController> logger,
            IServiceTicket serviceTicket) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTicket = serviceTicket;
        }

        [HttpGet("generateTicket/{id}/{idSession}")]
        public ResponseData ValidateBLAndGenerateTicket(int id, int idSession)
        {
            ResponseData result = new ResponseData();
            if (id > 0)
            {
                GetUserMail();
                result.objectData = _serviceTicket.ValidateBLAndGenerateTicket(id, idSession, userMail);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
            }
            return result;
        }
        
        [HttpGet("generateTicketAfterBlImport/{id}/{idSession}")]
        public ResponseData GenerateTicket(int id, int idSession)
        {
            ResponseData result = new ResponseData();
            if (id > 0)
            {
                GetUserMail();
                result.objectData = _serviceTicket.ValidateBLAndGenerateTicket(id, idSession, userMail, false);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
            }
            return result;
        }

        [HttpPost("getTicketsForSettlement"), Authorize("LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public  ResponseData GetTicketsForSettlement([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();

            FilterSearchTicketViewModel model = JsonConvert.DeserializeObject<FilterSearchTicketViewModel>(objectToSave.model.ToString());
            var dataSourceResult = _serviceTicket.GetTicketsForSettlement(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total,
                    sum = dataSourceResult.sum
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            
            return result;
        }


        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_PAYMENT_TICKET")]
        public override async Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return await base.DownloadJasperDocumentReport(data);
        }
 

    }
}
