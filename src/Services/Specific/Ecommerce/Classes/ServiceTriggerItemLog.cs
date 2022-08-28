using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Ecommerce.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Ecommerce.Interfaces;
using ViewModels.DTO.Ecommerce;

namespace Services.Specific.Ecommerce.Classes
{
    public class ServiceTriggerItemLog : Service<TriggerItemLogViewModel, TriggerItemLog>, IServiceTriggerItemLog
    {
        public ServiceTriggerItemLog(IRepository<TriggerItemLog> entityRepo, IUnitOfWork unitOfWork,
          ITriggerItemLogBuilder entityBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }


}
