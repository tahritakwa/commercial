using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/expenseReport")]
    public class ExpenseReportController : BaseController
    {
        private readonly IServiceExpenseReport _serviceExpenseReport;
        private readonly SmtpSettings _smtpSettings;

        public ExpenseReportController(IServiceProvider serviceProvider, ILogger<ExpenseReportController> logger,
            IOptions<SmtpSettings> smtpSettings,
            IServiceExpenseReport serviceExpenseReport)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceExpenseReport = serviceExpenseReport;
            _smtpSettings = smtpSettings.Value;
        }

        [HttpPost("insertExpenseReport"), Authorize("ADD_EXPENSEREPORT")]
        public ResponseData InsertPriceWithoutFiles([FromBody] ObjectToSaveViewModel objectToSave)
        {

            ExpenseReportViewModel expenseReportViewModel = JsonConvert.DeserializeObject<ExpenseReportViewModel>(objectToSave.model.ToString());
            GetUserMail();
            var objectData = _serviceExpenseReport.AddModel(expenseReportViewModel, objectToSave.EntityAxisValues, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = objectData,
                flag = 1
            };
            return result;

        }

        [HttpPost("calculateTotalAmount"), Authorize("ADD_EXPENSEREPORT")]
        public double CalculateTotalAmount([FromBody] IList<ExpenseReportDetailsViewModel> expenseReportDetails)
        {
            return _serviceExpenseReport.CalculateTotalAmount(expenseReportDetails);
        }

        [HttpPut("updateExpenseReport"), Authorize("ADD_EXPENSEREPORT")]
        public ResponseData UpdateWithoutFiles([FromBody] ObjectToSaveViewModel objectToSave)
        {

            ExpenseReportViewModel expenseReportViewModel = JsonConvert.DeserializeObject<ExpenseReportViewModel>(objectToSave.model.ToString());
            GetUserMail();
            _serviceExpenseReport.UpdateModel(expenseReportViewModel, objectToSave.EntityAxisValues, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("validate"), Authorize("VALIDATE_EXPENSEREPORT")]
        public ResponseData ValidateExpenseReport([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                GetUserMail();
                ExpenseReportViewModel expenseReportViewModel = JsonConvert.DeserializeObject<ExpenseReportViewModel>(objectToSave.model.ToString());
                ResponseData result = new ResponseData
                {
                    objectData = _serviceExpenseReport.ValidateExpenseReport(expenseReportViewModel, objectToSave.EntityAxisValues, userMail),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }

        }

        [HttpPost("getExpenseReportsRequestsWithHierarchy"), Authorize("LIST_EXPENSEREPORT")]
        public ResponseData GetExpenseReportsRequestsWithHierarchy([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            DateTime? month = null;
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            if (objectToSave.model.month != null)
            {
                month = (DateTime)objectToSave.model.month.Value;
            }
            GetUserMail();
            ResponseData result = new ResponseData()
            {
                flag = NumberConstant.One,
                objectData = _serviceExpenseReport.GetExpenseReportsRequestsWithHierarchy(userMail, predicateFormatViewModel, month,
                              objectToSave.model.onlyFirstLevelOfHierarchy != null && objectToSave.model.onlyFirstLevelOfHierarchy.Value),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("prepareAndSendEmail"), Authorize("UPDATE_EXPENSEREPORT")]
        public void PrepareAndSendEmail([FromBody] ObjectToSaveViewModel data)
        {
            MailBrodcastConfigurationViewModel configModel = JsonConvert.DeserializeObject<MailBrodcastConfigurationViewModel>(data.model.mailConfiguration.ToString());
            ExpenseReportViewModel oldLeave = new ExpenseReportViewModel();
            // old expense report is the entity after doing the action : ( after deleting or updating ) 
            if (data.model.objectBeforeAction != null)
            {
                oldLeave = JsonConvert.DeserializeObject<ExpenseReportViewModel>(data.model.objectBeforeAction.ToString());
            }
            string action = data.model.action.ToString();
            GetUserMail();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            _service.PrepareAndSendMail(configModel, userMail, action, oldLeave, _smtpSettings);
        }
        /// <summary>
        /// GetExpenseFromListId
        /// </summary>
        /// <param name="listIdExpenses"></param>
        /// <returns></returns>
        [HttpPost("getExpenseFromListId")]
        public List<ExpenseReportViewModel> GetExpenseFromListId([FromBody] List<int> listIdExpenses)
        {
            return _serviceExpenseReport.GetExpenseFromListId(listIdExpenses);
        }
        /// <summary>
        /// ValidateMassiveExpenses
        /// </summary>
        /// <param name="listOfExpenses"></param>
        /// <returns></returns>
        [HttpPost("validateMassiveExpenses"), Authorize("UPDATE_EXPENSEREPORT")]
        public ResponseData ValidateMassiveExpenses([FromBody] List<ExpenseReportViewModel> listOfExpenses)
        {
            GetUserMail();
            _serviceExpenseReport.ValidateMassiveExpenses(listOfExpenses, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// deleteMassiveexpenseReport
        /// </summary>
        /// <param name="listIdExpenses"></param>
        /// <returns></returns>
        [HttpPost("deleteMassiveexpenseReport"), Authorize("UPDATE_EXPENSEREPORT")]
        public ResponseData DeleteMassiveexpenseReport([FromBody] List<int> listIdExpenses)
        {
            GetUserMail();
            _serviceExpenseReport.DeleteMassiveexpenseReport(listIdExpenses, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// refuseMassiveexpenseReport
        /// </summary>
        /// <param name="listIdExpenses"></param>
        /// <returns></returns>
        [HttpPost("refuseMassiveexpenseReport"), Authorize("UPDATE_EXPENSEREPORT")]
        public ResponseData RefuseMassiveexpenseReport([FromBody] List<int> listIdExpenses)
        {
            GetUserMail();
            _serviceExpenseReport.RefuseMassiveexpenseReport(listIdExpenses, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }

        [HttpPost("downloadExpenseReportDocumentsWar")]
        public ResponseData DownloadExpenseReportDocumentsWar([FromBody] int idExpenseReport)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceExpenseReport.DownloadExpenseReportDocumentsWar(idExpenseReport),
                flag = NumberConstant.One
            };
            return result;
        }

        [HttpDelete("delete/{id}"), Authorize("DELETE_EXPENSEREPORT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
