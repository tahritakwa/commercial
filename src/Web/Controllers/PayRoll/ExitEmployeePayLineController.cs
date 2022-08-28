using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/exitEmployeePayLine")]
    public class ExitEmployeePayLineController : BaseController
    {
        private readonly IServiceExitEmployeePayLine _serviceExitEmployeePayLine;

        public ExitEmployeePayLineController(IServiceProvider serviceProvider,
        ILogger<ExitEmployeePayLineController> logger,
        IServiceExitEmployeePayLine serviceExitEmployeePayLine
       )
        : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceExitEmployeePayLine = serviceExitEmployeePayLine;
        }

        [HttpGet, Route("generatePayBalanceForExitEmployee/{idExitEmployee}"), Authorize("LIST_EXITEMPLOYEEPAYLINE")]
        public ResponseData GeneratePayBalanceForExitEmployee(int idExitEmployee)
        {
            _serviceExitEmployeePayLine.GeneratePayBalanceForExitEmployee(idExitEmployee);
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get list of Pay for exit employee
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        [HttpPost, Route("GetListOfPayForExitEmployee"), Authorize("LIST_EXITEMPLOYEEPAYLINE,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData GetListOfPayForExitEmployee([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idEmployeeExit = objectToSave.model.idEmployeeExit;
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
                objectData = _serviceExitEmployeePayLine.GetListOfPayForExitEmployee(predicate, idEmployeeExit),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
    }


}
