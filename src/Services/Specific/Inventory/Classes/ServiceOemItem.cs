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
    public class ServiceOemItem : Service<OemItemViewModel, OemItem>, IServiceOemItem
    {
        public ServiceOemItem(IRepository<OemItem> entityRepo, IUnitOfWork unitOfWork, IOemItemBuilder entityBuilder,
         IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
