using Microsoft.Extensions.Options;
using MimeKit;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.ErpSettings.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="Infrastruture.Service.Service{ModelView.ErpSettings.ModuleViewModel, DataMapping.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceMessage : Service<MessageViewModel, Message>, IServiceMessage
    {
        #region constants
        public const string SLASH = "/";
        public const string CODE = "{CODE}";
        #endregion

        #region fields

        private readonly IServiceCompany _companyService;
        private readonly IRepository<MsgNotification> _entityRepoMsgNotification;
        private readonly AppSettings _settings;
        protected readonly IServiceEmail _serviceEmail;
        #endregion
        /// <summary>
        /// Parametrized ctor
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="userService"></param>
        /// <param name="companyService"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="entityBuilder"></param>
        /// <param name="entityRepoTraceability"></param>
        /// <param name="entityRepoUser"></param>
        /// <param name="functionnalityRepo"></param>
        /// <param name="entityRepoMsgNotification"></param>
        /// <param name="entityRepoInformation"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        /// <param name="entityRepoEntity"></param>
        /// <param name="builderEntityAxisValues"></param>
        public ServiceMessage(IRepository<Message> entityRepo,
            IServiceCompany companyService, IUnitOfWork unitOfWork,
            IMessageBuilder entityBuilder, IServiceEmail serviceEmail,
            IRepository<MsgNotification> entityRepoMsgNotification,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<AppSettings> appSettings)
             : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _companyService = companyService;
            _entityRepoMsgNotification = entityRepoMsgNotification;
            _settings = appSettings.Value;
            _serviceEmail = serviceEmail;
        }
        #region Methodes
        /// <summary>
        /// Send broadcast mail
        /// </summary>
        /// <param name="mails"></param>
        /// <param name="url"></param>
        /// <param name="msg"></param>
        /// <param name="subject"></param>
        /// <param name="configMail"></param>
        /// <param name="smtpSettings"></param>
        public virtual void BroadCastMail(IList<string> mails, string url, string msg, string subject, MailBrodcastConfigurationViewModel configMail, SmtpSettings smtpSettings)
        {
            StringBuilder messageBody = new StringBuilder();
            int firstIndexOfAt = msg.IndexOf("@");
            int lastIndexOfAt = msg.LastIndexOf("@");
            if (firstIndexOfAt > -1 && lastIndexOfAt > -1)
            {
                string textContent = msg.Substring(0, firstIndexOfAt - 1).Replace(CODE, configMail.Model.Code);
                messageBody.Append(textContent);
            }
            else
            {
                string textContent = msg.Replace(CODE, configMail.Model.Code);
                messageBody.Append(textContent);
            }
            MailMessage message = new MailMessage();
            var path = Path.Combine("wwwroot", "views", "MallingTemplate", "RequestMail.html").Trim();
            string body = GetBody(message, mails, subject, smtpSettings, path, configMail, url, messageBody.ToString());
            message.AlternateViews.Add(GetAlternateViewsMessage(body));
            BodyBuilder bodyBuilder = new BodyBuilder
            {
                HtmlBody = messageBody.ToString()
            };
            message.Body = bodyBuilder.ToMessageBody().ToString();
            _serviceEmail.SendEmail(message, smtpSettings);
        }
        /// <summary>
        /// ConfigureMail
        /// </summary>
        /// <param name="configMail"></param>
        /// <param name="smtpSettings"></param>
        public void ConfigureMail(MailBrodcastConfigurationViewModel configMail, SmtpSettings smtpSettings)
        {
            BeginTransactionunReadUncommitted();
            MessageViewModel _msgVM = GetModelWithRelations(msg => msg.Id == configMail.IdMsg, msg => msg.IdInformationNavigation);
            StringBuilder urlBuilder = new StringBuilder();
            urlBuilder.Append(_msgVM.IdInformationNavigation.Url);
            urlBuilder.Append(SLASH);
            urlBuilder.Append(_msgVM.EntityReference);
            StringBuilder msgBuilder = new StringBuilder();
            CompanyViewModel company = _companyService.GetAllModels().FirstOrDefault();
            switch (company.Culture)
            {
                case "fr":
                    msgBuilder.Append(_msgVM.IdInformationNavigation.Fr);
                    break;
                case "en":
                    msgBuilder.Append(_msgVM.IdInformationNavigation.En);
                    break;
                case "de":
                    msgBuilder.Append(_msgVM.IdInformationNavigation.De);
                    break;
                case "ar":
                    msgBuilder.Append(_msgVM.IdInformationNavigation.Ar);
                    break;
            }
            msgBuilder.Append(' ', 90);
            BroadCastMail(configMail.users, urlBuilder.ToString(), msgBuilder.ToString(), _msgVM.IdInformationNavigation.MailSubject, configMail, smtpSettings);
            EndTransaction();
        }
        public int AddMessage(MessageViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail, string property = null)
        {
            int msgId = ((CreatedDataViewModel)base.AddModel(model, EntityAxisValuesModelList, userMail, property)).Id;
            if (model.users != null)
            {
                foreach (UserViewModel user in model.users)
                {
                    _entityRepoMsgNotification.Add(new MsgNotification() { IdMsg = msgId, IdTargetedUser = user.Id, Viewed = false, CreationDate = DateTime.Now });
                }
            }
            _unitOfWork.Commit();
            return msgId;
        }

        public string GetBody(MailMessage message, IList<string> mails, string subject, SmtpSettings smtpSettings, string root, MailBrodcastConfigurationViewModel configMail,
            string url, string messageValidation)
        {
            string body = string.Empty;
            message.From = new MailAddress(smtpSettings.AdministratorMail);
            mails.ToList().ForEach(mail => message.Bcc.Add(new MailAddress(mail)));
            message.Subject = subject;
            using (StreamReader reader = new StreamReader(Path.Combine(Directory.GetCurrentDirectory(), root)))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{LinkValidation}", new StringBuilder().Append(configMail.URL).Append(@url).ToString());
            body = body.Replace("{Validation}", messageValidation);
            body = body.Replace("{LogoCpompany}", "cid:companyLogo");
            body = body.Replace("{LogoStark}", "cid:StarkLogo");
            return body;
        }

        public AlternateView GetAlternateViewsMessage(string body)
        {
            CompanyViewModel company = _companyService.GetAllModels().FirstOrDefault();
            AlternateView av = AlternateView.CreateAlternateViewFromString(body, null, System.Net.Mime.MediaTypeNames.Text.Html);
            var path = Path.Combine("wwwroot", "assets", "images", "logos");
            byte[] readerFile = File.ReadAllBytes(Path.Combine(Directory.GetCurrentDirectory(), path, "logo_stark.png"));
            MemoryStream image1 = new MemoryStream(readerFile);
            LinkedResource headerImage = new LinkedResource(image1, System.Net.Mime.MediaTypeNames.Image.Jpeg)
            {
                ContentId = "StarkLogo",
                ContentType = new System.Net.Mime.ContentType("image/jpg")
            };
            av.LinkedResources.Add(headerImage);
            if (company.AttachmentUrl != null)
            {
                if (Directory.Exists(Path.Combine(_settings.UploadFilePath, company.Name, company.AttachmentUrl)))
                {
                    var logocompany = Directory.GetFiles(Path.Combine(_settings.UploadFilePath, company.Name, company.AttachmentUrl)).FirstOrDefault();
                    if (logocompany != null)
                    {
                        byte[] readerFileCompany = File.ReadAllBytes(logocompany);
                        MemoryStream image2 = new MemoryStream(readerFileCompany);
                        LinkedResource headerImageCompany = new LinkedResource(image2, System.Net.Mime.MediaTypeNames.Image.Jpeg)
                        {
                            ContentId = "companyLogo",
                            ContentType = new System.Net.Mime.ContentType("image/jpg")
                        };
                        av.LinkedResources.Add(headerImageCompany);
                    }
                }
            }
            return av;
        }


        #endregion
    }
}
