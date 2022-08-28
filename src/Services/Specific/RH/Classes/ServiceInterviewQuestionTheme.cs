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
    public class ServiceInterviewQuestionTheme : Service<InterviewQuestionThemeViewModel, InterviewQuestionTheme>, IServiceInterviewQuestionTheme
    {
        public ServiceInterviewQuestionTheme(IRepository<InterviewQuestionTheme> entityRepo, IUnitOfWork unitOfWork,
           IInterviewQuestionThemeBuilder InterviewQuestionThemeBuilder,
            IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, InterviewQuestionThemeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
