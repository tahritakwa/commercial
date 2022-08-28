using Microsoft.AspNetCore.Mvc;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Interfaces
{
    interface IMailingController : IBaseController
    {
        void BroadCastMail([FromBody] MailBrodcastConfigurationViewModel configModel);
    }
}
