using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceDocumentLine : IService<DocumentLineViewModel, DocumentLine>
    {

        double AccountAssocietedQuantity(int idDocumentAssocieted);
        double AccountAssocietedQuantityValid(int idDocumentAssocieted);
        IEnumerable<DocumentLineViewModel> GetDocumentLines(int idDocument);
        void UpdateModelWithoutTransaction(DocumentLineViewModel model);
        int PredpareDocumentLines(DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel, List<DocumentLineViewModel> documentLineViewModels, PredicateFormatViewModel predicate);
        string GetShelfAndStorageOfItemInWarehouse(int idItem, int? idWarehouse);
        void UpdateDocumentLineOperation(DocumentLineViewModel documentLine, List<DocumentLine> documentLinesAssociated=null, DocumentLine documentLineModel = null);
        List<DocumentLineViewModel> RecalculateAvailableQuantity(int idDocument);
        double GetOrdredQty(int idItem, int idWarehouse);
        bool IsDocumentLineNegotiatedFromDocumentLineId(int id);
        dynamic GetDocumentsAssociated(PredicateFormatViewModel predicate);
        IList<OrderQuantitybyItem> GetOrdredQty(IList<int> idProducts, int idWarehouse);
        List<BalanceDocumentLine> GetBalancedList(int idTiers, List<int> idItems = null,
            string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false);
        List<BalanceDocumentLine> GetBalancedListWithPredicate(int idTiers, PredicateFormatViewModel predicate, List<int> idItems = null,
           string importerDocumentType = null, string importedDocumentType = null, bool isFromB2B = false);
    }
}
