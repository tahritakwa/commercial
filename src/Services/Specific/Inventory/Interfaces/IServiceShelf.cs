using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceShelf : IService<ShelfViewModel, Shelf>
    {
        List<ShelfViewModel> getShelfsByWarehouse(int idWarehouse);
        object addShelfAndStorage(ShelfViewModel shelf,string userMail);
        bool CheckShelfAndStorageExistenceInWarehouse(ShelfViewModel shelf);
    }
}
