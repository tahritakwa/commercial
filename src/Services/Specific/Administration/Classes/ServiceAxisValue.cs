using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.Administration.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="ModuleViewModel.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceAxisValue : Service<AxisValueViewModel, AxisValue>, IServiceAxisValue
    {


        private readonly IAxisValueBuilder _axisValueBuilder;
        private readonly IRepository<AxisValueRelationShip> _entityRepoAxisValueRelationShip;
        private readonly IRepository<AxisValue> _entityRepoAxisValue;
        private readonly IEntityAxisValuesBuilder _entityAxisValuesBuilder;
        public ServiceAxisValue(IRepository<AxisValue> entityRepo, IUnitOfWork unitOfWork,
           IAxisValueBuilder entityBuilder,
           IRepository<AxisValueRelationShip> entityRepoAxisValueRelationShip, IRepository<AxisValue> entityRepoAxisValue,
           IAxisValueBuilder axisValueBuilder, IEntityAxisValuesBuilder entityAxisValuesBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoAxisValueRelationShip = entityRepoAxisValueRelationShip;
            _entityRepoAxisValue = entityRepoAxisValue;
            _axisValueBuilder = axisValueBuilder;
            _entityAxisValuesBuilder = entityAxisValuesBuilder;
        }

        public List<AxisValueViewModel> GetAxisValueByAxis(int idAxis, string[] listIdAxisValue = null)
        {
            if (listIdAxisValue != null)
            {
                const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
                return _entityRepoAxisValueRelationShip.GetAllWithConditionsRelations(c => listIdAxisValue.Where(p => string.Compare(p, "0", stringComparison) != 0)
                                                                                        .Contains(c.IdAxisValueParent.ToString(CultureInfo.InvariantCulture))
                                                                                        && c.IdAxisValueNavigation.IdAxis == idAxis, c => c.IdAxisValueNavigation)
                                                                                        .OrderBy(c => c.IdAxisValueParent)
                                                                                        .Select(c => _axisValueBuilder.BuildEntity(c.IdAxisValueNavigation)).ToList();
            }
            return _entityRepoAxisValue.GetAllWithConditionsRelations(c => c.IdAxis == idAxis)
                .Select(_axisValueBuilder.BuildEntity).ToList();
        }
        public IList<EntityAxisValuesViewModel> GetAxisValueByEntity(int idEntity, string tableName)
        {
            return _entityRepoEntityAxisValues.GetAllWithConditionsRelations(c => c.IdEntityItem == idEntity &&
                    c.IdAxisValueNavigation.IdAxisNavigation.AxisEntity.Any(p => p.IdTableEntityNavigation.TableName.Equals(tableName)), c => c.IdAxisValueNavigation)
                    .Select(_entityAxisValuesBuilder.BuildEntity).ToList();
        }

    }
}
