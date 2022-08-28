using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Settings.Exceptions;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;
#pragma warning disable CS0105 // The using directive for 'System.Linq' appeared previously in this namespace
#pragma warning restore CS0105 // The using directive for 'System.Linq' appeared previously in this namespace

namespace Services.Specific.Inventory.Classes
{
    public class ServiceStockMovement : Service<StockMovementViewModel, StockMovement>, IServiceStockMovement
    {
        private readonly IRepository<ItemWarehouse> _repoItemWareHouse;

        public ServiceStockMovement(IRepository<ItemWarehouse> repoItemWareHouse,
            IRepository<StockMovement> entityRepo, IUnitOfWork unitOfWork,
          IStockMovementBuilder entityBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _repoItemWareHouse = repoItemWareHouse;

        }


        public void UpdateItemQuantityFromStockMovement(int idItem, int idWarehouse, int qty, string Operation)
        {
            var Item = _repoItemWareHouse.FindSingleBy(x => x.IdItem == idItem && x.IdWarehouse == idWarehouse);

            if (Item == null)
            {
                throw new CustomException(CustomStatusCode.UpdateNotExistingItemWarehouse);
            }

            Item.AvailableQuantity = Operation.ToLower().Contains("I".ToLower()) ? Item.AvailableQuantity + qty : Item.AvailableQuantity - qty;
            _repoItemWareHouse.Update(Item);
            _unitOfWork.Commit();
        }

        public void UpdateItemQuantityFromStockMovement(int idStockMovement)
        {
            var StockMovement = FindModelsByNoTracked(x => x.Id == idStockMovement).FirstOrDefault();
            var Item = _repoItemWareHouse.FindSingleBy(x => x.IdItem == StockMovement.IdItem && x.IdWarehouse == StockMovement.IdWarehouse);

            if (StockMovement == null)
            {
                throw new CustomException(CustomStatusCode.UpdateNotExistingStockMovement);
            }

            if (Item == null)
            {
                throw new CustomException(CustomStatusCode.UpdateNotExistingItemWarehouse);
            }

            Item.AvailableQuantity = StockMovement.Operation.ToLower().Contains("I".ToLower()) ? Item.AvailableQuantity + StockMovement.MovementQty : Item.AvailableQuantity - StockMovement.MovementQty;
            _repoItemWareHouse.Update(Item);
            _unitOfWork.Commit();
        }

        public double GetReservationQuatity(int idItem)
        {
            return FindModelsByNoTracked(c => c.Operation == OperationEnumerator.Output && c.IdItem == idItem &&
             (c.Status == DocumentEnumerator.Reservation)).Sum(p => p.MovementQty);
        }
    }
}
