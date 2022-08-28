using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Shared.Classes
{
    public class ServiceGeneralSettings : Service<GeneralSettingsViewModel, GeneralSettings>, IServiceGeneralSettings
    {
        public ServiceGeneralSettings(IRepository<GeneralSettings> entityRepo, IUnitOfWork unitOfWork,
            IGeneralSettingsBuilder generalSettingsBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, generalSettingsBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        /// <summary>
        /// get the settings of review manager
        /// </summary>
        /// <returns>settings of reviex manager</returns>
        public List<GeneralSettingsViewModel> GetReviewManagerSettings()
        {
            List<GeneralSettingsViewModel> allSettings = GetModelsWithConditionsRelations(
                x => x.Keys.Equals(GeneralSettingsConstant.REVIEW_MANAGER_SETTING)).ToList();
            // if value does not exist replace by default values
            return allSettings;
        }


        public object updateReviewManagerSettings(List<GeneralSettingsViewModel> models, string userMail)
        {
            try
            {
                BeginTransaction();
                if (models.Where(x => x.Field != Constants.SUPERIOR_LEVEL).GroupBy(x => x.Value).Where(x => x.Count() > NumberConstant.One).Any())
                {
                    throw new CustomException(CustomStatusCode.DuplicatedAnnualReviewManagerPriority);
                }
                base.BulkUpdateModelWithoutTransaction(models, userMail);
                EndTransaction();
                var entity = _builder.BuildModel(models.FirstOrDefault());
                return new CreatedDataViewModel { Id = 0, EntityName = entity.GetType().Name.ToUpper() };
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
