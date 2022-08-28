using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        public void CalculateAverageSalesPerDay(string coonectionString)
        {
            try
            {
                BeginTransaction(coonectionString);
                List<ItemViewModel> itemList = _serviceItem.FindModelsByNoTracked(x => x.IdNatureNavigation.IsStockManaged && !x.OnOrder).ToList();
                List<ItemViewModel> updatedItem = new List<ItemViewModel>();

                int delayDuration = 180;
                int mounthsNumber = -6;
                DateTime endDate = DateTime.Now;
                DateTime startDate = endDate.AddMonths(mounthsNumber);


                List<ReducedDocumentLine> allDocumenLine = _entityDocumentLineRepo.QuerableGetAll().Where(x =>
                        x.IdDocumentNavigation.DocumentDate >= startDate && x.IdDocumentNavigation.DocumentDate <= endDate &&
                        x.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesDelivery)
                    .Select(z => new ReducedDocumentLine { IdItem = z.IdItem, MovementQty = z.MovementQty }).ToList();

                foreach (ItemViewModel item in itemList)
                {
                    double avreage = allDocumenLine.Where(x => x.IdItem == item.Id)
                    .Sum(x => x.MovementQty) / delayDuration;
                    var avregeSales = Math.Round(avreage, 3);
                    if (!item.AverageSalesPerDay.Equals(avregeSales))
                    {
                        item.AverageSalesPerDay = avregeSales;
                        updatedItem.Add(item);
                    }
                }
                _serviceItem.BulkUpdateModelWithoutTransaction(updatedItem, "Stark@spark-it.fr");
                EndTransaction();
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }

        }
    }
}
