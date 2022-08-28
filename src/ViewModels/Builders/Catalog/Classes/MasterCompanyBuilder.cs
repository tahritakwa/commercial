using Persistence.CatalogEntities;
using System;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Generic.Classes;
using ViewModels.DTO.MasterViewModels;

namespace ViewModels.Builders.Catalog.Classes
{
    public class MasterCompanyBuilder : GenericBuilderMaster<MasterCompanyViewModel, MasterCompany>, IMasterCompanyBuilder
    {
        private readonly IMasterDbSettingsBuilder _dbSettingsBuilder;
        public MasterCompanyBuilder(IMasterDbSettingsBuilder dbSettingsBuilder)
        {
            _dbSettingsBuilder = dbSettingsBuilder;
        }
        public override MasterCompanyViewModel BuildEntity(MasterCompany entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            MasterCompanyViewModel company = base.BuildEntity(entity);
            company.IdMasterDbSettingsNavigation = entity.IdMasterDbSettingsNavigation is null ?
                new MasterDbSettingsViewModel() :
                _dbSettingsBuilder.BuildEntity(entity.IdMasterDbSettingsNavigation);
            company.IdMasterDbSettingsNavigation.DataBaseName = company.DataBaseName;
            return company;
        }
    }
}
