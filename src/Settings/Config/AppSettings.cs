using ModelView.AppConfig;
using System;

namespace Settings.Config
{
    public class AppSettings
    {
        public Uri ReportUrl { get; set; }
        public Uri JasperReportUrl { get; set; }
        public Uri JasperSourceUrl { get; set; }
        public Uri TracabilityServiceUrl { get; set; }
        public string UploadFilePath { get; set; }
        public Uri BaseUrl { get; set; }
        public Uri MasterUrl { get; set; }
        public Uri DrupalUrl { get; set; }
        public string JWTAuthenticationValidIssuer { get; set; }
        public string JWTAuthenticationValidAudience { get; set; }
        public string MasterMediaType { get; set; }
        public DbSettings DbSettings { get; set; }
        public string SharedDocumentsKey { get; set; }
        public DbSettings MasterDbSettings { get; set; }
        public ECommerceConfig ECommerceConfig { get; set; }
        public BtoBConfig BtoBConfig { get; set; }
        public string JasperUser { get; set; }
        public string JasperPassword { get; set; }
        public bool CreateDateBase { get; set; }
        public PublicKey PublicKey { get; set; }
        public bool ExecuteJobs { get; set; }
        public ModulesSettings ModulesSettings { get; set; }
        public string checkPermissionJavaApi { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string UsersByRoles { get; set; }
        public DataBaseAutoCreationConfig DataBaseAutoCreationConfig { get; set; }
        public AppSettings()
        {

        }

    }

}
