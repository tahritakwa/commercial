using Infrastruture.Utility;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
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
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes.ServiceInterview
{
    public partial class ServiceInterview : Service<InterviewViewModel, Interview>, IServiceInterview
    {
        private readonly IServiceInterviewMark _serviceInterviewMark;
        private readonly IServiceEmail _serviceEmail;
        private readonly IRepository<Recruitment> _recruitmentEntityRepo;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IRepository<Offer> _offerEntityRepo;
        private readonly IRepository<User> _userEntityRepo;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IRepository<Candidacy> _candidacyEntityRepo;
        private readonly IRepository<Review> _reviewEntityRepo;
        private readonly SmtpSettings _smtpSettings;
        private readonly IRepository<ExitEmployee> _employeeExitEntityRepo;
        private readonly IRepository<Employee> _employeeEntityRepo;
        private readonly IEmailBuilder _emailBuilder;
        private readonly ICandidacyBuilder _candidacyBuilder;
        private readonly IRepository<InterviewType> _interviewTypeRepo;
        private readonly IServiceInterviewEmail _serviceInterviewEmail;


        public ServiceInterview(IRepository<Interview> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IUnitOfWork unitOfWork,
          IInterviewBuilder builder,
          IRepository<Offer> offerEntityRepo,
          IServiceEmployee serviceEmployee,
          IRepository<User> userEntityRepo,
          IEntityAxisValuesBuilder builderEntityAxisValues,
          IServiceInterviewMark serviceInterviewMark,
          IServiceEmail serviceEmail,
          IRepository<Recruitment> recruitmentEntityRepo,
          IServiceMsgNotification serviceMessageNotification,
          IRepository<ExitEmployee> employeeExitEntityRepo,
          IRepository<Candidacy> candidacyEntityRepo,
          IOptions<SmtpSettings> smtpSettings,
          IRepository<Review> reviewEntityRepo,
          IRepository<Employee> employeeEntityRepo,
          IOptions<AppSettings> appSettings,
          IRepository<Company> entityRepoCompany,
          IEmailBuilder emailBuilder,
          IServiceInterviewEmail serviceInterviewEmail,
          ICompanyBuilder companyBuilder,
          IMemoryCache memoryCache,
          ICandidacyBuilder candidacyBuilder,
          IRepository<InterviewType> interviewTypeRepo)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {
            _serviceInterviewMark = serviceInterviewMark;
            _serviceEmail = serviceEmail;
            _recruitmentEntityRepo = recruitmentEntityRepo;
            _serviceEmployee = serviceEmployee;
            _userEntityRepo = userEntityRepo;
            _serviceMessageNotification = serviceMessageNotification;
            _candidacyEntityRepo = candidacyEntityRepo;
            _offerEntityRepo = offerEntityRepo;
            _reviewEntityRepo = reviewEntityRepo;
            _smtpSettings = smtpSettings.Value;
            _employeeExitEntityRepo = employeeExitEntityRepo;
            _employeeEntityRepo = employeeEntityRepo;
            _emailBuilder = emailBuilder;
            _candidacyBuilder = candidacyBuilder;
            _interviewTypeRepo = interviewTypeRepo;
            _serviceInterviewEmail = serviceInterviewEmail;
        }

        #region Overrided methods

        /// <summary>
        /// AddModelWithoutTransaction override
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(InterviewViewModel interview, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckInterview(interview);
            ValidateResignedStatusInterviewers(interview);
            if (interview.IdExitEmployee.HasValue)
            {
                CheckInterviewWithValidateDate(interview);
            }
            interview.IdCreator = _userEntityRepo.FindSingleBy(x => x.Email == ActiveAccountHelper.GetConnectedUserEmail()).IdEmployee;
            if (interview.IdCandidacy.HasValue)
            {
                CheckInterviewDateWithRecruitmentCreationDate(interview);
                CheckInterviewDuplication(interview);
                VerifyViolations(interview);
            }
            else if (interview.IdReview.HasValue)
            {
                Review review = VerifyReviewViolation(interview.IdReview.Value);
                CheckEmployeeIsInterviewerOrSupervisorForHisOwnInterview(interview, review);
                if (!review.Interview.Any())
                {
                    review.IdEmployeeCollaboratorNavigation = null;
                    review.State = (int)ReviewStateEnumerator.InProgress;
                    _reviewEntityRepo.Update(review);
                }
            }
            else
            {
                VerifyEmployeeExitViolation(interview.IdExitEmployee.Value);
            }
            CreatedDataViewModel result = (CreatedDataViewModel)base.AddModelWithoutTransaction(interview, entityAxisValuesModelList, userMail, property);
            SendEmailsAndNotifications(interview, userMail);
            return result;
        }

        /// <summary>
        /// Find DataSource ModelBy overrided
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override DataSourceResult<InterviewViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<InterviewViewModel> dataSourceResult = base.FindDataSourceModelBy(predicateModel);
            IList<InterviewViewModel> interviewList = dataSourceResult.data;
            foreach (InterviewViewModel interviewViewModel in interviewList)
            {
                if (interviewViewModel.InterviewMark.Any())
                {
                    interviewViewModel.InterviewMark = _serviceInterviewMark.GetModelsWithConditionsRelations(iM => iM.IdInterview == interviewViewModel.InterviewMark.ElementAt(0).IdInterview,
                        iM => iM.IdEmployeeNavigation).ToList();
                }
            }
            return dataSourceResult;
        }

        /// <summary>
        /// Update Model Without Transaction overrided
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(InterviewViewModel interview, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            interview.InterviewDate = new DateTime(interview.InterviewDate.Year, interview.InterviewDate.Month, interview.InterviewDate.Day,
                interview.StartTime.Hours, interview.StartTime.Minutes, NumberConstant.Zero);

            CheckInterview(interview);
            ValidateResignedStatusInterviewers(interview);
            if (interview.IdExitEmployee.HasValue)
            {
                CheckInterviewWithValidateDate(interview);
            }
            int idNotification;
            string intervieweeFullName;

            if (interview.IdCandidacy.HasValue)
            {
                if (interview.Status >= (int)InterviewEnumerator.InterviewRequestedToCandidate)
                {
                    throw new CustomException(CustomStatusCode.Unauthorized, null, null);
                }
                Candidacy candidacy = VerifyViolations(interview);
                idNotification = (int)candidacy.IdRecruitment;
                intervieweeFullName = candidacy.IdCandidateNavigation.FirstName + ' ' +
                    candidacy.IdCandidateNavigation.LastName;
            }
            else if (interview.IdReview.HasValue)
            {
                Review review = VerifyReviewViolation(interview.IdReview.Value);
                idNotification = review.Id;
                intervieweeFullName = review.IdEmployeeCollaboratorNavigation.FullName;
            }
            else
            {
                ExitEmployee employeeExit = VerifyEmployeeExitViolation(interview.IdExitEmployee.Value);
                idNotification = employeeExit.Id;
                intervieweeFullName = employeeExit.IdEmployeeNavigation.FullName;
            }

            IDictionary<string, dynamic> parameters = PrepareInterviewParameters(interview, intervieweeFullName, userMail);

            DeleteAndNotifyInterviewersAfterUpdate(interview, userMail, parameters, idNotification);

            interview.IdReviewNavigation = null;
            interview.IdCandidacyNavigation = null;
            interview.IdInterviewTypeNavigation = null;
            interview.IdEmailNavigation = null;
            interview.IdSupervisorNavigation = null;
            InterviewViewModel interviewBeforeUpdate = GetModelAsNoTracked(x => x.Id == interview.Id, x => x.InterviewMark);
            if (!interview.InterviewDate.EqualsDate(interviewBeforeUpdate.InterviewDate) || !interview.StartTime.Equals(interviewBeforeUpdate.StartTime))
            {
                interview.Status = (int)InterviewEnumerator.InterviewRequestedToAllInterviewers;
                CancelInterviewersConfirmation(interview);
            }
            CreatedDataViewModel result = (CreatedDataViewModel)base.UpdateModelWithoutTransaction(interview, entityAxisValuesModelList, userMail, property);
            interview.InterviewMark = interview.InterviewMark.Where(x => x.IsRequired && !x.IsDeleted).ToList();
            interview.OptionalInterviewMark = interview.OptionalInterviewMark.Where(x => !x.IsDeleted).ToList();
            bool differentInterviewMark = interview.InterviewMark.Except(interviewBeforeUpdate.InterviewMark, new InterviewMarkComparer()).Any()
                || interviewBeforeUpdate.InterviewMark.Except(interview.InterviewMark, new InterviewMarkComparer()).Any();
            bool differentOptionalInterviewMark = interview.OptionalInterviewMark.Except(interviewBeforeUpdate.OptionalInterviewMark, new InterviewMarkComparer()).Any()
                || interviewBeforeUpdate.OptionalInterviewMark.Except(interview.OptionalInterviewMark, new InterviewMarkComparer()).Any();
            if (!interview.StartTime.Equals(interviewBeforeUpdate.StartTime) || !interview.InterviewDate.Date.Equals(interviewBeforeUpdate.InterviewDate.Date)
                   || differentInterviewMark || differentOptionalInterviewMark)
            {
                SendEmailsAndNotifications(interview, userMail, interviewBeforeUpdate);
            }
            return result;
        }

        /// <summary>
        /// Delete Model withou Transaction overrided
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            object obj = null;
            InterviewViewModel interview = GetModelAsNoTracked(x => x.Id == id, x => x.InterviewMark);
            if (interview.Status >= (int)InterviewEnumerator.InterviewRequestedToCandidate)
            {
                throw new CustomException(CustomStatusCode.DeleteInterviewViolation);
            }
            if (interview.IdCandidacy.HasValue)
            {
                VerifyViolations(interview);
            }
            PrepareAndSendInterviewCancellationEmail(interview, userMail);
            obj = base.DeleteModelwithouTransaction(id, tableName, userMail);

            if (interview.IdEmail != null)
            {
                obj = _serviceEmail.DeleteModelwithouTransaction(interview.IdEmail.Value, "Email", userMail);
            }
            return obj;
        }

        /// <summary>
        /// Generate Interview Email By Id
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public EmailViewModel GenerateInterviewEmailById(InterviewViewModel interview, string lang)
        {
            string userMail = ActiveAccountHelper.GetConnectedUserEmail();
            VerifyInterviewViolation(interview);
            EmailViewModel generatedEmail = interview.IdEmailNavigation;
            try
            {
                BeginTransaction();
                User user = _userEntityRepo.GetSingle(u => u.Email.ToLower() == userMail.ToLower());
                lang = !string.IsNullOrEmpty(lang) ? lang : user.Lang;
                generatedEmail = PrepareAndSendOrResendEmployeeOrCandidateInvitationMail(interview, lang, userMail, generatedEmail);
                EndTransaction();
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
            return generatedEmail;
        }

        #endregion

        #region Interview for reviews and interviews

        private void CancelInterviewersConfirmation(InterviewViewModel interview)
        {
            interview.InterviewMark.Where(x => x.Status == (int)InterviewMarkEnumerator.InterviewerAvailabilityConfirmed)
                .Select(x => { x.Status = (int)InterviewMarkEnumerator.InterviewMarkRequestedToInterviewer; return x; }).ToList();
            interview.OptionalInterviewMark.Where(x => x.Status == (int)InterviewMarkEnumerator.InterviewerAvailabilityConfirmed)
                .Select(x => { x.Status = (int)InterviewMarkEnumerator.InterviewMarkRequestedToInterviewer; return x; }).ToList();
        }


        public void CancelInterview(InterviewViewModel interview, string userMail)
        {
            VerifyInterviewViolation(interview);
            if (interview.Status != (int)InterviewEnumerator.InterviewDone)
            {
                Interview interviewAsNoTracking = _entityRepo.GetSingleNotTracked(i => i.Id == interview.Id);
                interviewAsNoTracking.Status = (int)InterviewEnumerator.InterviewRefused;
                interviewAsNoTracking.Remarks = interview.Remarks;
                if ((interviewAsNoTracking.IdReview.HasValue) || (interviewAsNoTracking.IdExitEmployee.HasValue))
                {
                    _entityRepo.Update(interviewAsNoTracking);
                    _unitOfWork.Commit();
                    PrepareAndSendInterviewCancellationEmail(interview, userMail);
                }
            }
        }

        /// <summary>
        /// Confirm the Candidate Disponibility
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="userMail"></param>
        public void ConfirmTheCandidateDisponibility(InterviewViewModel interview)
        {
            VerifyInterviewEmployeeConfirmationViolation(interview);

            if (interview.IdCandidacy.HasValue)
            {
                Interview interviewAsNoTracking = GetInterviewByIdForCandidacy(interview);
                SaveConfirmation(interviewAsNoTracking);

                if (interviewAsNoTracking.IdCandidacyNavigation.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Interview)
                {
                    interviewAsNoTracking.IdCandidacyNavigation.IdRecruitmentNavigation.State = (int)RecruitmentStateEnumerator.Evaluation;
                    _recruitmentEntityRepo.Update(interviewAsNoTracking.IdCandidacyNavigation.IdRecruitmentNavigation);
                    _unitOfWork.Commit();
                }
            }
            else if (interview.IdReview.HasValue)
            {
                Interview interviewAsNoTracking = GetInterviewByIdForReview(interview);
                SaveConfirmation(interviewAsNoTracking);
            }
            else if (interview.IdExitEmployee.HasValue)
            {
                Interview interviewAsNoTracking = GetInterviewByIdForEmployeeExitMeeting(interview);
                SaveConfirmation(interviewAsNoTracking);
            }
            else
            {
                throw new CustomException(CustomStatusCode.NotReviewOrCandidacy, null, null);
            }
        }

        #endregion

        #region general purpose methods

        public void DeleteAndNotifyInterviewersAfterUpdate(InterviewViewModel interview, string userMail, IDictionary<string, dynamic> parameters, int idNotification)
        {
            List<InterviewMarkViewModel> interviewsToDelete = interview.InterviewMark.Where(x => x.IsDeleted).ToList();
            interviewsToDelete.AddRange(interview.OptionalInterviewMark.Where(x => x.IsDeleted).ToList());
            interviewsToDelete.ForEach(interviewMark =>
           {
               EmployeeViewModel interviewer = _serviceEmployee.GetModelById(interviewMark.IdEmployee);
               SendInterviewCancellationMail(interview, userMail, interviewer);
               List<User> targetUsers = _userEntityRepo.FindByAsNoTracking(u => u.IdEmployee == interviewMark.IdEmployee).ToList();
               if (targetUsers.Any())
               {
                   if (!parameters.ContainsKey(Constants.USER_EMAIL_UPPER_CASE))
                   {
                       parameters.Add(Constants.USER_EMAIL_UPPER_CASE, targetUsers.FirstOrDefault().Email);
                   }
                   else
                   {
                       parameters[Constants.USER_EMAIL_UPPER_CASE] = targetUsers.FirstOrDefault().Email;
                   }
                   string informationType = interview.IdCandidacy.HasValue ? Constants.DELETED_FROM_INTERVIEWER_LIST_FOR_CANDIDACY_UPPER_CASE
                       : interview.IdReview.HasValue ? Constants.DELETED_FROM_INTERVIEWER_FOR_REVIEW_LIST_UPPER_CASE : Constants.DELETED_FROM_INTERVIEWER_FOR_EXIT_EMPLOYEE_LIST_UPPER_CASE;
                   _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(informationType, idNotification, JsonConvert.SerializeObject(parameters),
                       (int)MessageTypeEnumerator.AlertInterviewer, userMail, parameters, targetUsers, GetCurrentCompany().Code);
               }
           });
        }

        /// <summary>
        /// save confirmation and change interview state
        /// </summary>
        /// <param name="interviewAsNoTracking"></param>
        private void SaveConfirmation(Interview interviewAsNoTracking)
        {
            interviewAsNoTracking.Status = (int)InterviewEnumerator.InterviewConfirmedByCandidate;
            _entityRepo.Update(interviewAsNoTracking);
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Make The Interview As Requested To Candidate
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="userMail"></param>
        public void MakeTheInterviewAsRequestedToCandidate(InterviewViewModel interview, string userMail)
        {
            VerifyInterviewViolation(interview);
            if (interview.Status > (int)InterviewEnumerator.InterviewRequestedToCandidate)
            {
                throw new CustomException(CustomStatusCode.Unauthorized, null, null);
            }

            if (interview.Status < (int)InterviewEnumerator.InterviewRequestedToCandidate)
            {
                Interview interviewAsNoTracking = _entityRepo.GetSingleNotTracked(i => i.Id == interview.Id);
                interviewAsNoTracking.Status = (int)InterviewEnumerator.InterviewRequestedToCandidate;
                _entityRepo.Update(interviewAsNoTracking);
                _unitOfWork.Commit();
            }

        }

        /// <summary>
        /// preparing interview parameters
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="candidateFullName"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        IDictionary<string, dynamic> PrepareInterviewParameters(InterviewViewModel interview, string candidateFullName, string userMail)
        {
            User user = _userEntityRepo.GetSingleWithRelationsNotTracked(u => u.Email.ToLower() == userMail.ToLower(), u => u.IdEmployeeNavigation);
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
                            {
                                { Constants.INTERVIEW_CREATOR_UPPER_CASE, user.IdEmployeeNavigation != null ? user.IdEmployeeNavigation.FullName :  user.FullName },
                                { Constants.INTERVIEW_DATE_UPPER_CASE, DateUtility.GenerateDateByCulture(interview.InterviewDate, user.Lang) },
                                { Constants.INTERVIEW_TIME_UPPER_CASE, DateUtility.GenerateTimeByCulture(interview.InterviewDate, user.Lang)},
                                { Constants.NAME, candidateFullName},
                                { Constants.NOTIFICATION_DATE_UPPER_CASE, DateTime.Now}
                            };
            return parameters;
        }

        #endregion

        #region Interview for candidacy

        private void SendEmailsAndNotifications(InterviewViewModel interview, string userMail, InterviewViewModel interviewBeforeUpdate = null)
        {
            string fullName = "";
            int id = NumberConstant.Zero;
            EmployeeViewModel interviewee = new EmployeeViewModel();
            if (interview.IdCandidacy.HasValue)
            {
                Candidacy candidacy = _candidacyEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == interview.IdCandidacy, c => c.IdCandidateNavigation, c => c.IdRecruitmentNavigation);
                fullName = candidacy.IdCandidateNavigation.FirstName + ' ' + candidacy.IdCandidateNavigation.LastName;
                interview.IdCandidacyNavigation = _candidacyBuilder.BuildEntity(candidacy);
                id = interview.IdCandidacy.Value;
                interviewee = FromCandidateToEmployee(candidacy.IdCandidateNavigation);
            }
            else if (interview.IdReview.HasValue)
            {
                Review review = _reviewEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == interview.IdReview, c => c.IdEmployeeCollaboratorNavigation);
                fullName = review.IdEmployeeCollaboratorNavigation.FirstName + ' ' + review.IdEmployeeCollaboratorNavigation.LastName;
                id = interview.IdReview.Value;
                interviewee = FromCandidateToEmployee(null, review.IdEmployeeCollaboratorNavigation);
            }
            else
            {
                ExitEmployee employeeExit = _employeeExitEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == interview.IdExitEmployee, c => c.IdEmployeeNavigation);
                fullName = employeeExit.IdEmployeeNavigation.FullName;
                id = interview.IdExitEmployee.Value;
                interviewee = FromCandidateToEmployee(null, employeeExit.IdEmployeeNavigation);
            }
            IDictionary<string, dynamic> parameters = PrepareInterviewParameters(interview, fullName, userMail);
            if (interview.InterviewMark != null)
            {
                List<User> targetUsers = GetUsersListOfRequiredInterviewers(interview.InterviewMark.Where(x => x.IsRequired).ToList());
                SendInterviewAlertNotificationForInterviewer(false, id, targetUsers, parameters, userMail, interview);
            }
            if (interview.OptionalInterviewMark != null)
            {
                List<User> targetUsers = GetUsersListOfRequiredInterviewers(interview.OptionalInterviewMark.ToList());
                SendInterviewAlertNotificationForInterviewer(true, id, targetUsers, parameters, userMail, interview);
            }
            bool dateHasChanged = interviewBeforeUpdate != null && (!interview.InterviewDate.EqualsDate(interviewBeforeUpdate.InterviewDate) || !interview.StartTime.Equals(interviewBeforeUpdate.StartTime)) ?
                true : false;
            DateTime oldDate = dateHasChanged ? interviewBeforeUpdate.InterviewDate : interview.InterviewDate;
            bool statusChanged = interviewBeforeUpdate != null &&
                (interviewBeforeUpdate.Status == (int)InterviewEnumerator.InterviewConfirmedByCandidate || interviewBeforeUpdate.Status == (int)InterviewEnumerator.InterviewRequestedToCandidate)
                && interview.Status != interviewBeforeUpdate.Status ? true : false;
            if (dateHasChanged && statusChanged)
            {
                SendInterviewCancellationMail(interviewBeforeUpdate, userMail, interviewee);
            }
            PrepareAndSendInvitationEmailForAllInterviewers(interview, userMail, dateHasChanged, oldDate);
        }

        /// <summary>
        /// Create fake EmployeeViewModel from Candidate or Employee
        /// </summary>
        /// <param name="candidate"></param>
        /// <param name="employee"></param>
        /// <returns></returns>
        private EmployeeViewModel FromCandidateToEmployee(Candidate candidate, Employee employee = null)
        {
            return new EmployeeViewModel
            {
                Id = candidate != null ? NumberConstant.Zero : employee.Id,
                FirstName = candidate != null ? candidate.FirstName : employee.FirstName,
                LastName = candidate != null ? candidate.LastName : employee.LastName,
                FullName = candidate != null ? candidate.FullName : employee.FullName,
                Email = candidate != null ? candidate.Email : employee.Email,
                Sex = candidate != null ? candidate.Sex : employee.Sex
            };
        }
        #endregion

        #region Interview for Review

        /// <summary>
        /// Check if employee is selected as interviewer or supervisor of his own interview
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="review"></param>
        private void CheckEmployeeIsInterviewerOrSupervisorForHisOwnInterview(InterviewViewModel interview, Review review)
        {
            User user = _userEntityRepo.GetSingleNotTracked(x => x.Email == ActiveAccountHelper.GetConnectedUserEmail());
            bool isConcernedEmployeeInterviewer = (interview.InterviewMark != null && interview.InterviewMark.Any(x => x.IdEmployee == review.IdEmployeeCollaborator)) ||
                (interview.OptionalInterviewMark != null && interview.OptionalInterviewMark.Any(x => x.IdEmployee == review.IdEmployeeCollaborator)) ||
                (interview.IdSupervisor.HasValue && interview.IdSupervisor.Value == review.IdEmployeeCollaborator);
            if (isConcernedEmployeeInterviewer)
            {
                throw new CustomException(CustomStatusCode.EmployeeToInterviewMustNotBeInterviewer);
            }
        }

        #endregion

        #region fetch data

        /// <summary>
        /// Get required interviewers
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        private List<EmployeeViewModel> GetEmployeeListOfRequiredInterviewers(List<InterviewMarkViewModel> interviewMarks)
        {
            List<EmployeeViewModel> targetEmployees = new List<EmployeeViewModel>();
            foreach (InterviewMarkViewModel interviewMark in interviewMarks)
            {
                EmployeeViewModel currentEmployee = _serviceEmployee.FindSingleModelBy(new PredicateFormatViewModel
                {
                    Filter = new List<FilterViewModel>() { new FilterViewModel
                      {
                        Prop = nameof(EmployeeViewModel.Id),
                        Operation = Operation.Equals ,
                        Value = interviewMark.IdEmployee
                      }
                    }
                }
                );

                if (currentEmployee != null)
                {
                    currentEmployee.IsAlreadyAnInterviewer = interviewMark.Id != NumberConstant.Zero ? true : currentEmployee.IsAlreadyAnInterviewer;
                    targetEmployees.Add(currentEmployee);
                }
            }
            return targetEmployees;
        }

        /// <summary>
        /// fetch user list of required interviewers
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        private List<User> GetUsersListOfRequiredInterviewers(List<InterviewMarkViewModel> interviewMarks)
        {
            List<User> targetUsers = new List<User>();
            foreach (InterviewMarkViewModel interviewMark in interviewMarks)
            {
                User currentUser = _userEntityRepo.FindSingleBy(u => u.IdEmployee == interviewMark.IdEmployee);
                if (currentUser != null)
                {
                    targetUsers.Add(currentUser);
                }
            }
            return targetUsers;
        }

        /// <summary>
        /// Get interview by Id with Recrutment: 
        /// can only be used to get interview associated to candidacy
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        private Interview GetInterviewByIdForCandidacy(InterviewViewModel interview)
        {
            Interview interviewAsNoTracking = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == interview.Id,
                x => x.IdCandidacyNavigation, x => x.IdCandidacyNavigation.IdRecruitmentNavigation);

            if (interviewAsNoTracking.IdCandidacyNavigation.IdRecruitmentNavigation.State < (int)RecruitmentStateEnumerator.Interview)
            {
                throw new CustomException(CustomStatusCode.Unauthorized, null, null);
            }

            VerifyViolations(_builder.BuildEntity(interviewAsNoTracking));

            return interviewAsNoTracking;
        }

        /// <summary>
        /// Get interview by Id with Reviewed Employee: 
        /// can only be used to get interview associated to review
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        private Interview GetInterviewByIdForReview(InterviewViewModel interview)
        {
            return _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == interview.Id,
                x => x.IdReviewNavigation, x => x.IdReviewNavigation.IdEmployeeCollaboratorNavigation);
        }

        /// <summary>
        /// From Interview To Next Step
        /// </summary>
        /// <param name="recruitmentId"></param>
        /// <returns></returns>
        public List<InterviewViewModel> FromInterviewToNextStep(int recruitmentId)
        {
            // get the interview wich status
            List<InterviewViewModel> interviewViewModels = GetModelsWithConditionsRelations(i =>
            i.IdCandidacyNavigation.IdRecruitment == recruitmentId && i.Status > (int)InterviewEnumerator.InterviewRequestedToCandidate).ToList();
            if (!interviewViewModels.Any())
            {
                throw new CustomException(CustomStatusCode.InterviewToNextStepViolation);
            }
            return interviewViewModels;
        }

        /// <summary>
        /// From Evaluation To Next Step
        /// </summary>
        /// <param name="recruitmentId"></param>
        /// <returns></returns>
        public List<InterviewViewModel> FromEvaluationToNextStep(int recruitmentId)
        {
            List<InterviewViewModel> interviewViewModels = FindModelBy(model => model.IdCandidacyNavigation.IdRecruitment == recruitmentId &&
            model.InterviewMark.Any(t => t.InterviewerDecision != null)).ToList();
            return interviewViewModels;
        }

        /// <summary>
        /// GetCandidacyInterviewDetails in selection step
        /// </summary>
        /// <param name="idCandidacy"></param>
        /// <returns></returns>
        public List<InterviewViewModel> GetCandidacyInterviewDetails(int idCandidacy)
        {
            return _entityRepo.QuerableGetAll().Include(x => x.IdInterviewTypeNavigation)
                .Include(x => x.InterviewMark).ThenInclude(x => x.IdEmployeeNavigation)
                .Where(x => x.IdCandidacy == idCandidacy).Select(x => _builder.BuildEntity(x)).ToList();

        }

        #endregion

        #region data validation

        private void VerifyInterviewViolation(InterviewViewModel interview)
        {
            if(interview.IdReview.HasValue)
            {
                int idEmployee = interview.IdReviewNavigation != null ? interview.IdReviewNavigation.IdEmployeeCollaborator
                    : _employeeEntityRepo.GetSingleNotTracked(x => x.ReviewIdEmployeeCollaboratorNavigation.Any(y => y.Id == interview.IdReview.Value)).Id;
                _serviceEmployee.ValidateResignedStatusEmployee(idEmployee, interview.InterviewDate);
            }
            if (!interview.InterviewMark.Any(x => x.IdEmployee == interview.IdSupervisor))
            {
                throw new CustomException(CustomStatusCode.SupervisorNotInRequiredInterviewers);
            }
            if (interview == null)
            {
                throw new CustomException(CustomStatusCode.NotReviewOrCandidacy, null, null);
            }
            if ((!interview.IdCandidacy.HasValue) && (!interview.IdReview.HasValue) && (!interview.IdExitEmployee.HasValue))
            {
                throw new CustomException(CustomStatusCode.NotReviewOrCandidacy, null, null);
            }
        }

        /// <summary>
        /// Check if there is no violation in an interview
        /// </summary>
        /// <param name="interview"></param>
        private void CheckInterview(InterviewViewModel interview)
        {
            VerifyInterviewViolation(interview);
            if (interview.EndTime.BeforeTimeLimitIncluded(interview.StartTime))
            {
                throw new CustomException(CustomStatusCode.InterviewStartTimeExceedsEndTime);
            }

        }
        /// <summary>
        /// Validate Resigned status intervierviewes
        /// </summary>
        /// <param name="interview"></param>
        private void ValidateResignedStatusInterviewers(InterviewViewModel interview)
        {
            List<int> idsInterviewers = new List<int>();
            idsInterviewers.AddRange(interview.InterviewMark.Select(x => x.IdEmployee));
            idsInterviewers.AddRange(interview.OptionalInterviewMark.Select(x => x.IdEmployee));
            if (interview.IdSupervisor.HasValue)
            {
                idsInterviewers.Add(interview.IdSupervisor.Value);
            }
            foreach (int idInterviewer in idsInterviewers)
            {
                _serviceEmployee.ValidateResignedStatusEmployee(idInterviewer, interview.InterviewDate);
            }
        }

        /// <summary>
        /// Check if exit employee have validate days
        /// </summary>
        /// <param name="model"></param>
        private void CheckInterviewWithValidateDate(InterviewViewModel interview)
        {
            if (interview.IdExitEmployee != null)
            {
                ExitEmployee employeeExit = _employeeExitEntityRepo.GetSingleNotTracked(x => x.Id == interview.IdExitEmployee);
                EmployeeViewModel employee = _serviceEmployee.GetModelById(employeeExit.IdEmployee);
                if (interview.InterviewDate.BeforeDate(employee.HiringDate))
                {
                    throw new CustomException(CustomStatusCode.InterviewDateBeforeHiringDate);
                }
                if (employeeExit.ExitDepositDate.Value.AfterDate(interview.InterviewDate))
                {
                    throw new CustomException(CustomStatusCode.ExitDepositDateAfterInterviewDate);
                }
            }


        }
        public bool CheckInterviewerHasAnotherInterview(InterviewViewModel interview)
        {
            // Required interviewers ids
            List<int> interviewersIds = interview.InterviewMark.Select(x => x.IdEmployee).ToList();
            //check if there is an interview at the same time for the same interviewer
            List<InterviewViewModel> parallelInterviews = GetAllModelsQueryable(x => x.Id != interview.Id && x.InterviewDate.Date.Equals(interview.InterviewDate.Date)
                && x.InterviewMark.Any(y => interviewersIds.Contains(y.IdEmployee))).ToList();
            return parallelInterviews.Any() && parallelInterviews.Any(x => interview.EndTime.BetweenTimeLimitNotIncluded(x.InterviewDate.TimeOfDay, x.EndTime)
                 || interview.StartTime.BetweenTimeLimitNotIncluded(x.InterviewDate.TimeOfDay, x.EndTime)
                 || (interview.StartTime.BetweenTimeLimitIncluded(x.InterviewDate.TimeOfDay, x.EndTime) && interview.EndTime.BetweenTimeLimitIncluded(x.InterviewDate.TimeOfDay, x.EndTime))
                 || (interview.StartTime.BeforeTimeLimitIncluded(x.InterviewDate.TimeOfDay) && interview.EndTime.AfterTimeLimitIncluded(x.EndTime)));
        }

        /// <summary>
        /// verify that review has a collaborator assigned to it
        /// </summary>
        /// <param name="idReview"></param>
        /// <returns></returns>
        private Review VerifyReviewViolation(int idReview)
        {
            Review review = _reviewEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == idReview, c => c.IdEmployeeCollaboratorNavigation);

            if (review != null && review.IdEmployeeCollaboratorNavigation == null)
            {
                throw new CustomException(CustomStatusCode.NotFound, null, null);
            }

            return review;
        }

        /// <summary>
        /// verify that interview is not null and interview status is interview requested to candidate
        /// </summary>
        /// <param name="interview"></param>
        private void VerifyInterviewEmployeeConfirmationViolation(InterviewViewModel interview)
        {
            if (interview == null)
            {
                throw new CustomException(CustomStatusCode.NotReviewOrCandidacy, null, null);
            }
            if (interview.Status != (int)InterviewEnumerator.InterviewRequestedToCandidate)
            {
                throw new CustomException(CustomStatusCode.Unauthorized, null, null);
            }
        }

        /// <summary>
        /// Verify Closed Recruitment Violation
        /// </summary>
        /// <param name="idCandidacy"></param>
        Candidacy VerifyViolations(InterviewViewModel interview)
        {
            Candidacy candidacy = _candidacyEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == interview.IdCandidacy, c => c.IdCandidateNavigation, c => c.IdRecruitmentNavigation);

            if (candidacy.IdRecruitmentNavigation == null)
            {
                throw new CustomException(CustomStatusCode.Unauthorized, null, null);
            }

            if (candidacy.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }
            if (interview.InterviewDate.BeforeDate(candidacy.IdRecruitmentNavigation.CreationDate))
            {
                throw new CustomException(CustomStatusCode.InterviewDateBeforeRecuirmentCreationDate);
            }


            IList<Offer> offer = _offerEntityRepo.FindByAsNoTracking(
                                                           result => result.IdCandidacy.Equals(candidacy.Id) &&
                                                           (result.State >= (int)OfferStateEnumerator.Sended)
                                                       ).ToList();

            if (offer.Any())
            {
                throw new CustomException(CustomStatusCode.UpdateInterviewWithSendedOffers);
            }

            return candidacy;
        }

        #endregion

        #region Interview for EmployeeExit
        /// <summary>
        /// verify that employeeExit has a collaborator assigned to it
        /// </summary>
        /// <param name="idEmployeeExit"></param>
        /// <returns></returns>
        private ExitEmployee VerifyEmployeeExitViolation(int idEmployeeExit)
        {
            ExitEmployee employeeExit = _employeeExitEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == idEmployeeExit, c => c.IdEmployeeNavigation);

            if (employeeExit.IdEmployeeNavigation == null)
            {
                throw new CustomException(CustomStatusCode.NotFound, null, null);
            }

            return employeeExit;
        }

        /// can only be used to get interview associated to Employee Exit Meeting
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        private Interview GetInterviewByIdForEmployeeExitMeeting(InterviewViewModel interview)
        {
            return _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == interview.Id,
                x => x.IdExitEmployeeNavigation, x => x.IdExitEmployeeNavigation.IdEmployeeNavigation);
        }
        #endregion

        #region interview mark

        /// <summary>
        /// confirm the availability of selected interviewer and confirm interview if all required interviewrs are confirmed
        /// </summary>
        /// <param name="interviewMark"></param>
        /// <param name="userMail"></param>
        public void ConfirmAvailabilityForTheInterview(InterviewMarkViewModel interviewMark, string userMail)
        {
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            try
            {
                if (RoleHelper.HasPermission(RHPermissionConstant.CONFIRM_DISPONIBILITY) || connectedEmployee.Id == interviewMark.IdEmployee)
                {
                    if (interviewMark != null && interviewMark.Status == (int)InterviewMarkEnumerator.InterviewMarkRequestedToInterviewer)
                    {
                        BeginTransaction();
                        interviewMark.Status = (int)InterviewMarkEnumerator.InterviewerAvailabilityConfirmed;
                        _serviceInterviewMark.UpdateModelWithoutTransaction(interviewMark, null, userMail);
                        if (interviewMark.IdInterviewNavigation.IdCandidacy != null)
                        {
                            CheckCandidacyAndCheckRecruitmentState(interviewMark);
                        }

                        if (CheckConfirmationOfAllIRequiredInterviewer(interviewMark))
                        {
                            ConfirmInterview(interviewMark);
                        }
                        EndTransaction();

                    }
                }

            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Check if candidacy satisfy the required condition for validation
        /// </summary>
        /// <param name="interviewMark"></param>
        /// <param name="userMail"></param>
        private void CheckCandidacyAndCheckRecruitmentState(InterviewMarkViewModel interviewMark)
        {
            Candidacy candidacy = _candidacyEntityRepo.GetSingleWithRelations(c => c.Id == interviewMark.IdInterviewNavigation.IdCandidacy,
                        c => c.IdCandidateNavigation, c => c.IdRecruitmentNavigation);

            if (candidacy.IdRecruitmentNavigation == null)
            {
                throw new CustomException(CustomStatusCode.Unauthorized, null, null);
            }

            if (candidacy.IdRecruitmentNavigation.State == (int)RecruitmentStateEnumerator.Closed)
            {
                throw new CustomException(CustomStatusCode.UpdateClosedRecruitmentViolation);
            }

            List<Offer> offer = _offerEntityRepo.FindByAsNoTracking(result => result.IdCandidacy.Equals(candidacy.Id) &&
                                                           (result.State >= (int)OfferStateEnumerator.Sended)).ToList();
            if (offer.Any())
            {
                throw new CustomException(CustomStatusCode.UpdateInterviewWithSendedOffers);
            }
        }

        /// <summary>
        /// check if all required interviewer are confirmed
        /// </summary>
        /// <param name="interviewMark"></param>
        /// <returns></returns>
        private bool CheckConfirmationOfAllIRequiredInterviewer(InterviewMarkViewModel interviewMark)
        {
            bool interviewStatusIsValid = interviewMark.IdInterviewNavigation.Status == (int)InterviewEnumerator.InterviewRequestedToAllInterviewers;
            bool allInterviewMarkConfirmed = !_serviceInterviewMark.GetModelsWithConditionsRelations(x => x.Id != interviewMark.Id &&
                        x.IdInterview == interviewMark.IdInterview &&
                        x.IsRequired &&
                        x.Status == (int)InterviewMarkEnumerator.InterviewMarkRequestedToInterviewer).ToList().Any();
            return interviewStatusIsValid &&
                        interviewMark.IsRequired &&
                        allInterviewMarkConfirmed;
        }

        /// <summary>
        /// confirm interview
        /// </summary>
        /// <param name="interviewMark"></param>
        private void ConfirmInterview(InterviewMarkViewModel interviewMark)
        {
            Interview interview = _entityRepo.GetSingleWithRelations(x => x.Id == interviewMark.IdInterview, x => x.IdCreatorNavigation, x => x.IdEmailNavigation, x => x.IdInterviewTypeNavigation);
            interview.Status = (int)InterviewEnumerator.AllInterviewersAvailabilityConfirmed;
            bool automaticSending = GetCurrentCompany().AutomaticCandidateMailSending;
            if (automaticSending)
            {
                string senderEmail = "";
                User user = new User();
                if (interview.IdReview.HasValue)
                {
                    Review currentReview = _reviewEntityRepo.GetSingleWithRelationsNotTracked(x => x.Id == interview.IdReview.Value, x => x.IdManagerNavigation);
                    user = _userEntityRepo.GetSingleNotTracked(x => x.IdEmployee == currentReview.IdEmployeeCollaborator);
                    senderEmail = currentReview.IdManagerNavigation != null ? currentReview.IdManagerNavigation.Email :
                        ActiveAccountHelper.GetConnectedUserEmail();
                }
                else
                {
                    senderEmail = ActiveAccountHelper.GetConnectedUserEmail();
                    user = _userEntityRepo.GetSingleNotTracked(u => u.Email == senderEmail);
                }
                interview.Status = (int)InterviewEnumerator.InterviewRequestedToCandidate;
                InterviewViewModel interviewViewModel = _builder.BuildEntity(interview);
                EmailViewModel generatedEmail = PrepareAndSendOrResendEmployeeOrCandidateInvitationMail(interviewViewModel, user.Lang, senderEmail, null);
                _serviceEmail.PrepareAndSendEmail(generatedEmail, senderEmail, _smtpSettings);
                interview.IdEmail = generatedEmail.Id;
            }
            _entityRepo.Update(interview);
            _unitOfWork.Commit();
        }
        /// <summary>
        /// check if the interview date is greater than or equal to the recruitment creation date
        /// </summary>
        /// <param name="interview"></param>
        private void CheckInterviewDateWithRecruitmentCreationDate(InterviewViewModel interview)
        {
            Candidacy candidacy = _candidacyEntityRepo.GetSingleWithRelationsNotTracked(c => c.Id == interview.IdCandidacy, c => c.IdRecruitmentNavigation);
            if (interview.InterviewDate.BeforeDate(candidacy.IdRecruitmentNavigation.CreationDate))
            {
                throw new CustomException(CustomStatusCode.InterviewDateBeforeRecuirmentCreationDate);
            }

        }

        /// <summary>
        /// check if there is an interview at the same time for the same candidate and interview type
        /// <param name="interview"></param>
        private void CheckInterviewDuplication(InterviewViewModel interview)
        {
            List<InterviewViewModel> parallelInterviews = GetAllModelsQueryable(x => x.Id != interview.Id && x.InterviewDate.Date.Equals(interview.InterviewDate.Date)
            && x.EndTime.Equals(interview.EndTime) && x.IdInterviewType == interview.IdInterviewType && x.InterviewDate.TimeOfDay.Equals(interview.StartTime)).ToList();

            if (parallelInterviews.Any())
            {
                throw new CustomException(CustomStatusCode.InterviewDuplication);
            }
        }

        #endregion


    }
}
