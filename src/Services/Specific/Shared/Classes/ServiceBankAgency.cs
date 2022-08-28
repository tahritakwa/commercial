using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceBankAgency : Service<BankAgencyViewModel, BankAgency>, IServiceBankAgency

    {
        public ServiceBankAgency(IRepository<BankAgency> entityRepo,
            IUnitOfWork unitOfWork,
            IBankAgencyBuilder builder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
