using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceSubModel : IService<SubModelViewModel, SubModel>
    {
        DataSourceResult<SubModelViewModel> FindPriceDataSourceModelBy(PredicateFormatViewModel predicateModel);
    }
}
