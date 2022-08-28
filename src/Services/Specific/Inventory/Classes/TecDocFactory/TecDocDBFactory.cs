using Microsoft.Extensions.Options;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;

namespace Services.Specific.Inventory.Classes.TecDocFactory
{
    public class TecDocDBFactory
    {
        IServiceTecDoc TecTocDB;

        public IServiceTecDoc CreateTecDocConnection(IServiceItem serviceItem, IOptions<OtherDataBaseSettings> appSettings)
        {
            if (appSettings.Value.DbType == "2019q1")
                TecTocDB = new ServiceTecDoc(serviceItem, appSettings);
            if (appSettings.Value.DbType == "Api")
                TecTocDB = new ServiceTecDocApi(serviceItem,appSettings);
            return TecTocDB;
        }
    }
}
