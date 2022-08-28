using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceMeasureUnit : Service<MeasureUnitViewModel, MeasureUnit>, IServiceMeasureUnit
    {

        public readonly IReducedMeasureUnitBuilder _reducedBuilder;
        public ServiceMeasureUnit(IRepository<MeasureUnit> entityRepo,
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IReducedMeasureUnitBuilder reducedBuilder,
            IMeasureUnitBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
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
        /// <summary>
        /// Override of generic service method AddModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(MeasureUnitViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if(!model.IsDecomposable)
            {
                model.DigitsAfterComma = 0;
            }
            dynamic entity = _builder.BuildModel(model);

            // Generate Codification
            GenerateCodification(entity, property, false);

            // add entity
            _entityRepo.Add(entity);
            // add entityAxesValues
            //AddEntityAxesValues(entityAxisValuesModelList, (int)entity.Id, userMail);
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entity.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        public override object UpdateModelWithoutTransaction(MeasureUnitViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // save entity traceability
            if(!model.IsDecomposable)
            {
                model.DigitsAfterComma = 0;
            }
            dynamic entity = _builder.BuildModel(model);

            // update collection entity                
            UpdateCollections(entity, userMail);

            // update entity
            _entityRepo.Update(entity);
            // update entityAxesValues
            if (entityAxisValuesModelList != null && entityAxisValuesModelList.Any())
            {
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
            }
            // commit 
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entity.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }
    }
}
