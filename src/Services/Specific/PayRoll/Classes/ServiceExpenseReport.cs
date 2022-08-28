using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceExpenseReport : Service<ExpenseReportViewModel, ExpenseReport>, IServiceExpenseReport
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceExpenseReportDetails _serviceExpenseReportDetails;
        private readonly IServiceCurrencyRate _serviceCurrencyRate;
        private readonly IServiceCurrency _serviceCurrency;
        private readonly IServiceComment _serviceComment;
        private readonly IServiceExpenseReportEmail _serviceExpenseReportEmail;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceCompany _companyService;
        private readonly IServiceMessage _serviceMessage;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IUserBuilder _userBuilder;

        private const string zip = "zip";

        public ServiceExpenseReport(IRepository<ExpenseReport> entityRepo, IUnitOfWork unitOfWork,
            IExpenseReportBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IServiceEmployee serviceEmployee,
            IServiceExpenseReportDetails serviceExpenseReportDetails,
            IServiceCurrencyRate serviceCurrencyRate,
            IServiceCurrency serviceCurrency,
            IServiceComment serviceComment,
            IServiceExpenseReportEmail serviceExpenseReportEmail,
            IServiceEmail serviceEmail,
            IMemoryCache memoryCache,
            ICompanyBuilder builderCompany,
            IServiceCompany companyService,
            IServiceMessage serviceMessage,
            IRepository<Company> entityRepoCompany,
            IOptions<AppSettings> appSettings,
            IRepository<Entity> entityRepoEntity, IUserBuilder userBuilder,
            IRepository<EntityCodification> entityRepoEntityCodification, IOptions<SmtpSettings> smtpSettings,
            IRepository<Codification> entityRepoCodification, IServiceMsgNotification serviceMessageNotification)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                   entityRepoEntity, entityRepoEntityCodification, entityRepoCodification,builderCompany, memoryCache)
        {
            _serviceEmployee = serviceEmployee;
            _serviceExpenseReportDetails = serviceExpenseReportDetails;
            _serviceCurrencyRate = serviceCurrencyRate;
            _serviceCurrency = serviceCurrency;
            _serviceComment = serviceComment;
            _serviceExpenseReportEmail = serviceExpenseReportEmail;
            _serviceEmail = serviceEmail;
            _companyService = companyService;
            _serviceMessage = serviceMessage;
            _smtpSettings = smtpSettings.Value;
            _serviceMessageNotification = serviceMessageNotification;
            _userBuilder = userBuilder;
        }

        /// <summary>
        /// Add Expense Report with Expense Report Detail with files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModel(ExpenseReportViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            try
            {
                BeginTransaction();
                // Throw exception if the expenseReportDetails doesn't have a justificative support document
                CheckExpenseReportDetails(model);
                // Get connected user
                UserViewModel currentUser = _serviceEmployee.GetUserByUserMail(userMail);
                model.TransactionUserId = currentUser.Id;
                if (model.IdEmployee == 0)
                {
                    // Set request user by the current user
                    model.IdEmployee = currentUser != null ? currentUser.IdEmployee.Value : throw new ArgumentException("");
                }
                var date = model.ExpenseReportDetails.Count != NumberConstant.Zero ? model.ExpenseReportDetails.Max(x => x.Date) : (DateTime?)null;
                _serviceEmployee.ValidateResignedStatusEmployee(model.IdEmployee, date);
                CheckRightToAddUpdateDelete(model, userMail);
                model.SubmissionDate = DateTime.Now;
                model.Status = (int)AdministrativeDocumentStatusEnumerator.Waiting;
                List<ExpenseReportDetailsViewModel> expenseReportDetailsList = new List<ExpenseReportDetailsViewModel>();
                foreach (ExpenseReportDetailsViewModel expenseReport in model.ExpenseReportDetails)
                {
                    expenseReportDetailsList.Add(expenseReport);
                }
                model.TotalAmount = CalculateTotalAmount(model.ExpenseReportDetails.ToList());
                model.ExpenseReportDetails.Clear();
                CreatedDataViewModel entity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                // add details with files 
                if (expenseReportDetailsList.Any())
                {
                    foreach (ExpenseReportDetailsViewModel expenseReportDetail in expenseReportDetailsList)
                    {
                        expenseReportDetail.IdExpenseReport = entity.Id;
                        _serviceExpenseReportDetails.AddModelWithFiles(expenseReportDetail, entityAxisValuesModelList, userMail);
                    }
                }
                EndTransaction();
                MailBrodcastConfigurationViewModel configMail = new MailBrodcastConfigurationViewModel
                {
                    Model = new CreatedDataViewModel
                    {
                        Id = entity.Id,
                        Code = entity.Code
                    },
                    users = new List<string>
                    {
                        userMail, _serviceEmployee.FindByAsNoTracking(x => x.Id == model.IdEmployee).FirstOrDefault().Email
                    }
                };
                ExpenseReport expenseReportEntity = _entityRepo.GetAllAsNoTracking()
                   .Include(x => x.IdEmployeeNavigation)
                   .Include(x => x.ExpenseReportDetails)
                   .ThenInclude(x => x.IdExpenseReportDetailsTypeNavigation)
                   .Include(x => x.ExpenseReportDetails)
                   .ThenInclude(x => x.IdCurrencyNavigation)
                   .Where(x => x.Id == entity.Id).FirstOrDefault();
                SendMailAndNotifForExpenseReportAdd(userMail, null, _builder.BuildEntity(expenseReportEntity), "ADDING", configMail, _smtpSettings);
                return entity;

            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// Check expense report details
        /// </summary>
        /// <param name="expenseReportDetails"></param>
        private void CheckExpenseReportDetails(ExpenseReportViewModel expenseReport)
        {
            foreach (ExpenseReportDetailsViewModel expenseReportDetails in expenseReport.ExpenseReportDetails)
            {

                if (expenseReportDetails.Amount > NumberConstant.OneMillion)
                {
                    throw new CustomException(CustomStatusCode.ExpenseReportDetailLimit);
                }
                if (expenseReportDetails.FilesInfos.Count <= NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.ExpenseReportFileNotFoundException);
                }
                string[] allowedExtensions = { Constants.PDF, Constants.PNG, Constants.JPG, Constants.DOCX, Constants.DOC, Constants.JPEG };
                if (expenseReportDetails.FilesInfos.Any(x => !allowedExtensions.Contains(x.Name.Substring(x.Name.LastIndexOf(PayRollConstant.Point) + NumberConstant.One).ToLower(CultureInfo.CurrentCulture))))
                {
                    throw new CustomException(CustomStatusCode.ExpenseReportFileExtensionViolation);
                }
                if (expenseReportDetails.IdExpenseReportDetailsType == NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.MissingExpenseReportType);
                }
            }
        }

        /// <summary>
        /// Update Expense Report with Expense Report Detail with files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        /// 
        public override object UpdateModel(ExpenseReportViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                // Throw exception if the expenseReportDetails doesn't have a justificative support document
                CheckExpenseReportDetails(model);
                // Change state 
                ExpenseReport oldExpenseReport = _entityRepo.GetAllAsNoTracking()
                   .Include(x => x.ExpenseReportDetails)
                   .ThenInclude(x => x.IdExpenseReportDetailsTypeNavigation)
                    .Include(x => x.ExpenseReportDetails)
                    .ThenInclude(x => x.IdCurrencyNavigation).Where(x => x.Id == model.Id).FirstOrDefault();
                ExpenseReportViewModel expenseReportBeforeUpdate = _builder.BuildEntity(oldExpenseReport);
                if (expenseReportBeforeUpdate.Status != (int)AdministrativeDocumentStatusEnumerator.Waiting)
                {
                    // we can not change a status already validated 
                    throw new CustomException(CustomStatusCode.ExpenseReportUpdateViolation);
                }
                _serviceEmployee.ValidateResignedStatusEmployee(model.IdEmployee, model.ExpenseReportDetails.Max(x => x.Date));
                CheckRightToAddUpdateDelete(model, userMail);
                if (model.ExpenseReportDetails.Any())
                {
                    foreach (ExpenseReportDetailsViewModel expenseReportDetail in model.ExpenseReportDetails)
                    {
                        expenseReportDetail.IdExpenseReportNavigation = null;
                        if (expenseReportDetail.Id == 0)
                        {
                            // it 's an add operation
                            expenseReportDetail.IdExpenseReport = model.Id;
                            _serviceExpenseReportDetails.AddModelWithFiles(expenseReportDetail, entityAxisValuesModelList, userMail);
                        }
                        else
                        {
                            _serviceExpenseReportDetails.UpdateModelWithFiles(expenseReportDetail, entityAxisValuesModelList, userMail);
                        }
                    }
                }
                model.TotalAmount = CalculateTotalAmount(model.ExpenseReportDetails.ToList());
                model.ExpenseReportDetails = null;
                var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                MailBrodcastConfigurationViewModel configMail = new MailBrodcastConfigurationViewModel
                {
                    Model = new CreatedDataViewModel
                    {
                        Id = model.Id,
                        Code = model.Code
                    },
                    users = new List<string>
                    {
                        userMail, _serviceEmployee.FindByAsNoTracking(x => x.Id == model.IdEmployee).FirstOrDefault().Email
                    }
                };
                ExpenseReport expenseReport = _entityRepo.GetAllAsNoTracking()
                    .Include(x => x.IdEmployeeNavigation)
                    .Include(x => x.ExpenseReportDetails)
                    .ThenInclude(x => x.IdExpenseReportDetailsTypeNavigation)
                    .Include(x => x.ExpenseReportDetails)
                    .ThenInclude(x => x.IdCurrencyNavigation)
                    .Where(x => x.Id == model.Id).FirstOrDefault();
                SendMailAndNotifForExpenseReportAdd(userMail, expenseReportBeforeUpdate, _builder.BuildEntity(expenseReport), "UPDATING", configMail, _smtpSettings);
                EndTransaction();
                return result;
            }
            catch (Exception)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }

        /// <summary>
        /// SendNotifForTimeSheetValidation
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="connectedEmployee"></param>
        /// <param name="timeSheet"></param>
        /// <param name="smtpSettings"></param>
        public void SendMailAndNotifForExpenseReportAdd(string userMail, ExpenseReportViewModel oldExpenseReport, ExpenseReportViewModel expenseReportViewModel,
            string action, MailBrodcastConfigurationViewModel configMail, SmtpSettings smtpSetting)
        {

            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(expenseReportViewModel.IdEmployee);
            CompanyViewModel company = _companyService.GetAllModelsWithRelations(x => x.IdCurrencyNavigation).FirstOrDefault();
            ExpenseReportViewModel expenseReport;
            // get expense report 
            if (action == "DELETION")
            {
                expenseReport = oldExpenseReport;
            }
            else
            {
                // we can not getModel after deletion
                var expense = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == expenseReportViewModel.Id)
                             .Include(x => x.ExpenseReportDetails).ThenInclude(x => x.IdCurrencyNavigation)
                             .Include(x => x.ExpenseReportDetails).ThenInclude(x => x.IdExpenseReportDetailsTypeNavigation)
                             .Include(x => x.IdEmployeeNavigation)
                             .FirstOrDefault();
                if (expense == null)
                {
                    throw new CustomException(CustomStatusCode.NotFound);
                }
                expenseReport = _builder.BuildEntity(expense);

            }

            EmailViewModel generatedEmail = new EmailViewModel();
            ExpenseReportEmailViewModel expenseReportEmailViewModel;
            string mailBody = "";

            foreach (UserViewModel user in userList)
            {
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // prepare EmailBody subject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.ExpenseReport, user.Lang);
                // Prepare the EmailBody
                string msg = PrepareEmailHeader(connectedEmployee.FullName, expenseReportViewModel.IdEmployeeNavigation.FullName, action,
                administrativeDocumentConstant);
                if (action == "UPDATING")
                {
                    mailBody = PrepareExpenseReporMailBodyForUpdateCase(administrativeDocumentConstant, company, msg, oldExpenseReport, expenseReport, user.Lang);
                }
                else
                {
                    mailBody = PrepareExpenseReportMailBody(administrativeDocumentConstant, company, msg, expenseReport, user.Lang);
                }
                // Generate the email 
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = 1,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = user.Email
                };
                // add the email
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // add the leaveMail relation 
                expenseReportEmailViewModel = new ExpenseReportEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdExpenseReport = configMail.Model.Id
                };
                _serviceExpenseReportEmail.AddModelWithoutTransaction(expenseReportEmailViewModel, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSetting);
            }
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
                    {
                        { Constants.DOC_CREATOR,  connectedEmployee.FullName},
                        { Constants.DOC_CODE, expenseReportViewModel.Code},
                        { Constants.PROFIL, expenseReportViewModel.IdEmployeeNavigation.FullName }

                    };
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(GetInformationType(action),
                generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.NotifExpenseReport,
                userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }
        string GetInformationType(string action)
        {
            switch (action)
            {
                case "ADDING":
                    return Constants.ADD_EXPENSE_REPORT;
                case "UPDATING":
                    return Constants.UPDATE_EXPENSE_REPORT;
                case "VALIDATION":
                    return Constants.VALIDATE_EXPENSE_REPORT;
                case "REJECTION":
                    return Constants.REFUSE_EXPENSE_REPORT;
                case "DELETION":
                    return Constants.DELETE_EXPENSE_REPORT;
                default:
                    return "";
            }
        }

        public string PrepareEmailHeader(string connectedEmployeeName, string expenseReportEmployeeName, string action,
           AdministrativeDocumentConstant administrativeDocumentConstant)
        {
            StringBuilder header = new StringBuilder();
            header.Append(connectedEmployeeName).Append(" ");
            switch (action)
            {
                case "ADDING":
                    header.Append(administrativeDocumentConstant.AddingExpenseReport);
                    if (!connectedEmployeeName.Equals(expenseReportEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.For);
                    }
                    break;
                case "UPDATING":
                    header.Append(administrativeDocumentConstant.UpdatingExpenseReport);
                    if (!connectedEmployeeName.Equals(expenseReportEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.Of);
                    }
                    break;
                case "DELETION":
                    header.Append(administrativeDocumentConstant.DeletingExpenseReport);
                    if (!connectedEmployeeName.Equals(expenseReportEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.Of);
                    }
                    break;
                case "VALIDATION":
                    header.Append(administrativeDocumentConstant.ExpenseReportValidation);
                    if (!connectedEmployeeName.Equals(expenseReportEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.Of);
                    }
                    break;
                case "REJECTION":
                    header.Append(administrativeDocumentConstant.ExpenseReportRejection);
                    if (!connectedEmployeeName.Equals(expenseReportEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.Of);
                    }
                    break;
            }
            if (!connectedEmployeeName.Equals(expenseReportEmployeeName))
            {
                header.Append(" ").Append(expenseReportEmployeeName);
            }
            return header.ToString();
        }
        public object ValidateExpenseReport(ExpenseReportViewModel expenseReportViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            int idOfConnectedEmployee = ActiveAccountHelper.GetConnectedUserCredential().IdEmployee ?? NumberConstant.Zero;
            if (expenseReportViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted
                && idOfConnectedEmployee != NumberConstant.Zero && idOfConnectedEmployee == expenseReportViewModel.IdEmployee)
            {
                throw new CustomException(CustomStatusCode.ConnectedUserCannotValidateHisRequest);
            }
            CheckExpenseReportDetails(expenseReportViewModel);
            ExpenseReportViewModel oldExpenceReport = GetModelAsNoTracked(x => x.Id == expenseReportViewModel.Id);
            if (oldExpenceReport.Status != (int)AdministrativeDocumentStatusEnumerator.Waiting)
            {
                // we can not change a status already validated or refused
                throw new CustomException(CustomStatusCode.ExpenseReportUpdateViolation);
            }

            MailBrodcastConfigurationViewModel configMail = new MailBrodcastConfigurationViewModel
            {
                Model = new CreatedDataViewModel
                {
                    Id = oldExpenceReport.Id,
                    Code = oldExpenceReport.Code
                },
                users = new List<string>
                    {
                        userMail, _serviceEmployee.FindByAsNoTracking(x => x.Id == oldExpenceReport.IdEmployee).FirstOrDefault().Email
                    }
            };
            // check if the new status sended by the front is validate or refuse
            if (expenseReportViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                updateExpenseReportState(expenseReportViewModel, oldExpenceReport, entityAxisValuesModelList, userMail);
                SendMailAndNotifForExpenseReportAdd(userMail, expenseReportViewModel, expenseReportViewModel, "VALIDATION", configMail, _smtpSettings);
            }
            else if (expenseReportViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Refused)
            {
                updateExpenseReportState(expenseReportViewModel, oldExpenceReport, entityAxisValuesModelList, userMail);
                SendMailAndNotifForExpenseReportAdd(userMail, expenseReportViewModel, expenseReportViewModel, "REJECTION", configMail, _smtpSettings);
            }
            else
            {
                // we can not invoque this method to change the status at waiting => violation
                throw new CustomException(CustomStatusCode.ExpenseReportUpdateViolation);
            }
            return new CreatedDataViewModel { Id = oldExpenceReport.Id, Code = oldExpenceReport.Code };

        }
        void updateExpenseReportState(ExpenseReportViewModel expenseReportViewModel, ExpenseReportViewModel oldExpenceReport,
            IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            oldExpenceReport.Status = expenseReportViewModel.Status;
            // Get connected employee
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            if (connectedEmployee.Id != NumberConstant.Zero)
            {
                oldExpenceReport.TreatedBy = connectedEmployee.Id;
            }
            oldExpenceReport.TreatmentDate = DateTime.Now;
            base.UpdateModelWithoutTransaction(oldExpenceReport, entityAxisValuesModelList, userMail);
        }
        /// <summary>
        /// Delete the expense report if the status is waiting else generate exception
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            object obj;
            ExpenseReportViewModel expenseReport = GetModelById(id);
            if (expenseReport.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
            {
                CheckRightToAddUpdateDelete(expenseReport, userMail);
                List<ExpenseReportEmailViewModel> emails = _serviceExpenseReportEmail.FindModelBy(x => x.IdExpenseReport == id).ToList();
                List<int> emailsIds = new List<int>();
                if (emails != null && emails.Any())
                {
                    emailsIds = emails.Select(x => x.IdEmail).ToList();
                }
                // delete all emails related to the leave
                foreach (int idEmail in emailsIds)
                {
                    _serviceEmail.DeleteModelwithouTransaction(idEmail, null, userMail);
                }
                obj=base.DeleteModelwithouTransaction(id, tableName, userMail);
                MailBrodcastConfigurationViewModel configMail = new MailBrodcastConfigurationViewModel
                {
                    Model = new CreatedDataViewModel
                    {
                        Id = expenseReport.Id,
                        Code = expenseReport.Code
                    },
                    users = new List<string>
                    {
                        userMail, _serviceEmployee.FindByAsNoTracking(x => x.Id == expenseReport.IdEmployee).FirstOrDefault().Email
                    }
                };
                SendMailAndNotifForExpenseReportAdd(userMail, expenseReport, expenseReport, "DELETION", configMail, _smtpSettings);
            }
            else
            {
                throw new CustomException(CustomStatusCode.ExpenseReportDeleteViolation);
            }
            return obj;
        }

        /// <summary>
        /// Check if the user has permission to add, edit, or delete the expense report
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        private void CheckRightToAddUpdateDelete(ExpenseReportViewModel model, string userMail)
        {
            EmployeeViewModel employee = _serviceEmployee.GetModelAsNoTracked(x => x.Id == model.IdEmployee);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            bool canDoAction = connectedEmployee.Id == model.IdEmployee || _serviceEmployee.IsPartOfHierarchy(connectedEmployee.Id, employee.HierarchyLevel);
            if (!canDoAction)
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
        }

        /// <summary>
        /// Calculate total amount of expense Report
        /// </summary>
        /// <param name="model"></param>
        /// <returns>Total amount</returns>
        public double CalculateTotalAmount(IList<ExpenseReportDetailsViewModel> expenseReportDetails)
        {
            try
            {
                double totalAmount = 0;
                if (expenseReportDetails != null)
                {
                    int precisionValue = GetCompanyCurrencyPrecision();
                    foreach (ExpenseReportDetailsViewModel expenseReportDetail in expenseReportDetails)
                    {
                        if (expenseReportDetail.IdCurrency != 0 && expenseReportDetail.Date != null)
                        {
                            double exchangeRate = _serviceCurrencyRate.GetExchangeRateValue(expenseReportDetail.IdCurrency, expenseReportDetail.Date);
                            double amountwithCurrency = (exchangeRate != null && exchangeRate > 0) ? expenseReportDetail.Amount * exchangeRate : expenseReportDetail.Amount;
                            if (precisionValue != 0)
                            {
                                amountwithCurrency = AmountMethods.FormatValue(amountwithCurrency, precisionValue);
                            }
                            totalAmount += amountwithCurrency;
                        }
                    }
                }
                return totalAmount;

            }
            catch (CustomException)
            {
                throw;
            }
        }

        /// <summary>
        /// get by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override ExpenseReportViewModel GetModelById(int id)
        {
            // we can not getModel after deletion
            var expense = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                         .Include(x => x.ExpenseReportDetails).ThenInclude(x => x.IdCurrencyNavigation)
                         .Include(x => x.ExpenseReportDetails).ThenInclude(x => x.IdExpenseReportDetailsTypeNavigation)
                         .Include(x => x.IdEmployeeNavigation)
                         .FirstOrDefault();
            if (expense == null)
            {
                throw new CustomException(CustomStatusCode.NotFound);
            }
            ExpenseReportViewModel expenseReport = _builder.BuildEntity(expense);

            // Get files for every expense Report detail
            if (expenseReport.ExpenseReportDetails != null)
            {
                foreach (ExpenseReportDetailsViewModel expenseReportDetails in expenseReport.ExpenseReportDetails)
                {
                    if (expenseReportDetails.AttachmentUrl != null)
                    {
                        expenseReportDetails.FilesInfos = GetFiles(expenseReportDetails.AttachmentUrl).ToList();
                    }
                }
            }
            // get comments related to the current expense report
            expenseReport.Comments = _serviceComment.GetComments("ExpenseReportRequest", id);
            return expenseReport;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="predicate"></param>
        /// <param name="onlyFirstLevelOfHierarchy"></param>
        /// <returns></returns>
        public DataSourceResult<ExpenseReportViewModel> GetExpenseReportsRequestsWithHierarchy(string userMail, PredicateFormatViewModel predicate, DateTime? month, bool onlyFirstLevelOfHierarchy = false)
        {
            DataSourceResult<ExpenseReportViewModel> dataSourceResult = new DataSourceResult<ExpenseReportViewModel>();
            List<EmployeeViewModel> employeesList = new List<EmployeeViewModel>();
            Expression<Func<ExpenseReport, bool>> teamPredicate = x => true;
            Expression<Func<ExpenseReport, bool>> expenseReportPredicate = x => true;
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            _serviceEmployee.GetHierarchicalEmployeeList(connectedEmployee.Email, employeesList, true);
            // Get employee in connected employee team if he is team manager          
            List<EmployeeViewModel> employeeInTeam = _serviceEmployee.GetEmployeeInConnectedUserTeam(userMail).ToList();
            employeesList.AddRange(employeeInTeam);    
            predicate.Operator = Operator.And;
            PredicateFilterRelationViewModel<ExpenseReport> predicateFilterRelationModel = PreparePredicate(predicate);
            List<int> employeesListIds = employeesList.Select(y => y.Id).ToList();

            expenseReportPredicate = x => employeesListIds.Contains(x.IdEmployee);

            if (predicate.Filter.Any(p => p.Prop == nameof(EmployeeTeam.IdTeam)))
            {
                List<int> idTeams = predicate.Filter.Where(p => p.Prop == nameof(EmployeeTeam.IdTeam)).Select(p => Convert.ToInt32(p.Value)).ToList();
                teamPredicate = x => x.IdEmployeeNavigation.EmployeeTeam.Any(m =>
                    idTeams.Contains(m.IdTeam) && m.IdTeamNavigation.State &&
                    m.IsAssigned);
                predicate.Filter = predicate.Filter.Where(p => p.Prop != nameof(EmployeeTeam.IdTeam)).ToList();
                expenseReportPredicate = expenseReportPredicate.And(teamPredicate);
            }
            IQueryable<ExpenseReport> expenseReportQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(expenseReportPredicate,
                predicateFilterRelationModel.PredicateRelations).Where(predicateFilterRelationModel.PredicateWhere).BuildOrderBysQue(predicate.OrderBy);
            if (month.HasValue)
            {
                expenseReportQuery = expenseReportQuery.Where(model => month.Value.Month == model.SubmissionDate.Month);
            }
            dataSourceResult.total = expenseReportQuery.Count();
            expenseReportQuery = expenseReportQuery.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize);
            dataSourceResult.data = expenseReportQuery.Select(_builder.BuildEntity).ToList();
            return dataSourceResult;
        }

        public void PrepareAndSendMail(MailBrodcastConfigurationViewModel configMail, string userMail, string action,
            ExpenseReportViewModel oldExpenseReport, SmtpSettings smtpSettings)
        {
            CompanyViewModel company = _companyService.GetAllModelsWithRelations(x => x.IdCurrencyNavigation).FirstOrDefault();
            MessageViewModel msgVM = _serviceMessage.GetModelWithRelations(x => x.Id == configMail.IdMsg, x => x.IdInformationNavigation);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            ExpenseReportViewModel expenseReport;
            // get expense report 
            if (action == "DELETION")
            {
                expenseReport = oldExpenseReport;
            }
            else
            {
                // we can not getModel after deletion
                var expense = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == configMail.Model.Id)
                             .Include(x => x.ExpenseReportDetails).ThenInclude(x => x.IdCurrencyNavigation)
                             .Include(x => x.ExpenseReportDetails).ThenInclude(x => x.IdExpenseReportDetailsTypeNavigation)
                             .Include(x => x.IdEmployeeNavigation)
                             .FirstOrDefault();
                if (expense == null)
                {
                    throw new CustomException(CustomStatusCode.NotFound);
                }
                expenseReport = _builder.BuildEntity(expense);

            }

            EmailViewModel generatedEmail;
            ExpenseReportEmailViewModel expenseReportEmailViewModel;
            string mailBody;

            foreach (string email in configMail.users)
            {
                UserViewModel user = _serviceEmployee.GetUserByUserMail(userMail);
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // Prepare Message 
                string msg = AdministrativeDocumentInfosBuilder.PrepareMessage(user, connectedEmployee, msgVM, configMail);
                // prepare EmailBody subject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.ExpenseReport, user.Lang);
                // Prepare the EmailBody
                if (action == "UPDATING")
                {
                    mailBody = PrepareExpenseReporMailBodyForUpdateCase(administrativeDocumentConstant, company, msg, oldExpenseReport, expenseReport, user.Lang);
                }
                else
                {
                    mailBody = PrepareExpenseReportMailBody(administrativeDocumentConstant, company, msg, expenseReport, user.Lang);
                }
                // Generate the email 
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = 1,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = email
                };
                // add the email
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // add the leaveMail relation 
                expenseReportEmailViewModel = new ExpenseReportEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdExpenseReport = configMail.Model.Id
                };
                _serviceExpenseReportEmail.AddModelWithoutTransaction(expenseReportEmailViewModel, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            }
        }

        string PrepareExpenseReportMailBody(AdministrativeDocumentConstant administrativeDocumentConstant, CompanyViewModel company, string msg, ExpenseReportViewModel expenseReport, string culture)
        {

            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.ExpenseReportEmailTemplate);

            body = body.Replace("{MESSAGE}", msg.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{PRUPOSE}", expenseReport.Purpose, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{TOTAL_AMOUNT}", expenseReport.TotalAmount.ToString() + " " + company.IdCurrencyNavigation.Code,
                StringComparison.OrdinalIgnoreCase);
            string expenseReportDetails = PrepareExpenseReportDetails(administrativeDocumentConstant, culture, expenseReport);
            body = body.Replace("{EXPENSE_REPORT_DETAILS}", expenseReportDetails, StringComparison.OrdinalIgnoreCase);

            return body;
        }
        string PrepareExpenseReporMailBodyForUpdateCase(AdministrativeDocumentConstant administrativeDocumentConstant, CompanyViewModel company, string msg, ExpenseReportViewModel oldExpenseReport,
            ExpenseReportViewModel newExpenseReport, string culture)
        {

            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.ExpenseReportEmailUpdateTemplate);

            body = body.Replace("{MESSAGE}", msg.ToString(), StringComparison.OrdinalIgnoreCase);
            // Replace template by the document Request details Before update
            body = body.Replace("{OLD_EXPENSE_REPORT_PRUPOSE}", oldExpenseReport.Purpose, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{OLD_EXPENSE_REPORT_TOTAL_AMOUNT}", oldExpenseReport.TotalAmount.ToString() + " " + company.IdCurrencyNavigation.Code,
                StringComparison.OrdinalIgnoreCase);
            // Replace template by the new document Request details After update
            body = body.Replace("{NEW_EXPENSE_REPORT_PRUPOSE}", newExpenseReport.Purpose, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEW_EXPENSE_REPORT_TOTAL_AMOUNT}", newExpenseReport.TotalAmount.ToString() + " " + company.IdCurrencyNavigation.Code,
                StringComparison.OrdinalIgnoreCase);

            string expenseReportDetails = PrepareExpenseReportDetails(administrativeDocumentConstant, culture, oldExpenseReport, newExpenseReport);
            body = body.Replace("{EXPENSE_REPORT_DETAILS}", expenseReportDetails, StringComparison.OrdinalIgnoreCase);

            return body;
        }
        string PrepareExpenseReportDetails(AdministrativeDocumentConstant administrativeDocumentConstant, string culture, ExpenseReportViewModel expenseRepot)
        {
            StringBuilder details = new StringBuilder();
            if (expenseRepot.ExpenseReportDetails != null && expenseRepot.ExpenseReportDetails.Any())
            {
                int length = expenseRepot.ExpenseReportDetails.Count();
                if (length > 1)
                {
                    details.Append("<tr><td rowspan ='" + length + "'>" + administrativeDocumentConstant.ExpenseReportDetails + "</td>");
                }
                else
                {
                    details.Append("<tr><td>" + administrativeDocumentConstant.ExpenseReportDetails + "</td>");
                }
                for (int i = 0; i < length; i++)
                {
                    if (i > 0)
                    {
                        details.Append("<tr>");
                    }
                    details.Append("<td>" + administrativeDocumentConstant.Description + ": " + expenseRepot.ExpenseReportDetails.ElementAt(i).Description + "<br>" +
                                   administrativeDocumentConstant.Type + ": " + expenseRepot.ExpenseReportDetails.ElementAt(i).IdExpenseReportDetailsTypeNavigation.Label + "<br>" +
                                   administrativeDocumentConstant.Date + ": " + DateUtility.GenerateDateByCulture(expenseRepot.ExpenseReportDetails.ElementAt(i).Date, culture) + "<br>" +
                                   administrativeDocumentConstant.Amount + ": " + expenseRepot.ExpenseReportDetails.ElementAt(i).Amount + "<br>" +
                                   administrativeDocumentConstant.Currency + ": " + expenseRepot.ExpenseReportDetails.ElementAt(i).IdCurrencyNavigation.Code + "<br>" +
                                  administrativeDocumentConstant.Code + ": " + expenseRepot.Code + "</td></tr>");
                }
            }
            return details.ToString();
        }
        string PrepareExpenseReportDetails(AdministrativeDocumentConstant administrativeDocumentConstant, string culture, ExpenseReportViewModel oldExpenseRepot, ExpenseReportViewModel newExpenseRepot)
        {

            StringBuilder details = new StringBuilder();
            if ((oldExpenseRepot.ExpenseReportDetails != null && oldExpenseRepot.ExpenseReportDetails.Any())
               || (newExpenseRepot.ExpenseReportDetails != null && newExpenseRepot.ExpenseReportDetails.Any()))
            {
                int oldExpenseRepotDetailslength = oldExpenseRepot.ExpenseReportDetails.Count();
                int newExpenseRepotDetailslength = newExpenseRepot.ExpenseReportDetails.Count();
                int max = Math.Max(oldExpenseRepotDetailslength, newExpenseRepotDetailslength);
                if (max > 1)
                {
                    details.Append("<tr><td rowspan ='" + max + "'>" + administrativeDocumentConstant.ExpenseReportDetails + "</td>");
                }
                else
                {
                    details.Append("<tr><td> " + administrativeDocumentConstant.ExpenseReportDetails + " </td>");
                }
                for (int i = 0; i < max; i++)
                {
                    if (i > 0)
                    {
                        details.Append("<tr>");
                    }
                    // Add old info
                    if (i < oldExpenseRepotDetailslength)
                    {
                        details.Append("<td>" + administrativeDocumentConstant.Description + ": " + oldExpenseRepot.ExpenseReportDetails.ElementAt(i).Description + "<br>" +
                                  administrativeDocumentConstant.Type + ": " + oldExpenseRepot.ExpenseReportDetails.ElementAt(i).IdExpenseReportDetailsTypeNavigation.Label + "<br>" +
                                  administrativeDocumentConstant.Date + ": " + DateUtility.GenerateDateByCulture(oldExpenseRepot.ExpenseReportDetails.ElementAt(i).Date, culture) + "<br>" +
                                  administrativeDocumentConstant.Amount + ": " + oldExpenseRepot.ExpenseReportDetails.ElementAt(i).Amount + "<br>" +
                                  administrativeDocumentConstant.Currency + ": " + oldExpenseRepot.ExpenseReportDetails.ElementAt(i).IdCurrencyNavigation.Code + "<br>" +
                                  administrativeDocumentConstant.Code + ": " + oldExpenseRepot.Code + "</td>");
                    }
                    else
                    {
                        details.Append("<td></td>");
                    }
                    // Add new Info
                    if (i < newExpenseRepotDetailslength)
                    {
                        details.Append("<td>" + administrativeDocumentConstant.Description + ": " + newExpenseRepot.ExpenseReportDetails.ElementAt(i).Description + "<br>" +
                                    administrativeDocumentConstant.Type + ": " + newExpenseRepot.ExpenseReportDetails.ElementAt(i).IdExpenseReportDetailsTypeNavigation.Label + "<br>" +
                                    administrativeDocumentConstant.Date + ": " + DateUtility.GenerateDateByCulture(newExpenseRepot.ExpenseReportDetails.ElementAt(i).Date, culture) + "<br>" +
                                    administrativeDocumentConstant.Amount + ": " + newExpenseRepot.ExpenseReportDetails.ElementAt(i).Amount + "<br>" +
                                    administrativeDocumentConstant.Currency + ": " + newExpenseRepot.ExpenseReportDetails.ElementAt(i).IdCurrencyNavigation.Code + "<br>" +
                                  administrativeDocumentConstant.Code + ": " + oldExpenseRepot.Code + "</td>");

                        details.Append("</tr>");
                    }
                    else
                    {
                        details.Append("<td></td>");
                    }
                }
            }

            return details.ToString();
        }
        /// <summary>
        /// GetExpenseFromListId
        /// </summary>
        /// <param name="listIdExpenses"></param>
        /// <returns></returns>
        public List<ExpenseReportViewModel> GetExpenseFromListId(List<int> listIdExpenses)
        {
            List<ExpenseReportViewModel> listedExpenses = new List<ExpenseReportViewModel>();
            listIdExpenses.ForEach((x) =>
            {
                ExpenseReportViewModel expense = GetModelById(x);
                if (expense.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
                {
                    listedExpenses.Add(expense);
                }
            });


            return listedExpenses;
        }
        /// <summary>
        /// ValidateMassiveExpenses
        /// </summary>
        /// <param name="listOfExpenses"></param>
        public void ValidateMassiveExpenses(List<ExpenseReportViewModel> listOfExpenses, string userMail)
        {
            try
            {
                BeginTransaction();
                listOfExpenses.ForEach((x) =>
                {
                    x.Status = (int)AdministrativeDocumentStatusEnumerator.Accepted;
                    ValidateExpenseReport(x, null, userMail);
                });
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }

        }
        /// <summary>
        /// DeleteMassiveexpenseReport
        /// </summary>
        /// <param name="listIdLeaves"></param>
        public void DeleteMassiveexpenseReport(List<int> listIdLeaves, string userMail)
        {
            listIdLeaves.ForEach((x) =>
            {
                DeleteModel(x, nameof(ExpenseReport), userMail);
            });
        }
        /// <summary>
        /// RefuseMassiveexpenseReport
        /// </summary>
        /// <param name="listIdLeaves"></param>
        public void RefuseMassiveexpenseReport(List<int> listIdLeaves, string userMail)
        {
            listIdLeaves.ForEach((id) =>
            {
                ExpenseReportViewModel expense = GetModelById(id);
                expense.Status = (int)AdministrativeDocumentStatusEnumerator.Refused;
                ValidateExpenseReport(expense, null, userMail);
            });
        }
        public FileInfoViewModel DownloadExpenseReportDocumentsWar(int idExpenseReport)
        {
            ExpenseReportViewModel expenseReport = GetModelById(idExpenseReport);
            List<FileInfoViewModel> filesToDownload = new List<FileInfoViewModel>();
            foreach (ExpenseReportDetailsViewModel expenseReportDetails in expenseReport.ExpenseReportDetails)
            {
                filesToDownload.AddRange(expenseReportDetails.FilesInfos);
            }
            using (var memoryStream = new MemoryStream())
            {
                using (var archive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
                {
                    foreach (FileInfoViewModel fileInfo in filesToDownload)
                    {
                        var demoFile = archive.CreateEntry(fileInfo.Name);
                        using (var entryStream = demoFile.Open())
                        using (var streamWriter = new StreamWriter(entryStream))
                        {
                            streamWriter.BaseStream.Write(fileInfo.Data, NumberConstant.Zero, fileInfo.Data.Length);
                        }
                    }
                }
                FileInfoViewModel fileInfoViewModel = new FileInfoViewModel
                {
                    Extension = zip,
                    Name = string.Concat(nameof(ExpenseReport),"-", expenseReport.IdEmployeeNavigation.FullName, "-" ,
                    expenseReport.Code , ".", zip),
                    Data = memoryStream.ToArray(),
                };
                return fileInfoViewModel;
            }
        }
    }
}
