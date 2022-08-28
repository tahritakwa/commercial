using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class DocumentDownloadReportDataViewModel: DownloadReportDataViewModel
    {
        public string Idtype { get; set; }
        public DateTime? Startdate { get; set; }
        public DateTime? Enddate { get; set; }
        public int? IsFromBl { get; set; }
        public int Idwarehouse { get; set; }
        public int Idtiers { get; set; }
        public int Idstatus { get; set; }
        public int Groupbytiers { get; set; }
    }
}
