using Persistence.CatalogEntities;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Generic.Classes;
using ViewModels.DTO.MasterViewModels;

namespace ViewModels.Builders.Catalog.Classes
{
    public class MasterDbSettingsBuilder : GenericBuilderMaster<MasterDbSettingsViewModel, MasterDbSettings>, IMasterDbSettingsBuilder
    {
    }
}
