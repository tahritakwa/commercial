using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServiceCurrency : IService<CurrencyViewModel, Currency>
    {
    }
}
