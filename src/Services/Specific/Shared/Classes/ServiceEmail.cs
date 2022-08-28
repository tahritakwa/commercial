using MimeKit;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceEmail : Service<EmailViewModel, Email>, IServiceEmail
    {
        public ServiceEmail(IRepository<Email> entityRepo, IUnitOfWork unitOfWork,
           IEmailBuilder emailBuilder, 
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,  IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, emailBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        public string GetEmailHtmlContentFromFile(string root)
        {
            string emailHtmlContent = "";
            string currentDirectory = Directory.GetCurrentDirectory();
            using (StreamReader reader = new StreamReader(Path.Combine(currentDirectory, root)))
            {
                emailHtmlContent = reader.ReadToEnd();
            }
            return emailHtmlContent;
        }

        /// <summary>
        /// Prepare And Send Email
        /// </summary>
        /// <param name="email"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void PrepareAndSendEmail(EmailViewModel email, string userMail, SmtpSettings smtpSettings)
        {
            MailMessage message = GenerateMailMessageFromEmail(email, smtpSettings);
            SendEmail(message, smtpSettings);
        }

        public void SendEmail(MailMessage message, SmtpSettings smtpSettings)
        {
            if (message == null || smtpSettings == null)
            {
                throw new ArgumentException("");
            }
            if (message.To.Any() || message.Bcc.Any() || message.CC.Any())
            {
                using (var smtpClient = new SmtpClient(smtpSettings.SmtpMailServer, smtpSettings.SmtpMailPort))
                {
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new System.Net.NetworkCredential(smtpSettings.AdministratorMail, smtpSettings.AdministratorPassword);
                    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtpClient.EnableSsl = smtpSettings.EnableSsl;
                    smtpClient.Send(message);
                }
            }
        }

        /// <summary>
        /// Generate MailMessage From Email
        /// </summary>
        /// <param name="email"></param>
        /// <param name="smtpSettings"></param>
        /// <returns></returns>
        private MailMessage GenerateMailMessageFromEmail(EmailViewModel email, SmtpSettings smtpSettings)
        {

            AlternateView av = AlternateView.CreateAlternateViewFromString(email.Body, null, System.Net.Mime.MediaTypeNames.Text.Html);
            BodyBuilder bodyBuilder = new BodyBuilder
            {
                HtmlBody = email.Body
            };

            MailMessage message = new MailMessage
            {
                // Add From
                From = new MailAddress(smtpSettings.AdministratorMail),

                // Add subject
                Subject = email.Subject,

                // Add body
                Body = bodyBuilder.ToMessageBody().ToString(),

                AlternateViews = { av }
            };

            // Recivers list
            List<string> emailAdresses = email.Receivers.Split(";").ToList();

            // Add recievers
            emailAdresses.ForEach(e => message.Bcc.Add(new MailAddress(e)));


            return message;
        }
    }
}
