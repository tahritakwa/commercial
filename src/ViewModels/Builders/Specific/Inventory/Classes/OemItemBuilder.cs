using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class OemItemBuilder : GenericBuilder<OemItemViewModel, OemItem>, IOemItemBuilder
    {
        public override OemItemViewModel BuildEntity(OemItem entity)
        {
            return base.BuildEntity(entity);
        }

    }
}
