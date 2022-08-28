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
    public class ServiceSkillsFamily : Service<SkillsFamilyViewModel, SkillsFamily>, IServiceSkillsFamily
    {

        public ServiceSkillsFamily(IRepository<SkillsFamily> entityRepo, IUnitOfWork unitOfWork,
            ISkillsFamilyBuilder skillsFamilybuilder, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues) 
            : base(entityRepo, unitOfWork, skillsFamilybuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

    }
}
