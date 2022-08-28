using Newtonsoft.Json;
using Persistence.Entities;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Text;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Extensions;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes.ServiceReview
{
    public partial class ServiceReview
    {
        private string PrepareMailSubjectForAnnualInterviewReminder(AnnualReviewEmailConstant emailConstant)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.AnnualInterview).Append(emailConstant.Reminder);
            return subject.ToString();
        }

        private string PrepareMailBodyForAnnualInterviewReminder(AnnualReviewEmailConstant annualReviewEmailConstant, EmployeeViewModel employee)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@annualReviewEmailConstant.AnnualReviewTemplate);
            body = body.Replace("{EMPLOYEE_GENDER}", annualReviewEmailConstant._lang.GetTheCurrentLanguageCivilityFromGender(employee.Sex), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_NAME}", employee.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{REVIEW_DATE}", NextAnnualReviewDate(employee.HiringDate).Date + "", StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DAYS_BEFORE_REVIEW}", DaysBeforeReview(employee.HiringDate).ToString(), StringComparison.OrdinalIgnoreCase);
            return body;
        }

        private EmailViewModel PrepareAndSendMailForAnnualReview(string receiverLang, string userMail, EmployeeViewModel employee, SmtpSettings smtpSettings)
        {
            AnnualReviewEmailConstant annualReviewEmailConstant = new AnnualReviewEmailConstant(receiverLang ?? "fr");
            string subject = PrepareMailSubjectForAnnualInterviewReminder(annualReviewEmailConstant);
            string body = PrepareMailBodyForAnnualInterviewReminder(annualReviewEmailConstant, employee);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = employee.Email
            };
            // add the email in the db
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            return generatedEmail;
        }

        private void SendMailAndNotifForAnnualInterview(string userMail, SmtpSettings smtpSettings, EmployeeViewModel employee)
        {

            // Send mail target user employee  
            User targetUser = _userEntityRepo.GetSingleNotTracked(user => user.IdEmployee == employee.Id);
            EmailViewModel generatedEmail = PrepareAndSendMailForAnnualReview(targetUser.Lang, userMail, employee, smtpSettings);

            List<User> targetUsers = new List<User>();
            targetUsers.Add(targetUser);

            // send notification

            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["REVIEW_DATE"] = NextAnnualReviewDate(employee.HiringDate),
                ["REVIEW_DAYS_NUMBER"] = DaysBeforeReview(employee.HiringDate)
            };
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.ANNUAL_REVIEW,
            generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.AnnualReviewNotif,
            Constants.DO_NOT_REPLY_EMAIL, parameters, targetUsers);
        }

    }
}
