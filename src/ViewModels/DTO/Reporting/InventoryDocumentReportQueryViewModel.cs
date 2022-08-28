using System;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class InventoryDocumentReportQueryViewModel
    {
        //Document infos
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public DateTime? DocumentDate { get; set; }
        public TiersViewModel ListTiers { get; set; }
        public int? IdTiers { get; set; }
        public string CodeStatus { get; set; }
        public int? IdStatus { get; set; }
        public string IdType { get; set; }
        public int? GroupByTiers { get; set; }
        public int? IdWarehouse { get; set; }
        public int? IdInventory { get; set; }

        // int idinventory, int idwarehouse, string startdate, string enddate


    }
}
