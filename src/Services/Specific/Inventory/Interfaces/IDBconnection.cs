using System.Collections.Generic;
using ViewModels.DTO.Inventory.TecDoc;

namespace Services.Specific.Inventory.Interfaces
{
    interface IDBconnection
    {
        void Connect();
        List<TecDocManufacturersViewModel> GetMFA();
        void Disconnect();
    }
}
