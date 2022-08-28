using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceMessage : IService<MessageViewModel, Message>
    {
        int AddMessage(MessageViewModel model, IList<EntityAxisValuesViewModel> EntityAxisValuesModelList, string userMail, string property = null);
        void BroadCastMail(IList<string> mails, string url, string msg, string subject, MailBrodcastConfigurationViewModel configMail, SmtpSettings smtpSettings);
        void ConfigureMail(MailBrodcastConfigurationViewModel configMail, SmtpSettings smtpSettings);
    }
}
