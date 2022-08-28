using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.DTO.Inventory;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/stockDocumentLine")]
    public class StockDocumentLineController : BaseController, IStockDocumentLineController
    {
        private readonly IServiceStockDocumentLine _serviceStockDocumentLine;
        public StockDocumentLineController(IServiceStockDocumentLine serviceStockDocumentLine, IServiceProvider serviceProvider, ILogger<StockDocumentLineController> logger) : base(serviceProvider, logger)
        {
            _serviceStockDocumentLine = serviceStockDocumentLine;
        }

        [HttpPost("getStockDocumentLinesByItemId")]
        public List<StockDocumentLineViewModel> GetStockDocumentLinesByItemId([FromBody] ItemViewModel model)
        {
            return _serviceStockDocumentLine.GetModelsWithConditionsRelations(x => x.IdItem == model.Id, x => x.IdStockDocumentNavigation).ToList();
        }
    }
}
