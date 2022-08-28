using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory.TecDoc;

namespace ViewModels.Builders.Specific.Inventory.Classes.TecDoc
{
    public class OemBuilder : GenericBuilder<OemViewModel, Oem>, IOemBuilder
    {
    }
}
