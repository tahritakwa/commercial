using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Specific.ErpSettings.Classes;
using Services.Specific.Sales.Interfaces;
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

namespace Services.Specific.Sales.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="Infrastruture.Service.Service{ModelView.ErpSettings.ModuleViewModel, DataMapping.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceMessagePriceRequest : ServiceMessage, IServiceMessagePriceRequest
    {
        internal readonly IRepository<PriceRequest> _entityRepoPriceRequest;
        private readonly AppSettings _settings;
        private readonly IRepository<Item> _entityRepoItem;

        public ServiceMessagePriceRequest(IRepository<Message> entityRepo,
            IServiceCompany companyService,
            IUnitOfWork unitOfWork,
            IMessageBuilder entityBuilder,
            IServiceEmail serviceEmail,
            IRepository<PriceRequest> entityRepoPriceRequest,
            IRepository<MsgNotification> entityRepoMsgNotification,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings, IRepository<Item> entityRepoItem)
             : base(entityRepo, companyService, unitOfWork, entityBuilder, serviceEmail, entityRepoMsgNotification, entityRepoEntityAxisValues,
                  builderEntityAxisValues, appSettings)
        {
            _entityRepoPriceRequest = entityRepoPriceRequest;
            _settings = appSettings.Value;
            _entityRepoItem = entityRepoItem;
        }

        /// <summary>
        /// Send broadcast mail
        /// </summary>
        /// <param name="mails"></param>
        /// <param name="url"></param>
        /// <param name="msg"></param>
        /// <param name="subject"></param>
        /// <param name="configMail"></param>
        /// <param name="smtpSettings"></param>

        public override void BroadCastMail(IList<string> mails, string url, string msg, string subject, MailBrodcastConfigurationViewModel configMail, SmtpSettings smtpSettings)
        {
            MailMessage message = new MailMessage();
            string body = GetBody(message, mails, subject, smtpSettings, Path.Combine("wwwroot", "views", "MallingTemplate", "SendMailToSupplier.html").Trim(), configMail, url, msg);
            PriceRequest priceRequest = _entityRepoPriceRequest.GetSingleWithRelations(x => x.Id == configMail.Model.Id, x => x.PriceRequestDetail);
            if (priceRequest.PriceRequestDetail != null && priceRequest.PriceRequestDetail.Any())
            {
                priceRequest.PriceRequestDetail.ToList().ForEach(p => p.IdItemNavigation = _entityRepoItem.FindSingleBy(i => i.Id == p.IdItem));
            }
            var listItems = GetMyTable(priceRequest.PriceRequestDetail, x => x.IdItemNavigation.Code, x => x.Designation, x => x.MovementQty);
            body = body.Replace("{ListItems}", listItems);
            message.AlternateViews.Add(GetAlternateViewsMessage(body));
            _serviceEmail.SendEmail(message, smtpSettings);
        }

        public static string GetMyTable<T>(IEnumerable<T> list, params Func<T, object>[] fxns)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var item in list)
            {
                sb.Append("<tr>\n");
                foreach (var fxn in fxns)
                {
                    sb.Append("<td>");
                    sb.Append(fxn(item));
                    sb.Append("</td>");
                }
                sb.Append("</tr>\n");
            }

            return sb.ToString();
        }
    }
}
