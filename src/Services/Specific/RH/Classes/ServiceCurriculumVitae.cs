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
    public class ServiceCv : Service<CurriculumVitaeViewModel, CurriculumVitae>, IServiceCurriculumVitae
    {

        public ServiceCv(IRepository<CurriculumVitae> entityRepo,
           IUnitOfWork unitOfWork, ICurriculumVitaeBuilder builder,
           IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityAxisValues> entityRepoEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
