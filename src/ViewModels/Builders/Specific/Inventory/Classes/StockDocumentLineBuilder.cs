using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class StockDocumentLineBuilder : GenericBuilder<StockDocumentLineViewModel, StockDocumentLine>, IStockDocumentLineBuilder
    {
        #region Fields
        private readonly INatureBuilder _natureBuilder;
        private readonly IWarehouseBuilder _warehousBuilder;
        private readonly IItemWarehouseBuilder _builderItemWarehouse;
        private readonly IMeasureUnitBuilder _builderMeasureUnit;
        #endregion

        public StockDocumentLineBuilder(INatureBuilder natureBuilder, IWarehouseBuilder warehousBuilder, IItemWarehouseBuilder builderItemWarehouse, IMeasureUnitBuilder builderMeasureUnit)
        {
            _natureBuilder = natureBuilder;
            _warehousBuilder = warehousBuilder;
            _builderItemWarehouse = builderItemWarehouse;
            _builderMeasureUnit = builderMeasureUnit;
        }

        #region Methodes
        public override StockDocumentLineViewModel BuildEntity(StockDocumentLine entity)
        {
            StockDocumentLineViewModel model = base.BuildEntity(entity);
            if (entity != null && entity.IdItemNavigation != null && entity.IdItemNavigation.IdNatureNavigation != null)
            {
                model.IdItemNavigation.IdNatureNavigation = _natureBuilder.BuildEntity(entity.IdItemNavigation.IdNatureNavigation);
            }
            if (entity != null && entity.IdStockDocumentNavigation != null && entity.IdStockDocumentNavigation.IdWarehouseSourceNavigation != null)
            {
                model.IdStockDocumentNavigation.IdWarehouseSourceNavigation = _warehousBuilder.BuildEntity(entity.IdStockDocumentNavigation.IdWarehouseSourceNavigation);
            }
            if (entity != null && entity.IdStockDocumentNavigation != null && entity.IdStockDocumentNavigation.IdWarehouseDestinationNavigation != null)
            {
                model.IdStockDocumentNavigation.IdWarehouseDestinationNavigation = _warehousBuilder.BuildEntity(entity.IdStockDocumentNavigation.IdWarehouseDestinationNavigation);
            }
            if (entity != null && entity.IdItemNavigation != null && entity.IdItemNavigation.ItemWarehouse != null && entity.IdItemNavigation.ItemWarehouse.Count>0)
            {
                model.IdItemNavigation.ItemWarehouse= entity.IdItemNavigation.ItemWarehouse.Select(_builderItemWarehouse.BuildEntity).ToList();
            }
            if (entity != null && entity.IdItemNavigation != null && entity.IdItemNavigation.IdUnitStockNavigation != null)
            {
                model.IdItemNavigation.IdUnitStockNavigation = _builderMeasureUnit.BuildEntity(entity.IdItemNavigation.IdUnitStockNavigation);
            }
            return model;

        }
        #endregion

    }
}
