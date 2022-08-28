using System;
using System.Collections.Generic;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes.StockDocuments
{
    public partial class ServiceStockDocument
    {
        public void CreateInventoryDocument(List<StockDocumentLineViewModel> stockDocumentLineViewModels, DateTime DocumentDate, int idWarehouse)
        {
            foreach (StockDocumentLineViewModel stockDocumentLineViewModel in stockDocumentLineViewModels)
            {
                StockMovementViewModel previsionalOutputStockMovement = new StockMovementViewModel()
                {
                    IdStockDocumentLine = stockDocumentLineViewModel.Id,
                    MovementQty = stockDocumentLineViewModel.ActualQuantity ?? 0,
                    IdItem = stockDocumentLineViewModel.IdItem,
                    IdWarehouse = idWarehouse,
                    Operation = OperationEnumerator.Inventory,
                    Status = DocumentEnumerator.Provisional,
                    CreationDate = DocumentDate
                };
                _serviceStockMovement.AddModelWithoutTransaction(previsionalOutputStockMovement, null, null);
            }
        }
    }
}
