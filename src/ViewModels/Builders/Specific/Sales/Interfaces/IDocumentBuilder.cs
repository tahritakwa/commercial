using Persistence.Entities;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;

namespace ViewModels.Builders.Specific.Sales.Interfaces
{


    public interface IDocumentBuilder : IBuilder<DocumentViewModel, Document>
    {
        DocumentListViewModel BuildDocument(Document x);
        DocumentAssociatedGeneratedViewModel BuildDocumentAssociatedGenerated(Document x);
        ReducedDocumentList BuildEntityToReducedList(Document entity, List<StockMovement> listStockMovement, List<MasterUserViewModel> users = null, List<UsersBtob> usersBtob = null);
        DocumentViewModel BuildDocumentEntity(Document entity);
    }
}
