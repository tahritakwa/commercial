using Newtonsoft.Json;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes.ServiceTimeSheet
{
    public partial class ServiceTimeSheet
    {
        /// <summary>
        /// send mail to fill or send or validate a timesheet depending in the timesheet state
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <param name="userMail"> connected user</param>
        public int SendEmail(int idEmployee, DateTime startDate, string userMail)
        {
            string monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(startDate.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR")));
            TimeSheetViewModel timeSheet = FindModelsByNoTracked(x => x.IdEmployee.Equals(idEmployee) &&
                DateTime.Compare(x.Month.Date, new DateTime(startDate.Year, startDate.Month, NumberConstant.One)) == NumberConstant.Zero,
                 x => x.IdEmployeeNavigation)
                .FirstOrDefault();
            ReducedTimeSheetViewModel timeSheetReduced = new ReducedTimeSheetViewModel();
            if (timeSheet != null)
            {
                timeSheetReduced = new ReducedTimeSheetViewModel(timeSheet);
            }
            EmailViewModel generatedEmail = new EmailViewModel();
            // notif params
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["MONTH"] = monthAndYear.ToString()
            };
            if (timeSheetReduced.Id == NumberConstant.Zero || (timeSheetReduced.Id > NumberConstant.Zero && (timeSheetReduced.Status == (int)TimeSheetStatusEnumerator.Draft
                || timeSheetReduced.Status == (int)TimeSheetStatusEnumerator.ToReWork)))
            {
                UserViewModel user = _serviceEmployee.GetUserByIdEmployee(idEmployee);
                string receiverLang = "";
                string receiverEmail = "";
                string EmployeeName = "";
                if (user == null)
                {
                    receiverLang = "fr";
                    var employee = _serviceEmployee.GetModelById(idEmployee);
                    receiverEmail = employee.Email;
                    EmployeeName = employee.FullName;
                }
                else
                {
                    receiverLang = user.Lang;
                    EmployeeName = user.FirstName + " " + user.LastName;
                    receiverEmail = user.Email;
                    if (user.Lang != null && user.Lang.Equals("en"))
                    {
                        monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(startDate.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("en-En")));
                    }
                }
                parameters["MONTH"] = monthAndYear.ToString();
                parameters["EMPLOYEE"] = EmployeeName;
                generatedEmail = PrepareAndSendMail(receiverLang, receiverEmail, userMail, timeSheetReduced, monthAndYear.ToString());
            }
            else
            {
                if (timeSheetReduced.Id > NumberConstant.Zero && timeSheetReduced.Status == (int)TimeSheetStatusEnumerator.Sended)
                {
                    // send mail to all superiors to validate the timesheet
                    List<UserViewModel> superiors = _serviceEmployee.GetSuperiorsEmployeeAsUsers(idEmployee, false);
                    parameters["EMPLOYEE"] = timeSheetReduced.IdEmployeeNavigation.FullName;
                    foreach (UserViewModel superior in superiors)
                    {
                        if (superior.Lang != null && superior.Lang.Equals("en"))
                        {
                            monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(startDate.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("en-En")));
                        }
                        else
                        {
                            monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(startDate.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR")));
                        }
                        parameters["MONTH"] = monthAndYear.ToString();
                        generatedEmail = PrepareAndSendMail(superior.Lang, superior.Email, userMail, timeSheetReduced, monthAndYear.ToString());
                    }
                }
            }
            // send notif to connected user to notify that an email has been sended 
            UserViewModel connectedUser = _serviceEmployee.GetUserByUserMail(userMail);
            int entityId = timeSheet != null ? timeSheet.Id : NumberConstant.Zero;
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(checkInfoType(timeSheetReduced),
            entityId, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.TimesheetNotif,
            userMail, parameters, new List<User> { _userBuilder.BuildModel(connectedUser) }, GetCurrentCompany().Code);
            return timeSheetReduced.Status != NumberConstant.Zero ? timeSheetReduced.Status : (int)TimeSheetStatusEnumerator.ToDo;
        }

        public EmailViewModel PrepareAndSendMail(string receiverLang, string receiverEmail, string userMail, ReducedTimeSheetViewModel timeSheet,
            string monthAndYear, bool correctionRequestSubject = false, bool validationSubject = false, bool validationRequestSubject = false)
        {
            EmailConstant emailConstant = new EmailConstant(receiverLang ?? "fr");
            string subject = PrepareMailSubject(emailConstant, monthAndYear, correctionRequestSubject, validationSubject, validationRequestSubject);
            string body = PrepareMailBody(emailConstant, timeSheet, monthAndYear);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = receiverEmail
            };
            // add the email in the db
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, _smtpSettings);
            return generatedEmail;
        }

        /// <summary>
        /// Prepare Mail body depending with the timsheet state
        /// </summary>
        /// <param name="emailConstant"></param>
        /// <param name="timeSheet"></param>
        /// <returns></returns>
        public string PrepareMailBody(EmailConstant emailConstant, ReducedTimeSheetViewModel timeSheet, string monthaAndYear)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.TimeSheetTemplate);
            StringBuilder message = new StringBuilder();
            if (timeSheet.Id == NumberConstant.Zero && timeSheet.Status == NumberConstant.Zero)
            {
                // send mail to fill timesheet
                message.Append(emailConstant.TimesheetFillingRequestMessage).Append(" ").Append(monthaAndYear);
            }
            else
            {
                switch (timeSheet.Status)
                {
                    case (int)TimeSheetStatusEnumerator.Draft:
                        // send mail to send timesheet
                        message.Append(emailConstant.TimesheetSubmissionRequestMessage).Append(" ").Append(monthaAndYear);
                        break;

                    case (int)TimeSheetStatusEnumerator.ToReWork:
                        // send mail to validate timesheet
                        message.Append(emailConstant.TimesheeRequestCorrection).Append(monthaAndYear).Append(emailConstant.TimesheetEmployeeName)
                                .Append(timeSheet.IdEmployeeNavigation.FullName).Append(" ").Append(emailConstant.TimesheetCorrectionRequestMessage);
                        break;

                    case (int)TimeSheetStatusEnumerator.Sended:
                        // send mail to validate timesheet
                        message.Append(emailConstant.TimesheetValidationRequestMessage).Append(" ").Append(monthaAndYear)
                          .Append(" ").Append(emailConstant.ForEmployee).Append(" ").Append(timeSheet.IdEmployeeNavigation.FullName);
                        break;
                    case (int)TimeSheetStatusEnumerator.Validated:
                        if (timeSheet.IdEmployeeTreatedNavigation is null)
                        {
                            timeSheet.IdEmployeeTreatedNavigation = new EmployeeViewModel(true);
                        }
                        // send mail to validate timesheet
                        message.Append(timeSheet.IdEmployeeTreatedNavigation.FullName).Append(" ").Append(emailConstant.TimesheetValidationMessage).Append(" ").Append(monthaAndYear)
                            .Append(" ").Append(emailConstant.TimesheetEmployeeName).Append(timeSheet.IdEmployeeNavigation.FullName);
                        break;
                    default:
                        break;

                }
            }

            body = body.Replace("{MESSAGE}", message.ToString(), StringComparison.OrdinalIgnoreCase);
            return body;
        }

        /// <summary>
        /// Prepare Mail subject depending with the timsheet state
        /// </summary>
        /// <param name="emailConstant"></param>
        /// <param name="timeSheet"></param>
        /// <returns></returns>
        public string PrepareMailSubject(EmailConstant emailConstant, string monthAndYear,
                        bool correctionRequestSubject = false, bool validationSubject = false, bool validationRequestSubject = false)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.TimeSheet).Append(" ").Append(monthAndYear);
            if (correctionRequestSubject)
            {
                subject.Append(emailConstant.TimesheetCorrectionSubject);
            }
            if (validationSubject)
            {
                subject.Append(emailConstant.TimesheetValidationSubject);
            }
            if (validationRequestSubject)
            {
                subject.Append(emailConstant.TimesheetValidationRequestSubject);
            }
            return subject.ToString();
        }

        public void SendNotifForTimesheetSubmission(string userMail, EmployeeViewModel connectedEmployee, int idTimesheet)
        {
            string monthAndYear;
            TimeSheetViewModel timesheet = GetModelAsNoTracked(x => x.Id == idTimesheet, x => x.IdEmployeeNavigation);
            ReducedTimeSheetViewModel reducedTimesheet = new ReducedTimeSheetViewModel(timesheet);
            EmailViewModel generatedEmail = new EmailViewModel();
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["EMPLOYEE"] = reducedTimesheet.IdEmployeeNavigation.FullName
            };
            parameters["VALIDATOR"] = connectedEmployee.FullName;
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(reducedTimesheet.IdEmployee);
            foreach (UserViewModel user in userList)
            {
                if (user.Lang != null && user.Lang.Equals("en"))
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(reducedTimesheet.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("en-En")));
                }
                else
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(reducedTimesheet.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR")));
                }
                parameters["MONTH"] = monthAndYear.ToString();
                generatedEmail = PrepareAndSendMail(user.Lang, user.Email, userMail, reducedTimesheet, monthAndYear.ToString(), false, false, true);

            }
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SUBMISSION_TIMESHEET,
            reducedTimesheet.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.TimesheetNotif,
            userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }

        /// <summary>
        /// SendEmailForTimeSheetCorrection
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="timeSheet"></param>
        public void SendMailAndNotifForTimesheetCorrection(string userMail, ReducedTimeSheetViewModel timesheet)
        {
            string monthAndYear;
            EmailViewModel generatedEmail = new EmailViewModel();
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
            parameters["EMPLOYEE"] = timesheet.IdEmployeeNavigation.FullName;
            // Send mail to all superiors of the employee
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(timesheet.IdEmployee);
            foreach (UserViewModel user in userList)
            {
                if (user.Lang != null && user.Lang.Equals("en"))
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(timesheet.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("en-En")));
                }
                else
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(timesheet.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR")));
                }
                parameters["MONTH"] = monthAndYear.ToString();
                generatedEmail = PrepareAndSendMail(user.Lang, user.Email, userMail, timesheet, monthAndYear.ToString(), true);
            }
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.CORRECTION_REQUEST_TIMESHEET,
            generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.TimesheetNotif,
            userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }

        /// <summary>
        /// SendNotifForTimeSheetValidation
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="connectedEmployee"></param>
        /// <param name="timeSheet"></param>
        public void SendMailAndNotifForTimesheetValidation(string userMail, EmployeeViewModel connectedEmployee, TimeSheetViewModel timesheetViewModel)
        {
            EmailViewModel generatedEmail = new EmailViewModel();
            string monthAndYear;
            ReducedTimeSheetViewModel reducedTimesheet = new ReducedTimeSheetViewModel(timesheetViewModel);
            reducedTimesheet.IdEmployeeTreatedNavigation = connectedEmployee;
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["EMPLOYEE"] = reducedTimesheet.IdEmployeeNavigation.FullName
            };
            parameters["VALIDATOR"] = connectedEmployee.FullName;
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(reducedTimesheet.IdEmployee);
            foreach (UserViewModel user in userList)
            {
                if (user.Lang != null && user.Lang.Equals("en"))
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(reducedTimesheet.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("en-En")));
                }
                else
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(reducedTimesheet.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR")));
                }
                parameters["MONTH"] = monthAndYear.ToString();
                generatedEmail = PrepareAndSendMail(user.Lang, user.Email, userMail, reducedTimesheet, monthAndYear.ToString(), false, true);
            }
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.VALIDATION_TIMESHEET,
            generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.TimesheetNotif,
            userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }

    }
}
