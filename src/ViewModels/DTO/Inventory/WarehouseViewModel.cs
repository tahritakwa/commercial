using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Immobilisation;
using ViewModels.DTO.Payment;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{

    public class WarehouseViewModel : GenericViewModel
    {
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string WarehouseAdresse { get; set; }
        public double? AvailableQuantity { get; set; }
        public double? ReservedQuantity { get; set; }
        public double? OnOrderQuantity { get; set; }
        public int? IdWarehouseParent { get; set; }
        public bool IsCentral { get; set; }
        public bool IsWarehouse { get; set; }
        public int? IdResponsable { get; set; }
        public int? IdUserResponsable { get; set; }
        public bool? IsEcommerce { get; set; }
        public bool ForEcommerceModule { get; set; }
        public string Text { get; set; }
        public virtual EmployeeViewModel IdResponsableNavigation { get; set; }
        public virtual UserViewModel IdUserResponsableNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseParentNavigation { get; set; }
        public virtual ICollection<WarehouseViewModel> InverseIdWarehouseParentNavigation { get; set; }
        public ICollection<ActiveViewModel> Active { get; set; }

        public ICollection<WarehouseViewModel> Items { get; set; }
        public virtual ICollection<ShelfViewModel> Shelf { get; set; }
        public ICollection<CashRegisterViewModel> CashRegister { get; set; }

    }
}
