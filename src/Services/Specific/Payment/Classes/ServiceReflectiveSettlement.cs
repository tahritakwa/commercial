using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{
    public class ServiceReflectiveSettlement : Service<ReflectiveSettlementViewModel, ReflectiveSettlement>, IServiceReflectiveSettlement
    {
        public ServiceReflectiveSettlement(IRepository<ReflectiveSettlement> entityRepo, IUnitOfWork unitOfWork,
           IReflectiveSettlementBuilder ReflectiveSettlementBuilder,
            IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, ReflectiveSettlementBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
