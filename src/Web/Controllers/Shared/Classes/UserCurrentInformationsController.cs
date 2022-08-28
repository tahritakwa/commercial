using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Primitives;
using Services.Catalog.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Linq;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/userCurrentInformations")]
    public class UserCurrentInformationsController : BaseController
    {
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceUser _serviceUser;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServiceMasterUser _serviceMasterUser;
        public UserCurrentInformationsController(IServiceProvider serviceProvider, ILogger<UserCurrentInformationsController> logger,
            IServiceCompany serviceCompany, IServiceUser serviceUser, IServiceEmployee serviceEmployee, IServiceMasterUser serviceMasterUser)
           : base(serviceProvider, logger)
        {
            _serviceCompany = serviceCompany;
            _serviceUser = serviceUser;
            _serviceEmployee = serviceEmployee;
            _serviceMasterUser = serviceMasterUser;
        }

        [HttpGet("getCurrentCompanyActivityArea")]
        public int GetCurrentCompanyActivityArea()
        {
            return _serviceCompany.GetCurrentCompanyActivityArea();
        }

        [HttpGet("getConnectedEmployeeId")]
        public int GetConnectedEmployeeId()
        {
            Request.HttpContext.Request.Headers.TryGetValue("User", out StringValues userMailValue);
            string userMail = userMailValue.First();
            return _serviceEmployee.GetConnectedEmployeeId(userMail);
        }

        [HttpGet("getUserCurrentInformations")]
        public UserCurrentInformationsViewModel GetUserCurrentInformations()
        {
            GetUserMailInvariant();
            UserViewModel user = _serviceUser.GetModelWithRelationsAsNoTracked(x => x.Email == userMail);
            MasterUserViewModel masterUser = _serviceMasterUser.GetModelWithRelationsAsNoTracked(x => x.Email == userMail);
            CompanyViewModel company = _serviceCompany.GetModelWithRelationsAsNoTracked(x => x.Code == masterUser.LastConnectedCompany, x => x.IdCurrencyNavigation);
            return new UserCurrentInformationsViewModel()
            {
                IdUser = user.Id,
                UserMail = user.Email,
                Language = user.Lang,
                ActivityArea = company.ActivityArea,
                CompanyCode = company.Code,
                IdEmployee = user.IdEmployee
            };
        }
        /// <summary>
        /// api to get current company activity area and currency
        /// </summary>
        /// <returns></returns>
        [HttpGet("getCurrentCompanyActivityAreaAndCurrency")]
        public ReducedCurrencyAndActivityAreaViewModel GetCurrentCompanyActivityAreaAndCurrency()
        {
            return _serviceCompany.GetCurrentCompanyActivityAreaAndCurrency();
        }
    }
}
