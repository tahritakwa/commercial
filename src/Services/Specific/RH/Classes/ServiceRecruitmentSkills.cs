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
    public class ServiceRecruitmentSkills : Service<RecruitmentSkillsViewModel, RecruitmentSkills>, IServiceRecruitmentSkills
    {
        public ServiceRecruitmentSkills(IRepository<RecruitmentSkills> entityRepo, IUnitOfWork unitOfWork, 
         IRecruitmentSkillsBuilder recruitmentSkillsBuilder,IRepository<EntityAxisValues> entityRepoEntityAxisValues,IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, recruitmentSkillsBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {


        }

       
    }
}
