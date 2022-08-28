using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.Administration.Classes
{
    public class ServiceEntityAxisValues : Service<EntityAxisValuesViewModel, EntityAxisValues>, IServiceEntityAxisValues
    {
        public ServiceEntityAxisValues(IRepository<EntityAxisValues> entityRepo,
            IUnitOfWork unitOfWork,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builder)
            : base(entityRepo, unitOfWork, builder, builder, entityRepoEntityAxisValues)
        {

        }

        public void AddRangeEntityAxisValue(IList<EntityAxisValuesViewModel> model, int id)
        {
            throw new NotImplementedException();
        }

        public void UpdateRangeEntityAxisValue(IList<EntityAxisValuesViewModel> model, int id)
        {
            throw new NotImplementedException();
        }

        //public void AddEntityAxisValue(EntityAxisValuesViewModel model)
        //{
        //    if (model != null)
        //    {
        //        EntityAxisValues entity = _entityAxisValuesBuilder.BuildModel(model);
        //        _entityEntityAxisValues.Add(entity);
        //    }
        //}

        //public void UpdateEntityAxisValue(EntityAxisValuesViewModel model)
        //{
        //    if (model != null)
        //    {
        //        EntityAxisValues entity = _entityAxisValuesBuilder.BuildModel(model);
        //        _entityEntityAxisValues.Update(entity);
        //    }
        //}
    }
}
