using Infrastruture.Utility;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Classes.ServiceReview
{
    public partial class ServiceReview : Service<ReviewViewModel, Review>, IServiceReview
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceObjective _serviceObjective;
        private readonly IServiceReviewFormation _serviceReviewFormation;
        private readonly IServiceReviewSkills _serviceReviewSkills;
        private readonly IServiceQuestion _serviceQuestion;
        private readonly IRepository<User> _userEntityRepo;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceJobsParameters _serviceJobsParameters;
        private readonly IServiceGeneralSettings _serviceGeneralSettings;
        private readonly IRepository<EmployeeTeam> _employeeTeamEntityRepo;
        private readonly IRepository<InterviewMark> _interviewMarkRepo;
        private readonly IRepository<Interview> _interviewRepo;
        private readonly IRepository<Employee> _employeeRepo;

        public ServiceReview(IRepository<Review> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IUnitOfWork unitOfWork,
           IReviewBuilder builder,
           IEntityAxisValuesBuilder builderEntityAxisValues,
           IServiceEmployee serviceEmployee,
           IServiceObjective serviceObjective,
           IServiceReviewFormation serviceReviewFormation,
           IServiceReviewSkills serviceReviewSkills,
           IServiceQuestion serviceQuestion,
           IRepository<User> userEntityRepo,
           IServiceMsgNotification serviceMessageNotification,
           IServiceEmail serviceEmail,
           IServiceJobsParameters serviceJobsParameter,
           IServiceGeneralSettings serviceGeneralSettings,
           IRepository<EmployeeTeam> employeeTeamEntityRepo,
           IRepository<InterviewMark> interviewMarkRepo,
           IRepository<Interview> interviewRepo,
           IRepository<Employee> employeeRepo):
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceEmployee = serviceEmployee;
            _serviceObjective = serviceObjective;
            _serviceReviewFormation = serviceReviewFormation;
            _serviceReviewSkills = serviceReviewSkills;
            _serviceQuestion = serviceQuestion;
            _userEntityRepo = userEntityRepo;
            _serviceMessageNotification = serviceMessageNotification;
            _serviceEmail = serviceEmail;
            _serviceJobsParameters = serviceJobsParameter;
            _serviceGeneralSettings = serviceGeneralSettings;
            _employeeTeamEntityRepo = employeeTeamEntityRepo;
            _interviewMarkRepo = interviewMarkRepo;
            _interviewRepo = interviewRepo;
            _employeeRepo = employeeRepo;
        }

        #region overrided methods
        public override object AddModel(ReviewViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            int idManager = GenerateManagerForReview(model.IdEmployeeCollaborator);
            if (idManager > NumberConstant.Zero)
            {
                model.IdManager = idManager;
            }
            model.FormManager = (int)FormValidationState.New;
            model.FormEmployee = (int)FormValidationState.New;
            return base.AddModel(model, entityAxisValuesModelList, userMail, property);
        }

        public override DataSourceResult<ReviewViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<ReviewViewModel> reviewDataSourceList = new DataSourceResult<ReviewViewModel>();
            PredicateFilterRelationViewModel<Review> predicateFilterRelationModel = PreparePredicate(predicateModel);
            Expression<Func<Review, bool>> additionalPredicate = x => true;
            List<ReviewViewModel> fakeReviewList = new List<ReviewViewModel>();
            List<ReviewViewModel> participatedInReviews = new List<ReviewViewModel>();

            string currentUserEmail = ActiveAccountHelper.GetConnectedUserEmail();
            bool hasAllListPermission = RoleHelper.HasPermission(RHPermissionConstant.ALL_ANNUAL_REVIEW);
            bool hasListPermission = RoleHelper.HasPermission(RHPermissionConstant.LIST_ANNUALINTERVIEW);
            if (hasListPermission && !hasAllListPermission)
            {
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee();
                IList<int> superiorAndTeamCollaborator = _serviceEmployee.GetHierarchicalEmployeesList(currentUserEmail, false, true).Select(x => x.Id).ToList();
                // is current employee or inferior hierarchy
                additionalPredicate = x => (x.IdEmployeeCollaborator == connectedEmployee.Id ||
                superiorAndTeamCollaborator.Contains(x.IdEmployeeCollaborator) ||
                x.IdManager.Value == connectedEmployee.Id);
                fakeReviewList = GenerateFakeReview(predicateModel).Where(c=> superiorAndTeamCollaborator.Contains(c.IdEmployeeCollaborator)).ToList();
                participatedInReviews = ParticipatedInReviewList(); // is part of interview as an interviewer
            }
            else
            {
                fakeReviewList = GenerateFakeReview(predicateModel);
            }
            IQueryable<Review> dataSourceList = _entityRepo.GetAllWithConditionsRelationsQueryable(predicateFilterRelationModel.PredicateWhere, predicateFilterRelationModel.PredicateRelations)
                            .Where(additionalPredicate);

            // adding non duplicated element to List

            List<ReviewViewModel> realList = dataSourceList.Select(x => _builder.BuildEntity(x)).ToList();
            realList.AddRange(participatedInReviews);
            realList =  realList.GroupBy(x => x.Id).Select(x => x.First()).ToList();

            realList.AddRange(fakeReviewList);
            int pageNumber = predicateModel.page;
            int pageSize = predicateModel.pageSize;
            int startIndex = (pageNumber - NumberConstant.One) * pageSize;
            List<ReviewViewModel> paginatedList = realList.Skip(startIndex).Take(pageSize).ToList();

            reviewDataSourceList.total = realList.Count;
            reviewDataSourceList.data = paginatedList;

            return reviewDataSourceList;
        }
        #endregion

        #region fake review methods

        /// <summary>
        /// generate list of fake reviews depending on predicate information
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        private List<ReviewViewModel> GenerateFakeReview(PredicateFormatViewModel predicateModel)
        {

            List<ReviewViewModel> fakeReviewList = new List<ReviewViewModel>();
            //check if need to generate fake review list
            int reviewState = GetReviewStateFromPredicate(predicateModel);
            bool isGenerated = ((reviewState != (int)ReviewStateEnumerator.ToPlan) &&
                                (reviewState != (int)ReviewStateEnumerator.InProgress) &&
                                (reviewState != (int)ReviewStateEnumerator.Completed));
            // check if employee filter is active
            int idSelectedEmployee = GetIdEmployeeFromPredicate(predicateModel);
            // get limits from predicate
            DateTime startDate = GetStartDateFromPredicate(predicateModel);
            DateTime endDate = GetEndDateFromPredicate(predicateModel);
            if (isGenerated)
            {
                if (idSelectedEmployee == NumberConstant.Zero)
                {
                    List<EmployeeViewModel> targetEmployees = _serviceEmployee.GetModelsWithConditionsRelations(x => ReviewDateInRange(predicateModel, x.HiringDate),
                        x => x.ReviewIdEmployeeCollaboratorNavigation).ToList();
                    foreach (EmployeeViewModel employee in targetEmployees)
                    {
                        fakeReviewList.AddRange(GenerateEmployeeFakeReview(employee, startDate, endDate));
                    }

                }
                else
                { // for selected employee filter
                    EmployeeViewModel employee = _serviceEmployee.GetModelsWithConditionsRelations(x => x.Id == idSelectedEmployee,
                        x => x.ReviewIdEmployeeCollaboratorNavigation).FirstOrDefault();
                    if (employee != null)
                    {
                        fakeReviewList.AddRange(GenerateEmployeeFakeReview(employee, startDate, endDate));
                    }
                }
            }

            return fakeReviewList;
        }

        /// <summary>
        /// create a fake review for a selected employee 
        /// at a specific date
        /// </summary>
        /// <param name="employee"></param>
        /// <param name="reviewDate"></param>
        /// <returns></returns>
        ReviewViewModel GenerateFakeReviewModel(EmployeeViewModel employee, DateTime reviewDate)
        {
            return new ReviewViewModel()
            {
                IdEmployeeCollaborator = employee.Id,
                IdEmployeeCollaboratorNavigation = employee,
                ReviewDate = reviewDate,
                State = (int)ReviewStateEnumerator.NotPlanned
            };
        }

        List<ReviewViewModel> GenerateEmployeeFakeReview(EmployeeViewModel employee, DateTime startDate, DateTime endDate)
        {
            // get current reviews
            List<DateTime> currentReviewDates = GetAllModelsQueryable(x => x.IdEmployeeCollaborator == employee.Id).Select(x => x.ReviewDate.Date).ToList();
            List<ReviewViewModel> fakeReviewList = new List<ReviewViewModel>();
            DateTime currentDate = employee.HiringDate.AddYears(NumberConstant.One);
            while (currentDate.BeforeDateLimitIncluded(endDate) && (!employee.ResignationDate.HasValue 
                || (employee.ResignationDate.HasValue && currentDate.BeforeDateLimitIncluded(employee.ResignationDate.Value))))
            {
                if (currentDate.AfterDateLimitIncluded(startDate) && !currentReviewDates.Contains(currentDate))
                {
                    fakeReviewList.Add(GenerateFakeReviewModel(employee, currentDate));
                }
                currentDate = currentDate.AddYears(NumberConstant.One);
            }
            return fakeReviewList;
        }

        #endregion

        #region review formation methods
        /// <summary>
        /// Method call to add or update the array of different model which are in the review form
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void AddReviewForm(ReviewFormViewModel model, string userMail)
        {   
            try
            {
                VerifyReviewEditRight(model.Review.Id);

                BeginTransaction();

                model = UpdateReviewState(model);

                UpdateModelWithoutTransaction(model.Review, null, userMail);
          
                UpdateReviewObjective(model, userMail);

                UpdateReviewFormation(model, userMail);

                UpdateReviewSkills(model, userMail);

                UpdateReviewQuestion(model);

                _unitOfWork.Commit();

                EndTransaction();
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }

        }

        /// <summary>
        /// Close review
        /// </summary>
        /// <param name="review"></param>
        public void CloseReview(ReviewFormViewModel review)
        {
            if (!review.Interview.Any(x => x.Status == (int)InterviewEnumerator.InterviewDone
                || x.Status == (int)InterviewEnumerator.InterviewConfirmedByCandidate))
            {
                throw new CustomException(CustomStatusCode.CannotCloseReviewWithoutConfirmedInterview);
            }
            review.Review.State = (int)ReviewStateEnumerator.Completed;
            AddReviewForm(review, ActiveAccountHelper.GetConnectedUserEmail());
        }

        private ReviewFormViewModel UpdateReviewState(ReviewFormViewModel model)
        {
            // change review state
            if (model.Review.State == (int)ReviewStateEnumerator.ToPlan)
            {
                model.Review.State = (int)ReviewStateEnumerator.InProgress;
            }
            // Set form employee value
            model.Review.FormEmployee = (!model.PastObjective.Any() || model.PastObjective.All(x => x.ObjectiveCollaboratorStatus.HasValue))
                && (!model.PastReviewFormation.Any() || model.PastReviewFormation.All(x => x.FormationCollaboratorStatus.HasValue))
                && (!model.FutureReviewSkills.Any() || model.FutureReviewSkills.All(x => x.CollaboratorMark.HasValue)) ? (int)FormValidationState.Done :
                model.PastObjective.Any(x => x.ObjectiveCollaboratorStatus.HasValue)
                    || model.PastReviewFormation.Any(x => x.FormationCollaboratorStatus.HasValue) || model.FutureReviewSkills.Any(x => x.CollaboratorMark.HasValue)
                    ? (int)FormValidationState.Partial : (int)FormValidationState.New;
            // Set form manager value
            model.Review.FormManager = (!model.PastObjective.Any() || model.PastObjective.All(x => x.ObjectiveManagerStatus.HasValue))
              && (!model.PastReviewFormation.Any() || model.PastReviewFormation.All(x => x.FormationManagerStatus.HasValue))
              && (!model.FutureReviewSkills.Any() || model.FutureReviewSkills.All(x => x.ManagerMark.HasValue)) ? (int)FormValidationState.Done :
              model.PastObjective.Any(x => x.ObjectiveManagerStatus.HasValue)
                  || model.PastReviewFormation.Any(x => x.FormationManagerStatus.HasValue) || model.FutureReviewSkills.Any(x => x.ManagerMark.HasValue)
                  ? (int)FormValidationState.Partial : (int)FormValidationState.New;
            // Check if review state is completed and forms states aren't done
            if (model.Review.State == (int)ReviewStateEnumerator.Completed
                && (model.Review.FormManager != (int)FormValidationState.Done || model.Review.FormEmployee != (int)FormValidationState.Done))
            {
                throw new CustomException(CustomStatusCode.CannotCloseReviewWithoutDoneFormOfCollaboratorAndManager);
            }
            return model;
        }

        private void UpdateReviewFormation(ReviewFormViewModel model, string userMail)
        {
            // Get the pastReviewFormation
            List<ReviewFormationViewModel> pastReviewFormation = model.PastReviewFormation.ToList();
            List<ReviewFormationViewModel> futureReviewFormationToUpdate = model.FutureReviewFormation.Where(x => x.Id != NumberConstant.Zero).ToList();
            List<ReviewFormationViewModel> futureReviewFormationToAdd = model.FutureReviewFormation.Where(x => x.Id == NumberConstant.Zero).ToList();

            // date constraint
            if (model.FutureReviewFormation.Any(formation => formation.Date.Value.Date.BeforeDate(model.Review.ReviewDate)))
            {
                throw new CustomException(CustomStatusCode.InvalidFormationExpectedDate);
            }

            // update formation
            futureReviewFormationToUpdate.AddRange(pastReviewFormation);
            if (futureReviewFormationToUpdate.Any())
            {
                _serviceReviewFormation.BulkUpdateModelWithoutTransaction(futureReviewFormationToUpdate, userMail);
            }

            // add formation 
            if (futureReviewFormationToAdd.Any())
            {           
                _serviceReviewFormation.BulkAddWithoutTransaction(futureReviewFormationToAdd.ToList(), userMail);
            }
        }

        private void UpdateReviewObjective(ReviewFormViewModel model, string userMail)
        {
            // Get the pastObjective and future objective to update
            List<ObjectiveViewModel> pastObjective = model.PastObjective.ToList();
            List<ObjectiveViewModel> futureObjectiveToUpdate = model.FutureObjective.Where(x => x.Id != NumberConstant.Zero).ToList();
            List<ObjectiveViewModel> futureObjectiveToAdd = model.FutureObjective.Where(x => x.Id == NumberConstant.Zero).ToList();

            // date constraint
            if (model.FutureObjective.Any(objective => objective.ExpectedDate.Date.BeforeDate(model.Review.ReviewDate)))
            {
                throw new CustomException(CustomStatusCode.InvalidObjectifExpectedDate);
            }

            // update objective models
            futureObjectiveToUpdate.AddRange(pastObjective);
            if (futureObjectiveToUpdate.Any())
            {
                _serviceObjective.BulkUpdateModelWithoutTransaction(futureObjectiveToUpdate, userMail);
            }
            
            // add objective models
            if (futureObjectiveToAdd.Any())
            {
                _serviceObjective.BulkAddWithoutTransaction(futureObjectiveToAdd, userMail);
            }
        }

        private void UpdateReviewSkills(ReviewFormViewModel model, string userMail)
        {
            // Get the pastReviewSkills, get only the employeeSkills which were modified
            List<ReviewSkillsViewModel> pastReviewSkills = model.PastReviewSkills.Where(x => x.IsOld == true && (x.CollaboratorMark != null || x.ManagerMark != null)).ToList();
            if (pastReviewSkills.Count > NumberConstant.Zero)
            {
                _serviceReviewSkills.BulkAddWithoutTransaction(pastReviewSkills, ActiveAccountHelper.GetConnectedUserEmail());
            }
            // Get the futureReviewSkills to add
            List<ReviewSkillsViewModel> futureReviewSKillsToAdd = model.FutureReviewSkills.Where(x => x.Id == NumberConstant.Zero).ToList();
            if (futureReviewSKillsToAdd.Count > NumberConstant.Zero)
            {
                _serviceReviewSkills.BulkAddWithoutTransaction(futureReviewSKillsToAdd, userMail);
            }
            // Get the futureReviewSkills which are in the update mode
            List<ReviewSkillsViewModel> futureReviewSKillsToUpdate = model.FutureReviewSkills.Where(x => x.Id != NumberConstant.Zero).ToList();
            if (futureReviewSKillsToUpdate.Count > NumberConstant.Zero)
            {
                _serviceReviewSkills.BulkUpdateModelWithoutTransaction(futureReviewSKillsToUpdate, userMail);
            }
        }

        private void UpdateReviewQuestion(ReviewFormViewModel model)
        {
            // Get interviews with questions
            if (model.Interview.Count > NumberConstant.Zero)
            {
                var interviewsWithQuestions = model.Interview.Where(x => x.Question.Count > NumberConstant.Zero).ToList();
                interviewsWithQuestions.ToList().ForEach(interview =>
                {
                    // Fetch new questions and add them to corresponding interview
                    List<QuestionViewModel> questionToAdd = interview.Question.Where(x => x.Id == NumberConstant.Zero).ToList();
                    if (questionToAdd.Count > NumberConstant.Zero)
                    {
                        questionToAdd = questionToAdd.Select(x => { x.IdInterview = interview.Id; return x; }).ToList();
                    }
                    List<QuestionViewModel> questionToUpdate = interview.Question.Where(x => x.Id != NumberConstant.Zero).ToList();
                    questionToUpdate.AddRange(questionToAdd);
                    // Update old and new questions
                    if (questionToUpdate.Count > NumberConstant.Zero)
                    {
                        _serviceQuestion.BulkUpdateModelWithoutTransaction(questionToUpdate, ActiveAccountHelper.GetConnectedUserEmail());
                    }
                });
            }
        }

        /// <summary>
        /// GetPastObjectiveList
        /// </summary>
        /// <param name="review"></param>
        /// <returns></returns>
        public DataSourceResult<ObjectiveViewModel> GetPastObjectiveList(int idReview)
        {
            // Get the current review
            ReviewViewModel currentReview = GetModelAsNoTracked(x => x.Id == idReview);
            DataSourceResult<ObjectiveViewModel> dataSourceResult = new DataSourceResult<ObjectiveViewModel>();
            if (currentReview != null)
            {
                // Get last review of the employee based on date
                ReviewViewModel pastReview = FindModelsByNoTracked(
                                x => x.Id != idReview &&
                                x.ReviewDate < currentReview.ReviewDate &&
                                x.IdEmployeeCollaborator == currentReview.IdEmployeeCollaborator
                            ).OrderByDescending(x => x.ReviewDate).FirstOrDefault();
                // Get the list objectives of the pastReview
                if (pastReview != null)
                {
                    var queryableList = _serviceObjective.GetAllModelsQueryable(x => x.IdReview == pastReview.Id);
                    dataSourceResult.total = queryableList.Count();
                    dataSourceResult.data = queryableList.ToList();
                }
            }
            return dataSourceResult;
        }

        /// <summary>
        /// Get past reviewFormation list
        /// </summary>
        /// <param name="idReview"></param>
        /// <returns></returns>
        public DataSourceResult<ReviewFormationViewModel> GetPastReviewFormationList(int idReview)
        {
            ReviewViewModel currentReview = GetModelAsNoTracked(x => x.Id == idReview);
            DataSourceResult<ReviewFormationViewModel> dataSourceResult = new DataSourceResult<ReviewFormationViewModel>();
            if (currentReview != null)
            {
                ReviewViewModel pastReview = FindModelsByNoTracked(
                    elem => elem.Id != currentReview.Id &&
                    elem.ReviewDate < currentReview.ReviewDate &&
                    elem.IdEmployeeCollaborator == currentReview.IdEmployeeCollaborator).OrderByDescending(x => x.ReviewDate).FirstOrDefault();
                if (pastReview != null)
                {
                    var queryableList = _serviceReviewFormation.GetAllModelsQueryable(x => x.IdReview == pastReview.Id,
                        x => x.IdFormationNavigation,
                        x => x.IdFormationNavigation.IdFormationTypeNavigation);
                    dataSourceResult.total = queryableList.Count();
                    dataSourceResult.data = queryableList.ToList();
                }
            }
            return dataSourceResult;
        }
        #endregion

        #region review manager

        /// <summary>
        /// Interviewer Id List for a selected interview
        /// </summary>
        /// <param name="idInterview"></param>
        /// <returns></returns>
        private List<ReviewViewModel> ParticipatedInReviewList()
        {
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee();
            // list of all interviewMark connected to the interview
            Expression<Func<InterviewMark, bool>> condition = (x =>
            x.IdEmployee == connectedEmployee.Id && // interview mark of connected employee
            x.IdInterviewNavigation.IdReview != null); // interview mark of review
            Expression<Func<InterviewMark, object>> relation = (x => x.IdInterviewNavigation);
            IEnumerable<InterviewMark> interviewMarkList = _interviewMarkRepo.GetAllWithConditionsRelations(condition, relation);
            // getting interviews
            List<int> interviewIdList = new List<int>();
            List<Interview> interviews = new List<Interview>();
            interviewMarkList.ToList().ForEach(x => interviewIdList.Add(x.IdInterview));
            interviewIdList = interviewIdList.Distinct().ToList(); // remove duplicated ids
            interviews = _interviewRepo.GetAllWithConditions(x => interviewIdList.Contains(x.Id) || x.IdSupervisor == connectedEmployee.Id).ToList();
            //getting reviews
            List<int> reviewIdList = new List<int>();
            List<Review> reviews = new List<Review>();
            interviews.ForEach(x => {if (x.IdReview.HasValue) {reviewIdList.Add(x.IdReview.Value);}});
            reviewIdList = reviewIdList.Distinct().ToList();
            reviews = _entityRepo.GetAllWithConditionsRelations(x => reviewIdList.Contains(x.Id), x => x.IdEmployeeCollaboratorNavigation).ToList();
            //adding interviews to reviews as navigations
            reviews.ForEach(x => interviews.
                     ForEach(y =>
                     {
                         if (y.IdReview == x.Id)
                         {
                             x.Interview.Add(y);
                         }
                     })
                   );
            return reviews.Select(x => _builder.BuildEntity(x)).ToList();
        }
        #endregion

        #region custom methods
        /// <summary>
        /// GetReviewWithHisNavigations
        /// </summary>
        /// <param name="idReview"></param>
        /// <returns></returns>
        public ReviewViewModel GetReviewWithHisNavigations(int idReview)
        {
            return GetModelWithRelations(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation, x => x.IdEmployeeCollaboratorNavigation.JobEmployee);
        }

        /// <summary>
        /// verify review manager settings 
        /// and generate manager Id
        /// </summary>
        /// <param name="idEmployee"></param>
        ///<returns>id of manager</returns>
        private int GenerateManagerForReview(int idEmployee)
        {
            // get settings values
            List<GeneralSettingsViewModel> reviewGeneralSettings = _serviceGeneralSettings.GetReviewManagerSettings();
            int idManager = NumberConstant.Zero;
            if (reviewGeneralSettings.Count > NumberConstant.Zero)
            {
                int administrationPriorityValue = int.Parse(reviewGeneralSettings.Find(x => x.Field == GeneralSettingsConstant.ADMINISTRATION_PRIORITY).Value);
                int superiorPriorityValue = int.Parse(reviewGeneralSettings.Find(x => x.Field == GeneralSettingsConstant.SUPERIOR_PRIORITY).Value);
                int teamManagerPriorityValue = int.Parse(reviewGeneralSettings.Find(x => x.Field == GeneralSettingsConstant.TEAM_MANAGER_PRIORITY).Value);
                int superiorLevelPriorityValue = int.Parse(reviewGeneralSettings.Find(x => x.Field == GeneralSettingsConstant.SUPERIOR_Level).Value);
                // set values
                EmployeeViewModel employee = _serviceEmployee.GetModelById(idEmployee);
                if (superiorPriorityValue <= teamManagerPriorityValue)
                {
                    int idSuperior = _serviceEmployee.IdSuperiorOfEmployeeByLevel(superiorLevelPriorityValue, employee.HierarchyLevel);
                    idManager = idSuperior;
                }
                if ((teamManagerPriorityValue <= superiorPriorityValue) && idManager == NumberConstant.Zero)
                {
                    int idTeamManager = GetEmployeeTeamManagerWithHighestAssignmentPercentage(employee);
                    idManager = idTeamManager;
                }
                else
                {
                    idManager = NumberConstant.Zero;
                }
                if (idManager == NumberConstant.Zero)
                {
                    int idSuperior = _serviceEmployee.IdSuperiorOfEmployeeByLevel(superiorLevelPriorityValue, employee.HierarchyLevel);
                    idManager = idSuperior != NumberConstant.MinusOne ? idSuperior : NumberConstant.Zero;
                }
            }
            return idManager;
        }

        /// <summary>
        /// return the team id of the employee worked in the most during 
        /// the reviewed period
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        private int GetEmployeeTeamManagerWithHighestAssignmentPercentage(EmployeeViewModel employee)
        {
            // used variables
            Dictionary<int, double> idTeamWithPercentages = new Dictionary<int, double>();
            DateTime lastReviewDate = LastAnnualReviewDate(employee);
            DateTime nextReviewDate = NextAnnualReviewDate(employee.HiringDate);
            // all assigned teams
            List<EmployeeTeam> employeeTeams = _employeeTeamEntityRepo.GetAllWithConditionsRelations(x => x.IdEmployee == employee.Id, x => x.IdTeamNavigation).ToList();
            if (employeeTeams.Any())
            {
                // filtring by date
                foreach (EmployeeTeam employeeTeam in employeeTeams)
                {
                    if (IsTeamAssignmentPartOfThisReview(employeeTeam, lastReviewDate))
                    {
                        double workPercentage = WorkPercentageByTeamAssignmentSinceLastReview(employeeTeam, lastReviewDate);
                        if (!idTeamWithPercentages.ContainsKey(employeeTeam.IdTeamNavigation.IdManager))
                        {
                            // if the team id is not in dictionary
                            // add to dictionary
                            idTeamWithPercentages.Add(employeeTeam.IdTeamNavigation.IdManager, workPercentage);
                        }
                        else
                        {
                            // if employee is not in superior list
                            idTeamWithPercentages[employeeTeam.IdTeamNavigation.IdManager] += workPercentage;
                        }
                    }
                }
                return idTeamWithPercentages.Aggregate((inLoop, result) => inLoop.Value > result.Value ? inLoop : result).Key;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// determine if the recieved employee team assignment is 
        /// included in this review
        /// </summary>
        /// <param name="employeeTeam"></param>
        /// <param name="lastReviewDate"></param>
        /// <returns></returns>
        private bool IsTeamAssignmentPartOfThisReview(EmployeeTeam employeeTeam, DateTime lastReviewDate)
        {
            if (employeeTeam.UnassignmentDate == null)
            {
                return true;
            }
            else
            {
                return employeeTeam.UnassignmentDate.Value.AfterDate(lastReviewDate);
            }
        }

        /// <summary>
        /// calculat the percentage of employeeAssignment during the periode that
        /// separate the last review and the review creation date
        /// </summary>
        /// <param name="employeeTeam"></param>
        /// <param name="lastReviewDate"></param>
        /// <returns></returns>
        private double WorkPercentageByTeamAssignmentSinceLastReview(EmployeeTeam employeeTeam, DateTime lastReviewDate)
        {
            double totalDaysBetweenReviews = (DateTime.Now - lastReviewDate).TotalDays;
            double daysBeforeAssignment = NumberConstant.Zero;
            double daysAfterUnassignment = NumberConstant.Zero;
            if (employeeTeam.UnassignmentDate == null)
            {// undetermined unassignment date
                if (lastReviewDate.BeforeDate(employeeTeam.AssignmentDate))
                {
                    daysBeforeAssignment = (employeeTeam.AssignmentDate - lastReviewDate).TotalDays;
                }
            }
            else if (employeeTeam.UnassignmentDate.Value.AfterDate(DateTime.Now))
            {// Unassignment date later than review date
                if (lastReviewDate.BeforeDate(employeeTeam.AssignmentDate))
                {
                    daysBeforeAssignment = (employeeTeam.AssignmentDate - lastReviewDate).TotalDays;
                }
            }
            else
            {// Unassignment date is earlier than review date
                if (lastReviewDate.BeforeDateLimitIncluded(employeeTeam.AssignmentDate))
                {
                    daysAfterUnassignment = (DateTime.Now - employeeTeam.UnassignmentDate.Value).TotalDays;
                }
                else
                {
                    daysBeforeAssignment = (employeeTeam.AssignmentDate - lastReviewDate).TotalDays;
                    daysAfterUnassignment = (DateTime.Now - employeeTeam.UnassignmentDate.Value).TotalDays;
                }
            }
            return ((totalDaysBetweenReviews - (daysBeforeAssignment + daysAfterUnassignment)) / totalDaysBetweenReviews) * employeeTeam.AssignmentPercentage;
        }
        #endregion

        #region review dates
        private DateTime LastAnnualReviewDate(EmployeeViewModel employee)
        {
            ReviewViewModel lastReview = FindModelsByNoTracked(x => x.IdEmployeeCollaborator == employee.Id).OrderByDescending(x => x.ReviewDate).FirstOrDefault();
            return lastReview == null ? employee.HiringDate : lastReview.ReviewDate;
        }

        private int DaysBeforeReview(DateTime? hiringDate)
        {
            if (hiringDate is null)
            {
                throw new CustomException(CustomStatusCode.EmployeeHasAnyContract);
            }
            DateTime reviewDate = NextAnnualReviewDate(hiringDate.Value);
            return (int)(reviewDate - DateTime.Now).TotalDays;
        }

        private DateTime NextAnnualReviewDate(DateTime hiringDate)
        {
            DateTime nextAnnualReviewDate = hiringDate.AddYears(1);
            while (DateTime.Compare(nextAnnualReviewDate, DateTime.Now) < 0)
            {
                nextAnnualReviewDate = nextAnnualReviewDate.AddYears(1);
            }
            return nextAnnualReviewDate;
        }

        /// <summary>
        /// return true if review date between start and end date retrieved from predicate
        /// otherwise return false
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="hiringDate"></param>
        /// <returns></returns>
        private bool ReviewDateInRange(PredicateFormatViewModel predicateModel, DateTime? hiringDate)
        {
            if (hiringDate is null)
            {
                throw new CustomException(CustomStatusCode.EmployeeHasAnyContract);
            }
            DateTime startDate = GetStartDateFromPredicate(predicateModel);
            DateTime endDate = GetEndDateFromPredicate(predicateModel);
            DateTime nextAnnualReviewDate = new DateTime(startDate.Year, hiringDate.Value.Month, hiringDate.Value.Day);
            DateTime lastAnnualReviewDate = new DateTime(endDate.Year, hiringDate.Value.Month, hiringDate.Value.Day);
            var t = hiringDate.Value.Year < startDate.Year || hiringDate.Value.Year < endDate.Year;
            return (hiringDate.Value.Year < startDate.Year || hiringDate.Value.Year < endDate.Year)
                && (nextAnnualReviewDate.BetweenDateLimitIncluded(startDate, endDate) || lastAnnualReviewDate.BetweenDateLimitIncluded(startDate, endDate));
        }
        #endregion

        #region extract from predicate

        private int GetReviewStateFromPredicate(PredicateFormatViewModel predicateModel)
        {
            return predicateModel.Filter.Where(x => (x.Operation == Operation.Equals) &&
            (x.Prop == nameof(ReviewViewModel.State))).FirstOrDefault() != null ?
            (int)(long)predicateModel.Filter.Where(x => (x.Operation == Operation.Equals) &&
            (x.Prop == nameof(ReviewViewModel.State))).FirstOrDefault().Value :
            NumberConstant.Zero;
        }

        private int GetIdEmployeeFromPredicate(PredicateFormatViewModel predicateModel)
        {
            return predicateModel.Filter.Where(x => (x.Operation == Operation.Equals) &&
            (x.Prop == nameof(ReviewViewModel.IdEmployeeCollaborator))).FirstOrDefault() != null ?
            (int)(long)predicateModel.Filter.Where(x => (x.Operation == Operation.Equals) &&
            (x.Prop == nameof(ReviewViewModel.IdEmployeeCollaborator))).
            FirstOrDefault().Value : NumberConstant.Zero;
        }

        private DateTime GetStartDateFromPredicate(PredicateFormatViewModel predicateModel)
        {
            return (DateTime)predicateModel.Filter.Where(x => (x.Operation == Operation.GreaterThanOrEquals) &&
           (x.Prop == nameof(ReviewViewModel.ReviewDate))).FirstOrDefault().Value;
        }

        private DateTime GetEndDateFromPredicate(PredicateFormatViewModel predicateModel)
        {
            return (DateTime)predicateModel.Filter.Where(x => (x.Operation == Operation.LessThanOrEquals) &&
           (x.Prop == nameof(ReviewViewModel.ReviewDate))).FirstOrDefault().Value;
        }

        #endregion

        #region authorization

        /// <summary>
        /// Verify the review edit right: only collaborator or super hierarchique can edit the review
        /// </summary>
        /// <param name="idReview"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private void VerifyReviewEditRight(int idReview)
        {
            EmployeeReviewPosition employeeReviewPosition = ConnectedEmployeePriveleges(idReview);
            if(!employeeReviewPosition.IsManagement && !employeeReviewPosition.IsCollaborator && !employeeReviewPosition.IsReviewManager)
            {
                throw new CustomException(CustomStatusCode.ReviewEditException);
            };
        }

        public bool CanAccessReviewDetails(int idReview)
        {
            EmployeeReviewPosition employeeReviewPosition = ConnectedEmployeePriveleges(idReview);
            bool granted = employeeReviewPosition.IsManagement || employeeReviewPosition.IsCollaborator || employeeReviewPosition.IsReviewManager
                || employeeReviewPosition.IshierarchicalSuperior || employeeReviewPosition.IsInterviewer;
            return granted;
        }

        private Review CkeckReviewViolation(int idReview)
        {
   
            Review review = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation);

            if (review == null)
            {
                throw new Exception();
            }
            else if (review.IdEmployeeCollaboratorNavigation == null)
            {
                throw new Exception();
            }
            return review;
        }

        /*****************************************************************************************************/

        

        public EmployeeReviewPosition ConnectedEmployeePriveleges (int idReview) {
            EmployeeReviewPosition employeeReviewPosition = new EmployeeReviewPosition();
            Review review = CkeckReviewViolation(idReview);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee();
            //IsManagement
            employeeReviewPosition.IsManagement = RoleHelper.HasPermission(RHPermissionConstant.UPDATE_ANNUALINTERVIEW);

            //IsReviewManager
            if (connectedEmployee.Id == review.IdManager)
            {
                employeeReviewPosition.IsReviewManager = true;
            }

            //IsHierarchicalSuperior
            employeeReviewPosition.IshierarchicalSuperior = IsPartOfHierarchy(review);

            //IsCollaborator
            if (connectedEmployee.Id == review.IdEmployeeCollaborator)
            {
                employeeReviewPosition.IsCollaborator = true;
            }

            //IsInterviewer
            employeeReviewPosition.IsInterviewer = IsInterviewer(idReview);

            return employeeReviewPosition;
        }

        public bool IsPartOfHierarchy(Review review)
        {
            bool isSuperHierachique = _serviceEmployee.IsUserInSuperHierarchicalEmployeeList(ActiveAccountHelper.GetConnectedUserEmail(), _builder.BuildEntity(review).IdEmployeeCollaboratorNavigation);
            return isSuperHierachique;
        }

        public bool IsInterviewer(int idReview)
        {
            bool inInterview = false;
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee();
            Expression<Func<Interview, bool>> reviewCondition = (x => x.IdReview == idReview);
            Expression<Func<Interview, object>> interviewMarkRelation = (x => x.InterviewMark);
            List<Interview> interviews = _interviewRepo.GetAllWithConditionsRelationsAsNoTracking(reviewCondition, interviewMarkRelation).ToList();
            interviews.ForEach(x =>
                inInterview |= x.InterviewMark.Where(y => y.IdEmployee == connectedEmployee.Id).Any() || (x.IdSupervisor.Value == connectedEmployee.Id)
            );
            return inInterview;
        }

        #endregion

        #region review report

        public ReviewFormViewModel FetchReportInformation(int idReview)
        {
            ReviewFormViewModel reviewReportInfo = new ReviewFormViewModel();
            reviewReportInfo.Review = GetModelWithRelations(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation);
            // Future review info
            reviewReportInfo.FutureObjective = _serviceObjective.FindModelBy(x => x.IdReview == idReview);
            reviewReportInfo.FutureReviewFormation = _serviceReviewFormation.FindModelBy(x => x.IdReview == idReview);
            reviewReportInfo.FutureReviewSkills = _serviceReviewSkills.FindModelBy(x => x.IdReview == idReview);
            // Past review info
            reviewReportInfo.PastObjective = _serviceObjective.FindModelBy(x => x.IdReview != idReview && x.IdEmployee == reviewReportInfo.Review.IdEmployeeCollaborator);
            reviewReportInfo.PastReviewFormation = _serviceReviewFormation.FindModelBy(x => x.IdReview != idReview && x.IdEmployee == reviewReportInfo.Review.IdEmployeeCollaborator);
            reviewReportInfo.PastReviewSkills = _serviceReviewSkills.FindModelBy(x => x.IdReview != idReview && x.IdEmployee == reviewReportInfo.Review.IdEmployeeCollaborator);
            return reviewReportInfo;
        } 

        #endregion
    }
}
