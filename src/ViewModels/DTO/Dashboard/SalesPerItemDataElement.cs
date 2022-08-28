using System;

namespace ViewModels.DTO.Dashboard
{
    public class SalesPerItemDataElement
    {
        public double HtTotalPerItem { get; set; }
        public double QuantityPerItem { get; set; }
        public int IdItem { get; set; }
        public string ItemCode { get; set; }
        public string ItemDescription { get; set; }
        public string LabelItemFamily { get; set; }
        public string OperationType { get; set; }
        public byte PeriodEnum { get; set; }
        public string Period { get; set; }
        public DateTime StartPeriod { get; set; }
        public DateTime EndPeriod { get; set; }
        public int RankByAmount { get; set; }
        public int RankByQuantity { get; set; }
        public double HtTotalPerItemFamily { get; set; }
        public int QuantityPerItemFamily { get; set; }
        public string ItemFamily { get; set; }
        public long RankByFamilyPerAmount { get; set; }
        public long RankByFamilyPerQuantity { get; set; }







    }
}
