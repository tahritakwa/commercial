using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Enumerators;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Common;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServiceVehicle : Service<VehicleViewModel, Vehicle>, IServiceVehicle
    {
        public ServiceVehicle(IRepository<Vehicle> entityRepo, IUnitOfWork unitOfWork, IVehicleBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityAxisValues> entityRepoEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
        public override bool CheckUnicity(UnicityViewModel unicityModel)
        {
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            List<FilterViewModel> filters = new List<FilterViewModel>
            {
                new FilterViewModel { Prop = unicityModel.property, Operation = Operation.Equals, Value = unicityModel.value },
                new FilterViewModel { Prop = "IdTiers", Operation = Operation.NotEquals, Value = unicityModel.valueBeforUpdate }
            };
            predicate.Filter = filters;
            Operator key = Operator.And;
            if (predicate != null)
            {
                key = predicate.Operator;
            }
            Expression<Func<Vehicle, bool>> predicat = PredicateUtility<Vehicle>.PredicateFilter(predicate, key);
            var test = _entityRepo.FindByAsNoTracking(predicat);
            if (_entityRepo.FindByAsNoTracking(predicat).Count() != 0)
            {
                return true;
            }
            return false;
        }
    }
}
