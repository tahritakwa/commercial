using System;

namespace ViewModels.DTO.Inventory
{
    public class ItemToGetEquivalentList
    {
        public int Id { get; set; }
        public int? IdSelectedWarehouse { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public bool IsForPurchase { get; set; }
        public string SearchString { get; set; }
    }
}
