using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SessionLoanInstallmentComparer : IEqualityComparer<SessionLoanInstallmentViewModel>
    {
        bool IEqualityComparer<SessionLoanInstallmentViewModel>.Equals(SessionLoanInstallmentViewModel x, SessionLoanInstallmentViewModel y)
        {
            return x.Id == y.Id && x.IdLoanInstallment == y.IdLoanInstallment;
        }

        int IEqualityComparer<SessionLoanInstallmentViewModel>.GetHashCode(SessionLoanInstallmentViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return (obj.Id.GetHashCode() ^ obj.IdContract.GetHashCode() ^ obj.IdLoanInstallment.GetHashCode());
        }
    }
}
