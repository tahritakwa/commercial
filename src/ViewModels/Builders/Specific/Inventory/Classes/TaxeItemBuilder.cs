using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class TaxeItemBuilder : GenericBuilder<TaxeItemViewModel, TaxeItem>, ITaxeItemBuilder
    {
        private readonly ITaxeBuilder _taxeBuilder;
        public TaxeItemBuilder(ITaxeBuilder taxeBuilder)
        {
            _taxeBuilder = taxeBuilder;
        }
        public override TaxeItemViewModel BuildEntity(TaxeItem entity)
        {
            TaxeItemViewModel model = base.BuildEntity(entity);
            if (entity.IdTaxeNavigation != null)
            {
                model.IdTaxeNavigation = _taxeBuilder.BuildEntity(entity.IdTaxeNavigation);
            }
            return model;
        }
    }
}
