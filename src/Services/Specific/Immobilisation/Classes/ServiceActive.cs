using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Immobilisation.Interfaces;
using Settings.Exceptions;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Immobilisation;

namespace Services.Specific.Immobilisation.Classes
{
    public class ServiceActive : Service<ActiveViewModel, Active>, IServiceActive
    {

        private readonly IReducedActiveBuilder _reducedBuilder;
        private readonly IRepository<History> _HistoryRepo;

        public ServiceActive(IRepository<Active> entityRepo, IUnitOfWork unitOfWork,
          IReducedActiveBuilder reducedBuilder,
          IActiveBuilder actifBuilder, IRepository<Codification> entityRepoCodification,
           IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<History> HistoryRepo, IRepository<EntityAxisValues> entityRepoEntityAxisValues, 
           IRepository<Entity> entityRepoEntity,
           IEntityAxisValuesBuilder builderEntityAxisValues)
         : base(entityRepo, unitOfWork, actifBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _reducedBuilder = reducedBuilder;
            _HistoryRepo = HistoryRepo;
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

        public override object AddModelWithoutTransaction(ActiveViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            ActiveViewModel active = GetModelAsNoTracked(x => x.Code == model.Code);
            if (active != null)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "CODE", model.Code }
                };
                throw new CustomException(CustomStatusCode.CodeUnicity, paramtrs);
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(ActiveViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            ActiveViewModel active = GetModelAsNoTracked(x => x.Code == model.Code);
            if (active != null && active.Id != model.Id)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { "CODE", model.Code }
                };
                throw new CustomException(CustomStatusCode.CodeUnicity, paramtrs);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
        public DataSourceResult<ActiveViewModel> GetActifsByFiltres(PredicateFormatViewModel predicate)
        {
            PredicateFilterRelationViewModel<Active> predicateFilterRelationModel = PreparePredicate(predicate);
            IList<ActiveViewModel> ActiveList = new List<ActiveViewModel>();
            IQueryable<Active> ActiveQueryable = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                              .Where(predicateFilterRelationModel.PredicateWhere)
                                              .OrderByRelation(predicate.OrderBy);
            if (predicate.values != null && predicate.values.Length != 0)
            {
                List<int?> ActiveIDList = _HistoryRepo.FindBy(x => x.IdEmployee == predicate.values[0]).ToList().Select(y => y.IdActive).Distinct().ToList();
                ActiveQueryable = ActiveQueryable
                                              .Where(x => ActiveIDList.Contains(x.Id));
            }
            ActiveList = ActiveQueryable.Select(x => _builder.BuildEntity(x)).ToList();
            DataSourceResult<ActiveViewModel> dataSourceResult = new DataSourceResult<ActiveViewModel>();
            dataSourceResult.total = ActiveList.Count;
            dataSourceResult.data = ActiveList;
            return dataSourceResult;
        }

    }
}
