using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.Comparers;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/confirmation")]

    public class NoAuthController : BaseController
    {
        private readonly IServiceInterview _serviceInterview;
        private readonly IServiceOffer _serviceOffer;
        private readonly AppSettings _appSettings;
        private readonly IServiceCompany _serviceCompany;
        private readonly DbSettings _defaultDbSettings;



        public NoAuthController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, IServiceOffer serviceOffer,
        ILogger<CompanyController> logger, IServiceCompany serviceCompany, IServiceInterview serviceInterview)
            : base(serviceProvider, logger)
        {
            _serviceInterview = serviceInterview;
            _serviceOffer = serviceOffer;
            _appSettings = appSettings.Value;
            if (appSettings != null)
            {
                _defaultDbSettings = appSettings.Value.DbSettings;
            }
            _serviceCompany = serviceCompany;
            _logger = logger;
        }

        /// <summary>
        /// Confirm candidate disponibility for interview from link in email and return the Corresponding view
        /// </summary>
        /// <param name="token"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        [HttpGet("interview/{token}/{lang}"), AllowAnonymous]
        public IActionResult CandidateDisponibilityConfirmation(string token, string lang)
        {
            try
            {
                List<DbSettings> _dbConnectionSettings = _serviceCompany.GetAllDbSettings().ToList();
                var generatedConnectionString = ManageDBConnections.BuildConnectionString(_dbConnectionSettings[0], _defaultDbSettings);
                ViewBag.number = _serviceInterview.ConfirmTheCandidateDisponibilityFromLink(generatedConnectionString, token);
                switch (lang)
                {
                    case "fr":
                        return View(Constants.CONFIRMATION_EMAIL_PATH_FR);
                    case "en":
                        return View(Constants.CONFIRMATION_EMAIL_PATH_EN);
                    default:
                        return View(Constants.CONFIRMATION_EMAIL_PATH_EN);
                }
  
            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject(typeof(NoAuthController).Name, e);
                throw;
            }
        }
        /// <summary>
        /// Confirm the offer proposal from link in email and return the corresponding view
        /// </summary>
        /// <param name="token"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        [HttpGet("offer/{token}/{lang}"), AllowAnonymous]
        public IActionResult OfferConfirmation(string token, string lang)
        {
            try
            {
                List<DbSettings> _dbConnectionSettings = _serviceCompany.GetAllDbSettings().ToList();
                var generatedConnectionString = ManageDBConnections.BuildConnectionString(_dbConnectionSettings[0], _defaultDbSettings);
                ViewBag.number = _serviceOffer.ConfirmOfferFromLink(generatedConnectionString, token);
                switch (lang)
                {
                    case "fr":
                        return View(Constants.CONFIRMATION_EMAIL_PATH_FR);
                    case "en":
                        return View(Constants.CONFIRMATION_EMAIL_PATH_EN);
                    default:
                        return View(Constants.CONFIRMATION_EMAIL_PATH_EN);
                }

            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject(typeof(NoAuthController).Name, e);
                throw;
            }
        }
    }

}
