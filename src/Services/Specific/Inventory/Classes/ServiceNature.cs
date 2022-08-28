using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceNature : Service<NatureViewModel, Nature>, IServiceNature
    {

        public readonly IReducedNatureBuilder _reducedBuilder;
        public readonly INatureBuilder _entityBuilder;

        public ServiceNature(IRepository<Nature> entityRepo,
            IUnitOfWork unitOfWork,
          INatureBuilder entityBuilder,
          IEntityAxisValuesBuilder builderEntityAxisValues,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany,
          IReducedNatureBuilder reducedBuilder,
          IMemoryCache memoryCache)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _reducedBuilder = reducedBuilder;
            _entityBuilder = entityBuilder;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().OrderBy(x => x.Code).ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }
        /// <summary>
        /// UpdateModel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="EntityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        public override object UpdateModel(NatureViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
        {
            CheckUpdateModel(model);
            try
            {
                // begin transaction
                BeginTransaction();
                //update with files pictures 
                if (model.PictureFileInfo != null)
                {
                    ManagePicture(model);
                }
                // save entity traceability
                Nature entity = _builder.BuildModel(model);
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
        public override object AddModel(NatureViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            ManagePicture(model);
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
        /// <param name="nature"></param>
        public void ManagePicture(NatureViewModel nature)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(nature.UrlPicture))
            {
                if (nature.PictureFileInfo != null)
                {
                    nature.UrlPicture = Path.Combine("Inventory", "Nature", nature.Label, Guid.NewGuid().ToString());
                    CopyFiles(nature.UrlPicture, nature.PictureFileInfo);
                }

            }
            else
            {
                CopyFiles(nature.UrlPicture, nature.PictureFileInfo);
            }
            if (nature.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }
        public void CheckUpdateModel(NatureViewModel model)
        {
            NatureViewModel oldModel = GetModelAsNoTracked(x=> x.Id == model.Id, x => x.Item);
            if ((oldModel.IsStockManaged != model.IsStockManaged || oldModel.Code != model.Code) &&
                (oldModel.Code == Constants.EXPENSE || oldModel.Code == Constants.RESTAURN || oldModel.Code == Constants.SERVICE || oldModel.Code == Constants.PRODUIT || (oldModel.Item != null && oldModel.Item.Any())))
            {
                throw new CustomException(CustomStatusCode.CannotChangeStockManagedFromProductType);
            }

        }

        public override object DeleteModel(int id, string tableName, string userMail)
        {
            NatureViewModel nature = base.GetModelById(id);
            if(nature.Code == Constants.PRODUIT || nature.Code == Constants.EXPENSE || nature.Code == Constants.RESTAURN || nature.Code == Constants.SERVICE)
            {
                throw new CustomException(CustomStatusCode.DeleteError);
            }
            var obj = base.DeleteModel(id, tableName, userMail);
            return obj;
        }
        public override DataSourceResult<NatureViewModel> GetDataWithSpecificFilterRelation(PredicateFormatViewModel predicateModel, IQueryable<Nature> entities, PredicateFilterRelationViewModel<Nature> predicateFilterRelationModel)
        {
            entities = GetEntitiesDataWithSpecificFilterRelation(predicateModel, entities, predicateFilterRelationModel);
            var total = entities.Count();
            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = entities.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize);
            }
            List<Nature> listOfModel = entities.Where(x=> x.Code != "Remise" && x.Label != "Remise").ToList();
            List<NatureViewModel> model = listOfModel.Select(_entityBuilder.BuildEntity).ToList();

            return new DataSourceResult<NatureViewModel> { data = model, total = total };
        }
    } 
}
