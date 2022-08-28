using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceFinancialCommitment : IService<FinancialCommitmentViewModel, FinancialCommitment>
    {

        ICollection<FinancialCommitmentViewModel> GenerateFinancialCommitment(DocumentViewModel document, DocumentType documentType);
        ICollection<FinancialCommitmentViewModel> GetFinancialCommitmentOfCurrentDocument(int idDocument);
        void UpdateAffectedFinancialCommitment(IList<FinancialCommitmentViewModel> financialCommitments, int precision, double exchangeRate,
            SettlementViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        void CalculateWithholdingTaxForFinancialCommitmentWithoutTransaction(DocumentViewModel document, double exchangeRate, int tiersPrecision,
            int companyPrecision, string userMail);
        bool isDcoumentHaveOnlyDepositSettlement(int idDoc);

    }
}
