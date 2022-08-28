using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Shared.Classes
{
    public class ServiceTaxeType : Service<TaxeTypeViewModel, TaxeType>, IServiceTaxeType
    {
        internal readonly IRepository<User> _entityRepoUser;
        public ServiceTaxeType(IRepository<TaxeType> entityRepo,
            IUnitOfWork unitOfWork,
            ITaxeTypeBuilder builder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
        }


    }
}
