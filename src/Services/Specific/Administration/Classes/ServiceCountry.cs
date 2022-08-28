using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Administration.Classes
{
    public class ServiceCountry : Service<CountryViewModel, Country>, IServiceCountry
    {
        public readonly IReducedCountryBuilder _reducedBuilder;

        public ServiceCountry(IRepository<Country> entityRepo,             IUnitOfWork unitOfWork,            IReducedCountryBuilder reducedBuilder,
            ICountryBuilder countryBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, countryBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoEntity = entityRepoEntity;
            _reducedBuilder = reducedBuilder;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }
    }
}
