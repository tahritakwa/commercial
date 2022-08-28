using Microsoft.AspNetCore.Http;
using Settings.Config;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Generic.Interfaces
{
    public interface IService<TModel, TEntity>: IGenericService<TModel, TEntity>
        where TModel : class
        where TEntity : class
    {
        ReportSettings GetDocumentReportSettings(DownloadReportDataViewModel data, HttpContext ctx, string userMail, PrinterSettings printerSettings=null);
        void UpdateReportSettings(DownloadReportDataViewModel data);
        string GetStarkWebSiteUrl();
        string GetStarkLogo();
        CompanyViewModel GetCurrentCompany();
        void ResetCacheCurrentCompany();
        int GetCompanyCurrencyPrecision();
        int CheckWithCurrentCompanyCurrencyPrecision(string value);
        string GetConnectionString();
        string GetBTobConnectionString();
    }
}
