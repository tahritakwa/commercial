using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class ExpenseBuilder : GenericBuilder<ExpenseViewModel, Expense>, IExpenseBuilder
    {
        private readonly IItemBuilder _itemBuilder;
        private readonly IItemTiersBuilder _itemTiersBuilder;
        public ExpenseBuilder(IItemBuilder itemBuilder, IItemTiersBuilder itemTiersBuilder)
        {
            _itemBuilder = itemBuilder;
            _itemTiersBuilder = itemTiersBuilder;
        }

        public override ExpenseViewModel BuildEntity(Expense entity)
        {
            ExpenseViewModel model = base.BuildEntity(entity);
            if (entity != null)
            {
                if (entity.IdItemNavigation != null)
                {
                    model.IdItemNavigation = _itemBuilder.BuildEntity(entity.IdItemNavigation);
                }
                if (entity.IdItemNavigation != null && entity.IdItemNavigation.ItemTiers != null && entity.IdItemNavigation.ItemTiers.Count > 0)
                {
                    model.ItemTiers = entity.IdItemNavigation.ItemTiers.Select(x => _itemTiersBuilder.BuildEntity(x)).ToList();
                    model.ListTiers = model.IdItemNavigation.ItemTiers.Select(x => x.IdTiersNavigation).ToList();
                }

            }
            return model;

        }

        public override Expense BuildModel(ExpenseViewModel model)
        {
            var result = base.BuildModel(model);
            result.IdTaxeNavigation = null;
            result.IdItemNavigation = null;
            return result;
        }
    }
}
