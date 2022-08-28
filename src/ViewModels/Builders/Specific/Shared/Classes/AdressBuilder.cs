using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class AdressBuilder : GenericBuilder<AddressViewModel, Address>, IAddressBuilder
    {
        private readonly ICountryBuilder _countryBuilder;
        private readonly ICityBuilder _cityBuilder;

        public AdressBuilder(ICountryBuilder countryBuilder, ICityBuilder cityBuilder)
        {
            _countryBuilder = countryBuilder;
            _cityBuilder = cityBuilder;
        }

        public override Address BuildModel(AddressViewModel model)
        {
            var entity = base.BuildModel(model);           
            return entity;
        }

        public override AddressViewModel BuildEntity(Address entity)
        {

            var model = base.BuildEntity(entity);            
            return model;
        }
    }
}
