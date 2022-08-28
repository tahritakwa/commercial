using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public partial class ServiceTimeSheetReduce: Service<TimeSheetViewModel, TimeSheet>, IServiceTimeSheetReduce
    {
        public ServiceTimeSheetReduce(IRepository<TimeSheet> entityRepo, IUnitOfWork unitOfWork,
           ITimeSheetBuilder TimeSheetBuilder,
           IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Entity> entityRepoEntity,
            IRepository<Codification> entityRepoCodification)
             : base(entityRepo, unitOfWork, TimeSheetBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, 
                   appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
        }
    }
}
