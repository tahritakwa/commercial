using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Shared;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceMovementHistory : Service<MovementHistoryViewModel, MovementHistory>, IServiceMovementHistory
    {
        private readonly IServiceCurrency _serviceCurrency;
        private readonly IServiceTiers _serviceTiers;
        public ServiceMovementHistory(IRepository<MovementHistory> entityRepo, IUnitOfWork unitOfWork, 
            IMovementHistoryBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues, 
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IServiceTiers serviceTiers,
             IServiceCurrency serviceCurrency) 
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceCurrency = serviceCurrency;
            _serviceTiers = serviceTiers;
        }

        public override DataSourceResult<MovementHistoryViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<MovementHistory> predicateFilterRelationModel = PreparePredicate(predicateModel);
            List<MovementHistoryViewModel> movementHistoryList = _entityRepo.QuerableGetAll().Include(x => x.IdItemNavigation).ThenInclude(x => x.ItemTiers)
                .Where(predicateFilterRelationModel.PredicateWhere)
               .Select(x => _builder.BuildEntity(x)).ToList();

            var usedCurency = movementHistoryList.Select(x => x.IdItemNavigation.ItemTiers.First().IdTiersNavigation.IdCurrency).Distinct().ToList();
            var usedcuency = _serviceCurrency.FindModelBy(x => usedCurency.Contains(x.Id)).ToList();



            if (movementHistoryList != null && movementHistoryList.Any())
            {
                movementHistoryList.ForEach(element =>
                {
                    var currencyUsed = usedcuency.First(x => x.Id == element.IdItemNavigation.ItemTiers.First().IdTiersNavigation.IdCurrency);
                    element.FormatOption = element.IdItemNavigation.ItemTiers.First().IdTiersNavigation != null ? new NumberFormatOptionsViewModel
                    {
                        style = Constants.STYLE_CURRENCY,
                        currency = usedcuency.Where(x => x.Id == element.IdItemNavigation.ItemTiers.First().IdTiersNavigation.IdCurrency).First().Code,
                        currencyDisplay = Constants.CURRENCY_DISPLAY_SYMBOL,
                        minimumFractionDigits = usedcuency.Where(x => x.Id == element.IdItemNavigation.ItemTiers.First().IdTiersNavigation.IdCurrency).First().Precision
                    } : null;

                    element.CurrencyCode = currencyUsed.Symbole;
                });
            }
            return new DataSourceResult<MovementHistoryViewModel>
            {
                data = movementHistoryList.Take(predicateModel.pageSize).Skip((predicateModel.page - 1) * predicateModel.pageSize).ToList(),
                total = movementHistoryList.Count
            };
        }
    }
}
