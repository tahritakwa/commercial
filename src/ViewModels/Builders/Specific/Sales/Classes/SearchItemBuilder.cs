using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class SearchItemBuilder : GenericBuilder<SearchItemViewModel, SearchItem>, ISearchItemBuilder
    {
    }
}
