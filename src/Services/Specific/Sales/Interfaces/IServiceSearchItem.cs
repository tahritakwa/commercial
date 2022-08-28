using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceSearchItem : IService<SearchItemViewModel, SearchItem>
    {
        void AddSearch(SearchItemObjectToSaveViewModel searchItemSupplierViewModel, string userMail);
        List<ReducedTiersViewModel> GetSearchedSuppliers(PredicateFormatViewModel predicateFormatViewModel, out int total);
        List<SearchItemObjectToSaveViewModel> GetSerachDetailPeerSupplier(PredicateFormatViewModel predicateFormatViewModel, out int total);
        CreatedDataViewModel GenerateDocument(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel, string userMail);
        void AddItemToDocument(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel);
        TiersDetailsViewModel TiersDetails(int idTiers);
        bool CheckRealAndProvisionalStock(SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel);
        bool IsValidDocument(int idDocument);
    }
}
