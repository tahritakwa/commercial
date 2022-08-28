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
    public class ServiceTypePrices : Service<TypePricesViewModel, TypePrices>, IServiceTypePrices
    {
        public ServiceTypePrices(IRepository<TypePrices> entityRepo, IUnitOfWork unitOfWork, IRepository<User> entityRepoUser,
           ITypePricesBuilder typePricesBuilder, IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, typePricesBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
