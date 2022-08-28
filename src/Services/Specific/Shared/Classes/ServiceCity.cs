using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceCity : Service<CityViewModel, City>, IServiceCity
    {
        public readonly IReducedCityBuilder _reducedBuilder;

        internal readonly IRepository<User> _entityRepoUser;
        public ServiceCity(IRepository<City> entityRepo, IUnitOfWork unitOfWork, IReducedCityBuilder reducedBuilder,
           ICityBuilder cityBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, cityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
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
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<City> predicateFilterRelationModel)
        {
            IEnumerable<dynamic> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            }

            IList<dynamic> model = entities.Select(x => _reducedBuilder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }

    }
}
