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
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Utils;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceFamily : Service<FamilyViewModel, Family>, IServiceFamily
    {
        public readonly IReducedFamilyBuilder _reducedBuilder;
        public ServiceFamily(IRepository<Family> entityRepo, 
            IUnitOfWork unitOfWork,
          IFamilyBuilder entityBuilder,
          IReducedFamilyBuilder reducedBuilder,
          IEntityAxisValuesBuilder builderEntityAxisValues,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany )
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _entityRepoCompany = entityRepoCompany;
            _reducedBuilder = reducedBuilder;

        }

        /// <summary>
        /// UpdateModel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="EntityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        public override object UpdateModel(FamilyViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail)
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
                Family entity = _builder.BuildModel(model);
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
        public override object AddModel(FamilyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
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
        /// <param name="family"></param>
        public void ManagePicture(FamilyViewModel family)
        {  //Mange Observations Files
            if (string.IsNullOrEmpty(family.UrlPicture))
            {
                if (family.PictureFileInfo != null)
                {
                    family.UrlPicture = Path.Combine("Inventory", "Family", family.Label, Guid.NewGuid().ToString());
                    CopyFiles(family.UrlPicture, family.PictureFileInfo);
                }

            }
            else
            {
                if(family.PictureFileInfo != null)
                {
                        List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                        fileInfo.Add(family.PictureFileInfo);
                        DeleteFiles(family.UrlPicture, fileInfo);
                        CopyFiles(family.UrlPicture, fileInfo); 
                }
            }
            if (family.Id != 0)
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
        public override object DeleteModel(int id, string tableName, string userMail)
        {
            FamilyViewModel model = GetModelAsNoTracked(m => m.Id.Equals(id));
            model.UpdatedDate = DateTime.Now;
            base.UpdateModel(model, null, userMail);
            var obj = base.DeleteModel(id, tableName, userMail);
            return obj;
        }

    }
}
