using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Provisioning;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class ProvisioningDetailsBuilder : GenericBuilder<ProvisioningDetailsViewModel, ProvisioningDetails>, IProvisioningDetailsBuilder
    {
        IMeasureUnitBuilder _measureUnitBuilder;

        public ProvisioningDetailsBuilder(IMeasureUnitBuilder measureUnitBuilder)
        {
            _measureUnitBuilder = measureUnitBuilder;
        }

        public override ProvisioningDetailsViewModel BuildEntity(ProvisioningDetails entity)
        {
            ProvisioningDetailsViewModel model = base.BuildEntity(entity);
            if (entity != null && entity.IdItemNavigation != null && entity.IdItemNavigation.IdUnitStockNavigation != null)
            {
                model.IdItemNavigation.IdUnitStockNavigation = _measureUnitBuilder.BuildEntity(entity.IdItemNavigation.IdUnitStockNavigation);
            }

            return model;

        }
    }
}
