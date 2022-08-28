using Newtonsoft.Json;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes.ServiceInterview
{
    public partial class ServiceInterview
    {
        #region general email methods

        private EmailViewModel SendEmailToInterviewer(string userMail, EmailViewModel generatedEmail, InterviewViewModel interview)
        {
            if(interview.Id != NumberConstant.Zero) { 
            generatedEmail.InterviewEmail = new List<InterviewEmailViewModel>
            {
                new InterviewEmailViewModel
                {
                    IdInterview = interview.Id,
                    IdEmail = generatedEmail.Id,
                    CreationDate = DateTime.Now
                }
            };
            }
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
 
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, _smtpSettings);
            return generatedEmail;
        }

        /// <summary>
        /// getting the sender using connected user Mail
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private User GetSenderByUserMail(string userMail)
        {
            return _userEntityRepo.GetSingleWithRelationsNotTracked(u => u.Email.ToLower() == userMail.ToLower(), u => u.IdEmployeeNavigation);
        }

        #endregion

        #region Interview mail

        /// <summary>
        /// prepare mail body for interviewer for annual review invitation
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <param name="annualReviewEmailConstant"></param>
        /// <param name="interviewer"></param>
        /// <param name="requiredInterviewers"></param>
        /// <param name="optionalInterviewers"></param>
        /// <returns></returns>
        string PrepareInterviewInvitationMailBody(InterviewViewModel interview, string lang, string userMail, AnnualReviewEmailConstant annualReviewEmailConstant,
            EmployeeViewModel interviewer, List<EmployeeViewModel> requiredInterviewers, List<EmployeeViewModel> optionalInterviewers)
        {
            User user = GetSenderByUserMail(userMail);
            string interviewDate = DateUtility.GenerateDateByCulture(interview.InterviewDate, lang);
            string interviewTime="";
            string body = "";
            interviewTime = DateUtility.GenerateTimeByCulture(interview.InterviewDate, lang);
            string employeeFullName = interview.IdReview.HasValue ? VerifyReviewViolation(interview.IdReview.Value).IdEmployeeCollaboratorNavigation.FullName :
                interview.IdExitEmployee.HasValue ? VerifyEmployeeExitViolation(interview.IdExitEmployee.Value).IdEmployeeNavigation.FullName :
                interview.IdCandidacyNavigation.IdCandidateNavigation.FullName;
            string interviewType = interview.IdReview.HasValue ? annualReviewEmailConstant.AnnualReviewInterview : interview.IdExitEmployee.HasValue ?
                annualReviewEmailConstant.EmployeeExitMeeting : annualReviewEmailConstant.Interview;
            if (interview.IdCandidacy.HasValue)
            {
                interviewType += PayRollConstant.BlankSpace + _interviewTypeRepo.GetSingleNotTracked(x => x.Id == interview.IdInterviewType).Label;
            }
            body = _serviceEmail.GetEmailHtmlContentFromFile(@annualReviewEmailConstant.InterviewInvitationTemplate);
            body = body.Replace("{EMPLOYEE_NAME}", employeeFullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEW_TYPE}", interviewType, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{OF}", annualReviewEmailConstant.Of);
            body = body.Replace("{INTERVIEW_DATE}", interviewDate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEW_HOUR}", interviewTime, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", user.IdEmployeeNavigation != null ? user.IdEmployeeNavigation.FullName : user.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEWER_GENDER}", lang.GetTheCurrentLanguageCivilityFromGender(interviewer.Sex)
                , StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEWER_NAME}", interviewer != null ? interviewer.FirstName : "", StringComparison.OrdinalIgnoreCase);
            if (requiredInterviewers != null)
            {
                body = body.Replace("{REQUIRED_INTERVIEWERS_LIST}", GenerateInterviewersList(annualReviewEmailConstant, requiredInterviewers, true), StringComparison.OrdinalIgnoreCase);
                if (optionalInterviewers.Count > NumberConstant.Zero)
                {
                    body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", GenerateInterviewersList(annualReviewEmailConstant, optionalInterviewers, false), StringComparison.OrdinalIgnoreCase);
                }
                else
                {
                    body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
                }
            }
            else
            {
                body = body.Replace("{REQUIRED_INTERVIEWERS_LIST}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
                body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
            }
            return body;
        }

        /// <summary>
        /// Generate interviewers list template
        /// </summary>
        /// <param name="annualReviewEmailConstant"></param>
        /// <param name="interviewers"></param>
        /// <param name="isRequired"></param>
        /// <returns></returns>
        private string GenerateInterviewersList(AnnualReviewEmailConstant annualReviewEmailConstant, List<EmployeeViewModel> interviewers, bool isRequired)
        {
            StringBuilder interviewersTable = new StringBuilder();
            interviewersTable.Append("<table>");
            interviewersTable.Append("<thead>");
            interviewersTable.Append("<th>");
            if (isRequired)
            {
                interviewersTable.Append(annualReviewEmailConstant.RequiredInterviewers);
            }
            else
            {
                interviewersTable.Append(annualReviewEmailConstant.OptionalInterviewers);
            }
            interviewersTable.Append("</th>");
            interviewersTable.Append("</thead>");
            interviewersTable.Append("<tbody>");
            if (interviewers != null)
            {
                interviewers.ForEach(interviewer =>
                {
                    interviewersTable.Append("<tr>");
                    interviewersTable.Append("<td>");
                    interviewersTable.Append(interviewer.FullName);
                    interviewersTable.Append("</td>");
                    interviewersTable.Append("<tr/>");
                });
            }
            interviewersTable.Append("</tbody>");
            interviewersTable.Append("</table>");
            return interviewersTable.ToString();
        }

        /// <summary>
        /// Send interview invitation mail
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="userMail"></param>
        /// <param name="interviewer"></param>
        /// <param name="requiredInterviewers"></param>
        /// <param name="optionalInterviewers"></param>
        /// <param name="dateHasChanged"></param>
        /// <param name="oldDate"></param>
        /// <returns></returns>
        private EmailViewModel SendInterviewInvitationMail(InterviewViewModel interview, string userMail, EmployeeViewModel interviewer, List<EmployeeViewModel> requiredInterviewers = null,
            List<EmployeeViewModel> optionalInterviewers = null, bool dateHasChanged = false, DateTime? oldDate = null)
        {
            User user = _userEntityRepo.FindSingleBy(u => u.IdEmployee == interviewer.Id);
            string lang = null;
            if (user != null && user.Lang.NotNullOrEmpty())
            {
                lang = user.Lang;
            }
            AnnualReviewEmailConstant annualReviewEmailConstant = new AnnualReviewEmailConstant(lang ?? "en");
            string emailSubject = "";
            if (interviewer.IsAlreadyAnInterviewer && !dateHasChanged)
            {
                emailSubject = annualReviewEmailConstant.UpdateInterviewersList;
            }
            else if (dateHasChanged)
            {
                emailSubject = annualReviewEmailConstant.PostponedInterview;
            }
            else if (interview.IdCandidacy.HasValue)
            {
                emailSubject = annualReviewEmailConstant.InterviewerInvitationForInterview;
            } 
            else if (interview.IdReview.HasValue)
            {
                emailSubject = annualReviewEmailConstant.AnnualInterviewInterviewerInvitation;
            }
            else if (interview.IdExitEmployee.HasValue)
            {
                emailSubject = annualReviewEmailConstant.ExitEmployeeInterviewInvitationForInterviewer;
            }
            EmailViewModel generatedEmail = new EmailViewModel
            {
                Subject = emailSubject,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = interviewer.Email
            };
            if (dateHasChanged)
            {
                generatedEmail.Body = PreparePostponedInterviewInvitationMailBody(interview, lang, userMail, annualReviewEmailConstant, interviewer, requiredInterviewers, optionalInterviewers,
                    oldDate.Value);
            }
            else
            {
                generatedEmail.Body = PrepareInterviewInvitationMailBody(interview, lang, userMail, annualReviewEmailConstant, interviewer, requiredInterviewers, optionalInterviewers);
            }
            return SendEmailToInterviewer(userMail, generatedEmail, interview);
        }

        private string PreparePostponedInterviewInvitationMailBody(InterviewViewModel interview, string lang, string userMail, AnnualReviewEmailConstant annualReviewEmailConstant,
            EmployeeViewModel interviewer, List<EmployeeViewModel> requiredInterviewers, List<EmployeeViewModel> optionalInterviewers, DateTime oldDate)
        {
            string body = "";
            User user = GetSenderByUserMail(userMail);
            body = _serviceEmail.GetEmailHtmlContentFromFile(@annualReviewEmailConstant.PostponedInterviewEmailInvitationTemplate);
            string employeeFullName = interview.IdReview.HasValue ? VerifyReviewViolation(interview.IdReview.Value).IdEmployeeCollaboratorNavigation.FullName :
                interview.IdExitEmployee.HasValue ? VerifyEmployeeExitViolation(interview.IdExitEmployee.Value).IdEmployeeNavigation.FullName :
                VerifyViolations(interview).IdCandidateNavigation.FullName;
            body = body.Replace("{INTERVIEWER_GENDER}", lang.GetTheCurrentLanguageCivilityFromGender(interviewer.Sex), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEWER_NAME}", interviewer.FirstName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_NAME}", employeeFullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{OF}", annualReviewEmailConstant.Of);
            body = body.Replace("{OLD_INTERVIEW_DATE}", DateUtility.GenerateDateByCulture(oldDate, lang), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{OLD_INTERVIEW_HOUR}", DateUtility.GenerateTimeByCulture(oldDate, lang), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEW_INTERVIEW_DATE}", DateUtility.GenerateDateByCulture(interview.InterviewDate, lang), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEW_INTERVIEW_HOUR}", DateUtility.GenerateTimeByCulture(interview.InterviewDate, lang), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", user.IdEmployeeNavigation != null ? user.IdEmployeeNavigation.FullName : user.FullName, StringComparison.OrdinalIgnoreCase);
            if (requiredInterviewers != null)
            {
                body = body.Replace("{REQUIRED_INTERVIEWERS_LIST}", GenerateInterviewersList(annualReviewEmailConstant, requiredInterviewers, true), StringComparison.OrdinalIgnoreCase);
                if (optionalInterviewers.Count > NumberConstant.Zero)
                {
                    body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", GenerateInterviewersList(annualReviewEmailConstant, optionalInterviewers, false), StringComparison.OrdinalIgnoreCase);
                }
                else
                {
                    body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
                }
            }
            else
            {
                body = body.Replace("{REQUIRED_INTERVIEWERS_LIST}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
                body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
            }
            return body;
        }
        /// <summary>
        /// prepare and send invitation email for all interviewers
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <param name="dateHasChanged"></param>
        /// <param name="oldDate"></param>
        private void PrepareAndSendInvitationEmailForAllInterviewers(InterviewViewModel interview, string userMail, bool dateHasChanged, DateTime oldDate)
        {
            List<EmployeeViewModel> requiredInterviewers = new List<EmployeeViewModel>();
            List<EmployeeViewModel> optionalInterviewers = new List<EmployeeViewModel>();
            if (interview.InterviewMark != null)
            {
                requiredInterviewers = GetEmployeeListOfRequiredInterviewers(interview.InterviewMark.Where(x => x.IsRequired).ToList());
            }
            if (interview.OptionalInterviewMark != null)
            {
                optionalInterviewers = GetEmployeeListOfRequiredInterviewers(interview.OptionalInterviewMark.ToList());
            }
            foreach (EmployeeViewModel employee in requiredInterviewers)
            {
                SendInterviewInvitationMail(interview, userMail, employee, requiredInterviewers, optionalInterviewers, dateHasChanged, oldDate);
            }
            foreach (EmployeeViewModel employee in optionalInterviewers)
            {
                SendInterviewInvitationMail(interview, userMail, employee, requiredInterviewers, optionalInterviewers, dateHasChanged, oldDate);
            }
        }

        /// <summary>
        /// Resend email to interviewer
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="idInterviewer"></param>
        /// <param name="userMail"></param>
        public void ResendEmailToInterviewer(InterviewViewModel interview, int idInterviewer, string userMail)
        {
            List<EmployeeViewModel> requiredInterviewers = new List<EmployeeViewModel>();
            List<EmployeeViewModel> optionalInterviewers = new List<EmployeeViewModel>();
            if (interview.InterviewMark != null)
            {
                requiredInterviewers = GetEmployeeListOfRequiredInterviewers(interview.InterviewMark.Where(x => x.IsRequired).ToList());
            }
            if (interview.OptionalInterviewMark != null)
            {
                optionalInterviewers = GetEmployeeListOfRequiredInterviewers(interview.OptionalInterviewMark.ToList());
            }
            EmployeeViewModel employee = _serviceEmployee.GetModelById(idInterviewer);
            SendInterviewInvitationMail(interview, userMail, employee, requiredInterviewers, optionalInterviewers);
        }

        #endregion

        #region Mail cancellation

        /// <summary>
        /// send a cancellation email to employee and interviewers
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="userMail"></param>
        /// <param name="status"></param>
        private void PrepareAndSendInterviewCancellationEmail(InterviewViewModel interview, string userMail, int status = 0)
        {

            // send mail employee
            EmployeeViewModel employee = new EmployeeViewModel();
            if (interview.IdReview.HasValue)
            {
                Review review = VerifyReviewViolation(interview.IdReview.Value);

                employee.Id = review.IdEmployeeCollaboratorNavigation.Id;
                employee.Email = review.IdEmployeeCollaboratorNavigation.Email;
                employee.Sex = review.IdEmployeeCollaboratorNavigation.Sex;
                employee.FirstName = review.IdEmployeeCollaboratorNavigation.FirstName;

            }
            else if (interview.IdExitEmployee.HasValue)
            {
                ExitEmployee employeeExit = VerifyEmployeeExitViolation(interview.IdExitEmployee.Value);

                employee.Id = employeeExit.IdEmployeeNavigation.Id;
                employee.Email = employeeExit.IdEmployeeNavigation.Email;
                employee.Sex = employeeExit.IdEmployeeNavigation.Sex;
                employee.FirstName = employeeExit.IdEmployeeNavigation.FirstName;

            }
            status = status == NumberConstant.Zero ? interview.Status : status;
            if (status != NumberConstant.Zero && (status == (int)InterviewEnumerator.InterviewConfirmedByCandidate || status == (int)InterviewEnumerator.InterviewRequestedToCandidate))
            {
                SendInterviewCancellationMail(interview, userMail, employee);
            }
            // send mail to required interviewer
            if (interview.InterviewMark != null)
            {
                foreach (EmployeeViewModel interviewer in GetEmployeeListOfRequiredInterviewers(interview.InterviewMark.Where(x => x.IsRequired).ToList()))
                {
                    SendInterviewCancellationMail(interview, userMail, interviewer);
                }
            }
            // send mail to optional interviewer
            if (interview.OptionalInterviewMark != null)
            {
                foreach (EmployeeViewModel interviewer in GetEmployeeListOfRequiredInterviewers(interview.OptionalInterviewMark.ToList()))
                {
                    SendInterviewCancellationMail(interview, userMail, interviewer);
                }
            }
        }

        /// <summary>
        /// prepare cancellation body 
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <param name="annualReviewEmailConstant"></param>
        /// <param name="receiver"></param>
        /// <returns></returns>
        string PrepareInterviewCancellationMailBody(InterviewViewModel interview, string lang, string userMail, AnnualReviewEmailConstant annualReviewEmailConstant, EmployeeViewModel receiver)
        {
            User creator = GetSenderByUserMail(userMail);
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@annualReviewEmailConstant.InterviewMailCancellationTemplate);
            body = body.Replace("{INTERVIEW_DATE}", DateUtility.GenerateDateByCulture(interview.InterviewDate, lang), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEW_TIME}", DateUtility.GenerateTimeByCulture(interview.InterviewDate, lang), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", creator.IdEmployeeNavigation != null ? creator.IdEmployeeNavigation.FullName : creator.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{RECIEVER_GENDER}", lang.GetTheCurrentLanguageCivilityFromGender(receiver.Sex)
                , StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{RECIEVER_NAME}", receiver != null ? receiver.FirstName : "", StringComparison.OrdinalIgnoreCase);
            Employee employee = interview.IdReview.HasValue ? VerifyReviewViolation(interview.IdReview.Value).IdEmployeeCollaboratorNavigation :
                interview.IdExitEmployee.HasValue ? VerifyEmployeeExitViolation(interview.IdExitEmployee.Value).IdEmployeeNavigation :
                new Employee
                {
                    Id = NumberConstant.Zero,
                    FirstName = VerifyViolations(interview).IdCandidateNavigation.FullName,
                    LastName = ""
                };
            if (employee.Id == receiver.Id)
            {
                body = body.Replace("{RECEIVER_TYPE}", @annualReviewEmailConstant.SamePerson, StringComparison.OrdinalIgnoreCase);
                body = body.Replace("{EMPLOYEE_NAME}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
            }
            else
            {
                body = body.Replace("{RECEIVER_TYPE}", @annualReviewEmailConstant.DifferentPerson, StringComparison.OrdinalIgnoreCase);
                body = body.Replace("{EMPLOYEE_NAME}", employee.FullName, StringComparison.OrdinalIgnoreCase);
            }

            if (interview.Remarks != null)
            {
                body = body.Replace("{CANCELLATION_REASON}", annualReviewEmailConstant.CancellationReason + interview.Remarks, StringComparison.OrdinalIgnoreCase);
            }
            else
            {
                body = body.Replace("{CANCELLATION_REASON}", PayRollConstant.Empty, StringComparison.OrdinalIgnoreCase);
            }
            return body;
        }

        /// <summary>
        /// prepare and send cancellation email
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="userMail"></param>
        /// <param name="receiver"></param>
        /// <returns></returns>
        private EmailViewModel SendInterviewCancellationMail(InterviewViewModel interview, string userMail, EmployeeViewModel receiver)
        {
            User user = _userEntityRepo.FindSingleBy(u => u.IdEmployee == receiver.Id);
            string lang = user != null ? user.Lang : "en";
            AnnualReviewEmailConstant annualReviewEmailConstant = new AnnualReviewEmailConstant(lang);
            string subject = "";
            if (interview.IdReview.HasValue)
            {
                subject = annualReviewEmailConstant.AnnualInterviewCancelInterview;
            }
            else if (interview.IdCandidacy.HasValue)
            {
                subject = annualReviewEmailConstant.CanceledInterview;
            }
            else if (interview.IdExitEmployee.HasValue)
            {
                subject = annualReviewEmailConstant.ExitEmployeeMeetingCancelInterview;
            }
            EmailViewModel generatedEmail = new EmailViewModel
            {
                Subject = subject,
                Body = PrepareInterviewCancellationMailBody(interview, lang, userMail, annualReviewEmailConstant, receiver),
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = receiver.Email
            };
            return SendEmailToInterviewer(userMail, generatedEmail, interview);
        }

        private void SendInterviewAlertNotificationForInterviewer(bool optional, int notificationReference, List<User> targetUsers, IDictionary<string, dynamic> parameters, string userMail,
            InterviewViewModel interview)
        {
            string informationType = "";
            if (optional)
            {
                informationType = interview.IdCandidacy.HasValue ? Constants.ADDED_AS_OPTIONAL_INTERVIEWER_FOR_CANDIDACY_UPPER_CASE
                    : interview.IdReview.HasValue ? Constants.ADDED_AS_OPTIONAL_INTERVIEWER_FOR_REVIEW_UPPER_CASE : Constants.ADDED_AS_OPTIONAL_INTERVIEWER_FOR_EXIT_EMPLOYEE_UPPER_CASE;
            }
            else
            {
                informationType = interview.IdCandidacy.HasValue ? Constants.ADDED_AS_REQUIRED_INTERVIEWER_FOR_CANDIDACY_UPPER_CASE
                  : interview.IdReview.HasValue ? Constants.ADDED_AS_REQUIRED_INTERVIEWER_FOR_REVIEW_UPPER_CASE : Constants.ADDED_AS_REQUIRED_INTERVIEWER_FOR_EXIT_EMPLOYEE_UPPER_CASE;
            }
            if (targetUsers.Count != NumberConstant.Zero)
            {
                _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(informationType,
                notificationReference, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AlertInterviewer,
                userMail, parameters, targetUsers, GetCurrentCompany().Code);
            }

        }

        #endregion
        #region Send mail invitation to employee or candidate
        string PrepareInterviewMailBodyForEmployeeOrCandidate(InterviewViewModel interview, string lang, string userMail, AnnualReviewEmailConstant annualReviewEmailConstant,
                Employee receiver)
        {
            User creator = GetSenderByUserMail(userMail);
            string interviewDate = DateUtility.GenerateDateByCulture(interview.InterviewDate, lang);
            string interviewTime = DateUtility.GenerateTimeByCulture(interview.InterviewDate, lang);
            string interviewType = interview.IdReview.HasValue ? annualReviewEmailConstant.AnnualReview : interview.IdExitEmployee.HasValue ?
                annualReviewEmailConstant.EmployeeExitMeeting : annualReviewEmailConstant.Interview + PayRollConstant.BlankSpace + interview.IdInterviewTypeNavigation.Label;
            string body = _serviceEmail.GetEmailHtmlContentFromFile(annualReviewEmailConstant.InterviewInvitationTemplate);
            body = body.Replace("{INTERVIEW_TYPE}", interviewType, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEWER_GENDER}", lang.GetTheCurrentLanguageCivilityFromGender(receiver.Sex)
                , StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEWER_NAME}", receiver.FirstName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_NAME}", PayRollConstant.Empty);
            body = body.Replace("{OF}", PayRollConstant.Empty);
            body = body.Replace("{INTERVIEW_DATE}", interviewDate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{INTERVIEW_HOUR}", interviewTime, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CREATOR_FULL_NAME}", creator.IdEmployeeNavigation != null ? creator.IdEmployeeNavigation.FullName : creator.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{REQUIRED_INTERVIEWERS_LIST}", PayRollConstant.Empty);
            body = body.Replace("{OPTIONAL_INTERVIEWERS_LIST}", PayRollConstant.Empty);
            return body;
        }
        /// <summary>
        /// send mail invitation to employee
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <param name="annualReviewEmailConstant"></param>
        /// <returns></returns>
        private EmailViewModel SendEmployeeOrCandidateInvitationMail(InterviewViewModel interview, string lang, string userMail, AnnualReviewEmailConstant annualReviewEmailConstant)
        {
            Employee receiver = interview.IdReview.HasValue ? VerifyReviewViolation(interview.IdReview.Value).IdEmployeeCollaboratorNavigation :
                interview.IdExitEmployee.HasValue ? VerifyEmployeeExitViolation(interview.IdExitEmployee.Value).IdEmployeeNavigation :
                new Employee
                {
                    Sex = interview.IdCandidacyNavigation.IdCandidateNavigation.Sex,
                    FirstName = interview.IdCandidacyNavigation.IdCandidateNavigation.FirstName,
                    Email = interview.IdCandidacyNavigation.IdCandidateNavigation.Email
                };
            EmailViewModel generatedEmail = new EmailViewModel
            {
                Subject = interview.IdReview.HasValue ? annualReviewEmailConstant.InterviewerInvitationForInterview :
                    interview.IdExitEmployee.HasValue ? annualReviewEmailConstant.MeetingEmployeeInvitation : annualReviewEmailConstant.InterviewerInvitationForInterview,
                Body = PrepareInterviewMailBodyForEmployeeOrCandidate(interview, lang, userMail, annualReviewEmailConstant, receiver),
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = receiver.Email,
                From = _smtpSettings.AdministratorMail
            };
            generatedEmail.InterviewEmail = new List<InterviewEmailViewModel>
            {
                new InterviewEmailViewModel
                {
                    IdInterview = interview.Id,
                    IdEmail = generatedEmail.Id,
                    CreationDate = DateTime.Now
                }
            };
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            generatedEmail.InterviewEmail = null;
            return generatedEmail;
        }
        /// <summary>
        /// Resend mail to employee or candidate
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <param name="generatedEmail"></param>
        /// <param name="annualReviewEmailConstant"></param>
        private void ResendEmployeeOrCandidateInvitationMail(InterviewViewModel interview, string lang, string userMail, EmailViewModel generatedEmail,
            AnnualReviewEmailConstant annualReviewEmailConstant)
        {
            Employee receiver = interview.IdReview.HasValue ? VerifyReviewViolation(interview.IdReview.Value).IdEmployeeCollaboratorNavigation : interview.IdExitEmployee.HasValue ?
                VerifyEmployeeExitViolation(interview.IdExitEmployee.Value).IdEmployeeNavigation :
                new Employee
                {
                    Sex = interview.IdCandidacyNavigation.IdCandidateNavigation.Sex,
                    FirstName = interview.IdCandidacyNavigation.IdCandidateNavigation.FirstName,
                    Email = interview.IdCandidacyNavigation.IdCandidateNavigation.Email
                };
            generatedEmail.From = _smtpSettings.AdministratorMail;
            generatedEmail.Subject = interview.IdReview.HasValue ? annualReviewEmailConstant.InterviewerInvitationForInterview : annualReviewEmailConstant.MeetingEmployeeInvitation;
            generatedEmail.Body = PrepareInterviewMailBodyForEmployeeOrCandidate(interview, lang, userMail, annualReviewEmailConstant, receiver);
            _serviceEmail.UpdateModelWithoutTransaction(generatedEmail, null, userMail);
        }
        /// <summary>
        /// prepare and send or resend mail invitation
        /// </summary>
        /// <param name="interview"></param>
        /// <param name="lang"></param>
        /// <param name="userMail"></param>
        /// <param name="generatedEmail"></param>
        /// <returns></returns>
        private EmailViewModel PrepareAndSendOrResendEmployeeOrCandidateInvitationMail(InterviewViewModel interview, string lang, string userMail, EmailViewModel generatedEmail)
        {
            AnnualReviewEmailConstant annualReviewEmailConstant = new AnnualReviewEmailConstant(lang ?? "fr");

            if (generatedEmail == null)
            {
                return SendEmployeeOrCandidateInvitationMail(interview, lang, userMail, annualReviewEmailConstant);
            }
            else
            {
                ResendEmployeeOrCandidateInvitationMail(interview, lang, userMail, generatedEmail, annualReviewEmailConstant);
                return generatedEmail;
            }
        }

        #endregion

        /// <summary>
        /// Confirm the candiate diponibility 
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="token"></param>
        /// <returns></returns>
        public int ConfirmTheCandidateDisponibilityFromLink(string connectionString, string token)
        {
            int state = NumberConstant.Zero;
            try
            {
                BeginTransaction(connectionString);
                Interview interview = _entityRepo.GetSingleNotTracked(x => x.Token == token);
                if (interview != null && interview.Status == (int)InterviewEnumerator.InterviewRequestedToCandidate)
                {
                    ConfirmTheCandidateDisponibility(_builder.BuildEntity(interview));
                    state = (int)InterviewConfirmationEnumerator.InterviewConfirmed;
                }
                else if (interview != null && interview.Status == (int)InterviewEnumerator.InterviewConfirmedByCandidate)

                {
                    state = (int)InterviewConfirmationEnumerator.InterviewAlreadyConfirmed;
                }
                else
                {
                    state = (int)InterviewConfirmationEnumerator.InvalidUrl;
                }
                EndTransaction();
            }
            catch (Exception e)
            {
                throw;
            }
            return state;
        }
    }
}
