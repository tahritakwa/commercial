using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceBillingEmployee : Service<BillingEmployeeViewModel, BillingEmployee>, IServiceBillingEmployee
    {
        public ServiceBillingEmployee(IRepository<BillingEmployee> entityRepo,
            IRepository<Company> entityRepoCompany,
            IUnitOfWork unitOfWork,
            IBillingEmployeeBuilder billingEmployeeBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings)
           : base(entityRepo, unitOfWork, billingEmployeeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
        }
    }
}
