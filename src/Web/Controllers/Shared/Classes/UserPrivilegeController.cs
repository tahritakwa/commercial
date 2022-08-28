using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Shared.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/userPrivilege")]
    public class UserPrivilegeController : BaseController
    {
        private readonly IServiceUserPrivilege _userPrivilegeService;

        public UserPrivilegeController(IServiceProvider serviceProvider, ILogger<BaseController> logger, IServiceUserPrivilege userPrivilegeService)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _userPrivilegeService = userPrivilegeService;
        }

        [HttpPost("getUserPrivileges"), Authorize("SHOW_USERPRIVILEGE")]
        public DataSourceResult<UserPrivilegeViewModel> GetUserPrivilege([FromBody] PredicateFormatViewModel predicate)
        {
            return _userPrivilegeService.GetUserPrivileges(predicate);
        }
    }
}
