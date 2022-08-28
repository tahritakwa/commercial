using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class ZipCodeBuilder : GenericBuilder<ZipCodeViewModel, ZipCode>, IZipCodeBuilder
    {
        CityBuilder cityBuilder = new CityBuilder();
        public override ZipCodeViewModel BuildEntity(ZipCode entity)
        {
            ZipCodeViewModel model = base.BuildEntity(entity);
            if (model.IdCityNavigation != null)
            {
                model.IdCityNavigation = cityBuilder.BuildEntity(entity.IdCityNavigation);
            }
            return model;
        }
    }

}
