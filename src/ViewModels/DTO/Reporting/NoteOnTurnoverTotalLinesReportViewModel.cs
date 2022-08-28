using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Reporting
{
   public  class NoteOnTurnoverTotalLinesReportViewModel
    {
        public double? totalAmountHT { get; set; }
        public List <NoteOnTurnoverLineReportViewModel> NoteOnTurnoverLines { get; set; }
    }
}
