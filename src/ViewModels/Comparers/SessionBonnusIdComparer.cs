using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SessionBonnusIdComparer : IEqualityComparer<SessionBonusViewModel>
    {
        bool IEqualityComparer<SessionBonusViewModel>.Equals(SessionBonusViewModel x, SessionBonusViewModel y)
        {
            return x.Id == y.Id && x.IdBonus == y.IdBonus;
        }

        int IEqualityComparer<SessionBonusViewModel>.GetHashCode(SessionBonusViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return (obj.Id.GetHashCode() ^ obj.IdContract.GetHashCode() ^ obj.IdBonus.GetHashCode());
        }
    }
}
