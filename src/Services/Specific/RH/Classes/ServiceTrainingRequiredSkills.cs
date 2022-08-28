using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceTrainingRequiredSkills : Service<TrainingRequiredSkillsViewModel, TrainingRequiredSkills>, IServiceTrainingRequiredSkills
    {
        public ServiceTrainingRequiredSkills(IRepository<TrainingRequiredSkills> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ITrainingRequiredSkillsBuilder builder,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }


    }
}
