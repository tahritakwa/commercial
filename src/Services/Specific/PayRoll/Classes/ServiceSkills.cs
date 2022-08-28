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
    public class ServiceSkills : Service<SkillsViewModel, Skills>, IServiceSkills
    {
        public ServiceSkills(IRepository<Skills> entityRepo, IUnitOfWork unitOfWork,
        ISkillsBuilder skillsbuilder, IEntityAxisValuesBuilder builderEntityAxisValues,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues,
        IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
        IRepository<Codification> entityRepoCodification)
        : base(entityRepo, unitOfWork, skillsbuilder, builderEntityAxisValues, entityRepoEntityAxisValues,
           entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
        }
    }
}
