using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/attendance")]
    public class AttendanceController : BaseController
    {
        private readonly IServiceAttendance _serviceAttendance;
        public AttendanceController(IServiceProvider serviceProvider, ILogger<AttendanceController> logger, IServiceAttendance serviceAttendance)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceAttendance = serviceAttendance;
        }
        [HttpPost("updateAttendance")]
        public ResponseData UpdateAttendance([FromBody] ObjectToSaveViewModel objectToSave)
        {
            AttendanceViewModel attendanceViewModel = JsonConvert.DeserializeObject<AttendanceViewModel>(objectToSave.model.attendance.ToString());
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceAttendance.UpdateModelWithoutTransaction(attendanceViewModel, null, null, null)
            };
            return responseData;
        }
        [HttpGet("getById/{id}"), Authorize("UPDATE_ATTENDANCE")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
