using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceStockDocumentType : Service<StockDocumentTypeViewModel, StockDocumentType>, IServiceStockDocumentType
    {
        public ServiceStockDocumentType(IRepository<StockDocumentType> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IUnitOfWork unitOfWork,
            IStockDocumentTypeBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
