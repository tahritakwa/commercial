using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes
{
    public class ServiceFileDriveSharedDocument : Service<FileDriveSharedDocumentViewModel, FileDriveSharedDocument>, IServiceFileDriveSharedDocument
    {
        private readonly IServiceUser _serviceUser;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IRepository<User> _entityRepoUser;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceInformation _serviceInformation;
        internal readonly IRepository<Company> _entityRepoCompany;
        private readonly AppSettings _appSettings;
        public ServiceFileDriveSharedDocument(IRepository<FileDriveSharedDocument> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IFileDriveSharedDocumentBuilder builder,
          IRepository<User> entityRepoUser, IRepository<Company> entityRepoCompany, IServiceInformation serviceInformation,
          IServiceUser serviceUser, IOptions<SmtpSettings> smtpSettings, IServiceEmail serviceEmail, IServiceEmployee serviceEmployee, IOptions<AppSettings> appSettings,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceUser = serviceUser;
            _entityRepoUser = entityRepoUser;
            _serviceEmail = serviceEmail;
            _smtpSettings = smtpSettings.Value;
            _serviceEmployee = serviceEmployee;
            _serviceInformation = serviceInformation;
            _entityRepoCompany = entityRepoCompany;
            _appSettings = appSettings.Value;

        }
        /// <summary>
        /// saving proprietes of shared document
        /// </summary>
        /// <param name="url"></param>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object AddSharedDocumentAndSendMail(string url, FileDriveSharedDocumentViewModel model, string userMail)
        {
            model.TransactionUserId = _serviceUser.GetModel(x => x.Email == userMail).Id;
            CreatedDataViewModel result = (CreatedDataViewModel)AddModelWithoutTransaction(model, null, userMail, null);
            if (result != null)
            {

                User userToNotify = _entityRepoUser.FindSingleBy(x => x.IdEmployee == model.IdEmployee);
                if (userToNotify != null)
                {
                 
                    // send mail 
                    InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == Constants.SHARING_DOCUMENT)
                     .FirstOrDefault();
                    sendEmail(information, userToNotify, userMail, url, _smtpSettings);
                }
            }
            return result;
        }
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
        public override object AddModelWithoutTransaction(FileDriveSharedDocumentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
          {
              model.SharingDate = DateTime.Now;
              // Add Files
              ManageFiles(model, userMail);
        User connectedUser = _entityRepoUser.FindSingleBy(x => x.Email == userMail);
         if (connectedUser != null)
         {
             model.TransactionUserId = connectedUser.Id;
         }
         return (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, null);
     }
        private void ManageFiles(FileDriveSharedDocumentViewModel model, string userMail)
        {
            Employee employee = _serviceEmployee.GetEntityAsNoTracked(x => x.Id == model.IdEmployee);
            string fileUrl = Path.Combine("SharedDocument", employee.FirstName + "_" + employee.LastName, Guid.NewGuid().ToString()); 
            if (model.FilesInfos != null)
            {
                if (model.EncryptFile)
                {
                    ServiceStarkdrive.CopyPdfFilesWithSecurityPassword(fileUrl, model.FilesInfos,
                        _serviceEmployee.GetSharedDocumentsPasswordAndSendItIfFirstGeneration(employee, userMail, _smtpSettings));
                }
                else
                {
                    string companyName = _entityRepoCompany.GetSingleNotTracked(x => true).Name;
                    string uploadDirectory = _appSettings.UploadFilePath;
                    string fullpath = uploadDirectory + companyName + fileUrl;
                    ServiceStarkdrive.MoveFiles(fullpath, model.FilesInfos);
                }
            }
            model.AttachmentUrl = fileUrl;
        }
    }
}