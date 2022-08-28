using System.Collections.Generic;
using System.Linq;

namespace Utils.Extensions
{
    public static class GenericExtensions
    {
        public static bool NotNullOrEmpty<T>(this IEnumerable<T> source)
        {
            return source != null && source.Any();
        }
    }
}
