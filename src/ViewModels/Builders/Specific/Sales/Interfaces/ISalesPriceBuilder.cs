using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Interfaces
{
    public interface ISalesPriceBuilder : IBuilder<SalesPriceViewModel, SalesPrice>
    {
    }
}
