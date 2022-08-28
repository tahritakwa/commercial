using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceLanguage : Service<LanguageViewModel, Language>, IServiceLanguage
    {


        public ServiceLanguage(
          IRepository<Language> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,            ILanguageBuilder builder,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
