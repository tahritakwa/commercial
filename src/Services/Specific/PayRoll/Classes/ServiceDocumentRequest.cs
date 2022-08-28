using Infrastruture.Utility;
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
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
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
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceDocumentRequest : Service<DocumentRequestViewModel, DocumentRequest>, IServiceDocumentRequest
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceComment _serviceComment;
        private readonly IServiceDocumentRequestEmail _serviceDocumentRequestEmail;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceMessage _serviceMessage;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IUserBuilder _userBuilder;
        private readonly SmtpSettings _smtpSettings;

        public ServiceDocumentRequest(IRepository<DocumentRequest> entityRepo, IUnitOfWork unitOfWork,
           IDocumentRequestBuilder consultantsCustomerContractBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IServiceEmployee serviceEmployee, IServiceComment serviceComment,
           IServiceDocumentRequestEmail serviceDocumentRequestEmail, IServiceEmail serviceEmail,
           IServiceMessage serviceMessage,
           IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification,
           IServiceMsgNotification serviceMessageNotification,
           IUserBuilder userBuilder,
           IMemoryCache memoryCache,
           ICompanyBuilder builderCompany,
           IOptions<SmtpSettings> smtpSettings)
         : base(entityRepo, unitOfWork, consultantsCustomerContractBuilder, builderEntityAxisValues, entityRepoEntityAxisValues,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification, builderCompany, memoryCache)
        {
            _serviceEmployee = serviceEmployee;
            _serviceComment = serviceComment;
            _serviceDocumentRequestEmail = serviceDocumentRequestEmail;
            _serviceEmail = serviceEmail;
            _serviceMessage = serviceMessage;
            _serviceMessageNotification = serviceMessageNotification;
            _userBuilder = userBuilder;
            _smtpSettings = smtpSettings.Value;
        }

        /// <summary>
        /// Add model override
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(DocumentRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList,
            string userMail, string property = null)
        {
            // Get connected user
            var currentUser = _serviceEmployee.GetUserByUserMail(userMail);
            model.TransactionUserId = currentUser.Id;
            if (model.IdEmployee == 0)
            {
                // Set request user by the current user
                model.IdEmployee = currentUser != null ? currentUser.IdEmployee.Value : throw new ArgumentException("");
            }
            _serviceEmployee.ValidateResignedStatusEmployee(model.IdEmployee, model.DeadLine);

            CheckRightToAddUpdateDelete(model, userMail);
            model.SubmissionDate = DateTime.Now;
            model.Status = (int)AdministrativeDocumentStatusEnumerator.Waiting;
            CreatedDataViewModel entity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            model = GetModelWithRelationsAsNoTracked(x => x.Id == entity.Id, x => x.IdEmployeeNavigation, x => x.IdDocumentRequestTypeNavigation);
            SendMailAndNotifForDocumentRequest(userMail, null, model, Constants.ADDING, _smtpSettings);
            return entity;
        }
        /// <summary>
        /// Update Document Request
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModel(DocumentRequestViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                // Change state 
                DocumentRequestViewModel oldDocument = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, x => x.IdEmployeeNavigation, x => x.IdDocumentRequestTypeNavigation);
                if (model.Status != oldDocument.Status)
                {
                    // user want to validate the status 
                    if (oldDocument.Status != (int)AdministrativeDocumentStatusEnumerator.Waiting)
                    { // we can not change a status already validated 
                        throw new CustomException(CustomStatusCode.DocumentRequestUpdateViolation);
                    }
                    else
                    {
                        // Get connected employee
                        EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                        if (connectedEmployee.Id != NumberConstant.Zero)
                        {
                            model.TreatedBy = connectedEmployee.Id;
                        }
                        model.TreatmentDate = DateTime.Now;
                    }
                }
                CheckRightToAddUpdateDelete(model, userMail);
                // Update Model 
                var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                model = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, x => x.IdEmployeeNavigation, x => x.IdDocumentRequestTypeNavigation);
                SendMailAndNotifForDocumentRequest(userMail, oldDocument, model, Constants.UPDATING, _smtpSettings);
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
        ///  Validate Document Request
        /// </summary>
        /// <param name="documentRequestViewModel"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object ValidateDocumentRequest(DocumentRequestViewModel documentRequestViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            int idOfConnectedEmployee = ActiveAccountHelper.GetConnectedUserCredential().IdEmployee ?? NumberConstant.Zero;
            if (documentRequestViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted
                && idOfConnectedEmployee != NumberConstant.Zero && idOfConnectedEmployee == documentRequestViewModel.IdEmployee)
            {
                throw new CustomException(CustomStatusCode.ConnectedUserCannotValidateHisRequest);
            }
            DocumentRequestViewModel oldDocumentRequestViewModel = GetModelAsNoTracked(x => x.Id == documentRequestViewModel.Id);
            if (oldDocumentRequestViewModel.Status != (int)AdministrativeDocumentStatusEnumerator.Waiting)
            {
                // we can not change a status already validated or refused
                throw new CustomException(CustomStatusCode.DocumentRequestUpdateViolation);
            }
            // check if the new status sended by the front is validate or refuse
            if (documentRequestViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted
               || documentRequestViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Refused)
            {
                CheckRightToValidateOrRefuse();
                oldDocumentRequestViewModel.Status = documentRequestViewModel.Status;
                // Get connected employee
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                if (connectedEmployee.Id != NumberConstant.Zero)
                {
                    oldDocumentRequestViewModel.TreatedBy = connectedEmployee.Id;
                }
                oldDocumentRequestViewModel.TreatmentDate = DateTime.Now;
                base.UpdateModelWithoutTransaction(oldDocumentRequestViewModel, entityAxisValuesModelList, userMail);
                string action = "";
                switch (documentRequestViewModel.Status)
                {
                    case (int)AdministrativeDocumentStatusEnumerator.Accepted:
                        action = Constants.VALIDATION;
                        break;
                    case (int)AdministrativeDocumentStatusEnumerator.Refused:
                        action = Constants.REJECTION;
                        break;
                    case (int)AdministrativeDocumentStatusEnumerator.Canceled:
                        action = Constants.CANCELLATION;
                        break;
                    default:
                        break;
                }
                documentRequestViewModel = GetModelWithRelationsAsNoTracked(x => x.Id == documentRequestViewModel.Id, x => x.IdEmployeeNavigation, x => x.IdDocumentRequestTypeNavigation);
                SendMailAndNotifForDocumentRequest(userMail, oldDocumentRequestViewModel, documentRequestViewModel, action, _smtpSettings);
            }
            else
            {
                // we can not invoque this method to change the status at waiting => violation
                throw new CustomException(CustomStatusCode.DocumentRequestUpdateViolation);
            }
            return new CreatedDataViewModel { Id = oldDocumentRequestViewModel.Id, Code = oldDocumentRequestViewModel.Code };

        }
        /// <summary>
        /// Delete the document request if the status is waiting else generate exception
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            DocumentRequestViewModel documentRequest = GetModelWithRelationsAsNoTracked(m => m.Id == id, x => x.IdEmployeeNavigation, x => x.IdDocumentRequestTypeNavigation);
            if (documentRequest.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
            {
                CheckRightToAddUpdateDelete(documentRequest, userMail);
                List<DocumentRequestEmailViewModel> emails = _serviceDocumentRequestEmail.FindModelBy(x => x.IdDocumentRequest == id).ToList();
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
                var obj = base.DeleteModelwithouTransaction(id, tableName, userMail);
                SendMailAndNotifForDocumentRequest(userMail, null, documentRequest, Constants.DELETION, _smtpSettings);
                return obj;
            }
            else
            {
                throw new CustomException(CustomStatusCode.DocumentRequestDeleteViolation);
            }
        }

        /// <summary>
        /// Check if the user has permission to add, edit, or delete the expense report
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        private void CheckRightToAddUpdateDelete(DocumentRequestViewModel model, string userMail)
        {
            // check if the connected user has the right to add an expense report to the employee
            IList<int> hierarchicalEmployeesList = _serviceEmployee.GetHierarchicalEmployeesList(userMail, true, true).Select(x => x.Id).ToList();
            if (!hierarchicalEmployeesList.Contains(model.IdEmployee))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
        }

        /// <summary>
        /// Check if the user has permission to validate or refuse the expense report
        /// </summary>
        private void CheckRightToValidateOrRefuse()
        {
            if (!RoleHelper.HasPermission(PayRollConstant.VALIDATE_DOCUMENTREQUEST))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
        }

        public DataSourceResult<DocumentRequestViewModel> GetDocumentRequestsWithHierarchy(string userMail, PredicateFormatViewModel predicate, DateTime? month, bool onlyFirstLevelOfHierarchy = false)
        {
            DataSourceResult<DocumentRequestViewModel> dataSourceResult = new DataSourceResult<DocumentRequestViewModel>();
            List<EmployeeViewModel> employeesList = new List<EmployeeViewModel>();
            Expression<Func<DocumentRequest, bool>> teamPredicate = x => true;
            Expression<Func<DocumentRequest, bool>> documentRequestPredicate = x => true;

            //if (isAdmin)
            //{
            //    employeesList = _serviceEmployee.GetAllModels().ToList();
            //}
            //else
            //{
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                if (onlyFirstLevelOfHierarchy)
                {
                    employeesList = _serviceEmployee.GetModelsWithConditionsRelations(x => x.IdUpperHierarchy == connectedEmployee.Id).ToList();
                }
                else
                {
                    _serviceEmployee.GetHierarchicalEmployeeList(connectedEmployee.Email, employeesList, true);
                }
                // Get employee in connected employee team if he is team manager          
                List<EmployeeViewModel> employeeInTeam = _serviceEmployee.GetEmployeeInConnectedUserTeam(userMail).ToList();
                employeesList.AddRange(employeeInTeam);
            //}

            predicate.Operator = Operator.And;
            PredicateFilterRelationViewModel<DocumentRequest> predicateFilterRelationModel = PreparePredicate(predicate);

            List<DocumentRequestViewModel> expenseReportsList = new List<DocumentRequestViewModel>();

            List<int> employeesListIds = employeesList.Select(y => y.Id).ToList();
            documentRequestPredicate = x => employeesListIds.Contains(x.IdEmployee);
            if (predicate.Filter.Any(p => p.Prop == nameof(EmployeeTeam.IdTeam)))
            {
                List<int> idTeams = predicate.Filter.Where(p => p.Prop == nameof(EmployeeTeam.IdTeam)).Select(p => Convert.ToInt32(p.Value)).ToList();
                teamPredicate = x => x.IdEmployeeNavigation.EmployeeTeam.Any(m =>
                    idTeams.Contains(m.IdTeam) && m.IdTeamNavigation.State &&
                    m.IsAssigned);
                predicate.Filter = predicate.Filter.Where(p => p.Prop != nameof(EmployeeTeam.IdTeam)).ToList();
                documentRequestPredicate = documentRequestPredicate.And(teamPredicate);
            }
            IQueryable<DocumentRequest> documentRequestsQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(documentRequestPredicate,
                predicateFilterRelationModel.PredicateRelations).Where(predicateFilterRelationModel.PredicateWhere)
                .BuildOrderBysQue(predicate.OrderBy);
            if (month.HasValue)
            {
                documentRequestsQuery = documentRequestsQuery.Where(model => month.Value.Month == model.SubmissionDate.Month);
            }
            dataSourceResult.total = documentRequestsQuery.Count();
            documentRequestsQuery = documentRequestsQuery.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize);
            expenseReportsList = documentRequestsQuery.Select(_builder.BuildEntity).ToList();
            dataSourceResult.data = expenseReportsList;
            return dataSourceResult;
        }

        /// <summary>
        /// get by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override DocumentRequestViewModel GetModelById(int id)
        {
            DocumentRequestViewModel documentRequest = GetModelAsNoTracked(x => x.Id == id,
                x => x.IdDocumentRequestTypeNavigation, x => x.IdEmployeeNavigation);
            // get comments related to the current expense report
            documentRequest.Comments = _serviceComment.GetComments("DocumentRequest", id);
            return documentRequest;
        }



        /// <summary>
        /// Send mail and notif of document request
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="oldDocument"></param>
        /// <param name="document"></param>
        /// <param name="action"></param>
        /// <param name="smtpSetting"></param>
        public void SendMailAndNotifForDocumentRequest(string userMail, DocumentRequestViewModel oldDocument, DocumentRequestViewModel document, string action, SmtpSettings smtpSetting)
        {
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(document.IdEmployee);
            EmailViewModel generatedEmail = new EmailViewModel();
            DocumentRequestEmailViewModel documentRequestEmailViewModel;
            string mailBody;

            foreach (UserViewModel user in userList)
            {
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // prepare emailSubject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.LeaveRequest, user.Lang);
                // Prepare emailBody 
                string msg = EmailFirstLine(connectedEmployee.FullName, document.IdEmployeeNavigation.FullName, action, document.Code, administrativeDocumentConstant);
                if (action == Constants.UPDATING)
                {
                    mailBody = PrepareInterviewMailBodyForUpdateCase(administrativeDocumentConstant, msg, oldDocument, document, user.Lang);
                }
                else
                {
                    mailBody = PrepareInterviewMailBody(administrativeDocumentConstant, msg, document, user.Lang);
                }
                // generate the email
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = NumberConstant.One,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = user.Email
                };
                // add the email in the db
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // Add the documentRequestEmail relation 
                documentRequestEmailViewModel = new DocumentRequestEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdDocumentRequest = document.Id
                };
                _serviceDocumentRequestEmail.AddModelWithoutTransaction(documentRequestEmailViewModel, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSetting);
            }

            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["DOC_CREATOR"] = connectedEmployee.FullName,
                ["DOC_CODE"] = document.Code,
                ["PROFIL"] = document.IdEmployeeNavigation.FullName
            };
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(GetInformationType(action),
               generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.LeaveNotification,
               userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }

        /// <summary>
        /// Get information type
        /// </summary>
        /// <param name="action"></param>
        /// <returns></returns>
        private string GetInformationType(string action)
        {
            string type = "";
            switch (action)
            {
                case "ADDING":
                    type = Constants.ADD_DOCUMENT_REQUEST;
                    break;
                case "UPDATING":
                    type = Constants.UPDATE_DOCUMENT_REQUEST;
                    break;
                case "DELETION":
                    type = Constants.DELETE_DOCUMENT_REQUEST;
                    break;
                case "VALIDATION":
                    type = Constants.VALIDATE_DOCUMENT_REQUEST;
                    break;
                case "REJECTION":
                    type = Constants.REFUSE_DOCUMENT_REQUEST;
                    break;
                default:
                    break;
            }
            return type;
        }
        /// <summary>
        /// Prepare first line of email
        /// </summary>
        /// <param name="connectedEmployeeName"></param>
        /// <param name="documentEmployeeName"></param>
        /// <param name="action"></param>
        /// <param name="code"></param>
        /// <param name="administrativeDocumentConstant"></param>
        /// <returns></returns>
        private string EmailFirstLine(string connectedEmployeeName, string documentEmployeeName, string action, string code, AdministrativeDocumentConstant administrativeDocumentConstant)
        {
            StringBuilder header = new StringBuilder();
            header.Append(connectedEmployeeName).Append(" ");
            switch (action)
            {
                case "ADDING":
                    header.Append(administrativeDocumentConstant.AddingDocumentRequest);
                    if (!connectedEmployeeName.Equals(documentEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.For).Append(" ").Append(documentEmployeeName);
                    }
                    break;
                case "UPDATING":
                    header.Append(administrativeDocumentConstant.UpdatingDocumentRequest).Append(" ").Append(code);
                    break;
                case "DELETION":
                    header.Append(administrativeDocumentConstant.DeletingDocumentRequest);
                    break;
                case "VALIDATION":
                    header.Append(administrativeDocumentConstant.ValidatingDocumentRequest);
                    break;
                case "REJECTION":
                    header.Append(administrativeDocumentConstant.RejectingDocumentRequest);
                    break;
                default:
                    break;
            }
            if (!action.Equals(Constants.ADDING) && !connectedEmployeeName.Equals(documentEmployeeName))
            {
                header.Append(" ").Append(administrativeDocumentConstant.Of).Append(" ").Append(documentEmployeeName);
            }
            return header.ToString();
        }

        public void PrepareAndSendMail(MailBrodcastConfigurationViewModel configMail, string userMail, string action,
            DocumentRequestViewModel oldDocumentRequest, SmtpSettings smtpSettings)
        {
            MessageViewModel msgVM = _serviceMessage.GetModelWithRelations(x => x.Id == configMail.IdMsg, x => x.IdInformationNavigation);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);

            DocumentRequestViewModel documentRequest;
            if (action == "DELETION")
            {
                documentRequest = oldDocumentRequest;
            }
            else
            {
                // we can not getModel after deletion
                documentRequest = GetModelById(configMail.Model.Id);
            }
            // prepare mail


            EmailViewModel generatedEmail;
            DocumentRequestEmailViewModel documentRequestEmailViewModel;
            string mailBody;

            foreach (string email in configMail.users)
            {
                UserViewModel user = _serviceEmployee.GetUserByUserMail(userMail);
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // Prepare Message 
                string msg = AdministrativeDocumentInfosBuilder.PrepareMessage(user, connectedEmployee, msgVM, configMail);
                // Prepare subject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.DocumentRequest, user.Lang);
                // Prepare mail body
                if (action == "UPDATING")
                {
                    mailBody = PrepareInterviewMailBodyForUpdateCase(administrativeDocumentConstant, msg, oldDocumentRequest, documentRequest, user.Lang);
                }
                else
                {
                    mailBody = PrepareInterviewMailBody(administrativeDocumentConstant, msg, documentRequest, user.Lang);
                }
                // generate the email 
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = 1,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = email
                };
                // add the email in db
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // add the leaveMail relation 
                documentRequestEmailViewModel = new DocumentRequestEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdDocumentRequest = configMail.Model.Id
                };
                _serviceDocumentRequestEmail.AddModelWithoutTransaction(documentRequestEmailViewModel, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            }
        }
        string PrepareInterviewMailBody(AdministrativeDocumentConstant administrativeDocumentConstant, string msg, DocumentRequestViewModel documentRequest, string culture)
        {
            string deadline = DateUtility.GenerateDateByCulture(documentRequest.DeadLine, culture);
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.DocumentRequestEmailTemplate);
            body = body.Replace("{MESSAGE}", msg.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CODE}", documentRequest.Code, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{LABEL}", documentRequest.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DESCRIPTION}", documentRequest.Description, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{TYPE}", documentRequest.IdDocumentRequestTypeNavigation.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DEADLINE}", deadline, StringComparison.OrdinalIgnoreCase);
            return body;
        }
        string PrepareInterviewMailBodyForUpdateCase(AdministrativeDocumentConstant administrativeDocumentConstant, string msg, DocumentRequestViewModel oldDocumentRequest,
            DocumentRequestViewModel newDocumentRequest, string culture)
        {

            string deadlineOldDocumentRequest = DateUtility.GenerateDateByCulture(oldDocumentRequest.DeadLine, culture);
            string deadlineNewDocumentRequest = DateUtility.GenerateDateByCulture(newDocumentRequest.DeadLine, culture);
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.DocumentRequestEmailUpdateTemplate);
            body = body.Replace("{MESSAGE}", msg.ToString(), StringComparison.OrdinalIgnoreCase);
            // Replace template by the document Request details Before update
            body = body.Replace("{LABEL_OLD_DOCUMENT_REQUEST}", oldDocumentRequest.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DESCRIPTION_OLD_DOCUMENT_REQUEST}", oldDocumentRequest.Description, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{TYPE_OLD_DOCUMENT_REQUEST}", oldDocumentRequest.IdDocumentRequestTypeNavigation.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DEADLINE_OLD_DOCUMENT_REQUEST}", deadlineOldDocumentRequest, StringComparison.OrdinalIgnoreCase);
            // Replace template by the new document Request details After update
            body = body.Replace("{LABEL_NEW_DOCUMENT_REQUEST}", newDocumentRequest.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DESCRIPTION_NEW_DOCUMENT_REQUEST}", newDocumentRequest.Description, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{TYPE_NEW_DOCUMENT_REQUEST}", newDocumentRequest.IdDocumentRequestTypeNavigation.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DEADLINE_NEW_DOCUMENT_REQUEST}", deadlineNewDocumentRequest, StringComparison.OrdinalIgnoreCase);
            return body;
        }
        /// <summary>
        /// GetDocumentsFromListId
        /// </summary>
        /// <param name="listIdDocuments"></param>
        /// <returns></returns>
        public List<DocumentRequestViewModel> GetDocumentsFromListId(List<int> listIdDocuments)
        {
            List<DocumentRequestViewModel> listedDocuments = new List<DocumentRequestViewModel>();
            listIdDocuments.ForEach((x) =>
            {
                DocumentRequestViewModel document = GetModelById(x);
                if (document.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
                {
                    listedDocuments.Add(document);
                }
            });
            return listedDocuments;
        }
        /// <summary>
        /// ValidateMassiveDocuments
        /// </summary>
        /// <param name="listOfDocuments"></param>
        public void ValidateMassiveDocuments(List<DocumentRequestViewModel> listOfDocuments, string userMail)
        {
            try
            {
                BeginTransaction();
                listOfDocuments.ForEach((document) =>
                {
                    document.Status = (int)AdministrativeDocumentStatusEnumerator.Accepted;
                    ValidateDocumentRequest(document, null, userMail);
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
        /// RefuseMassiveDocumentRequest
        /// </summary>
        /// <param name="listIdDocuments"></param>
        public void RefuseMassiveDocumentRequest(List<int> listIdDocuments, string userMail)
        {
            listIdDocuments.ForEach((x) =>
            {
                DocumentRequestViewModel document = GetModelById(x);
                document.Status = (int)AdministrativeDocumentStatusEnumerator.Refused;
                ValidateDocumentRequest(document, null, userMail);
            });

        }
        /// <summary>
        /// DeleteMassiveDocumentRequest
        /// </summary>
        /// <param name="listIdDocuments"></param>
        public void DeleteMassiveDocumentRequest(List<int> listIdDocuments, string userMail)
        {
            listIdDocuments.ForEach((id) =>
            {
                DeleteModel(id, nameof(DocumentRequest), userMail);
            });

        }
    }
}
