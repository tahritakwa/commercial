using System;
using System.Collections.Generic;
using ViewModels.DTO.Sales.Document;

namespace ViewModels.DTO.Inventory
{
    public class ItemHistoryViewModel
    {
        public int IdItem { get; set; }
        public int? IdTiers { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<DocumentMovementDetail> Document { get; set; }
        public double InQuantity { get; set; }
        public double OutQuantity { get; set; }
        public double EndPurchaseAmount { get; set; }
        public double EndSaleAmount { get; set; }
        public double AvailableQty { get; set; }
        public double NumberDayOutStock { get; set; }
        public double StartQuantity { get; set; }

    }
}
