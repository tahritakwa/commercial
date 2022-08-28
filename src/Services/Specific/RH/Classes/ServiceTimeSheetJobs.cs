using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceTimeSheetJobs : Service<TimeSheetViewModel, TimeSheet>, IServiceTimeSheetJobs
    {
        
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IUserBuilder _userBuilder;

        public ServiceTimeSheetJobs(IRepository<TimeSheet> entityRepo,           
            IRepository<Entity> entityRepoEntity,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, 
            IUnitOfWork unitOfWork,
            ITimeSheetBuilder builder,
            IServiceEmail serviceEmail,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IServiceEmployee serviceEmployee,
            IUserBuilder userBuilder)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                    entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceEmail = serviceEmail;
            _serviceEmployee = serviceEmployee;
            _userBuilder = userBuilder;
        }

        #region automatic jobs
        public void SendSubmitTimeSheetNotification(string connectionString, SmtpSettings smtpSettings)
        {
            if (DateTime.Now.Day >= NumberConstant.TwentySix)
            {
                try
                {

                    BeginTransaction(connectionString);
                    // source code for submit timeSheet
                    List<EmployeeViewModel> notSubmittedEmployeesList = EmployeesWithoutTimeSheet(DateTime.Now);
                    foreach (EmployeeViewModel employeeVM in notSubmittedEmployeesList)
                    {
                        PrepareAndSendMailForSubmitTimeSheet(Constants.DO_NOT_REPLY_EMAIL, employeeVM, smtpSettings);
                    }
                    EndTransaction();
                }
                catch
                {
                    // rollback transaction
                    _unitOfWork.RollbackTransaction();
                    // throw Exception
                    throw;
                }
            }
        }

        private List<EmployeeViewModel> EmployeesWithoutTimeSheet (DateTime month)
        {
            List<TimeSheetViewModel>  selectedMonthTimeSheet = GetModelsWithConditionsRelations(timeSheetVM => (timeSheetVM.Month.Month == month.Month) && (timeSheetVM.Month.Year == month.Year)).ToList();
            List<int> submittedEmployeesListIds = new List<int>();
            foreach(TimeSheetViewModel timeSheetVM in selectedMonthTimeSheet)
            {
                submittedEmployeesListIds.Add(timeSheetVM.IdEmployee);
            }
            List<EmployeeViewModel> notSubmittedEmployeesList = _serviceEmployee.GetModelsWithConditionsRelations(employeeVM => ! submittedEmployeesListIds.Contains(employeeVM.Id)).ToList();
            return notSubmittedEmployeesList;          
        }

        public void SendValidateTimeSheetNotification(string connectionString, SmtpSettings smtpSettings)
        {
            try
            {

                BeginTransaction(connectionString);
                // source code for validate timeSheet
                List<EmployeeViewModel> notValidatedEmployeesList = EmployeesWithTimeSheetNotValidated(DateTime.Now);
                Dictionary<UserViewModel, List<EmployeeViewModel>> superiorEmployeesDictionary = new Dictionary<UserViewModel, List<EmployeeViewModel>>();
                foreach (EmployeeViewModel employeeVM in notValidatedEmployeesList)
                {
                    // getting employee hierarchical list
                    List<UserViewModel> usersSuperiorsList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(idEmployee: employeeVM.Id);
                    usersSuperiorsList.Remove(usersSuperiorsList.Single(x => x.IdEmployee == employeeVM.Id));
                    // List<EmployeeViewModel> employeeSuperiorsList = new List<EmployeeViewModel>();                 
                    foreach (UserViewModel superiorVM in usersSuperiorsList)
                    {
                        if (!superiorEmployeesDictionary.ContainsKey(superiorVM))
                        {
                            // if the superior is not in dictionary
                            // create employee empty list
                            List<EmployeeViewModel> employeesToValidate = new List<EmployeeViewModel>();
                            // add current employee
                            employeesToValidate.Add(employeeVM);
                            // add to dictionary
                            superiorEmployeesDictionary.Add(superiorVM, employeesToValidate);
                        }
                        else
                        {
                            // if the superior in dictionary
                            if (!superiorEmployeesDictionary[superiorVM].Contains(employeeVM))
                            {
                                // if employee is not in superior list
                                superiorEmployeesDictionary[superiorVM].Add(employeeVM);
                            }
                        }
                    }
                }
                // sending only one mail to the superior containing the list of empployees to validate
                foreach (KeyValuePair<UserViewModel, List<EmployeeViewModel>> item in superiorEmployeesDictionary)
                {
                    PrepareAndSendMailForValidateTimeSheet(Constants.DO_NOT_REPLY_EMAIL, item.Key, smtpSettings, item.Value);
                }
                EndTransaction();
            }
            catch
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                throw;
            }

        }

        private List<EmployeeViewModel> EmployeesWithTimeSheetNotValidated(DateTime month)
        {
            List<TimeSheetViewModel> selectedMonthTimeSheet = GetModelsWithConditionsRelations(timeSheetVM => (timeSheetVM.Month.Month == month.Month) && (timeSheetVM.Month.Year == month.Year) && (timeSheetVM.Status == (int)TimeSheetStatusEnumerator.Sended)).ToList();
            List<int> submittedEmployeesListIds = new List<int>();
            foreach (TimeSheetViewModel timeSheetVM in selectedMonthTimeSheet)
            {
                submittedEmployeesListIds.Add(timeSheetVM.IdEmployee);
            }
            List<EmployeeViewModel> submittedEmployeesList = _serviceEmployee.GetModelsWithConditionsRelations(employeeVM => submittedEmployeesListIds.Contains(employeeVM.Id)).ToList();
            return submittedEmployeesList;
        }

        #endregion
        
        #region notification and email

        private EmailViewModel PrepareAndSendMailForSubmitTimeSheet(string userMail, EmployeeViewModel employee, SmtpSettings smtpSettings)
        {
            UserViewModel userViewModel = _serviceEmployee.GetUserByIdEmployee(employee.Id);
            TimeSheetEmailConstant timeSheetEmailConstant = new TimeSheetEmailConstant(userViewModel != null ? userViewModel.Lang ?? "fr" : "fr");
            string subject = PrepareMailSubjectForSubmitTimeSheet(timeSheetEmailConstant);
            string body = PrepareMailBodyForSubmitTimeSheetReminder(timeSheetEmailConstant, employee);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = userViewModel != null ? userViewModel.Email : employee.Email
            };
            // add the email in the db
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            return generatedEmail;
        }

        private EmailViewModel PrepareAndSendMailForValidateTimeSheet(string userMail, UserViewModel superior, SmtpSettings smtpSettings, List<EmployeeViewModel> employeesList)
        {
            TimeSheetEmailConstant timeSheetEmailConstant = new TimeSheetEmailConstant(superior.Lang ?? "fr");
            string subject = PrepareMailSubjectForValidateTimeSheet(timeSheetEmailConstant);
            string body = PrepareMailBodyForValidateTimeSheetReminder(timeSheetEmailConstant, superior, employeesList);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = superior.Email
            };
            // add the email in the db
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            return generatedEmail;
        }

        private string PrepareMailSubjectForSubmitTimeSheet(TimeSheetEmailConstant emailConstant)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.submitTimeSheet).Append(emailConstant.Reminder);
            return subject.ToString();
        }

        private string PrepareMailSubjectForValidateTimeSheet(TimeSheetEmailConstant emailConstant)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.validateTimeSheet).Append(emailConstant.Reminder);
            return subject.ToString();
        }

        private string PrepareMailBodyForSubmitTimeSheetReminder(TimeSheetEmailConstant emailConstant, EmployeeViewModel employee)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.SubmitTimeSheetTemplate);
            body = body.Replace("{EMPLOYEE_GENDER}", emailConstant._lang.GetTheCurrentLanguageCivilityFromGender(employee.Sex), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_NAME}", employee.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DAY}", NumberConstant.TwentySix.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{MONTH}", DateTime.Now.Month.ToString(), StringComparison.OrdinalIgnoreCase);
            return body;
        }

        private string PrepareMailBodyForValidateTimeSheetReminder(TimeSheetEmailConstant emailConstant, UserViewModel user, List<EmployeeViewModel> employeesList)
        {
            string userFullName = user.FirstName + " " + user.LastName; 
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.ValidateTimeSheetTemplate);
            string employeesListInHtmlFormat = @BuildEmployeesListInHtmlFormat(employeesList);
            body = body.Replace("{EMPLOYEE_NAME}", userFullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_LIST}", employeesListInHtmlFormat, StringComparison.OrdinalIgnoreCase);
            return body;
        }

        private string BuildEmployeesListInHtmlFormat (List<EmployeeViewModel> employeesList)
        {
            StringBuilder htmlFormat = new StringBuilder();
            String newLine = @"</br>";
            String openParagraph = @"<p><strong>";
            String closeParagraph = @"</strong></p>";
            String space = @" ";
            foreach (EmployeeViewModel emp in employeesList)
            {
                htmlFormat.Append(newLine);
                htmlFormat.Append(openParagraph);
                htmlFormat.Append(emp.FirstName);
                htmlFormat.Append(space);
                htmlFormat.Append(emp.LastName);
                htmlFormat.Append(closeParagraph);
            }
            htmlFormat.Append(newLine);
            return htmlFormat.ToString();
        }

        
        #endregion
    }
}
