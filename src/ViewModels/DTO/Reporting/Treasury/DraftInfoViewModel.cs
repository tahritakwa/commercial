using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class DraftInfoViewModel
    {
        public int Number { get; set; }
        public string DraftNumber { get; set; }
        public string Bank { get; set; }
        public string Holder { get; set; }
        public string Amount { get; set; }
        public string CommmitmentDate { get; set; }
    }
}
