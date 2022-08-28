using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceCompany : IService<CompanyViewModel, Company>
    {
        object UpdateCompany(CompanyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, bool role);
        CompanyViewModel GetCompanyWithDbSettings(string code);
        IList<CompanyViewModel> GetCompaniesWithDbSettings();
        IEnumerable<DbSettings> GetAllDbSettings();
        CommRhProperties GetCommRhVersionProperties();
        ReportCompanyInformationViewModel GetReportCompanyInformation();
        ReducedCurrencyViewModel GetCurrentCompanyCurrency();
        CompanyViewModel GetCurrentCompanyWithContactPictures();

        int GetMasterCompanyId(string companyCode);
        DbSettings GetCompanyDbSettings(string companyCode);
        int GetCurrentCompanyActivityArea();
        ReducedCurrencyAndActivityAreaViewModel GetCurrentCompanyActivityAreaAndCurrency();


    }
}
