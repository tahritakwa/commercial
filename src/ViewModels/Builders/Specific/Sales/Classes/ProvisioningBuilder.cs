using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Provisioning;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class ProvisioningBuilder : GenericBuilder<ProvisioningViewModel, Provisioning>, IProvisioningBuilder
    {
        private readonly ITiersBuilder _tiersBuilder;
        public ProvisioningBuilder(ITiersBuilder tiersBuilder)
        {
            _tiersBuilder = tiersBuilder;
        }

        public override ProvisioningViewModel BuildEntity(Provisioning entity)
        {
            if (entity == null)
            {
                return null;
            }
            ProvisioningViewModel provisioningViewModel = base.BuildEntity(entity);
            if (provisioningViewModel.TiersProvisioning != null)
            {
                foreach (var provisioningTiers in provisioningViewModel.TiersProvisioning)
                {
                    provisioningTiers.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.TiersProvisioning.First(y => y.IdTiers == provisioningTiers.IdTiers).IdTiersNavigation);

                }
            }

            return provisioningViewModel;
        }
    }
}
