using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceSettlementMode : Service<SettlementModeViewModel, SettlementMode>, IServiceSettlementMode
    {
        private readonly IRepository<DetailsSettlementMode> _entityRepoDetailsSettlementMode;
        private readonly IDetailsSettlementModeBuilder _builderDetailsSettlementMode;
        public ServiceSettlementMode(IRepository<DetailsSettlementMode> entityRepoDetailsSettlementMode, IDetailsSettlementModeBuilder builderDetailsSettlementMode
           , IRepository<SettlementMode> entityRepo, IUnitOfWork unitOfWork,
           ISettlementModeBuilder settlementModeBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, settlementModeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

            _entityRepoDetailsSettlementMode = entityRepoDetailsSettlementMode;
            _builderDetailsSettlementMode = builderDetailsSettlementMode;
        }
        public override DataSourceResult<SettlementModeViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<SettlementModeViewModel> dataSourceResult = base.FindDataSourceModelBy(predicateModel);
            if (dataSourceResult != null && dataSourceResult.data != null)
            {
                foreach (SettlementModeViewModel settlementMode in dataSourceResult.data)
                {
                    if (settlementMode.DetailsSettlementMode != null)
                    {
                        IEnumerable<DetailsSettlementMode> detailsSettlementMode = _entityRepoDetailsSettlementMode.GetAllWithConditionsRelations(p => p.IdSettlementMode == settlementMode.Id,
                            c => c.IdPaymentMethodNavigation, c => c.IdSettlementTypeNavigation);
                        ICollection<DetailsSettlementModeViewModel> detailsSettlementModeViewModel = detailsSettlementMode.Select(_builderDetailsSettlementMode.BuildEntity).ToList();
                        settlementMode.DetailsSettlementMode = detailsSettlementModeViewModel;
                    }
                }
            }
            return dataSourceResult;
        }
        /// <summary>
        /// Finds the model by Generic Predicate.
        /// The method receive a generic predicate
        /// and return the collection of model found according to the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable SettlementModeViewModel</returns>
        public override IList<SettlementModeViewModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            IList<SettlementModeViewModel> listOfSettlementModeViewModel = base.FindModelBy(predicateModel);
            // fetch listOfSettlementModeViewModel and specify CanDelete, CanEdit and CanShow
            foreach (SettlementModeViewModel settlementModeViewModel in listOfSettlementModeViewModel)
            {
                // if settelmentMode is used by document ==> set CanDelete and CanEdit to false
                if (settlementModeViewModel.Document != null && settlementModeViewModel.Document.Any())
                {
                    settlementModeViewModel.CanDelete = false;
                    settlementModeViewModel.CanEdit = false;
                }
                // if settelmentMode is not used by any document ==> set CanShow to false
                else
                {
                    settlementModeViewModel.CanShow = false;
                }
            }
            return listOfSettlementModeViewModel;
        }
        /// <summary>
        /// GetAllModels
        /// </summary>
        /// <returns></returns>
        public override IList<SettlementModeViewModel> GetAllModels()
        {
            var entities = _entityRepo.GetAll().OrderBy(x => x.Code);
            return entities.Select(c => _builder.BuildEntity(c)).ToList();
        }
    }
}
