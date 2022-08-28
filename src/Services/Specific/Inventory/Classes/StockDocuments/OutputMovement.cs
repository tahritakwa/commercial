using System;
using System.Collections.Generic;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes.StockDocuments
{
    public partial class ServiceStockDocument
    {
        public void CreateOutputMovementDocument(List<StockDocumentLineViewModel> stockDocumentLineViewModels, DateTime DocumentDate, int idWarehouse, string statusOfLine=null)
        {
            foreach (StockDocumentLineViewModel stockDocumentLineViewModel in stockDocumentLineViewModels)
            {
                // Add a previsional Output stock movement 
                StockMovementViewModel previsionalOutputStockMovement = new StockMovementViewModel()
                {
                    IdStockDocumentLine = stockDocumentLineViewModel.Id,
                    MovementQty = stockDocumentLineViewModel.ActualQuantity ?? 0,
                    IdItem = stockDocumentLineViewModel.IdItem,
                    IdWarehouse = idWarehouse,
                    Status = statusOfLine!=null ? statusOfLine: DocumentEnumerator.Provisional,
                    Operation = OperationEnumerator.Output,
                    CreationDate = DocumentDate
                };
                _serviceStockMovement.AddModelWithoutTransaction(previsionalOutputStockMovement, null, null);
            }
        }
    }
}
