using System;
using System.Collections.Generic;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes.StockDocuments
{
    public partial class ServiceStockDocument
    {

        public void CreateInputMovementDocument(List<StockDocumentLineViewModel> stockDocumentLineViewModels, DateTime DocumentDate, int idWarehouse, string statusOfLine = null)
        {
            foreach (StockDocumentLineViewModel stockDocumentLineViewModel in stockDocumentLineViewModels)
            {
                // Add a previsional Iutput stock movement 
                StockMovementViewModel previsionalInputStockMovement = new StockMovementViewModel()
                {
                    IdStockDocumentLine = stockDocumentLineViewModel.Id,
                    MovementQty = stockDocumentLineViewModel.ActualQuantity ?? 0,
                    IdItem = stockDocumentLineViewModel.IdItem,
                    IdWarehouse = idWarehouse,
                    Status = statusOfLine !=null ? statusOfLine : DocumentEnumerator.Provisional,
                    Operation = OperationEnumerator.Input,
                    CreationDate = DocumentDate
                };
                // Update and commit chnages
                _serviceStockMovement.AddModelWithoutTransaction(previsionalInputStockMovement, null, null);
            }
        }
    }
}
