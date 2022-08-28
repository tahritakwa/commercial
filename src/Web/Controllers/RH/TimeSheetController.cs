using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/timeSheet")]
    public class TimeSheetController : BaseController
    {
        private readonly IServiceTimeSheet _serviceTimeSheet;
        private readonly IServiceEmployee _serviceEmployee;
        private readonly SmtpSettings _smtpSettings;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceTimeSheet"></param>
        public TimeSheetController(IServiceProvider serviceProvider, ILogger<TimeSheetController> logger, IServiceTimeSheet serviceTimeSheet,
             IOptions<SmtpSettings> smtpSettings, IServiceEmployee serviceEmployee)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTimeSheet = serviceTimeSheet;
            _serviceEmployee = serviceEmployee;
            _smtpSettings = smtpSettings.Value;
        }

        /// <summary>
        /// Retrieve the employee's timeSheet as a parameter for the current month. If the employee has already returned one
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        [HttpPost("getEmployeeTimeSheet"), Authorize("LIST_TIMESHEET,ADD_TIMESHEET,SHOW_TIMESHEET")]
        public TimeSheetViewModel GetEmployeeTimeSheet([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave.model.IdEmployee == null || objectToSave.model.Month == null)
            {
                throw new ArgumentException("");
            }
            return _serviceTimeSheet.GetEmployeeTimeSheet((int)objectToSave.model.IdEmployee,
                objectToSave.model.Month.Value);
        }

        /// <summary>
        /// Returns the list of Timesheets of the year in parameter for the employee in parameter
        /// if the employee does not have a Timesheet for certain months, fictitious Timesheets are generated
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        [HttpPost("getYearTimeSheet"), Authorize("TIMESHEET_MY_TIMESHEET")]
        public IList<TimeSheetViewModel> GetYearTimeSheet([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave.model.IdEmployee == null || objectToSave.model.Year == null)
            {
                throw new ArgumentException("");
            }
            return _serviceTimeSheet.GetYearTimeSheet((int)objectToSave.model.IdEmployee, objectToSave.model.Year.Value);
        }

        [HttpPost("validate")]
        public ResponseData ValidateTimeSheet([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                TimeSheetViewModel timeSheetViewModel = JsonConvert.DeserializeObject<TimeSheetViewModel>(objectToSave.model.ToString());
                GetUserMail();
                bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName(RHConstant.VALIDATE_TIMESHEET, Request.HttpContext) ||
                    _serviceEmployee.CheckUserIsTeamManagerOrUpperHierrarchy(timeSheetViewModel.IdEmployee, userMail);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                ResponseData result = new ResponseData
                {
                    objectData = _serviceTimeSheet.ValidateTimeSheet(timeSheetViewModel, userMail),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }
        }


        [HttpGet("definitiveValidate/{employeeId}/{idTimeSheet}")]
        public ResponseData DefinitiveValidateTimeSheet(int employeeId, int idTimeSheet)
        {
            if (idTimeSheet == NumberConstant.Zero || employeeId == NumberConstant.Zero)
            {
                throw new ArgumentException("");
            }
            else
            {
                GetUserMail();
                ResponseData result = new ResponseData
                {
                    objectData = _serviceTimeSheet.DefinitiveValidateTimeSheet(idTimeSheet, userMail),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }
        }
        [HttpPost("sendMail"), Authorize("SEND_REMINDER_EMAIL_TIMESHEET")]
        public ResponseData SendMail([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            if (objectToSave.model.idEmployee == null || objectToSave.model.startDate == null)
            {
                throw new ArgumentException("");
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceTimeSheet.SendEmail((int)objectToSave.model.idEmployee, objectToSave.model.startDate.Value, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }


        [HttpPost("timeValueChange"), Authorize("LIST_TIMESHEET,ADD_TIMESHEET,UPDATE_TIMESHEET")]
        public ResponseData TimeValueChange([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave.model.date == null || objectToSave.model.StartTime == null || objectToSave.model.EndTime == null)
            {
                throw new ArgumentException("");
            }
            ResponseData result = new ResponseData
            {
                objectData = _serviceTimeSheet.TimeValueChange(objectToSave.model.date.Value, (TimeSpan)objectToSave.model.StartTime,
                (TimeSpan)objectToSave.model.EndTime)
            };
            return result;
        }

        [HttpGet("timeSheetFixRequest/{idTimeSheet}")]
        public ResponseData TimeSheetFixRequest(int idTimeSheet)
        {
            if (idTimeSheet != NumberConstant.Zero)
            {
                GetUserMail();
                _serviceTimeSheet.TimeSheetFixRequest(idTimeSheet, userMail);
            }
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };
        }



        [HttpPost("getEmployeeTimeSheetRequests"), Authorize("LIST_TIMESHEET")]
        public ResponseData GetEmployeeTimeSheetRequests([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            GetUserMail();
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTimeSheet.GetEmployeeTimeSheetRequests(userMail, predicateFormatViewModel, objectToSave.model.isAdmin.Value),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }


        [HttpPost("getAvailableEmployeeByTimeSheet"), Authorize("LIST_TIMESHEET")]
        public ResponseData Post([FromBody] DateTime endDate)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var employeeViewModels = _serviceTimeSheet.GetAvailableEmployeeByTimeSheet(endDate);
                result.listObject = new ListObject
                {
                    listData = employeeViewModels,
                    total = employeeViewModels.Count
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        /// <summary>
        /// GetTimesheetFromListId
        /// </summary>
        /// <param name="listIdTimesheets"></param>
        /// <returns></returns>
        [HttpPost("getTimesheetFromListId")]
        public List<TimeSheetViewModel> GetTimesheetFromListId([FromBody] List<int> listIdTimesheets)
        {
            return _serviceTimeSheet.GetTimesheetFromListId(listIdTimesheets);
        }
        /// <summary>
        /// validateMassiveTimesheets
        /// </summary>
        /// <param name="listOfTimesheets"></param>
        /// <returns></returns>
        [HttpPost("validateMassiveTimesheets"), Authorize("MASSIVE_VALIDATE_TIMESHEET")]
        public ResponseData ValidateMassiveTimesheets([FromBody] List<TimeSheetViewModel> listOfTimesheets)
        {
            GetUserMail();
            _serviceTimeSheet.ValidateMassiveTimesheets(listOfTimesheets, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// timeSheetMassiveFixRequest
        /// </summary>
        /// <param name="listOfTimesheets"></param>
        /// <returns></returns>
        [HttpPost("timeSheetMassiveFixRequest"), Authorize("MASSIVE_FIX_TIMESHEET")]
        public ResponseData TimeSheetMassiveFixRequest([FromBody] List<int> listOfTimesheets)
        {
            GetUserMail();
            if (listOfTimesheets != null)
            {
                _serviceTimeSheet.MassiveTimeSheetFixRequest(listOfTimesheets, userMail);
            }
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };

        }

        [HttpPost("insert"), Authorize("ADD_TIMESHEET")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("UPDATE_TIMESHEET")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);

        }

        [HttpGet("getById/{id}"), Authorize("SHOW_TIMESHEET")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
    }

}
