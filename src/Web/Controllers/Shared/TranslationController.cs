using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Services.Specific.ErpSettings.Interfaces;
using Settings.Config;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.Controllers.Shared
{
    [Route("api/translation")]
    public class TranslationController : Controller
    {

        private readonly IServiceTranslation _serviceTranslation;
        private readonly AppSettings _appSettings;


        public TranslationController(IOptions<AppSettings> appSettings, IServiceTranslation serviceTranslation)
        {
            _serviceTranslation = serviceTranslation;
            _appSettings = appSettings.Value;
        }

    }
}
