using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Shared.Interfaces
{
    public interface IReducedTaxeBuilder : IBuilder<ReducedTaxeViewModel, Taxe>
    {
    }
}
