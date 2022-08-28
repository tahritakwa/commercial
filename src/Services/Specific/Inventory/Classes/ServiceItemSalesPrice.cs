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
    public class ServiceItemSalesPrice : Service<ItemSalesPriceViewModel, ItemSalesPrice>, IServiceItemSalesPrice
    {
        public ServiceItemSalesPrice(IRepository<ItemSalesPrice> entityRepo, IUnitOfWork unitOfWork,
           IItemSalesPriceBuilder itemSalesPriceBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, itemSalesPriceBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
