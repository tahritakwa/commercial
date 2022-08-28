using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.Comparers
{
    public class FinancialCommitmentComparer : IEqualityComparer<FinancialCommitmentViewModel>
    {
        bool IEqualityComparer<FinancialCommitmentViewModel>.Equals(FinancialCommitmentViewModel x, FinancialCommitmentViewModel y)
        {
            if (x == null  && y != null || x != null && y == null )
            {
                return false;
            }
            return (x.Id == y.Id && x.IdStatus == y.IdStatus && x.RemainingAmountWithCurrency == y.RemainingAmountWithCurrency
                    && x.RemainingWithholdingTaxWithCurrency == y.RemainingWithholdingTaxWithCurrency);
        }

        int IEqualityComparer<FinancialCommitmentViewModel>.GetHashCode(FinancialCommitmentViewModel obj)
        {
            if (obj != null && obj.RemainingWithholdingTaxWithCurrency.HasValue)
            {
                obj.RemainingWithholdingTaxWithCurrency.Value.GetHashCode();
            }
            return 0;
        }
    }
}
