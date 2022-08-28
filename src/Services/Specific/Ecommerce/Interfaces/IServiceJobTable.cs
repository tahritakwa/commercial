using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Threading.Tasks;
using ViewModels.DTO.Ecommerce;

namespace Services.Specific.Ecommerce.Interfaces
{
    public interface IServiceJobTable : IService<JobTableViewModel, JobTable>
    {
        Task<bool> SynchronizeAllProdcutsWithDetailsToEcommerceAsync(string generatedConnectionString);
    }
}
