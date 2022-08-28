using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;

namespace ViewModels.Builders.Specific.Administration.Classes
{
    public class CurrencyBuilder : GenericBuilder<CurrencyViewModel, Currency>, ICurrencyBuilder
    {
        readonly CurrencyRateBuilder currencyRateBuilder = new CurrencyRateBuilder();
        public override Currency BuildModel(CurrencyViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.CurrencyRate != null)
            {
                entity.CurrencyRate = model.CurrencyRate.Select(c => currencyRateBuilder.BuildModel(c)).ToList();
            }
            return entity;
        }
    }
}
