using ViewModels.DTO.Sales;

namespace Services.Specific.Strategy
{
    public interface IFinancialCommitementDateStrategy
    {
        void SetFcDate(FinancialCommitmentViewModel financialCommitment, int? settlementDate);
    }
}
