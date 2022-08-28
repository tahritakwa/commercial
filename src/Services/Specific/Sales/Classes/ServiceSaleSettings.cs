﻿using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceSaleSettings : Service<SaleSettingsViewModel, SaleSettings>, IServiceSaleSettings
    {


        public ServiceSaleSettings(IRepository<SaleSettings> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IUnitOfWork unitOfWork,
            ISaleSettingsBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
