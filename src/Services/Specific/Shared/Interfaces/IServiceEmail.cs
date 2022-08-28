using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Net.Mail;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceEmail : IService<EmailViewModel, Email>
    {
        string GetEmailHtmlContentFromFile(string root);
        void PrepareAndSendEmail(EmailViewModel email, string userMail, SmtpSettings smtpSettings);
        void SendEmail(MailMessage message, SmtpSettings smtpSettings);
    }
}
