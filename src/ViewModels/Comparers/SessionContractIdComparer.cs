using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SessionContractIdComparer : IEqualityComparer<SessionContractViewModel>
    {
        bool IEqualityComparer<SessionContractViewModel>.Equals(SessionContractViewModel x, SessionContractViewModel y)
        {
            return (x.IdContract == y.IdContract && x.IdSession == y.IdSession);
        }

        int IEqualityComparer<SessionContractViewModel>.GetHashCode(SessionContractViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return (obj.IdContract.GetHashCode() ^ obj.IdSession.GetHashCode() ^ obj.Id.GetHashCode());
        }
    }
}
