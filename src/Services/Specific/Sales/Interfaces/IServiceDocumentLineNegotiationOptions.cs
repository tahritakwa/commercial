using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceDocumentLineNegotiationOptions : IService<DocumentLineNegotiationOptionsViewModel, DocumentLineNegotiationOptions>
    {
        object addNegotiationOption(DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel, string userMail);
        void AcceptOrRejectPrice(DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel, string userMail);
        DataSourceResult<DocumentLineNegotiationOptionsViewModel> GetListNegotiationByItem(PredicateFormatViewModel model);
        ReportNegotiationDataViewModel PrintNegotiation(int idDocument);
    }
}
