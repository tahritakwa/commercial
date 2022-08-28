using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Inventory
{
    public class ItemExportPdfViewModel
    {
        public string CodeTiers { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public double AllAvailableQuantity { get; set; }
        public double UnitHtsalePrice { get; set; }
        public string LabelProduct { get; set; }
        public string LabelVehicule { get; set; }
        public int IdItem { get; set; }
        public bool IsAvailable { get; set; }
        public Guid? EquivalenceItem { get; set; }
        public int? TecDocId { get; set; }
        public string TecDocRef { get; set; }
        public int? TecDocIdSupplier { get; set; }
        public virtual ICollection<ItemWarehouseViewModel> ItemWarehouse { get; set; }
        public bool isCommnadInProgress { get; set; }

    }
}
