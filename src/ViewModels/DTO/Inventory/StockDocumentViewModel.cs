using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class StockDocumentViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string TypeStockDocument { get; set; }
        public int? IdWarehouseSource { get; set; }
        public int? IdWarehouseDestination { get; set; }
        public int? IdDocumentStatus { get; set; }
        public DateTime? DocumentDate { get; set; }
        public DateTime? ValidationDate { get; set; }
        public bool? IsPlannedInventory { get; set; }
        public string Reference { get; set; }
        public string Informations { get; set; }
        public int? IdTiers { get; set; }
        public string Shelf { get; set; }
        public int? IdUser { get; set; }
        public int? IdInputUser1 { get; set; }
        public int? IdInputUser2 { get; set; }
        public bool? IsDefaultValue { get; set; }
        public bool? IsOnlyAvailableQuantity { get; set; }
        public virtual ICollection<StockDocumentLineViewModel> StockDocumentLine { get; set; }
        public virtual DocumentStatusViewModel IdDocumentStatusNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseDestinationNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseSourceNavigation { get; set; }
        public virtual StockDocumentTypeViewModel TypeSockDocumentNavigation { get; set; }
        public virtual UserViewModel IdUserNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
        public virtual UserViewModel IdInputUser1Navigation { get; set; }
        public virtual UserViewModel IdInputUser2Navigation { get; set; }
        public int? IdStorageSource { get; set; }
        public int? IdStorageDestination { get; set; }
        public virtual ShelfStorageViewModel IdStorageDestinationNavigation { get; set; }
        public virtual ShelfStorageViewModel IdStorageSourceNavigation { get; set; }
        public string TransferType { get; set; }
        public string shelfSourceLabel { get; set; }
        public string shelfDestinationLabel { get; set; }
        public string DocumentStatus { get; set; }
        public bool FromUserDropdown { get; set; }

    }
}
