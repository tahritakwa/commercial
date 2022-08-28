using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Classes
{

    public class ServiceReportTemplate : Service<ReportTemplateViewModel, ReportTemplate>, IServiceReportTemplate
    {
        public ServiceReportTemplate(IRepository<ReportTemplate> entityRepo, IUnitOfWork unitOfWork,
         IReportTemplateBuilder entityBuilder,
         IRepository<EntityAxisValues> entityRepoEntityAxisValues,
         IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
