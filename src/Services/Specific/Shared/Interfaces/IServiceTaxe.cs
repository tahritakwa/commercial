using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceTaxe : IService<TaxeViewModel, Taxe>
    {
        void getUsedCurrency(DownloadReportDataViewModel data);
    }
}
