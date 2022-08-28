using Microsoft.EntityFrameworkCore;
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
    public class ServiceMessageDocument : ServiceMessage, IServiceMessageDocument
    {
        internal readonly IRepository<Document> _entityRepoDocument;
        private readonly AppSettings _settings;
        public ServiceMessageDocument(IRepository<Message> entityRepo,
            IServiceCompany companyService,
            IUnitOfWork unitOfWork,
            IMessageBuilder entityBuilder, IServiceEmail serviceEmail, IRepository<Document> entityRepoDocument,
            IRepository<MsgNotification> entityRepoMsgNotification,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues, IOptions<AppSettings> appSettings)
            : base(entityRepo, companyService, unitOfWork, entityBuilder, serviceEmail, entityRepoMsgNotification, entityRepoEntityAxisValues,
                  builderEntityAxisValues, appSettings)
        {
            _entityRepoDocument = entityRepoDocument;
            _settings = appSettings.Value;
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
            Document document = _entityRepoDocument.QuerableGetAll().Include(x => x.DocumentLine).ThenInclude(x => x.IdItemNavigation).Include(x => x.DocumentLine).
                ThenInclude(x => x.DocumentLineTaxe).ThenInclude(x => x.IdTaxeNavigation).Where(x => x.Id == configMail.Model.Id).FirstOrDefault();
            if (document != null)
            {
                MailMessage message = new MailMessage();
                string validationMessage = msg.Replace(CODE, configMail.Model.Code);
                url = new StringBuilder().Append(url).Append("/").Append(document.IdDocumentStatus).ToString();
                string body = GetBody(message, mails, subject, smtpSettings,Path.Combine("wwwroot","views","MallingTemplate","SendMail.html").Trim(), configMail, url, validationMessage);


                var listItems = GetMyTable
                    (document.DocumentLine,
                    document.DocumentHtpriceWithCurrency != null ? document.DocumentHtpriceWithCurrency.Value : 0,
                    x => x.IdItemNavigation.Description + " - " + x.IdItemNavigation.Code,
                    x => x.MovementQty,
                    x => x.UnitPriceFromQuotation != null && x.UnitPriceFromQuotation > 0 ? x.UnitPriceFromQuotation : x.HtUnitAmountWithCurrency,
                    x => x.DiscountPercentage,
                    x => x.HtTotalLineWithCurrency);

                body = body.Replace("{ListItems}", listItems);
                message.AlternateViews.Add(GetAlternateViewsMessage(body));
                _serviceEmail.SendEmail(message, smtpSettings);
            }
        }

        public static string GetMyTable<T>(IEnumerable<T> list, double totalHT, params Func<T, object>[] fxns)
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
                sb.Append("</TR>\n");
            }
            sb.Append("<tr>");
            sb.Append("<td></td>");
            sb.Append("<td></td>");
            sb.Append("<td></td>");
            sb.Append("<td></td>");
            sb.Append("<td>Totaux: " + totalHT + "</td>");
            sb.Append(" </tr>");
            return sb.ToString();
        }
    }
}
