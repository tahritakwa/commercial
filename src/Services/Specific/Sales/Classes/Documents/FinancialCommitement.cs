using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes.Documents
{
    public partial class ServiceDocument
    {

        public void SetDocumentFinancialCommitment(DocumentViewModel document, DocumentType documentType)
        {
            if (documentType.IsFinancialCommitmentAffected)
            {
                var addedFinancialCommitment = _serviceFinancialCommitment.GenerateFinancialCommitment(document, documentType).ToList();
                addedFinancialCommitment.ForEach(x => x.IdDocument = document.Id);
                // delete if exist old FinancialCommitment
                _entityFinancialCommitmentRepo.GetAllAsNoTracking().Where(x => x.IdDocument == document.Id).
                    UpdateFromQuery(x => new FinancialCommitment { IsDeleted = true });
                _serviceFinancialCommitment.BulkAddWithoutTransactionMultiCodification(addedFinancialCommitment, nameof(document.DocumentTypeCode), document.DocumentTypeCode);
            }
            else
            {
                document.FinancialCommitment = new List<FinancialCommitmentViewModel>();
            }
        }

        public void SetDocumentFinancialCommitmentForTerm(IList<Document> documentList, DocumentType documentType)
        {
            if (documentType.IsFinancialCommitmentAffected)
            {

                List<FinancialCommitmentViewModel> addedFinancialCommitment = new List<FinancialCommitmentViewModel>();
                foreach (var document in documentList)
                {
                    var documentViewModel = _builder.BuildEntity(document);
                    var finacementcommietemnt = _serviceFinancialCommitment.GenerateFinancialCommitment(documentViewModel, documentType).ToList();
                    finacementcommietemnt.ForEach(x => x.IdDocument = document.Id);
                    addedFinancialCommitment.AddRange(finacementcommietemnt);
                }
                if (documentList.Any())
                {
                    var document = documentList.First();
                    _serviceFinancialCommitment.BulkAddWithoutTransactionMultiCodification(addedFinancialCommitment, nameof(document.DocumentTypeCode), document.DocumentTypeCode);
                }
            }
        }

    }
}
