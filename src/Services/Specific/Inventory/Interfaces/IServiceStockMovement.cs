using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceStockMovement : IService<StockMovementViewModel, StockMovement>
    {
        void UpdateItemQuantityFromStockMovement(int idItem, int idWarehouse, int qty, string Operation);
        void UpdateItemQuantityFromStockMovement(int idStockMovement);
        double GetReservationQuatity(int idItem);
    }
}
