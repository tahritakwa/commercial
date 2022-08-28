using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceUserWarehouse : IService<UserWarehouseViewModel, UserWarehouse>
    {
        void UpdateUserWarehouse(string userEmail, int? idWarehouse);
        WarehouseViewModel GetWarehouse(string email);
    }
}

