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
    public class ServiceJobSkills : Service<JobSkillsViewModel, JobSkills>, IServiceJobSkills
    {
        public ServiceJobSkills(IRepository<JobSkills> entityRepo,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IJobSkillsBuilder builder,
        IRepository<User> entityRepoUser,
        IEntityAxisValuesBuilder builderEntityAxisValues)
        : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
