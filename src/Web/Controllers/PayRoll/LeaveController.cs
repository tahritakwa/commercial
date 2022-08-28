using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
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
    [Route("api/leave")]
    public class LeaveController : BaseController
    {
        private readonly IServiceLeave _serviceLeave;

        private readonly SmtpSettings _smtpSettings;
        public LeaveController(IServiceProvider serviceProvider,
            ILogger<LeaveController> logger,
            IOptions<SmtpSettings> smtpSettings,
            IServiceLeave serviceLeave)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceLeave = serviceLeave;
            _smtpSettings = smtpSettings.Value;
        }


        /// <summary>
        /// Calculate total number remaining of leave each employee
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <returns></returns>
        [HttpPost("calculateLeaveBalance"), Authorize("LIST_LEAVE,ADD_LEAVE,SHOW_LEAVE")]
        public ResponseData CalculateLeaveBalance([FromBody] LeaveViewModel leaveViewModel)
        {
            _serviceLeave.CalculateNumberOfDaysAndHourOfLeaveBalance(leaveViewModel);
            ResponseData result = new ResponseData()
            {
                flag = NumberConstant.One,
                objectData = leaveViewModel,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getEmployeeLeaveRequests"), Authorize("LIST_LEAVE,ADD_LEAVE")]
        public ResponseData GetEmployeeLeaveRequests([FromBody] ObjectToSaveViewModel objectToSave)
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
                objectData = _serviceLeave.GetEmployeeLeaveRequests(userMail, predicateFormatViewModel, month, objectToSave.model.onlyFirstLevelOfHierarchy != null && objectToSave.model.onlyFirstLevelOfHierarchy.Value,
                objectToSave.model.isAdmin.Value),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_LEAVE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceLeave.GetEmployeeConnectedLeave(model, userMail);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getModelByCondition"), Authorize("LIST_LEAVE")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData result = new ResponseData
            {
                objectData = _service.GetModelWithRelations(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            LeaveViewModel leaveViewModel = result.objectData;
            leaveViewModel.LeaveFileInfo = _service.GetFilesContent(leaveViewModel.LeaveAttachementFile);
            result.objectData = leaveViewModel;

            return result;
        }

        /// <summary>
        /// GetStartTimeOfPeriod
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        [HttpPost("getStartTimeOfPeriod"), Authorize("LIST_LEAVE")]
        public ResponseData GetStartTimeOfPeriod([FromBody] DateTime date)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceLeave.GetStartTimeOfPeriod(date),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }


        /// <summary>E:\1-Stark-Back\erp-commercial-rh\01-Web\SparkIt.Web\Controllers\PayRoll\DocumentRequestController.cs
        /// GetEndTimeOfPeriod
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        [HttpPost("getEndTimeOfPeriod"), Authorize("LIST_LEAVE")]
        public ResponseData GetEndTimeOfPeriod([FromBody] DateTime date)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceLeave.GetEndTimeOfPeriod(date),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getHoursPeriodOfDate"), Authorize("LIST_LEAVE,ADD_LEAVE,SHOW_LEAVE")]
        public ResponseData GetHoursPeriodOfDate([FromBody] DateTime date)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceLeave.GetHoursPeriodOfDate(date),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("verifyPeriodOfDate"), Authorize("LIST_LEAVE")]
        public ResponseData VerifyPeriodOfDate([FromBody] DateTime date)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceLeave.VerifyPeriodOfDate(date),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getTwoLeavesDecomposedFromNegativeBalanceLeave"), Authorize("ADD_LEAVE")]
        public ResponseData GetTwoLeavesDecomposedFromNegativeBalanceLeave([FromBody] LeaveViewModel leaveViewModel)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceLeave.GetTwoLeavesDecomposedFromNegativeBalanceLeave(leaveViewModel),
                flag = 1
            };
            return result;
        }
        [HttpPost("prepareAndSendEmail"), Authorize("UPDATE_LEAVE")]
        public void PrepareAndSendEmail([FromBody] ObjectToSaveViewModel data)
        {
            MailBrodcastConfigurationViewModel configModel = JsonConvert.DeserializeObject<MailBrodcastConfigurationViewModel>(data.model.mailConfiguration.ToString());
            LeaveViewModel oldLeave = new LeaveViewModel();
            // old leave is the entity after doing the action : ( after deleting or updating ) 
            if (data.model.objectBeforeAction != null)
            {
                oldLeave = JsonConvert.DeserializeObject<LeaveViewModel>(data.model.objectBeforeAction.ToString());
            }
            string action = data.model.action.ToString();
            GetUserMail();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            _service.PrepareAndSendMail(configModel, userMail, action, oldLeave, _smtpSettings);
        }

        [HttpPost("getLeaveFromListId")]
        public List<LeaveViewModel> GetLeaveFromListId([FromBody] List<int> listIdLeaves)
        {
            return _serviceLeave.GetLeaveFromListId(listIdLeaves);
        }
        [HttpPost("validateMassiveLeaves"), Authorize("VALIDATEALL_LEAVE")]
        public ResponseData ValidateMassiveLeaves([FromBody] List<LeaveViewModel> listOfLeaves)
        {
            GetUserMail();
            _serviceLeave.ValidateMassiveLeaves(listOfLeaves, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// deleteMassiveLeave
        /// </summary>
        /// <param name="listIdLeaves"></param>
        /// <returns></returns>
        [HttpPost("deleteMassiveLeave"), Authorize("DELETEALL_LEAVE")]
        public ResponseData DeleteMassiveLeave([FromBody] List<int> listIdLeaves)
        {
            GetUserMail();
            _serviceLeave.DeleteMassiveLeave(listIdLeaves, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// refuseMassiveLeave
        /// </summary>
        /// <param name="listIdLeaves"></param>
        /// <returns></returns>
        [HttpPost("refuseMassiveLeave"), Authorize("REFUSEALL_LEAVE")]
        public ResponseData RefuseMassiveLeave([FromBody] List<int> listIdLeaves)
        {
            GetUserMail();
            _serviceLeave.RefuseMassiveLeave(listIdLeaves, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }

        /// <summary>
        /// Add multiple leaves
        /// </summary>
        /// <param name="listOfLeaves"></param>
        /// <returns></returns>
        [HttpPost("addMassiveLeaves"), Authorize("ADD_LEAVE")]
        public ResponseData AddMassiveLeaves([FromBody] List<LeaveViewModel> listOfLeaves)
        {
            _serviceLeave.AddMassiveLeaves(listOfLeaves);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }

        /// <summary>
        /// validate leave request
        /// </summary>
        /// <param name="leave"></param>
        /// <returns></returns>
        [HttpPost("validateLeaveRequest")]
        public ResponseData ValidateLeaveRequest([FromBody] LeaveViewModel leave)
        {
            _serviceLeave.ValidateLeaveRequest(leave);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        [HttpDelete("delete/{id}"), AllowAnonymous]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
        /// <summary>
        /// send leave balance remaining email to all employess
        /// </summary>
        /// <param name="leaveBalanceRemainingFilter"></param>
        /// <returns></returns>
        [HttpPost("sendMail"), Authorize("SEND_LEAVE_REMAINING_BALANCE")]
        public ResponseData SendLeaveBalanceRemainingEmails([FromBody] LeaveBalanceRemainingFilter leaveBalanceRemainingFilter)
        {
            GetUserMail();
            _serviceLeave.MassiveSendLeaveBalanceRemainingEmails(leaveBalanceRemainingFilter, userMail);
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
            };
            return result;
        }

        [HttpPut("update"), AllowAnonymous]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
