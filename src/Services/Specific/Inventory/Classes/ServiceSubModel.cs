using Microsoft.EntityFrameworkCore;
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
    public class ServiceSubModel : Service<SubModelViewModel, SubModel>, IServiceSubModel
    {

        public readonly IReducedSubModelBuilder _reducedBuilder;

        public ServiceSubModel(IRepository<SubModel> entityRepo, IUnitOfWork unitOfWork,
          ISubModelBuilder entityBuilder, IReducedSubModelBuilder reducedBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _entityRepoCompany = entityRepoCompany;
            _reducedBuilder = reducedBuilder;
        }

        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<SubModel> predicateFilterRelationModel)
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
        public override object UpdateModel(SubModelViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
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
                SubModel entity = _builder.BuildModel(model);
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
        public override object AddModel(SubModelViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            ManagePicture(model);
            model.CreationDate = DateTime.Now;
            var entity =  base.AddModel(model, entityAxisValuesModelList, userMail, property);
            if (isFromModal)
            {
                return base.GetDataDropdown();
            }
            return entity;
        }
        /// <summary>
        /// ManagePicture
        /// </summary>
        /// <param name="SubModel"></param>
        public void ManagePicture(SubModelViewModel SubModel)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(SubModel.UrlPicture))
            {
                if (SubModel.PictureFileInfo != null)
                {
                    SubModel.UrlPicture = Path.Combine("Inventory", "SubModel", SubModel.Label, Guid.NewGuid().ToString());
                    CopyFiles(SubModel.UrlPicture, SubModel.PictureFileInfo);
                }

            }
            else
            {
                CopyFiles(SubModel.UrlPicture, SubModel.PictureFileInfo);
            }
            if (SubModel.Id != 0)
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
            IList<dynamic> list = entityList.Select(x => _builder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        public DataSourceResult<SubModelViewModel> FindPriceDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<SubModel> predicateFilterRelationModel = PreparePredicate(predicateModel);
            IQueryable<SubModel> subModels = GetAllModelsQueryable().Include(x => x.IdModelNavigation)
                .Where(predicateFilterRelationModel.PredicateWhere);

            List<SubModel> subModelOfCurrentPage = subModels.Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            List<SubModelViewModel> subModelToList = new List<SubModelViewModel>();
            subModelOfCurrentPage.ForEach(element =>
            {

                subModelToList.Add(new SubModelViewModel
                {
                    Id = element.Id,
                    Code = element.Code,
                    Label = element.Label,
                    IdModel = element.IdModel,
                    Deleted_Token =element.DeletedToken,
                    UrlPicture = element.UrlPicture,
                    PictureFileInfo = GetFiles(element.UrlPicture).FirstOrDefault(),
                    ModelLabel = element.IdModelNavigation.Label
               });
            });

            return new DataSourceResult<SubModelViewModel> { data = subModelToList, total = subModels.Count() };
        }
        public override object DeleteModel(int id, string tableName, string userMail)
        {
            SubModelViewModel model = GetModelAsNoTracked(m => m.Id.Equals(id));
            model.UpdatedDate = DateTime.Now;
            base.UpdateModel(model, null, userMail);
            var obj = base.DeleteModel(id, tableName, userMail);
            return obj;
        }

    }
}
