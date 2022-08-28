using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Immobilisation.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceExitEmployee : Service<ExitEmployeeViewModel, ExitEmployee>, IServiceExitEmployee
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceComment _serviceComment;
        private readonly IServiceHistory _serviceHistory;
        private readonly IServiceContract _serviceContract;
        private readonly IExitEmailForEmployeeBuilder _exitEmailForEmployeeBuilder;
        private readonly IServiceExitEmailForEmployee _ServiceEmployeeExittEmployee;
        private readonly IServicePeriod _servicePeriod;
        private readonly IServiceEmail _serviceEmail;
        private readonly IUserBuilder _userBuilder;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServiceJobsParameters _serviceJobsParameters;
        private readonly IRepository<User> _userEntityRepo;
        private readonly IRepository<EmployeeTeam> _employeeTeamRepo;
        private readonly IRepository<ExitAction> _exitActionRepo;
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IServiceUser _serviceUser;
        private readonly IServiceExitActionEmployee _serviceActionExitEmployees;
        private readonly IRepository<Employee> _entityRepoEmployee;
        private readonly IRepository<EmployeeTeam> _repoEmployeeTeam;
        private readonly IRepository<Team> _repoTeam;

        public ServiceExitEmployee(IServicePeriod servicePeriod, IRepository<ExitEmployee> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IServiceEmployee serviceEmployee,
           IRepository<EmployeeTeam> employeeTeamRepo,
           IServiceComment serviceComment,
            IServiceHistory serviceHistory,
            IServiceContract serviceContract,
            IRepository<ExitAction> exitActionRepo,
            IExitEmailForEmployeeBuilder exitEmailForEmployeeBuilder,
            IServiceExitEmailForEmployee ServiceEmployeeExittEmployee,
            IServiceEmail serviceEmail,
            IUserBuilder userBuilder,
            IEmployeeBuilder employeeBuilder,
            IServiceUser serviceUser,
            IServiceExitActionEmployee serviceActionExitEmployees,
            IServiceMsgNotification serviceMessageNotification,
            IServiceJobsParameters serviceJobsParameter,
            IRepository<User> userEntityRepo,
           IUnitOfWork unitOfWork,
           IExitEmployeeBuilder builder,
           IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
           IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Employee> employeeEntityRepo, IRepository<EmployeeTeam> repoEmployeeTeam, IRepository<Team> repoTeam) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceEmployee = serviceEmployee;
            _serviceComment = serviceComment;
            _serviceHistory = serviceHistory;
            _ServiceEmployeeExittEmployee = ServiceEmployeeExittEmployee;
            _serviceContract = serviceContract;
            _exitEmailForEmployeeBuilder = exitEmailForEmployeeBuilder;
            _servicePeriod = servicePeriod;
            _serviceEmail = serviceEmail;
            _userBuilder = userBuilder;
            _serviceMessageNotification = serviceMessageNotification;
            _serviceJobsParameters = serviceJobsParameter;
            _userEntityRepo = userEntityRepo;
            _employeeTeamRepo = employeeTeamRepo;
            _exitActionRepo = exitActionRepo;
            _employeeBuilder = employeeBuilder;
            _serviceUser = serviceUser;
            _serviceActionExitEmployees = serviceActionExitEmployees;
            _entityRepoEmployee = employeeEntityRepo;
            _repoEmployeeTeam = repoEmployeeTeam;
            _repoTeam = repoTeam;
        }

        public override object AddModelWithoutTransaction(ExitEmployeeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            model.CreationDate = DateTime.Now;
            CheckExistenceOfEmployeeExitWithSameReleaseDate(model);
            CheckExistEmployeeWithValidateDate(model);
            // Manage leave attachement file
            ManageExitEmployeeAttachementFile(model);
            model.MinNoticePeriodDate = model.ReleaseDate;
            model.MaxNoticePeriodDate = model.ReleaseDate;
            model.StatePay = (int)ExitEmployeeStatePayEnumerator.NotCalculate;
            model.StateLeave = (int)ExitEmployeeStatePayEnumerator.NotCalculate;
            CreatedDataViewModel entity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            List<ExitAction> listOfActions = _exitActionRepo.GetAllAsNoTracking().ToList();
            if (listOfActions.Any())
            {
                listOfActions.ForEach(x =>
                {
                    ExitActionEmployeeViewModel actionExitEmployeeViewModel = new ExitActionEmployeeViewModel
                    {
                        IdExitAction = x.Id,
                        IdExitEmployee = entity.Id
                    };
                    CreatedDataViewModel entityAction = (CreatedDataViewModel)_serviceActionExitEmployees.AddModelWithoutTransaction(actionExitEmployeeViewModel, entityAxisValuesModelList, userMail, property);
                });
            }
            return entity;
        }

        public override object UpdateModelWithoutTransaction(ExitEmployeeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckExistenceOfEmployeeExitWithSameReleaseDate(model);
            CheckExistEmployeeWithValidateDate(model);
            // Manage leave attachement file
            ManageExitEmployeeAttachementFile(model);
            AddEmployeeToDropDownMultisecet(model);
            model.IdExitReasonNavigation = null;
            model.IdEmployeeNavigation = null;
            model.ExitActionEmployee.Select(x => { x.IdExitEmployeeNavigation = null; return x; }).ToList();
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public object ValidateExitEmployee(ExitEmployeeViewModel exitEmployeeViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, SmtpSettings smtpSettings)
        {
            // User want to Change the status 
            ExitEmployeeViewModel oldEmployeeExit = GetModelAsNoTracked(x => x.Id == exitEmployeeViewModel.Id);
            if (exitEmployeeViewModel.Status != oldEmployeeExit.Status)
            {
                if (oldEmployeeExit.Status == (int)ExitEmployeeStatusEnumerator.Refused ||
                   oldEmployeeExit.Status == (int)ExitEmployeeStatusEnumerator.Accepted)
                { // we can not change a status already refused or accepted  
                    throw new CustomException(CustomStatusCode.EmployeeExitUpdateViolation);
                }
                // Get connected employee
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                if (connectedEmployee.Id != NumberConstant.Zero)
                {
                    exitEmployeeViewModel.TreatedBy = connectedEmployee.Id;
                }
                exitEmployeeViewModel.TreatmentDate = DateTime.Now;
            }
            if (!exitEmployeeViewModel.ExitPhysicalDate.HasValue && exitEmployeeViewModel.Status == (int)ExitEmployeeStatusEnumerator.Accepted)
            {
                throw new CustomException(CustomStatusCode.EmployeeExithasNoExitPhysicalDate);
            }
            SetEmployeeDate(exitEmployeeViewModel);
            // Manage leave attachement file
            ManageExitEmployeeAttachementFile(exitEmployeeViewModel);
            //get EmployeeTeams attached to employee 
            List<EmployeeTeam> employeeTeam = _repoEmployeeTeam.GetAllWithConditionsRelationsAsNoTracking(x => x.IdEmployee == exitEmployeeViewModel.IdEmployee, y => y.IdTeamNavigation).ToList();
            //get attached Teams to employee 
            List<Team> teamsAttachedToEmployee = employeeTeam.Select(x => x.IdTeamNavigation).ToList();
            //update NumberOfAffected in all teams attached to employee
            teamsAttachedToEmployee.ForEach(t => t.NumberOfAffected = t.NumberOfAffected - NumberConstant.One);
            _repoTeam.BulkUpdate(teamsAttachedToEmployee);
            //add UnassignmentDate for each employee team
            employeeTeam.ForEach(x => 
            {
                x.UnassignmentDate = DateTime.Now;
                x.IsAssigned = false;
            });
            _repoEmployeeTeam.BulkUpdate(employeeTeam);
            // Update Model 
            base.UpdateModelWithoutTransaction(exitEmployeeViewModel, entityAxisValuesModelList, userMail);
            return new CreatedDataViewModel { Id = exitEmployeeViewModel.Id };
        }

        public override ExitEmployeeViewModel GetModelById(int id)
        {
            ExitEmployeeViewModel employeeExitViewModel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.IdExitReasonNavigation)
                .Include(x => x.IdEmployeeNavigation)
                .Include(x => x.ExitActionEmployee)
                .ThenInclude(x => x.IdExitActionNavigation)
                .Include(x => x.ExitEmailForEmployee)
                .ThenInclude(x => x.IdEmployeeNavigation).Select(_builder.BuildEntity).FirstOrDefault();
            if (employeeExitViewModel != null)
            {
                employeeExitViewModel.Comments = _serviceComment.GetComments(nameof(ExitEmployee), employeeExitViewModel.Id);
                employeeExitViewModel.ExitFileInfo = GetFiles(employeeExitViewModel.ExitEmployeeAttachementFile).ToList();
            }
            employeeExitViewModel.History = _serviceHistory.GetModelsWithConditionsRelations(x =>
            x.IdEmployee == employeeExitViewModel.IdEmployee && !x.AbandonmentDate.HasValue || x.AbandonmentDate.HasValue 
            && DateTime.Compare(x.AbandonmentDate.Value, DateTime.Now) > NumberConstant.Zero, x => x.IdActiveNavigation).ToList();
            List<ContractViewModel> contractList = _serviceContract.GetModelsWithConditionsRelations(x => x.IdEmployee == employeeExitViewModel.IdEmployee && x.State == NumberConstant.Two, x => x.IdContractTypeNavigation
            ).ToList();
            employeeExitViewModel.Contract = contractList.Any() ? contractList.First() : null;
            CalculateNoticeMinAndMaxDate(employeeExitViewModel);
            return employeeExitViewModel;
        }

        /// <summary>
        /// Manage Leave file attachement
        /// </summary>
        /// <param name="employeeExitViewModel"></param>
        private void ManageExitEmployeeAttachementFile(ExitEmployeeViewModel employeeExitViewModel)
        {
            if (string.IsNullOrEmpty(employeeExitViewModel.ExitEmployeeAttachementFile))
            {
                if (employeeExitViewModel.ExitFileInfo != null && employeeExitViewModel.ExitFileInfo.Count != NumberConstant.Zero)
                {
                    EmployeeViewModel employee = _serviceEmployee.GetModelById(employeeExitViewModel.IdEmployee);
                    employeeExitViewModel.ExitEmployeeAttachementFile = Path.Combine(PayRollConstant.PayRollFileRootPath + employee.FirstName + employee.LastName, Guid.NewGuid().ToString());
                    CopyFiles(employeeExitViewModel.ExitEmployeeAttachementFile, employeeExitViewModel.ExitFileInfo);
                }
            }
            else
            {
                if (employeeExitViewModel.ExitFileInfo != null)
                {
                    DeleteFiles(employeeExitViewModel.ExitEmployeeAttachementFile, employeeExitViewModel.ExitFileInfo);
                    CopyFiles(employeeExitViewModel.ExitEmployeeAttachementFile, employeeExitViewModel.ExitFileInfo);
                }
            }
        }

        /// <summary>
        /// Set Employee Date if resignated or resigning
        /// </summary>
        /// <param name="model"></param>
        private void SetEmployeeDate(ExitEmployeeViewModel model)
        {
            Employee employee = _entityRepoEmployee.GetSingleNotTracked(x => x.Id == model.IdEmployee);
            if (model.Status == (int)ExitEmployeeStatusEnumerator.Accepted)
            {
                employee.ResignationDepositDate = model.ExitDepositDate;
                employee.ResignationDate = model.ExitPhysicalDate;
                employee.Status = (employee.ResignationDate.HasValue && employee.ResignationDate.Value.BeforeDateLimitIncluded(DateTime.Today)) ?
                    (int)EmployeeState.Resigned :
                    (int)EmployeeState.Resigning;
            }
            else
            {
                employee.ResignationDepositDate = null;
                employee.ResignationDate = null;
                employee.Status = (int)EmployeeState.Active;
            }
            _entityRepoEmployee.Update(employee);
            _unitOfWork.Commit();
        }


        public ExitEmployeeViewModel GetEmployeeExitById(int id)
        {
            ExitEmployeeViewModel employeeExit = base.GetModelAsNoTracked(x => x.Id == id);
            return employeeExit;
        }

        /// <summary>
        /// Check if exit employee release date corresponds to an existing one
        /// </summary>
        /// <param name="releaseDate"></param>
        private void CheckExistenceOfEmployeeExitWithSameReleaseDate(ExitEmployeeViewModel employeeExit)
        {
            if (FindModelsByNoTracked(x => x.IdEmployee == employeeExit.IdEmployee && x.ReleaseDate == employeeExit.ReleaseDate).Any(x => x.Id != employeeExit.Id))
            {
                throw new CustomException(CustomStatusCode.ExisitingEmployeeExitReleaseDate);
            }
        }
        /// <summary>
        /// Check if exit employee have validate days
        /// </summary>
        /// <param name="model"></param>
        private void CheckExistEmployeeWithValidateDate(ExitEmployeeViewModel model)
        {
            Employee employee = _entityRepoEmployee.GetSingleNotTracked(x => x.Id == model.IdEmployee);
            if (model.ExitDepositDate.BeforeDate(employee.HiringDate))
            {
                throw new CustomException(CustomStatusCode.ExitDepositDateBeforeHiringDate);
            }
            if (model.ReleaseDate.BeforeDate(employee.HiringDate))
            {
                throw new CustomException(CustomStatusCode.ReleaseDateBeforeHiringDate);
            }
            if (model.ExitDepositDate.AfterDate(model.ReleaseDate))
            {
                throw new CustomException(CustomStatusCode.ExitDepositDateAfterReleaseDate);
            }
            employee.ResignationDepositDate = model.ExitDepositDate;
            employee.ResignedFromExitEmployee = true;
            employee.Status = (int)EmployeeState.Resigning;
            _entityRepoEmployee.Update(employee);
        }
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            ExitEmployee exitEmployee = _entityRepo.GetSingleWithRelationsNotTracked(m => m.Id.Equals(id), x => x.IdEmployeeNavigation);
            if (exitEmployee.Status == (int)ExitEmployeeStatusEnumerator.Accepted || exitEmployee.Status == (int)ExitEmployeeStatusEnumerator.Refused)
            {
                throw new CustomException(CustomStatusCode.ExitEmployeeDeleteCheck);
            }
            else
            {
                Employee employee = exitEmployee.IdEmployeeNavigation;
                employee.ResignedFromExitEmployee = false;
                exitEmployee.IdEmployeeNavigation = null;
                _entityRepoEmployee.Update(employee);
                return base.DeleteModelwithouTransaction(id, tableName, userMail);
            }
        }
        /// <summary>
        /// manage add, delete and update in multiselect dropdown
        /// </summary>
        /// <param name="model"></param>
        public void AddEmployeeToDropDownMultisecet(ExitEmployeeViewModel model)
        {
            model.ExitEmailForEmployee = model.Id != NumberConstant.Zero ? _ServiceEmployeeExittEmployee.FindByAsNoTracking(x => x.IdExitEmployee == model.Id).ToList() :
                new List<ExitEmailForEmployeeViewModel>();
            var listOldIds = model.ExitEmailForEmployee.Select(x => x.IdEmployee).ToList();
            // Relation to Remove
            List<int> relationToRemove = model.ListIdEmployeeMultiselect != null ? listOldIds.Where(x => !model.ListIdEmployeeMultiselect.Contains(x)).ToList() : new List<int>();
            // delete  the removed relation
            if (relationToRemove.Any())
            {
                List<ExitEmailForEmployee> exitEmployeeToDelete = new List<ExitEmailForEmployee>();
                _ServiceEmployeeExittEmployee.BulkDeleteWithoutTransaction(model.ExitEmailForEmployee.Where(x => relationToRemove.Contains(x.IdEmployee)).
                    Select(x => _exitEmailForEmployeeBuilder.BuildModel(x)).ToList());
                model.ExitEmailForEmployee = model.ExitEmailForEmployee.Where(x => !relationToRemove.Contains(x.IdEmployee)).ToList();
            }
            // Relation to add
            if (model.ListIdEmployeeMultiselect != null)
            {
                List<int> relationToAdd = model.ListIdEmployeeMultiselect != null ? model.ListIdEmployeeMultiselect.Except(listOldIds).ToList() : new List<int>();
                if (relationToAdd.Any())
                {
                    relationToAdd.ForEach((x) =>
                    {
                        model.ExitEmailForEmployee.Add(new ExitEmailForEmployeeViewModel
                        {
                            Id = NumberConstant.Zero,
                            IdEmployee = x,
                            IdEmployeeExit = model.Id
                        });
                    });
                }
            }
        }

        /// <summary>
        /// Validate all pay lines and set state pay to valid
        /// </summary>
        /// <param name="id"></param>
        public void ValidateAllExitEmployeePayLine(int id)
        {
            ExitEmployeeViewModel exitEmployee = GetModelAsNoTracked(x => x.Id == id, x => x.ExitEmployeePayLine);
            exitEmployee.ExitEmployeePayLine.Select(x => { x.State = (int)PayLineStateEnumerator.Valid; return x; }).ToList();
            exitEmployee.StatePay = (int)ExitEmployeeStatePayEnumerator.Valid;
            base.UpdateModelWithoutTransaction(exitEmployee, null, ActiveAccountHelper.GetConnectedUserEmail());
        }

        #region calculate notice date
        /// <summary>
        /// calculate min and max notice period with calender or without
        /// </summary>
        /// <param name="model"></param>

        private void CalculateNoticeMinAndMaxDate(ExitEmployeeViewModel model)
        {
            if (model.Contract != null)
            {

                if (model.Contract.IdContractTypeNavigation.CalendarNoticeDays == true)
                {
                    model.MinNoticePeriodDate = model.ExitDepositDate.Date.AddDays(model.Contract.IdContractTypeNavigation.MinNoticePeriod);
                    model.MaxNoticePeriodDate = model.ExitDepositDate.Date.AddDays(model.Contract.IdContractTypeNavigation.MaxNoticePeriod);
                }
                else
                {
                    PeriodViewModel periodViewModel = _servicePeriod.VerifyPeriodOfDate(model.ExitDepositDate);
                    List<DateTime> validDate = _servicePeriod.ValidDatesInIntervalDates(periodViewModel, model.ExitDepositDate, periodViewModel.EndDate).ToList();
                    model.MinNoticePeriodDate = CalculateMinAndMaxPeriodNoticeWithoutCalender(periodViewModel, model.Contract.IdContractTypeNavigation.MinNoticePeriod, model.ExitDepositDate, validDate);
                    model.MaxNoticePeriodDate = CalculateMinAndMaxPeriodNoticeWithoutCalender(periodViewModel, model.Contract.IdContractTypeNavigation.MaxNoticePeriod, model.ExitDepositDate, validDate);
                }
            }
        }

        /// <summary>
        /// calculate min and max notice period without calender
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="numberNoticeDay"></param>
        /// <param name="NoticePeriodDate"></param>
        /// <param name="validDates"></param>
        /// <returns></returns>
        public DateTime CalculateMinAndMaxPeriodNoticeWithoutCalender(PeriodViewModel periodViewModel, int numberNoticeDay, DateTime NoticePeriodDate, List<DateTime> validDates)
        {
            while (numberNoticeDay != NumberConstant.Zero)
            {
                if (!(NoticePeriodDate.BeforeDate(periodViewModel.EndDate)))
                {
                    periodViewModel = _servicePeriod.VerifyPeriodOfDate(NoticePeriodDate);
                    validDates = _servicePeriod.ValidDatesInIntervalDates(periodViewModel, NoticePeriodDate, periodViewModel.EndDate).ToList();
                }
                NoticePeriodDate = NoticePeriodDate.AddDays(NumberConstant.One);
                if (validDates.Contains(NoticePeriodDate))
                {
                    numberNoticeDay--;
                }
            }
            return NoticePeriodDate;
        }
        #endregion
        #region prepare mail for IT team
        /// <summary>
        /// PrepareMailBodyForMaterialRecovery
        /// </summary>
        /// <param name="materialrecoveryEmailConstant"></param>
        /// <param name="employee"></param>
        /// <param name="employeeExit"></param>
        /// <returns></returns>
        private string PrepareMailBodyForMaterialRecovery(EmployeeExitMeetingEmailConstant materialrecoveryEmailConstant, EmployeeViewModel employee, List<EmployeeViewModel> employeesList)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@materialrecoveryEmailConstant.MaterialRecoveryTemplate);
            string employeesListInHtmlFormat = @BuildEmployeesListInHtmlFormat(employeesList);
            body = body.Replace("{EMPLOYEE_GENDER}", materialrecoveryEmailConstant._lang.GetTheCurrentLanguageCivilityFromGender(employee.Sex), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_NAME}", employee.FullName, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_LIST}", employeesListInHtmlFormat, StringComparison.OrdinalIgnoreCase);
            return body;
        }
        private string BuildEmployeesListInHtmlFormat(List<EmployeeViewModel> employeesList)
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
        /// <summary>
        /// PrepareAndSendMailForMaterialRecovery
        /// </summary>
        /// <param name="receiverLang"></param>
        /// <param name="userMail"></param>
        /// <param name="employee"></param>
        /// <param name="smtpSettings"></param>
        /// <returns></returns>
        private EmailViewModel PrepareAndSendMailForMaterialRecovery(string receiverLang, string userMail, EmployeeViewModel employee, List<EmployeeViewModel> employeesList, SmtpSettings smtpSettings)
        {
            EmployeeExitMeetingEmailConstant materialrecoveryEmailConstant = new EmployeeExitMeetingEmailConstant(receiverLang ?? "fr");
            string subject = materialrecoveryEmailConstant.MaterialRecoverySubject;
            string body = PrepareMailBodyForMaterialRecovery(materialrecoveryEmailConstant, employee, employeesList);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = NumberConstant.One,
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
        }/// <summary>
         /// Send Mail And Notif to employee 
         /// </summary>
         /// <param name="userMail"></param>
         /// <param name="smtpSettings"></param>
         /// <param name="employee"></param>
         /// <param name="employeeExit"></param>
        private void SendMailForValidateMaterialRecovery(string userMail, SmtpSettings smtpSettings, EmployeeViewModel employee, List<EmployeeViewModel> employeesToValidate)
        {

            // Send mail target user employee  
            User targetUser = _userBuilder.BuildModel(_serviceEmployee.GetUserByIdEmployee(employee.Id));
            PrepareAndSendMailForMaterialRecovery(targetUser.Lang, userMail, employee, employeesToValidate, smtpSettings);
        }
        /// <summary>
        ///  get resigned employee who has a resignation date before date now
        /// </summary>
        /// <returns></returns>
        private List<EmployeeViewModel> EmployeeswithPhysicalExitDateBeforeDatenow()
        {
            List<int> resignedEmployeesListIds = new List<int>();
            List<ExitEmployeeViewModel> employeeExitViewModel = GetModelsWithConditionsRelations(employeeExit => (DateTime.Now.AddDays(NumberConstant.One) >= employeeExit.ExitPhysicalDate)).ToList();
            foreach (ExitEmployeeViewModel employeeExit in employeeExitViewModel)
            {
                resignedEmployeesListIds.Add(employeeExit.IdEmployee);
            }
            List<EmployeeViewModel> resignedEmployeesList = _serviceEmployee.GetModelsWithConditionsRelations(employeeVM => resignedEmployeesListIds.Contains(employeeVM.Id)).ToList();
            return resignedEmployeesList;
        }

        /// <summary>
        /// get employee who belongs to the team IT
        /// </summary>
        /// <returns></returns>
        private List<EmployeeViewModel> GetEmployeeWithTeamIt()
        {
            List<int> EmployeesListTeamItIds = _employeeTeamRepo.GetAllWithConditionsRelations(employee => employee.IdTeamNavigation.Name.Equals("IT", StringComparison.OrdinalIgnoreCase) && (
               !employee.UnassignmentDate.HasValue || employee.AssignmentDate.BeforeDate(DateTime.Now) || employee.UnassignmentDate.Value.AfterDate(DateTime.Now)), employee =>
            employee.IdTeamNavigation).Select(x => x.IdEmployee).ToList();
            List<EmployeeViewModel> EmployeesItTeamList = _serviceEmployee.GetModelsWithConditionsRelations(employeeVM => EmployeesListTeamItIds.Contains(employeeVM.Id)).ToList();
            return EmployeesItTeamList;
        }
        #endregion

        #region auto jobs
        public void SendMaterialRecoveryNotification(string connectionString, SmtpSettings smtpSettings)
        {
            try
            {
                BeginTransaction(connectionString);
                //get employee resigned list 
                List<EmployeeViewModel> resignedEmployeesList = EmployeeswithPhysicalExitDateBeforeDatenow();
                //get list employee from IT team (reciever)
                List<EmployeeViewModel> itTeamEmployeeList = GetEmployeeWithTeamIt();
                //send email 
                itTeamEmployeeList.ForEach(x => SendMailForValidateMaterialRecovery(Constants.DO_NOT_REPLY_EMAIL, smtpSettings, x, resignedEmployeesList));
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


        #endregion
        #region control actions for exit employee

        /// <summary>
        /// choose method according to IdAction 
        /// </summary>
        /// <param name="idAction"></param>
        /// <param name="model"></param>
        public void ChooseMethodAccordingToAction(int idAction, ExitEmployeeViewModel model)
        {
            switch (idAction)
            {
                case 5:
                    DesactivateUserFollowingExitEmployee(model);
                    break;
                case 4:
                    ClosingCurrentContract(model);
                    break;
                case 1:
                    ReleaseEmployeeFromTheTeam(model);
                    break;
                case 3:
                    AssignmentOfNewSupervisor(model);
                    break;
                default:
                    return;
            }
        }


        /// <summary>
        /// desactivate user after her resignation
        /// </summary>
        /// <param name="IdEmployee"></param>
        public void DesactivateUserFollowingExitEmployee(ExitEmployeeViewModel employeeExit)
        {
            UserViewModel user = _serviceUser.GetModelAsNoTracked(x => x.IdEmployee == employeeExit.IdEmployee);
            if (user != null)
            {
                _serviceUser.ChangeStateOfUser(user.Id);
            }
            ExitActionEmployeeViewModel actionExitEmployee = employeeExit.ExitActionEmployee.ToList()
                  .Where(x => x.IdExitActionNavigation.Label.Equals("DESACTIVATED_ACTION", StringComparison.OrdinalIgnoreCase))
                  .FirstOrDefault();
            actionExitEmployee.VerifyAction = true;
            _serviceActionExitEmployees.UpdateModelWithoutTransaction(actionExitEmployee, null, null);
        }


        /// <summary>
        /// closing current contract
        /// </summary>
        /// <param name="employeeExit"></param>
        public void ClosingCurrentContract(ExitEmployeeViewModel employeeExit)
        {
            if (!employeeExit.ExitPhysicalDate.HasValue)
            {
                throw new CustomException(CustomStatusCode.EmployeeExithasNoExitPhysicalDate);
            }
            if (_serviceContract.GetAllModelsQueryable(x =>
                x.IdEmployee == employeeExit.IdEmployee && x.StartDate.AfterDate(employeeExit.ExitPhysicalDate.Value)).Any())
            {
                throw new CustomException(CustomStatusCode.EmployeeHasSomeContractAfterExitPhysicalDate);
            }
            IList<ContractViewModel> lastContracts = _serviceContract.FindModelsByNoTracked(x =>
                x.IdEmployee == employeeExit.IdEmployee &&
                ((x.EndDate.HasValue && employeeExit.ExitPhysicalDate.Value.BetweenDateLimitIncluded(x.StartDate, x.EndDate.Value))
                || (!x.EndDate.HasValue && x.StartDate.BeforeDateLimitIncluded(employeeExit.ExitPhysicalDate.Value))), x => x.BaseSalary);
            if (lastContracts.Any())
            {
                lastContracts.First().EndDate = employeeExit.ExitPhysicalDate.Value;
                _serviceContract.UpdateModelWithoutTransaction(lastContracts.First(), null, null);
            }
            ExitActionEmployeeViewModel actionExitEmployee = employeeExit.ExitActionEmployee.Where(x => x.IdExitActionNavigation.Label.Equals("CONTRACT_ACTION", StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
            actionExitEmployee.VerifyAction = true;
            _serviceActionExitEmployees.UpdateModelWithoutTransaction(actionExitEmployee, null, null);
        }


        /// <summary>
        /// Release of the team at which the employee is carried out
        /// </summary>
        /// <param name="employeeExit"></param>
        public void ReleaseEmployeeFromTheTeam(ExitEmployeeViewModel employeeExit)
        {
            if (!employeeExit.ExitPhysicalDate.HasValue)
            {
                throw new CustomException(CustomStatusCode.EmployeeExithasNoExitPhysicalDate);
            }
            IList<EmployeeTeam> employeeTeams = _employeeTeamRepo.FindByAsNoTracking(employeeTeam =>
                employeeTeam.IdEmployee == employeeExit.IdEmployee &&
                ((employeeTeam.UnassignmentDate.HasValue && employeeExit.ExitPhysicalDate.Value.BetweenDateLimitIncluded(employeeTeam.AssignmentDate, employeeTeam.UnassignmentDate.Value))
                || (!employeeTeam.UnassignmentDate.HasValue && employeeTeam.AssignmentDate.BeforeDateLimitIncluded(employeeExit.ExitPhysicalDate.Value)))).ToList().Select(x =>
                {
                    x.UnassignmentDate = employeeExit.ExitPhysicalDate.Value;
                    return x;
                }).ToList();
            if (employeeTeams.Any())
            {
                _employeeTeamRepo.BulkUpdate(employeeTeams);
                _unitOfWork.Commit();
            }
            ExitActionEmployeeViewModel actionExitEmployee = employeeExit.ExitActionEmployee.Where(x => x.IdExitActionNavigation.Label.Equals("TEAM_ACTION", StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
            actionExitEmployee.VerifyAction = true;
            _serviceActionExitEmployees.UpdateModelWithoutTransaction(actionExitEmployee, null, null);
        }


        /// <summary>
        /// assignment of new supervisor after employee resignation 
        /// </summary>
        /// <param name="employeeExit"></param>
        public void AssignmentOfNewSupervisor(ExitEmployeeViewModel employeeExit)
        {
            List<Employee> employeesToUpdate = new List<Employee>();
            //get employee
            EmployeeViewModel employee = _serviceEmployee.GetModelsWithConditionsRelations(x => x.Id == employeeExit.IdEmployee).ToList().FirstOrDefault();
            //get superior employee
            EmployeeViewModel superior = _serviceEmployee.GetModelsWithConditionsRelations(x => x.Id == employee.IdUpperHierarchy).ToList().FirstOrDefault();
            //get list of lower employee
            List<EmployeeViewModel> lowerEmployees = _serviceEmployee.GetModelsWithConditionsRelations(x => x.IdUpperHierarchy == employee.Id).ToList();
            if (lowerEmployees.Count > NumberConstant.Zero && superior != null)
            {
                lowerEmployees.ForEach(lowerViewModel =>
                {
                    Employee lower = _employeeBuilder.BuildModel(lowerViewModel);
                    lower.IdUpperHierarchy = superior.Id;
                    employeesToUpdate.AddRange(_serviceEmployee.GetLowerEmployees(lower));
                });
                if (employeesToUpdate.Count > NumberConstant.Zero)
                {
                    _serviceEmployee.BulkUpdateWithoutTransaction(employeesToUpdate);
                }
            }
            ExitActionEmployeeViewModel actionExitEmployee = employeeExit.ExitActionEmployee.Where(x =>
                x.IdExitActionNavigation.Label.Equals("SUPERVISOR_ACTION", StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
            actionExitEmployee.VerifyAction = true;
            _serviceActionExitEmployees.UpdateModelWithoutTransaction(actionExitEmployee, null, null);
        }
        #endregion
    }
}


