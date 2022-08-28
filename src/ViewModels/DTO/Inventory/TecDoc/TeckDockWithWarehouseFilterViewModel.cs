namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TeckDockWithWarehouseFilterViewModel
    {
        public string TecDocReferance { get; set; }
        public int? idSupplier { get; set; }
        public int? idPC { get; set; }
        public int? idProduct { get; set; }
        public int? idWarehouse { get; set; }
        public bool isAvailableInStack { get; set; }
        public bool isCentralOnly { get; set; }
        public string oem { get; set; }
        public bool? idForB2b { get; set; }
        public string UserMail { get; set; }
        public string GlobalSearch { get; set; }
        public bool? isExactSearch { get; set; }
        public FilterSearchItemViewModel filterSearchItem { get; set; }

    }
}
