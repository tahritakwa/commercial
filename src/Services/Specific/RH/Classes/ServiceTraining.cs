using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Dynamic.Core;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceTraining : Service<TrainingViewModel, Training>, IServiceTraining
    {
        private readonly IServiceUser _serviceUser;

        public ServiceTraining(IRepository<Training> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<User> entityRepoUser,
            IUnitOfWork unitOfWork,
            ITrainingBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IServiceUser serviceUser,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany) :
        base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceUser = serviceUser;
        }


        public override object AddModelWithoutTransaction(TrainingViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            ManageTrainingPictureFile(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(TrainingViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            ManageTrainingPictureFile(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// ManageTrainingPictureFile
        /// </summary>
        /// <param name="model"></param>
        private void ManageTrainingPictureFile(TrainingViewModel model)
        {
            if (string.IsNullOrEmpty(model.TrainingPictureUrl))
            {
                if (model.TrainingPictureFileInfo != null)
                {
                    model.TrainingPictureUrl = Path.Combine(RHConstant.RHTrainingPictureFileRootPath + model.Name, Guid.NewGuid().ToString());
                    CopyFiles(model.TrainingPictureUrl, model.TrainingPictureFileInfo);
                }
            }
            else
            {
                if (model.TrainingPictureFileInfo != null)
                {
                    List<FileInfoViewModel> fileInfo = new List<FileInfoViewModel>();
                    fileInfo.Add(model.TrainingPictureFileInfo);
                    DeleteFiles(model.TrainingPictureUrl, fileInfo);
                    CopyFiles(model.TrainingPictureUrl, fileInfo);
                }
            }
        }

        /// <summary>
        /// GetModelById
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override TrainingViewModel GetModelById(int id)
        {
            TrainingViewModel trainingViewModel = base.GetModelWithRelations(x => x.Id == id, y => y.TrainingExpectedSkills);
            trainingViewModel.TrainingPictureFileInfo = GetFilesContent(trainingViewModel.TrainingPictureUrl).FirstOrDefault();
            return trainingViewModel;
        }


        /// <summary>
        /// get list of trainings
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public DataSourceResult<TrainingViewModel> GetCatalog(PredicateFormatViewModel predicate)
        {
            DataSourceResult<TrainingViewModel> dataSourceResult = new DataSourceResult<TrainingViewModel>();
            predicate.Operator = Operator.And;
            PredicateFilterRelationViewModel<Training> predicateFilterRelationModel = PreparePredicate(predicate);
            IQueryable<Training> trainingQuery = _entityRepo.QuerableGetAll()
                                .Include(x => x.IdSupplierNavigation)
                                .Include(x => x.TrainingRequiredSkills).ThenInclude(x => x.IdSkillsNavigation)
                                .Include(x => x.TrainingExpectedSkills).ThenInclude(x => x.IdSkillsNavigation)
                                .Include(x => x.TrainingByEmployee).ThenInclude(x => x.IdEmployeeNavigation)
                                .Where(predicateFilterRelationModel.PredicateWhere)
                                .BuildOrderBysQue(predicate.OrderBy);
            dataSourceResult.total = trainingQuery.Count();
            trainingQuery = trainingQuery.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize);
            IList<TrainingViewModel> trainingViewModelList = trainingQuery.Select(_builder.BuildEntity).ToList();
            // Get training file content
            trainingViewModelList.ToList().ForEach((traningViewModel) =>
            {
                traningViewModel.TrainingPictureFileInfo = GetFilesContent(traningViewModel.TrainingPictureUrl).FirstOrDefault();
            });
            dataSourceResult.data = trainingViewModelList;
            return dataSourceResult;
        }

        /// <summary>
        /// GetListWithSpecificPredicat overrided  
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="predicateFilterRelationModel"></param>
        /// <returns></returns>
        public override DataSourceResult<TrainingViewModel> GetListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Training> predicateFilterRelationModel)
        {
            DataSourceResult<TrainingViewModel> trainingViewModels = base.GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            trainingViewModels.data.ToList().ForEach(x =>
            {
                if(x.TrainingPictureUrl != null)
                {
                    x.TrainingPictureFileInfo = GetFiles(x.TrainingPictureUrl).FirstOrDefault();
                }
            });
            return trainingViewModels;
        }

    }
}
