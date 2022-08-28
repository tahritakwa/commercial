using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Provisioning;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class ProvisioningOptionBuilder : GenericBuilder<ProvisioningOptionViewModel, ProvisioningOption>, IProvisioningOptionBuilder
    {
    }
}
