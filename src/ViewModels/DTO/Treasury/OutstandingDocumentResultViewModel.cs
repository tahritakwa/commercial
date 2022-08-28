using System.Collections.Generic;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Treasury
{
    public class OutstandingDeliveryFormResultViewModel
    {
        public long Total { get; set; }
        public List<OutstandingDeliveryFormViewModel> Data { get; set;}
        public double? TotalAmount { get; set; }
        public double? TotalRemainingAmount { get; set; }

    }
}
