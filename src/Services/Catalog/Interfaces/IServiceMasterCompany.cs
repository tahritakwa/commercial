using Persistence.CatalogEntities;
using Settings.Config;
using ViewModels.DTO.MasterViewModels;

namespace Services.Catalog.Interfaces
{
    public interface IServiceMasterCompany: IServiceMaster<MasterCompanyViewModel, MasterCompany>
    {
        DbSettings GetCompanyDbSettings(string companyCode);
        int GetCompanyId(string companyCode);
    }
}
