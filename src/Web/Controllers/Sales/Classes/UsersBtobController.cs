using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;
using Web.Controllers.Sales.Interfaces;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/usersBtob")]
    public class UsersBtobController : BaseController, IUsersBtobController
    {
        private readonly IServiceUsersBtob _serviceUsersBtob;
        public UsersBtobController(IServiceProvider serviceProvider, IServiceUsersBtob serviceUsersBtob, ILogger<UsersBtobController> logger)
         : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceUsersBtob = serviceUsersBtob;
        }
        [HttpPost("SynchronizeUserBtoB")]
        public SynchronizeUsersBtobResponseViewModel SynchronizeUserBtoB([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            ListOfUsersFromBToBViewModel responseSynchronizedUsers = JsonConvert.DeserializeObject<ListOfUsersFromBToBViewModel>(stringData);
            {
                return _serviceUsersBtob.SynchronizeUserBtoB(responseSynchronizedUsers.Users);
            }
        }

        /// <summary>
        /// B2B synchronize Update User BtoB
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("UpdateUserBtoB")]
        public ResponseData UpdateUserBtoB([FromBody] dynamic response)
        {
            ResponseData result = new ResponseData();
            string stringData = response.ToString();
            ListOfUsersFromBToBViewModel responseSynchronizedUsers = JsonConvert.DeserializeObject<ListOfUsersFromBToBViewModel>(stringData);
            _serviceUsersBtob.UpdateUserBtoB(responseSynchronizedUsers.Users);
            {
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }



    }
}
