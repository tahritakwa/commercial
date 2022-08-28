using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Interfaces
{
    public interface IUserWarehouseBuilder : IBuilder<UserWarehouseViewModel, UserWarehouse>
    {
    }
}

