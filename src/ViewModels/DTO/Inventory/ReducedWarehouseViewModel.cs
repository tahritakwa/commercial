using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class ReducedWarehouseViewModel : GenericViewModel
    {

        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string WarehouseAdresse { get; set; }
        public int? IdWarehouseParent { get; set; }
        public bool IsCentral { get; set; }
        public bool IsWarehouse { get; set; }
        public int? IdResponsable { get; set; }
        public bool IsEcommerce { get; set; }

        public ReducedWarehouseViewModel()
        {
        }

        public ReducedWarehouseViewModel(WarehouseViewModel idWarehouseNavigation) : base(idWarehouseNavigation)
        {
            if (idWarehouseNavigation != null)
            {
                WarehouseCode = idWarehouseNavigation.WarehouseCode;
                WarehouseName = idWarehouseNavigation.WarehouseName;
                WarehouseAdresse = idWarehouseNavigation.WarehouseAdresse;
                IdWarehouseParent = idWarehouseNavigation.IdWarehouseParent;
                IsCentral = idWarehouseNavigation.IsCentral;
                IsWarehouse = idWarehouseNavigation.IsWarehouse;
                IdResponsable = idWarehouseNavigation.IdResponsable;
            }
        }
    }
}
