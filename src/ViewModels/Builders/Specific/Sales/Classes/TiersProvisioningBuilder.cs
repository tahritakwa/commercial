using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Provisioning;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class TiersProvisioningBuilder : GenericBuilder<TiersProvisioningViewModel, TiersProvisioning>, ITiersProvisioningBuilder
    {
        private readonly ICurrencyBuilder _currencyBuilder;
        public TiersProvisioningBuilder(ICurrencyBuilder currencyBuilder)
        {
            _currencyBuilder = currencyBuilder;
        }
        public override TiersProvisioningViewModel BuildEntity(TiersProvisioning entity)
        {
            var model = base.BuildEntity(entity);
            if (entity.IdTiersNavigation != null && entity.IdTiersNavigation.IdCurrencyNavigation != null)
            {
                model.IdTiersNavigation.IdCurrencyNavigation = _currencyBuilder.BuildEntity(entity.IdTiersNavigation.IdCurrencyNavigation);
            }
            return model;
        }
    }
}
