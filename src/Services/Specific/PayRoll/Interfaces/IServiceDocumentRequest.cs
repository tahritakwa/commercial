using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceDocumentRequest: IService<DocumentRequestViewModel, DocumentRequest>
    {
        DataSourceResult<DocumentRequestViewModel> GetDocumentRequestsWithHierarchy(string userMail, PredicateFormatViewModel predicate, DateTime? month,
            bool onlyFirstLevelOfHierarchy = false);
        void PrepareAndSendMail(MailBrodcastConfigurationViewModel configModel, string userMail, string action,
            DocumentRequestViewModel documentRequest, SmtpSettings smtpSettings);
        object ValidateDocumentRequest(DocumentRequestViewModel documentRequestViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        List<DocumentRequestViewModel> GetDocumentsFromListId(List<int> listIdDocuments); 
        void ValidateMassiveDocuments(List<DocumentRequestViewModel> listOfDocuments, string userMail);
        void RefuseMassiveDocumentRequest(List<int> listIdDocuments, string userMail);
        void DeleteMassiveDocumentRequest(List<int> listIdDocuments, string userMail);

    }
}
