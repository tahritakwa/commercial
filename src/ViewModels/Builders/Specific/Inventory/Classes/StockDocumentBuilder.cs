using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class StockDocumentBuilder : GenericBuilder<StockDocumentViewModel, StockDocument>, IStockDocumentBuilder
    {
        private readonly IStockDocumentLineBuilder _stockDocumentLineBuilder;

        public StockDocumentBuilder()
        {
        }

        public StockDocumentBuilder(IStockDocumentLineBuilder stockDocumentLineBuilder)
        {
            _stockDocumentLineBuilder = stockDocumentLineBuilder;
        }

        public override StockDocumentViewModel BuildEntity(StockDocument entity)
        {
            StockDocumentViewModel model = base.BuildEntity(entity);
            if(model != null && model.IdDocumentStatus != null && model.IdDocumentStatusNavigation != null)
            {
                model.DocumentStatus = model.IdDocumentStatusNavigation.Label != null ? model.IdDocumentStatusNavigation.Label : string.Empty;
            }
            if (entity != null && entity.StockDocumentLine != null && entity.StockDocumentLine.Count>0)
            {
                model.StockDocumentLine=entity.StockDocumentLine.ToList().Select(x => _stockDocumentLineBuilder.BuildEntity(x)).ToList();
            }
            return model;

        }


        public override StockDocument BuildModel(StockDocumentViewModel model)
        {
            StockDocument entity = base.BuildModel(model);
            entity.IdWarehouseSourceNavigation = null;
            entity.IdWarehouseDestinationNavigation = null;
            return entity;
        }
    }
}
