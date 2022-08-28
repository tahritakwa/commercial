using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceModelOfItem : Service<ModelOfItemViewModel, ModelOfItem>, IServiceModelOfItem
    {
        public readonly IReducedModelOfItemBuilder _reducedBuilder;

        public ServiceModelOfItem(IRepository<ModelOfItem> entityRepo, IUnitOfWork unitOfWork,
          IModelOfItemBuilder entityBuilder, IReducedModelOfItemBuilder reducedBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _entityRepoCompany = entityRepoCompany;
            _reducedBuilder = reducedBuilder;
        }
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<ModelOfItem> predicateFilterRelationModel)
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
        /// <summary>
        /// UpdateModel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="EntityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public override object UpdateModel(ModelOfItemViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
        {
            try
            {
                // begin transaction
                BeginTransaction();
                model.UpdatedDate = DateTime.Now;
                //update with files pictures 
                if (model.PictureFileInfo != null)
                {
                    ManagePicture(model);
                }
                // save entity traceability
                ModelOfItem entity = _builder.BuildModel(model);
                // update collection entity                
                UpdateCollections(entity, userMail);

                // update entity
                _entityRepo.Update(entity);
                //update entity axes value
                UpdateEntityAxesValues(EntityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
                _unitOfWork.Commit();
                EndTransaction();
                return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw the original exception
                throw;
            }
        }
        /// <summary>
        /// AddModel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModel(ModelOfItemViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            ManagePicture(model);
            model.CreationDate = DateTime.Now;
            var entity = base.AddModel(model, entityAxisValuesModelList, userMail, property);
            if (isFromModal)
            {
                return base.GetDataDropdown();
            }
            return entity;
        }
        /// <summary>
        /// ManagePicture
        /// </summary>
        /// <param name="ModelOfItem"></param>
        public void ManagePicture(ModelOfItemViewModel ModelOfItem)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(ModelOfItem.UrlPicture))
            {
                if (ModelOfItem.PictureFileInfo != null)
                {
                    ModelOfItem.UrlPicture = Path.Combine("Inventory", "ModelOfItem", ModelOfItem.Label, Guid.NewGuid().ToString());
                    CopyFiles(ModelOfItem.UrlPicture, ModelOfItem.PictureFileInfo);
                }

            }
            else
            {
                CopyFiles(ModelOfItem.UrlPicture, ModelOfItem.PictureFileInfo);
            }
            if (ModelOfItem.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }
        
        /// <summary>
        /// GetDataDropdown
        /// </summary>
        /// <returns></returns>
        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().OrderBy(x => x.Label).ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }
        public List<ModelOfItem> GetListOfModelOfItem()
        {
            return _entityRepo.GetAll().ToList();
        }
        public override object DeleteModel(int id, string tableName, string userMail)
        {
            ModelOfItemViewModel model = GetModelAsNoTracked(m => m.Id.Equals(id));
            model.UpdatedDate = DateTime.Now;
            base.UpdateModel(model, null, userMail);
            var obj = base.DeleteModel(id, tableName, userMail);
            return obj;
        }

    }
}
