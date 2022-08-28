using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Immobilisation;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {
        private void GenerateActives(DocumentViewModel document, DocumentType documentType, string userMail)
        {
            if (!documentType.IsActiveGeneration)
            {
                return;
            }
            IList<DocumentLineViewModel> documentLineViewModelList = document.DocumentLine.Where(p => p.IsActive).ToList();
            documentLineViewModelList.ToList().ForEach(p =>
                                                        {
                                                            for (int i = 0; i < p.MovementQty; i++)
                                                            {
                                                                AddActive(document, p, userMail);
                                                            }
                                                        });
        }
        private void AddActive(DocumentViewModel document, DocumentLineViewModel documentLineViewModel, string userMail)
        {
            ActiveViewModel actifViewModel = new ActiveViewModel
            {
                AcquisationDate = document.DocumentDate,
                IdDocumentLine = documentLineViewModel.Id,
                Label = documentLineViewModel.Designation,
                Status = (int)ActiveStatusEnumerator.Live,
                Value = documentLineViewModel.HtAmountWithCurrency.Value,
                Description = documentLineViewModel.Designation,
                IdWarehouse = documentLineViewModel.IdWarehouse
            };
            _serviceActive.AddModelWithoutTransaction(actifViewModel, null, userMail);
        }
    }
}
