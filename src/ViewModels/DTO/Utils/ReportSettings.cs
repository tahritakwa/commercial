

using Settings.Config;

namespace ViewModels.DTO.Utils
{
    public class ReportSettings
    {
        public string ReportNameToDisplay { get; set; }
        public string ReportConnectionString { get; set; }
        public string ReportPath { get; set; }
        public string ReportName { get; set; }
        public string ReportType { get; set; }
        public string DataLogoCompany { get; set; }
        public int Id { get; set; }
        public int IdCompany { get; set; }
        public int IdContract { get; set; }
        public int Version { get; set; }
        public int PrintType { get; set; }
        public int IsFromBL { get; set; }
        public string UploadFilePath { get; set; }
        public string DirectoryName { get; set; }
        public string Url { get; set; }
        public string Telerik { get; set; }
        public string User { get; set; }
        public int NumberofCopies { get; set; } = 1;
        public int IdTiers { get; set; }
        public int IdStatus { get; set; }
        public string IdType { get; set; }
        public int IdWarehouse { get; set; }
        public string startdate { get; set; }
        public string enddate { get; set; }
        public PrinterSettings _printerSettings;
        public dynamic ReportParameters { get; set; }

    }
}
