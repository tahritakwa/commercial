using System;

namespace ViewModels.DTO.ErpSettings
{
    public class SalesInventoryDocumentLineViewModel
    {
        public int Take { get; set; }
        public int Skip { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? IdWarehouse { get; set; }


    }
}
