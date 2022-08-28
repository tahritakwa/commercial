using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceBillingEmployee : IService<BillingEmployeeViewModel, BillingEmployee>
    {
    }
}
