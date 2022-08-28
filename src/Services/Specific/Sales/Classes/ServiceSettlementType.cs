using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceSettlementType : Service<SettlementTypeViewModel, SettlementType>, IServiceSettlementType
    {
        internal readonly IRepository<User> _entityRepoUser;
        public ServiceSettlementType(IRepository<SettlementType> entityRepo, IUnitOfWork unitOfWork,
           ISettlementTypeBuilder settlementTypeBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, settlementTypeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
        }
    }
}
