using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.MasterViewModels;

namespace Services.Catalog.Classes
{
    public class ServiceMasterCompany : ServiceMaster<MasterCompanyViewModel, MasterCompany>, IServiceMasterCompany
    {
        private readonly IMasterDbSettingsBuilder _masterDbSettingsBuilder;
        private readonly AppSettings _appSettings;
        public static bool lockorUnlock = true;

        public ServiceMasterCompany(IMasterRepository<MasterCompany> entityRepo,
            IMasterUnitOfWork unitOfWork,
            IMasterCompanyBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IMasterDbSettingsBuilder masterDbSettingsBuilder, IOptions<AppSettings> appSettings) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _masterDbSettingsBuilder = masterDbSettingsBuilder;
            _appSettings = appSettings.Value;
        }

        public override IList<MasterCompanyViewModel> GetAllModelsAsNoTracking()
        {
            IEnumerable<MasterCompany> entities = _entityRepo.GetAllAsNoTracking().Include(x => x.IdMasterDbSettingsNavigation);
            return entities.Select(c => _builderMaster.BuildEntity(c)).ToList();
        }
        public DbSettings GetCompanyDbSettings(string companyCode)
        {
            MasterCompany selectedCompany = _entityRepo.GetAllAsNoTracking().Include(x => x.IdMasterDbSettingsNavigation)
                .Where(x => x.Code == companyCode).FirstOrDefault();
            DbSettings dbSettings = _masterDbSettingsBuilder.BuildMasterSlaveModel(selectedCompany.IdMasterDbSettingsNavigation, Activator.CreateInstance<DbSettings>());
            dbSettings.DataBaseName = selectedCompany.DataBaseName;
            return dbSettings;
        }

        public int GetCompanyId(string companyCode)
        {
            return _entityRepo.GetSingleNotTracked(x => x.Code == companyCode).Id;
        }
    }
}
