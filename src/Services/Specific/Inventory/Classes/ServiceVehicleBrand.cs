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
    public class ServiceVehicleBrand : Service<VehicleBrandViewModel, VehicleBrand>, IServiceVehicleBrand
    {
        private readonly IVehicleBrandBuilder _builderVehicleBrand; 
        public ServiceVehicleBrand(IRepository<VehicleBrand> entityRepo, IUnitOfWork unitOfWork,
          IVehicleBrandBuilder entityBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues,
          IOptions<AppSettings> appSettings,
          IRepository<Company> entityRepoCompany, IVehicleBrandBuilder builderVehicleBrand)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _entityRepoCompany = entityRepoCompany;
            _builderVehicleBrand = builderVehicleBrand;
        }
        /// <summary>
        /// UpdateModel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="EntityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public override object UpdateModel(VehicleBrandViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
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
                VehicleBrand entity = _builder.BuildModel(model);
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
        public override object AddModel(VehicleBrandViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
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
        /// <param name="VehicleBrand"></param>
        public void ManagePicture(VehicleBrandViewModel VehicleBrand)
        {  
            if (string.IsNullOrEmpty(VehicleBrand.UrlPicture))
            {
                if (VehicleBrand.PictureFileInfo != null)
                {
                    VehicleBrand.UrlPicture = Path.Combine("Inventory", "VehicleBrand", VehicleBrand.Label, Guid.NewGuid().ToString());
                    CopyFiles(VehicleBrand.UrlPicture, VehicleBrand.PictureFileInfo);
                }

            }
            else
            {
                CopyFiles(VehicleBrand.UrlPicture, VehicleBrand.PictureFileInfo);
            }
            if (VehicleBrand.Id != 0)
            {
                _unitOfWork.Commit();
            }
        }
        
       
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<VehicleBrand> predicateFilterRelationModel)
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

            IList<dynamic> model = entities.Select(x => _builderVehicleBrand.BuildReducedVehicleBrandEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }
        public override object DeleteModel(int id, string tableName, string userMail)
        {
            VehicleBrandViewModel model = GetModelAsNoTracked(m => m.Id.Equals(id));
            model.UpdatedDate = DateTime.Now;
            base.UpdateModel(model, null, userMail);
            var obj = base.DeleteModel(id, tableName, userMail);
            return obj;
        }
        public List<VehicleBrandViewModel> AddTecDocMissingVehicleBrands(List<string> brands, string userMail)
        {
            var savedBrands = GetAllModelsAsNoTracking().Select(x => x.Label.ToUpper());
            var BrandsToSave = brands.Select(x => x.ToUpper()).Except(savedBrands).Select(x => new VehicleBrandViewModel
            {
                Code = x,
                Label = x
            }).ToList();
            BulkAdd(BrandsToSave, userMail);
            return
                GetModelsWithConditionsRelations(x => brands.Select(y => y.ToUpper()).Contains(x.Label)).ToList();
        }


    }
}
