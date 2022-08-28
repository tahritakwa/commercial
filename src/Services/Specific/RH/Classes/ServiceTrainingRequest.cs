using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Classes
{
    public class ServiceTrainingRequest : Service<TrainingRequestViewModel, TrainingRequest>, IServiceTrainingRequest
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceUser _serviceUser;
        public ServiceTrainingRequest(IRepository<TrainingRequest> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ITrainingRequestBuilder builder,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceEmployee serviceEmployee, IServiceUser serviceUser)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceUser = serviceUser;
            _serviceEmployee = serviceEmployee;
        }

        /// <summary>
        /// GetEmployeeListNotIncludedInTrainingSession
        /// </summary>
        /// <returns></returns>
        public DataSourceResult<TrainingRequestViewModel> GetEmployeeListNotIncludedInTrainingSession(List<int> idEmployeeListInTrainingSession, int idTraining)
        {
            DataSourceResult<TrainingRequestViewModel> trainingRequestForEmployeeListNotIncludedInTrainingSession = new DataSourceResult<TrainingRequestViewModel>();
            IList<TrainingRequestViewModel> listTrainingRequest = new List<TrainingRequestViewModel>();
            var employeeRequestWaintingIdList = base.GetModelsWithConditionsRelations(x => idTraining.Equals(x.IdTraining) && ((int)TrainingRequestState.Waiting).Equals(x.Status));
            employeeRequestWaintingIdList.ToList().ForEach(element =>
            {
                idEmployeeListInTrainingSession.Add(element.IdEmployeeCollaborator);
            });
            var dataSourceList = _serviceEmployee.GetModelsWithConditionsRelations(x => !idEmployeeListInTrainingSession.Contains(x.Id));
            dataSourceList.ToList().ForEach(element =>
            {
                var trainingRequest = new TrainingRequestViewModel();
                trainingRequest.IdEmployeeCollaboratorNavigation = element;
                trainingRequest.IdEmployeeCollaborator = element.Id;
                trainingRequest.ExpectedDate = DateTime.Now.Date;
                trainingRequest.CreationDate = DateTime.Now.Date;
                listTrainingRequest.Add(trainingRequest);
            });
            trainingRequestForEmployeeListNotIncludedInTrainingSession.data = listTrainingRequest;
            trainingRequestForEmployeeListNotIncludedInTrainingSession.total = listTrainingRequest.Count;
            return trainingRequestForEmployeeListNotIncludedInTrainingSession;
        }


        /// <summary>
        ///  Add training session and update the training requestList associated
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="trainingRequestList"></param>
        public void AddSelectedEmployeesToTrainingRequest(string userMail, IList<TrainingRequestViewModel> trainingRequestList)
        {
            try
            {
                BeginTransaction();
                trainingRequestList.ToList().ForEach((trainingRequest) =>
                {
                    trainingRequest.Status = (int)TrainingRequestState.Accepted;
                    trainingRequest.IdEmployeeCollaboratorNavigation = null;
                });
                base.BulkAddWithoutTransaction(trainingRequestList, userMail);
                EndTransaction();
            }
            catch (Exception e)
            {
                RollBackTransaction();
                throw e;
            }
        }

        /// <summary>
        /// Add training request to employee who hasn't an accepted one and not assigned to a session neither one in waiting 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(TrainingRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // Throw exception if the employee has a training request which state is waiting or accepted
            IList<TrainingRequestViewModel> oldTrainings = FindModelsByNoTracked(x => x.IdTraining == model.IdTraining &&
            x.IdEmployeeCollaborator == model.IdEmployeeCollaborator && (x.Status == (int)TrainingRequestState.Waiting || (x.Status == (int)TrainingRequestState.Accepted && x.IdTrainingSession == null)),
                            x => x.IdEmployeeCollaboratorNavigation).ToList();
            if (oldTrainings.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(Employee), oldTrainings.FirstOrDefault().IdEmployeeCollaboratorNavigation.FullName}
                };
                throw new CustomException(CustomStatusCode.AddTrainingRequestException, paramtrs);
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Update training request of an employee which is in waiting state
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(TrainingRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            TrainingRequestViewModel oldModel = GetModelAsNoTracked(x => x.Id == model.Id);
            // Update trainingRequest which state is wainting
            if (oldModel.Status != (int)TrainingRequestState.Waiting)
            {
                throw new CustomException(CustomStatusCode.UpdateTrainingRequestException);
            }
            // Throw exception if the employee has a training request which state is waiting or accepted
            IList<TrainingRequestViewModel> oldTrainings = FindModelsByNoTracked(x => x.Id != model.Id && x.IdTraining == model.IdTraining &&
             x.IdEmployeeCollaborator == model.IdEmployeeCollaborator && (x.Status == (int)TrainingRequestState.Waiting || (x.Status == (int)TrainingRequestState.Accepted && x.IdTrainingSession == null)),
                        x => x.IdEmployeeCollaboratorNavigation).ToList();
            if (oldTrainings.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(Employee), oldTrainings.FirstOrDefault().IdEmployeeCollaboratorNavigation.FullName}
                };
                throw new CustomException(CustomStatusCode.AddTrainingRequestException, paramtrs);
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }


        /// <summary>
        /// GetTrainingRequestListByHierarchy 
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<TrainingRequestViewModel> GetTrainingRequestListByHierarchy(string userMail, PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<TrainingRequestViewModel> trainingRequestDataSourceList = new DataSourceResult<TrainingRequestViewModel>();
            predicateModel.Operator = Operator.And;
            PredicateFilterRelationViewModel<TrainingRequest> predicateFilterRelationModel = base.PreparePredicate(predicateModel);
            UserViewModel user = _serviceUser.GetModel(x => x.Email == userMail);
            bool hasAllListTrainingPermission = RoleHelper.HasPermission(RHPermissionConstant.ALL_TRAINING_REQUEST);
            bool hasListTrainingPermission = RoleHelper.HasPermission(RHPermissionConstant.LIST_TRAININGREQUEST);

            if (hasAllListTrainingPermission && !hasListTrainingPermission)
            {
                IQueryable<TrainingRequestViewModel> dataSourceList = base.GetAllModelsQueryable(predicateFilterRelationModel.PredicateWhere,
                            x => x.IdEmployeeCollaboratorNavigation, x => x.IdTrainingNavigation).OrderByDescending(x => x.Id)
                  ;
                trainingRequestDataSourceList.total = dataSourceList.Count();
                trainingRequestDataSourceList.data = dataSourceList.Skip((predicateModel.page - 1) * predicateModel.pageSize).Take(predicateModel.pageSize).ToList();
            }
            else
            {
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                Expression<Func<TrainingRequest, bool>> expression = x => x.IdEmployeeCollaboratorNavigation != null
                && x.IdEmployeeCollaborator.Equals(connectedEmployee.Id) || (x.IdEmployeeCollaboratorNavigation.IdUpperHierarchy != null && x.IdEmployeeCollaboratorNavigation.IdUpperHierarchy.Equals(connectedEmployee.Id));
                // Combining two expressions
                ParameterExpression param = Expression.Parameter(typeof(TrainingRequest), "x");
                BinaryExpression body = Expression.AndAlso(Expression.Invoke(predicateFilterRelationModel.PredicateWhere, param),
                    Expression.Invoke(expression, param));
                predicateFilterRelationModel.PredicateWhere = Expression.Lambda<Func<TrainingRequest, bool>>(body, param);
                IQueryable<TrainingRequestViewModel> dataSourceList = base.GetAllModelsQueryable(predicateFilterRelationModel.PredicateWhere,
                          x => x.IdEmployeeCollaboratorNavigation,
                        x => x.IdTrainingNavigation).OrderByDescending(x => x.Id);
                trainingRequestDataSourceList.total = dataSourceList.ToList().Count;
                trainingRequestDataSourceList.data = dataSourceList.Skip((predicateModel.page - 1) * predicateModel.pageSize).ToList();
            }
            return trainingRequestDataSourceList;
        }

        /// <summary>
        /// GetTrainingRequestListForPanifing
        /// </summary>
        /// <param name="idTraining"></param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public DataSourceResult<TrainingRequestViewModel> GetTrainingRequestListForPanifing(int idTraining, PredicateFormatViewModel predicate)
        {
            DataSourceResult<TrainingRequestViewModel> trainingRequestDataSourceList = new DataSourceResult<TrainingRequestViewModel>();
            IQueryable<TrainingRequestViewModel> dataSourceList;
            if (predicate != null && predicate.Filter != null && predicate.Filter.Count() > NumberConstant.Zero)
            {
                dataSourceList = base.FindDataSourceModelBy(predicate).data.AsQueryable();
            }
            else
            {
                dataSourceList = base.GetAllModelsQueryable(
                        x => x.IdTraining == idTraining && !x.IdTrainingSession.HasValue && x.Status == (int)TrainingRequestState.Accepted,
                        x => x.IdEmployeeCollaboratorNavigation, x => x.IdTrainingNavigation).OrderByDescending(x => x.Id);
            }
            trainingRequestDataSourceList = getFilteredTrainingRequestList(dataSourceList, null);
            return trainingRequestDataSourceList;
        }

        /// <summary>
        /// GetTrainingRequestListInUpdateMode
        /// </summary>
        /// <param name="idTraining"></param>
        /// <param name="idTrainingSession"></param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public DataSourceResult<TrainingRequestViewModel> GetTrainingRequestListInUpdateMode(int idTraining, int idTrainingSession, PredicateFormatViewModel predicate)
        {
            DataSourceResult<TrainingRequestViewModel> trainingRequestDataSourceList = new DataSourceResult<TrainingRequestViewModel>();
            IQueryable<TrainingRequestViewModel> dataSourceList;
            if (predicate != null && predicate.Filter != null && predicate.Filter.Count() > NumberConstant.Zero)
            {
                dataSourceList = base.FindDataSourceModelBy(predicate).data.AsQueryable();
            }
            else
            {
                dataSourceList = base.GetAllModelsQueryable(
                            x => x.IdTraining == idTraining && ((x.IdTrainingSession.HasValue && x.IdTrainingSession == idTrainingSession) || !x.IdTrainingSession.HasValue) && x.Status == (int)TrainingRequestState.Accepted,
                            x => x.IdEmployeeCollaboratorNavigation, x => x.IdTrainingNavigation).OrderByDescending(x => x.Id);
            }
            trainingRequestDataSourceList = getFilteredTrainingRequestList(dataSourceList, idTrainingSession);
            return trainingRequestDataSourceList;
        }

        private DataSourceResult<TrainingRequestViewModel> getFilteredTrainingRequestList(IQueryable<TrainingRequestViewModel> dataSourceList, int? idTrainingSession)
        {
            DataSourceResult<TrainingRequestViewModel> trainingRequestDataSourceList = new DataSourceResult<TrainingRequestViewModel>();

            IEnumerable<IGrouping<int, TrainingRequestViewModel>> duplicatedTrainingRequest = dataSourceList.ToList().GroupBy(x => x.IdEmployeeCollaborator).Where(x => x.Count() > NumberConstant.One);
            IList<TrainingRequestViewModel> filteredTrainingRequest = new List<TrainingRequestViewModel>();
            if (duplicatedTrainingRequest.Any())
            {
                duplicatedTrainingRequest.ToList().ForEach((element) =>
                {
                    int? idTrainingSessionDuplicated = idTrainingSession;
                    if (idTrainingSessionDuplicated.HasValue)
                    {
                        idTrainingSessionDuplicated = element.Max(x => x.IdTrainingSession);
                    }
                    filteredTrainingRequest.Add(element.Where(x => x.IdTrainingSession == idTrainingSessionDuplicated).FirstOrDefault());
                });
                IList<TrainingRequestViewModel> filteredDataSourceList = new List<TrainingRequestViewModel>();
                filteredDataSourceList = dataSourceList.Where(x => !filteredTrainingRequest.Select(y => y.IdEmployeeCollaborator).Contains(x.IdEmployeeCollaborator)).ToList();
                filteredTrainingRequest.ToList().ForEach((element) =>
                {
                    filteredDataSourceList.Add(element);
                });

                trainingRequestDataSourceList.total = filteredDataSourceList.Count();
                trainingRequestDataSourceList.data = filteredDataSourceList.ToList();
            }
            else
            {
                trainingRequestDataSourceList.total = dataSourceList.Count();
                trainingRequestDataSourceList.data = dataSourceList.ToList();
            }

            return trainingRequestDataSourceList;
        }

    }
}
