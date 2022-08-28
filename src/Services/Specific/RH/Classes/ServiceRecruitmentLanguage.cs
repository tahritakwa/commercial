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
    public class ServiceRecruitmentLanguage : Service<RecruitmentLanguageViewModel, RecruitmentLanguage>, IServiceRecruitmentLanguage
    {
        public ServiceRecruitmentLanguage(IRepository<RecruitmentLanguage> entityRepo, IUnitOfWork unitOfWork,
         IRecruitmentLanguageBuilder recruitmentLanguage, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, recruitmentLanguage, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
    

        }
       

      
    }
}
