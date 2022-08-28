using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class ReducedBankAccountDataBuilder : GenericBuilder<ReducedBankAccountDataViewModel, BankAccount>, IReducedBankAccountDataBuilder
    {
        public ReducedBankAccountDataBuilder()
        {
        }

        public override ReducedBankAccountDataViewModel BuildEntity(BankAccount entity)
        {
            if (entity == null)
            {
                throw new Exception();
            }

            ReducedBankAccountDataViewModel model = base.BuildEntity(entity);

            if (entity.IdBankNavigation != null)
            {
                model.BankName = entity.IdBankNavigation.Name;
                model.BankAttachmentUrl = entity.IdBankNavigation.AttachmentUrl;
            }
            if (entity.IdCurrencyNavigation != null)
            {
                model.Precision = entity.IdCurrencyNavigation.Precision;
                model.CodeCurrency = entity.IdCurrencyNavigation.Code;
                model.CurrencyDescription = entity.IdCurrencyNavigation.Description;
            }
            if (entity.IdCountryNavigation != null)
            {
                model.CountryNameFr = entity.IdCountryNavigation.NameFr;
                model.CountryNameEn = entity.IdCountryNavigation.NameEn;
            }
            if (entity.IdCityNavigation != null)
            {
                model.CityName = entity.IdCityNavigation.Label;
            }
            return model;
        }
    }

}
