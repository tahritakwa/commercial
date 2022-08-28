using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class SectionViewModel : GenericViewModel
    {
        public string SectionName { get; set; }
        public string SectionCode { get; set; }
        public int IdUnitType { get; set; }
        public int IdWarehouse { get; set; }
        public double CapacityPerUnit { get; set; }
        public MeasureUnitViewModel UnitType { get; set; }
        public WarehouseViewModel Warehouse { get; set; }
    }
}
