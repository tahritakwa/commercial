using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class TiersBuilder : GenericBuilder<TiersViewModel, Tiers>, ITiersBuilder
    {
        private readonly IContactBuilder _contactBuilder;
        private readonly ICurrencyBuilder _currencyBuilder;
        private readonly IAddressBuilder _addressBuilder;
        public TiersBuilder(IContactBuilder contactBuilder, ICurrencyBuilder currencyBuilder, IAddressBuilder addressBuilder)
        {
            _contactBuilder = contactBuilder;
            _currencyBuilder = currencyBuilder;
            _addressBuilder = addressBuilder;
        }
        public override Tiers BuildModel(TiersViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model.Contact != null)
            {
                entity.Contact = model.Contact.Select(c => _contactBuilder.BuildModel(c)).ToList();
            }
            if (model.Address != null)
            {
                entity.Address = model.Address.Select(c => _addressBuilder.BuildModel(c)).ToList();

            }
            return entity;
        }
        public override TiersViewModel BuildEntity(Tiers entity)
        {
            var model = base.BuildEntity(entity);
            if (entity.Contact != null && entity.Contact.Count > 0)
            {
                model.Contact = entity.Contact.Select(c => _contactBuilder.BuildEntity(c)).ToList();
            }
            else
            {
                model.Contact = new List<ContactViewModel>();
            }

            if (entity.Address != null && entity.Address.Count > 0)
            {
                model.Address = entity.Address.Select(c => _addressBuilder.BuildEntity(c)).ToList();
            }
            else
            {
                model.Address = new List<AddressViewModel>();
            }

            if (entity.IdCurrencyNavigation != null)
            {
                model.IdCurrencyNavigation = _currencyBuilder.BuildEntity(entity.IdCurrencyNavigation);

                model.FormatOption = new NumberFormatOptionsViewModel
                {
                    style = Constants.STYLE_CURRENCY,
                    currency = model.IdCurrencyNavigation.Code,
                    currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                    minimumFractionDigits = model.IdCurrencyNavigation.Precision
                };
            }

            return model;
        }
        public ClientBToBViewModel BuildListClientBtoB( Tiers x)
        {
           return new ClientBToBViewModel
            {
                IdTierStark = x.Id,
                Name = x.Name,
                Email = x.Email,
                Phone = x.IdPhoneNavigation != null ? x.IdPhoneNavigation.Number : null,
                DialCode = x.IdPhoneNavigation != null ? x.IdPhoneNavigation.DialCode : string.Empty,
                CountryCode = x.IdPhoneNavigation != null ? x.IdPhoneNavigation.CountryCode : string.Empty,
                Address = x.Address.Any() ? x.Address.FirstOrDefault().PrincipalAddress : string.Empty,
                sector = x.ActivitySector,
                currency_code = x.IdCurrencyNavigation != null ? x.IdCurrencyNavigation.Code : string.Empty,
                tax_group = x.IdTaxeGroupTiersNavigation != null ? x.IdTaxeGroupTiersNavigation.Label : string.Empty,
                IdCategory = x.IdSalesPrice != 0 ? x.IdSalesPrice : null,
                updated_at = x.UpdatedDate,
                created_at = x.CreationDate
           };
        }
        public SynchronizeBToBTierViewModel BuildResponseTiersForBToB(Tiers x)
        {
            return new SynchronizeBToBTierViewModel
            {
                Email = x.Email,
                IdStarkTier = x.Id
            };
        }
    }
}
