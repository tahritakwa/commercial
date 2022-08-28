using System.Collections.Generic;
using ViewModels.DTO.Administration;

namespace ViewModels.Comparers
{
    public class AxisRelationShipComparer : IEqualityComparer<AxisRelationShipViewModel>
    {
        bool IEqualityComparer<AxisRelationShipViewModel>.Equals(AxisRelationShipViewModel x, AxisRelationShipViewModel y)
        {
            return (x.IdAxisParent == y.IdAxisParent && x.IdAxis == y.IdAxis);
        }

        int IEqualityComparer<AxisRelationShipViewModel>.GetHashCode(AxisRelationShipViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return obj.IdAxisParent.GetHashCode();
        }
    }
}
