using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class StockMovementInformationViewModel
    {
        public string DocumentDate { get; set; }
        public string WarehouseSource { get; set; }
        public string WarehouseDestination { get; set; }
        public string Code { get; set; }
        public string Status { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }

        public ReportCompanyInformationViewModel Company { get; set; }
    }

    public class ReportStockMovementViewModel
    {
        public string Item { get; set; }
        public string Quantity { get; set; }
    }

}

