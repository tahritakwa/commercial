using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Inventory.TecDoc;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceOem : IService<OemViewModel, Oem>
    {
        List<TecDocArticleViewModel> getOemSubs(TeckDockWithWarehouseFilterViewModel TecDocItem);
    }
}
