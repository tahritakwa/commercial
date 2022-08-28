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
    public class ServiceQualificationType : Service<QualificationTypeViewModel, QualificationType>, IServiceQualificationType
    {
        
        public ServiceQualificationType(IRepository<QualificationType> entityRepo, IUnitOfWork unitOfWork,

           IQualificationTypeBuilder qualificationTypeBuilder,
            IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, qualificationTypeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
