using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.MasterViewModels;

namespace Services.Catalog.Classes
{
    public class ServiceCompanyLicence : ServiceMaster<CompanyLicenceViewModel, CompanyLicence>, IServiceCompanyLicence
    {
        public ServiceCompanyLicence(IMasterRepository<CompanyLicence> entityRepo,
            IMasterUnitOfWork unitOfWork,
            ICompanyLicenceBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
