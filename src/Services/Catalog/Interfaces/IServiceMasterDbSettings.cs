using Persistence.CatalogEntities;
using ViewModels.DTO.MasterViewModels;

namespace Services.Catalog.Interfaces
{
    public interface IServiceMasterDbSettings : IServiceMaster<MasterDbSettingsViewModel, MasterDbSettings>
    {
    }
}
