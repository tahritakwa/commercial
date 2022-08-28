using Application.Builder.Administration.Interfaces;
using Application.Builder.Inventory.Interfaces;
using Application.Services.Inventory.Interfaces;
using DataMapping.Models;
using Infrastruture.Service.Classes;
using ModelView.Inventory;
using SparkIt.Infrastucture.Repository;
using SparkIt.Infrastucture.UnitOfWork;
using System;
using System.Collections.Generic;
using System.Text;

namespace Application.Services.Inventory.Classes
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
