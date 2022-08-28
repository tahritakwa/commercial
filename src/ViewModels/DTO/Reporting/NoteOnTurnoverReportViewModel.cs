using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class NoteOnTurnoverReportViewModel
    {
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }
        public ReportCompanyInformationViewModel Company { get; set; }
    }
}
