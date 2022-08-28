using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceConstantValueValidityPeriod : Service<ConstantValueValidityPeriodViewModel, ConstantValueValidityPeriod>, IServiceConstantValueValidityPeriod
    {
      
  

        public ServiceConstantValueValidityPeriod(IRepository<ConstantValueValidityPeriod> entityRepo, 
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IConstantValueValidityPeriodBuilder builder, 
            IRepository<Entity> entityRepoEntity,IEntityAxisValuesBuilder builderEntityAxisValues )
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
