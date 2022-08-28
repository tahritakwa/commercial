using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Interfaces
{
    public interface ITiersBuilder : IBuilder<TiersViewModel, Tiers>
    {
        ClientBToBViewModel BuildListClientBtoB(Tiers x);
        SynchronizeBToBTierViewModel BuildResponseTiersForBToB(Tiers x);
    }
}
