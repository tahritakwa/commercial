using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceWarehouse : IService<WarehouseViewModel, Warehouse>
    {
        List<WarehouseViewModel> GetListOfWarehouses(string searchWarehouse);
        void DeleteWarehouse(int id, string tableName, string userMail);
        Warehouse GetCentralWarehouse();
        DataSourceResult<WarehouseViewModel> GetWarehouseForInventory(PredicateFormatViewModel model);
        DataSourceResult<ReducedWarehouseViewModel> GetWarehouseDropdownForInventory(PredicateFormatViewModel model);
        DataSourceResult<ReducedWarehouseViewModel> GetWarehouseDropdownForEcommerce(PredicateFormatViewModel model);
        List<WarehouseViewModel> GetChildrens(List<WarehouseViewModel> List, List<WarehouseViewModel> ListGlobal, string searchWarehouse);
        bool CheckWarehouseNameExistence(WarehouseViewModel warehouse);


        }
}
