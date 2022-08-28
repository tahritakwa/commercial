using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class TransferOrderSessionIdComparer : IEqualityComparer<TransferOrderSessionViewModel>
    {
        bool IEqualityComparer<TransferOrderSessionViewModel>.Equals(TransferOrderSessionViewModel x, TransferOrderSessionViewModel y)
        {
            return (x.IdSession == y.IdSession && x.IdTransferOrder == y.IdTransferOrder && x.Id == y.Id && x.IsDeleted == y.IsDeleted);
        }

        int IEqualityComparer<TransferOrderSessionViewModel>.GetHashCode(TransferOrderSessionViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;
            return (obj.IdSession.GetHashCode() ^ obj.IdTransferOrder.GetHashCode() ^ obj.Id.GetHashCode());
        }
    }
}
