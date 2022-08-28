using System;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DailySalesDeliveryReportQueryViewModel
    {
        //Document infos
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public TiersViewModel ListTiers { get; set; }
        public int? IdTiers { get; set; }
        public string CodeStatus { get; set; }
        public int? IdStatus { get; set; }
        public string IdType { get; set; }
        public int? GroupByTiers { get; set; }


    }
}
