using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class ItemWarehouseViewModel : GenericViewModel
    {
        public int IdItem { get; set; }
        public int IdWarehouse { get; set; }
        public string WarehouseName { get; set; }
        public double? MinQuantity { get; set; }
        public double? MaxQuantity { get; set; }
        public double AvailableQuantity { get; set; }
        public double ReservedQuantity { get; set; }
        public double OnOrderQuantity { get; set; }
        public double SumOfAvailableQuantity { get; set; }
        public double SumOnOrderedReservedQuantity { get; set; }
        public WarehouseState State { get; set; }

        public double ToOrderQuantity { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
        public string NewStorage { get; set; }
        public double SalesAverege { get; set; }
        public virtual ItemViewModel IdItemNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseNavigation { get; set; }
        public double? ConsumedQuanityAfterDelay { get; set; }
        public double OrderedQuantity { get; set; }
        public double TradedQuantity { get; set; }
        public double OutTransferedQuantity { get; set; }
        public double InTransferedQuantity { get; set; }
        public double ReservedQuantityInDelivery { get; set; }
        public double CMD { get; set; }
        public string CRP { get; set; }
        public int? IdShelf { get; set; }
        public int? IdStorage { get; set; }
        public virtual ShelfViewModel IdShelfNavigation { get; set; }
        public virtual ShelfStorageViewModel IdStorageNavigation { get; set; }
    }
}
