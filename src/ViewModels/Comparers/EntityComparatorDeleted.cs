using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.Comparers
{
    public class EntityComparatorDeleted<T> : IEqualityComparer<T> where T : GenericViewModel
    {
        public bool Equals(T x, T y)
        {
            if (x == null || y == null)
            {
                return false;
            }
            return x.Id == y.Id && x.IsDeleted == y.IsDeleted;
        }

        public int GetHashCode(T obj)
        {
            return obj.Id.GetHashCode();
        }
    }
}
