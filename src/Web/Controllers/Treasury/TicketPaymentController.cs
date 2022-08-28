using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Treasury
{
    [Route("api/ticketPayment")]
    public class TicketPaymentController : BaseController
    {
        public TicketPaymentController(IServiceProvider serviceProvider, ILogger<TicketPaymentController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
        }

        [HttpPost("insert"), Authorize("TICKET_PAYMENT")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);

        }

        [HttpPut("update"), Authorize("TICKET_PAYMENT")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);

        }

        [HttpDelete("delete/{id}"), Authorize("TICKET_PAYMENT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
