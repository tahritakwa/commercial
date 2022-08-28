using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;

namespace ViewModels.Builders.Specific.Administration.Classes
{
    public class ReducedCurrencyBuilder : GenericBuilder<ReducedCurrencyViewModel, Currency>, IReducedCurrencyBuilder
    {
    }
}
