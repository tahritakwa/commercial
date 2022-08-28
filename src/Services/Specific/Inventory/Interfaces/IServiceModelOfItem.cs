using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceModelOfItem : IService<ModelOfItemViewModel, ModelOfItem>
    {
        List<ModelOfItem> GetListOfModelOfItem();
    }
}
