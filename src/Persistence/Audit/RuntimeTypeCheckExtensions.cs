using System;
using System.Collections.Generic;
using System.Linq;

namespace Persistence.Audit
{
    public static class RuntimeTypeCheckExtensions
    {
        public static bool IsAssignableToAnyOf(this Type typeOperand, IEnumerable<Type> types)
        {
            return types.Any(type => type.IsAssignableFrom(typeOperand));
        }
    }
}
