using System;

namespace ViewModels.DTO.Sales.Document
{
    public class ProvisionalSDFilterViewModel
    {
        public int IdSupplier { get; set; }
        public int IdDocument { get; set; }
        public string Code { get; set; }

        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
    }
}
