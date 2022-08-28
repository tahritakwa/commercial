﻿using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceTaxeItem : Service<TaxeItemViewModel, TaxeItem>, IServiceTaxeItem
    {
        public ServiceTaxeItem(IRepository<TaxeItem> entityRepo,
            IUnitOfWork unitOfWork,
            ITaxeItemBuilder builder,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
