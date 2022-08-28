using Microsoft.Extensions.Options;
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
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSharedDocument : Service<SharedDocumentViewModel, SharedDocument>, IServiceSharedDocument
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IRepository<User> _entityRepoUser;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServiceInformation _serviceInformation;
        private readonly IServiceEmail _serviceEmail;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceUser _serviceUser;
        private readonly ISharedDocumentBuilder _reducedBuilder;
        public ServiceSharedDocument(IRepository<SharedDocument> entityRepo,
        IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ISharedDocumentBuilder builder,
        IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany, IServiceEmployee serviceEmployee,
        IServiceMsgNotification serviceMessageNotification, IServiceInformation serviceInformation,
        IOptions<SmtpSettings> smtpSettings, IServiceEmail serviceEmail,
        IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser, IEntityAxisValuesBuilder builderEntityAxisValues,
        IServiceUser serviceUser)
        : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceEmployee = serviceEmployee;
            _serviceMessageNotification = serviceMessageNotification;
            _serviceInformation = serviceInformation;
            _entityRepoUser = entityRepoUser;
            _serviceEmail = serviceEmail;
            _smtpSettings = smtpSettings.Value;
            _serviceUser = serviceUser;
            _reducedBuilder = builder;
        }
        /// <summary>
        /// get the list of sharedDocument with files
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="predicateFilterRelationModel"></param>
        /// <returns></returns>
        public override DataSourceResult<SharedDocumentViewModel> GetListWithSpecificPredicat(PredicateFormatViewModel predicateModel,
            PredicateFilterRelationViewModel<SharedDocument> predicateFilterRelationModel)
        {

            DataSourceResult<SharedDocumentViewModel> dataSource = base.GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            dataSource.data.ToList().ForEach(sharedDocument =>
                {
                    sharedDocument.FilesInfos = GetFiles(sharedDocument.AttachmentUrl).ToList();
                }
             );
            return dataSource;
        }
        public override DataSourceResult<SharedDocumentViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {

            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<SharedDocument> entities = null;
            PredicateFilterRelationViewModel<SharedDocument> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
               
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
                entities = GetEntitiesDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);
                var total = entities.Count();
                if (predicateModelWithSpecificFilters.page > 0 && predicateModelWithSpecificFilters.pageSize > 0)
                {
                    entities = entities.Skip((predicateModelWithSpecificFilters.page - 1) * predicateModelWithSpecificFilters.pageSize).Take(predicateModelWithSpecificFilters.pageSize);
                }
                List<int> idsDoc = entities.Select(x => x.Id).ToList();
                List<SharedDocumentViewModel> model = entities.ToList().Select(x => _reducedBuilder.BuildEntity(x)).ToList();
                return new DataSourceResult<SharedDocumentViewModel> { data = model, total = total };

            }
            return null;

        }
        /// <summary>
        /// Save Pictures and update the attachement Url
        /// </summary>
        /// <param name="model"></param>
        private void ManageFiles(SharedDocumentViewModel model, string userMail)
        {
            Employee employee = _serviceEmployee.GetEntityAsNoTracked(x => x.Id == model.IdEmployee);
            string fileUrl = Path.Combine("SharedDocument", employee.FirstName + "_" + employee.LastName, Guid.NewGuid().ToString()); 
            if (model.FilesInfos != null)
            {
                if (model.EncryptFile)
                {
                    CopyPdfFilesWithSecurityPassword(fileUrl, model.FilesInfos,
                        _serviceEmployee.GetSharedDocumentsPasswordAndSendItIfFirstGeneration(employee, userMail, _smtpSettings));
                }
                else
                {
                    CopyFiles(fileUrl, model.FilesInfos);
                }
            }
            model.AttachmentUrl = fileUrl;
        }
        /// <summary>
        /// override the base add method to support saving files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(SharedDocumentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (!model.FilesInfos.Any())
            {
                throw new CustomException(CustomStatusCode.CannotAddSharedDocumentEntityWithoutDocument);
            }
            model.SubmissionDate = DateTime.Now;
            // Add Files
            ManageFiles(model, userMail);
            User connectedUser = _entityRepoUser.FindSingleBy(x => x.Email == userMail);
            if (connectedUser != null)
            {
                model.TransactionUserId = connectedUser.Id;
            }
            return (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, null);
        }
        /// <summary>
        /// add the shared document and send a mail and notif to the user associated 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object AddSharedDocumentAndSendMail(string url, SharedDocumentViewModel model, string userMail)
        {
            model.TransactionUserId = _serviceUser.GetModel(x => x.Email == userMail).Id;
             _serviceEmployee.ValidateResignedStatusEmployee(model.IdEmployee);
            
            CreatedDataViewModel result = (CreatedDataViewModel)AddModelWithoutTransaction(model, null, userMail, null);
            if (result != null)
            {

                User userToNotify = _entityRepoUser.FindSingleBy(x => x.IdEmployee == model.IdEmployee);
                if (userToNotify != null)
                {
                    // send notif
                    _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.SHARING_DOCUMENT,
                     result.Id, result.Code, (int)MessageTypeEnumerator.AlertSharingDocument,
                     userMail, null, new List<User> { userToNotify }, GetCurrentCompany().Code);
                    // send mail 
                    InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == Constants.SHARING_DOCUMENT)
                     .FirstOrDefault();
                    sendEmail(information, userToNotify, userMail, url, _smtpSettings);
                }
            }
            return result;
        }

        /// <summary>
        /// Send email after adding a shared document to the user associated 
        /// </summary>
        /// <param name="information"></param>
        /// <param name="user"></param>
        /// <param name="userMail"></param>
        /// <param name="link"></param>
        /// <param name="smtpSettings"></param>
        public void sendEmail(InformationViewModel information, User user, string userMail, string link,
            SmtpSettings smtpSettings)
        {

            EmailConstant emailConstant = new EmailConstant(user.Lang);
            string subject = emailConstant.SharedDocumentEmailSubject;
            string message = PrepareMessage(user, information);
            StringBuilder path = new StringBuilder();
            path.Append(link); path.Append(information.Url);
            string mailUrl = PrepareUrl(emailConstant, path.ToString());
            string body = PrepareMailBody(emailConstant, message, mailUrl);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = 1,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = user.Email
            };
            // add the email in the db
            _serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail);
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
        }
        public string PrepareMessage(User user, InformationViewModel information)
        {
            StringBuilder msgBuilder = new StringBuilder();
            switch (user.Lang)
            {
                case "fr":
                    msgBuilder.Append(information.Fr);
                    break;
                case "en":
                    msgBuilder.Append(information.En);
                    break;
            }
            string msg = msgBuilder.ToString();
            return msg;
        }

        string PrepareUrl(EmailConstant emailConstant, string url)
        {
            StringBuilder Url = new StringBuilder();
            Url.Append("<a href='");
            Url.Append(@url);
            Url.Append("'>");
            Url.Append(emailConstant.AccessToYourSpace);
            Url.Append("</a>");
            return Url.ToString();
        }

        string PrepareMailBody(EmailConstant emailConstant, string msg, string link)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.SharingDocumentEmailTemplate);
            body = body.Replace("{MESSAGE}", msg, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{LINK}", link, StringComparison.OrdinalIgnoreCase);
            return body;
        }

        public DataSourceResult<SharedDocumentViewModel> GenerateSharedDocumentList(string userMail, DateTime? endDate, DateTime? startDate, PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<SharedDocumentViewModel> dataSourceResult = new DataSourceResult<SharedDocumentViewModel>();
            predicateModel.Operator = Operator.And;
            PredicateFilterRelationViewModel<SharedDocument> predicateFilterRelationModel = PreparePredicate(predicateModel);
            UserViewModel user = _serviceUser.GetModel(x => x.Email == userMail);
            Expression<Func<SharedDocument, bool>> sharedDocumentPredicate = x => 
                (!startDate.HasValue || (startDate.HasValue && endDate.HasValue && (x.SubmissionDate.BetweenDateTimeLimitIncluded(startDate.Value, endDate.Value))))
                || (!startDate.HasValue || (startDate.HasValue && x.SubmissionDate.AfterDateLimitIncluded(startDate.Value)))
                || (!endDate.HasValue || (endDate.HasValue && x.SubmissionDate.BeforeDateLimitIncluded(endDate.Value)));
            IQueryable<SharedDocument> dataSourceList = _entityRepo.GetAllWithConditionsRelationsQueryable(sharedDocumentPredicate,
                predicateFilterRelationModel.PredicateRelations)
                .Skip((predicateModel.page - 1) * predicateModel.pageSize)
                .Take(predicateModel.pageSize);
            dataSourceResult.total = _entityRepo.GetCountWithPredicate(sharedDocumentPredicate);
            dataSourceResult.data = dataSourceList.Select(x => _builder.BuildEntity(x)).ToList();
            dataSourceResult.data.ToList().ForEach((sharedDocumentViewModel) =>
            {
                sharedDocumentViewModel.FilesInfos = GetFilesContent(sharedDocumentViewModel.AttachmentUrl);
            });

            return dataSourceResult;
        }

    }
}
