namespace ViewModels.DTO.Reporting.Generic
{
    public class DownloadReportDataViewModel
    {
        public int Id { get; set; }
        public int PrintType { get; set; }
        public string ReportName { get; set; }
        public string ReportCode { get; set; }

        public string DocumentName { get; set; }
        public string ZipFolderName { get; set; }
        public string ReportFormatName { get; set; }
        public string ReportType { get; set; }
        public dynamic Reportparameters { get; set; }

        public int[] ListIds { get; set; }
        public dynamic[] DynamicListIds { get; set; }
        public int? IsFromBl { get; set; }
        public bool? getWithReportName { get; set; }
    }
}
