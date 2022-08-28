using Microsoft.Extensions.DependencyInjection;
using Persistence.Context;
using Persistence.UnitOfWork.Classes;
using Persistence.UnitOfWork.Interfaces;

namespace Web.App_Start
{
    public static class IocDbContext
    {
        public static void RegisterDbContext(this IServiceCollection services)
        {
            services.AddDbContext<StarkContextFactory>();
            services.AddDbContext<CatalogContextFactory>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddScoped<IMasterUnitOfWork, MasterUnitOfWork>();
        }
    }
}
