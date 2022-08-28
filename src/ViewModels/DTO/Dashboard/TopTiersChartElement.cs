using System;

namespace ViewModels.DTO.Dashboard
{
    public class TopTiersChartElement
    {
        public DateTime DocumentDate { get; set; }
        public int DocumentMonth { get; set; }
        public byte PeriodEnum { get; set; }
        public string Period { get; set; }
        public DateTime StartPeriod { get; set; }
        public DateTime EndPeriod { get; set; }
        public int DocumentYear { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string TiersCode { get; set; }
        public double HTAmount { get; set; }
        public double TTCAmount { get; set; }
        public int Quantity { get; set; }
        public string Type { get; set; }
        public int RankByTTCAmount { get; set; }
        public int RankByQuantity { get; set; }






    }
}
