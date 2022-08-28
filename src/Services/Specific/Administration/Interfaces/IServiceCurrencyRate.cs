using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServiceCurrencyRate : IService<CurrencyRateViewModel, CurrencyRate>
    {
        double GetExchangeRateValue(int IdCurrency, DateTime date, double? exchangeRate = null);
        object AddCurrencyRate(CurrencyRateViewModel currencyRate, string userMail);
        object UpdateCurrencyRate(CurrencyRateViewModel currencyRate, string userMail);
    }
}
