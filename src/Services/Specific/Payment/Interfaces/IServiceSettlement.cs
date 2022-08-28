using ModelView.Payment;
using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServiceSettlement : IService<SettlementViewModel, Settlement>
    {
        object ValidateSettlement(int idSettlement, string userMail);
        IList<SettlementViewModel> GetDocumentSettlements(int idDocument);
        List<DocumentPaymentHistoryViewModel> GetDocumentPaymentHisotry(int idDocument);
        SettlementHistoryDataResultViewModel GetSettlements(int tiersType, DateTime? startDate, DateTime? endDate, List<int> idInvoices, PredicateFormatViewModel predicateModel);
        Task<SettlementViewModel> GenerateSettlementFromCustomerOutstanding(IntermediateSettlementGeneration model, string userMail, bool isDepositSettlement = false);
        void ReplaceSettlement(int id, string userMail);
        void UpdateSettlement(ReducedSettlementList model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        List<SettlementCommitmentViewModel> GetFinancialCommitmentPaymentHistory(int idFinancialCommitment);
        DataSourceResult<SettlementAccounting> GetAccountingSettlement(PredicateFormatViewModel settlementAccountingModel);
        bool ChangeSettlementAccountedStatus(int idSettlement);
        dynamic GetInvoivesBySettlement(int tiersType, PredicateFormatViewModel predicateModel);
        double CalculateWithholdingTaxToBePaid(List<int> SelectedFinancialCommitments);
        SettlementForReconciliationResultViewModel GetBankAccountReconciliationSettlement(PredicateFormatViewModel predicateModel, int idBankAccount, bool unreconciledRegulations, bool reconciledRegulations);
        BankAccountPrevisionnelSoldViewModel GetBankAccountPrevisionnelSold(int idBankAccount);
        SettlemenToAddInPaymentSlipResultViewModel GetSettlementListToAddInPaymentSlip(PredicateFormatViewModel predicateModel, bool isPaymentSlipStateProvisional, int? idPaymentSlip);
        int GetSettlementNumberToAddPaymentSlip(string paymentMethod);
        Task<SettlementViewModel> ReGenerateWithholdingTaxCertificatAsync(int id, string userMail);
        DataSourceResult<ReducedSettlementList> GetDataWithSpecificFilter(List<PredicateFormatViewModel> model);
        Task<SettlementViewModel> GenerateSettlementFromTicket(IntermediateSettlementGeneration model, string userMail);
        DocumentViewModel ValidateDocumentAndGenerateSettlemnt(SettlementViewModel settlement, int idDocument, int documentStatus, string userMail);
    }
}
