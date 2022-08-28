using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class CheckInfoViewModel
    {
        public int Number { get; set; }
        public string CheckNumber { get; set; }
        public string Bank { get; set; }
        public string Holder { get; set; }
        public string Amount { get; set; }
    }
}
