using Microsoft.EntityFrameworkCore;
using System;
using System.Reflection;

namespace Persistence.Context
{
    public partial class BaseContext: DbContext
    {
        public string GeneratedConnectionString { get; set; }

        public BaseContext()
        {

        }

        public BaseContext(DbContextOptions<StarkContextFactory> options) : base(options)
        {

        }

        public BaseContext(DbContextOptions<CatalogContextFactory> options) : base(options)
        {

        }

        public static dynamic DynamicCastTo(dynamic obj, Type castTo, bool safeCast)
        {
            MethodInfo castMethod = obj.GetType().GetMethod("CastTo").MakeGenericMethod(castTo);
            return castMethod.Invoke(null, new object[] { obj, safeCast });
        }

        public int SaveChangesWithoutTraceability()
        {
            return base.SaveChanges();
        }

    }
}
