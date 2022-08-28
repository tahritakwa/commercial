using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.Comparers
{
    public class EntityComparator<T> : IEqualityComparer<T> where T : GenericViewModel
    {
        public bool Equals(T x, T y)
        {
            if (x != null && y != null && x.Id == y.Id )
            {
                return true;
            }
            return false;
        }

        public int GetHashCode(T obj)
        {
            return obj.Id.GetHashCode();
        }
    }
}
