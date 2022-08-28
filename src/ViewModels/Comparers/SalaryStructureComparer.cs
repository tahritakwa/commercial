using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SalaryStructureComparer : IEqualityComparer<SalaryStructureViewModel>
    {
        public bool Equals(SalaryStructureViewModel x, SalaryStructureViewModel y)
        {
            if (x == null || y == null)
            {
                return false;
            }
            return x.Id == y.Id &&
                x.Order == y.Order &&
                x.IdParent == y.IdParent;
        }

        public int GetHashCode(SalaryStructureViewModel obj)
        {
            if (obj == null)
            {
                return 0;
            }
            return obj.Id.GetHashCode() ^
                obj.Order.GetHashCode();
        }
    }
}
