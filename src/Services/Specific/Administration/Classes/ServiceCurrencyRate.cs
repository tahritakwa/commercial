using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    public class ServiceCurrencyRate : Service<CurrencyRateViewModel, CurrencyRate>, IServiceCurrencyRate
    {
        private readonly IRepository<DocumentLinePrices> _entityDocumentLinePricesRepo;
        public ServiceCurrencyRate(IRepository<CurrencyRate> entityRepo, IUnitOfWork unitOfWork,
           ICurrencyRateBuilder entityBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IEntityAxisValuesBuilder builderEntityAxisValues,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache, IRepository<Company> entityRepoCompany, IOptions<AppSettings> appSettings, IRepository<DocumentLinePrices> entityDocumentLinePricesRepo)
            : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _entityRepoCompany = entityRepoCompany;
            _appSettings = appSettings.Value;
            _entityDocumentLinePricesRepo = entityDocumentLinePricesRepo;
        }


        public double GetExchangeRateValue(int IdCurrency, DateTime date, double? exchangeRate = null)
        {
            var CompanyCurency = GetCurrentCompany().IdCurrency;
            if (CompanyCurency == IdCurrency)
            {
                return 1;
            }

            if (exchangeRate != null)
            {
                return exchangeRate ?? 0;
            }
            DateTime today = DateTime.Now;
            var currencyRate = GetModelsWithConditionsRelations(
                                  x => x.IdCurrency == IdCurrency && ((x.EndDate.HasValue && DateTime.Compare(today.Date, x.StartDate.Value) >= NumberConstant.Zero 
                                  && DateTime.Compare(today.Date, x.EndDate.Value) <= NumberConstant.Zero)
                                  || (!x.EndDate.HasValue && DateTime.Compare(today.Date, x.StartDate.Value) >= NumberConstant.Zero)) && x.Document.Count() == 0,x=>x.Document).ToList().FirstOrDefault();
            return currencyRate != null ? currencyRate.Rate / currencyRate.Coefficient : 1;
        }

        public object AddCurrencyRate(CurrencyRateViewModel currencyRate, string userMail)
        {
            CheckIfTheCurrencyRateStartDateExeedEndDate(currencyRate);
            var ids = _entityDocumentLinePricesRepo.GetAllAsNoTracking().Select(x => x.IdPrices).ToList().Distinct();
        CheckIfTheCurrencyRateChosenPeriodOverlapsWithAnother(currencyRate,
                GetModelsWithConditionsRelations(x => x.IdCurrency == currencyRate.IdCurrency && !ids.Contains(x.Id)).ToList());
            return AddModel(currencyRate, null, userMail);
        }


        public object UpdateCurrencyRate(CurrencyRateViewModel currencyRate, string userMail)
        {
            CheckIfTheCurrencyRateStartDateExeedEndDate(currencyRate);
            CheckIfTheCurrencyRateChosenPeriodOverlapsWithAnother(currencyRate,
                GetModelsWithConditionsRelations(x => x.IdCurrency == currencyRate.IdCurrency && x.Id != currencyRate.Id).ToList());
            return UpdateModel(currencyRate, null, userMail);
        }
        private void CheckIfTheCurrencyRateStartDateExeedEndDate(CurrencyRateViewModel currencyRate)
        {
            if (currencyRate.EndDate.GetDateOfNullableDateTime() < currencyRate.StartDate.GetDateOfNullableDateTime())
            {
                throw new CustomException(CustomStatusCode.STARTDATE_EXCEED_ENDDATE);
            }
        }
        private void CheckIfTheCurrencyRateChosenPeriodOverlapsWithAnother(CurrencyRateViewModel currencyRate, List<CurrencyRateViewModel> currencyRateList)
        {
            currencyRateList.ForEach(currentCurrencyRate =>
            {
                if (currencyRate.StartDate.GetDateOfNullableDateTime().
                    BetweenDateLimitIncluded(currentCurrencyRate.StartDate.GetDateOfNullableDateTime(), currentCurrencyRate.EndDate.GetDateOfNullableDateTime()) ||
                    currencyRate.EndDate.GetDateOfNullableDateTime().
                    BetweenDateLimitIncluded(currentCurrencyRate.StartDate.GetDateOfNullableDateTime(), currentCurrencyRate.EndDate.GetDateOfNullableDateTime()))
                {
                    throw new CustomException(CustomStatusCode.ChosenPeriodOverlapsWithAnother);
                }
            });
        }

        public override DataSourceResult<CurrencyRateViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            var currencyRateList =  base.FindDataSourceModelBy(predicateModel);

            currencyRateList.data.ToList().ForEach(currencyRate =>
            {
                currencyRate.CodeDocument = currencyRate.Document?.FirstOrDefault().Code;

            });

            return currencyRateList;
        }

    }
}
