using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace Web.Controllers.Inventory.Interfaces
{
    interface IStockDocumentLineController
    {
        List<StockDocumentLineViewModel> GetStockDocumentLinesByItemId([FromBody] ItemViewModel model);
    }
}
