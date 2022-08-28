using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class PricesBuilder : GenericBuilder<PricesViewModel, Prices>, IPricesBuilder
    {
        private IItemBuilder _ItemBuilder;
        private ITiersBuilder _tiersBuilder;
        public PricesBuilder(IItemBuilder ItemBuilder, ITiersBuilder TiersBuilder)
        {
            _ItemBuilder = ItemBuilder;
            _tiersBuilder = TiersBuilder;
        }

        //public override Prices BuildModel(PricesViewModel model)
        //{
        //    Prices prices = base.BuildModel(model);
        //    //if (model.ItemPrices != null && model.ItemPrices.Any())
        //    //{
        //    //    prices.ItemPrices.ToList().ForEach(x =>
        //    //    {
        //    //        x.IdItemNavigation = _ItemBuilder.BuildModel(model.ItemPrices.Where(y => y.IdItem == x.IdItem).First().IdItemNavigation);
        //    //    });
        //    //}
        //    //if (model.TiersPrices != null && model.TiersPrices.Any())
        //    //{
        //    //    prices.TiersPrices.ToList().ForEach(x =>
        //    //    {
        //    //        x.IdTiersNavigation = _tiersBuilder.BuildModel(model.TiersPrices.Where(y => y.IdTiers == x.IdTiers).First().IdTiersNavigation);
        //    //    });
        //    //}
        //    return prices;
        //}

        public override PricesViewModel BuildEntity(Prices entity)
        {
            PricesViewModel model = base.BuildEntity(entity);
            if(entity.ItemPrices != null && entity.ItemPrices.Any())
            {
                model.ItemPrices.ToList().ForEach(x =>
                {
                    x.IdItemNavigation = _ItemBuilder.BuildEntity(entity.ItemPrices.Where(y => y.IdItem == x.IdItem).First().IdItemNavigation);
                });
            }
            if (entity.TiersPrices != null && entity.TiersPrices.Any())
            {
                model.TiersPrices.ToList().ForEach(x =>
                {
                    var tier = entity.TiersPrices.Where(y => y.IdTiers == x.IdTiers).First();
                    if (tier != null && tier.IdTiersNavigation != null)
                    {
                        x.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.TiersPrices.Where(y => y.IdTiers == x.IdTiers).First().IdTiersNavigation);
                    }
                });
            }
            return model;
        }
    }
}
