﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class SettlementDataViewModel
    {
        public string Type { get; set; }
        public string InvoiceCode { get; set; }
        public string DeadlineCode { get; set; }
        public string DeadlineDate { get; set; }
        public string TotalAmount { get; set; }
        public string Holding { get; set; }
        public string AssignedAmount { get; set; }
        public string CurrencyCode { get; set; }

    }
}
