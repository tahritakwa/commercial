using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Services.Reporting.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/payslip")]
    public class PaySlipController : BaseController
    {
        private const string jsonHeaderType = "application/json";
        private const string reportApi = "api/customReports/downloadPayslip";
        private const string getAllReportApi = "api/customReports/getAllPayslip";
        private const string allReportApi = "api/customReports/downloadAllPayslip";
        private const string connectionString = "connectionString";
        private const string Payslip = "BS";

        private readonly AppSettings _appSettings;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServicePayslip _servicePayslip;
        private readonly IServiceContract _serviceContract;
        private readonly IServiceJasperReporting _serviceJasperReporting;



        public PaySlipController(IServiceProvider serviceProvider, ILogger<PaySlipController> logger, IOptions<AppSettings> appSettings,
             IOptions<SmtpSettings> smtpSettings, IServicePayslip servicePayslip, IServiceContract serviceContract, IServiceJasperReporting serviceJasperReporting)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _servicePayslip = servicePayslip;
            _serviceContract = serviceContract;
            if (appSettings != null)
                _appSettings = appSettings.Value;
            _smtpSettings = smtpSettings.Value;
            _serviceJasperReporting = serviceJasperReporting;
        }

        /// <summary>
        /// Distribution of payslips from the pay session to consecrated employees
        /// </summary>
        /// <param name="id">id session</param>
        /// <returns></returns>
        [HttpPost("broadcastPayslip"), Authorize("PRINT_PAYSLIP")]
        public async Task<ResponseData> BrodcastPayslip([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int id = objectToSave.model.idSession != null ? System.Convert.ToInt32(objectToSave.model.idSession.Value) : 0;
            string url = objectToSave.model.url != null ? objectToSave.model.url.Value : "";
            ResponseData responseData = new ResponseData();
            if (id != NumberConstant.Zero)
            {
                GetUserMail();
                IList<Payslip> payslips;
                DownloadReportDataViewModel downloadReportDataViewModel = _servicePayslip.GetAllPayslipReportSettings(id, userMail, out payslips);
                GetUserMail();
                responseData.objectData = await _serviceJasperReporting.GetPayslipReports(downloadReportDataViewModel, payslips, userMail);
                // Save the files Encrypted
                _servicePayslip.BrodcastPayslip(userMail, id, url, responseData.objectData, _smtpSettings);
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetByIdSuccessfull
                };
                return result;
            }
            else
            {
                throw new ArgumentException("");
            }
        }

        [HttpPost("brodcastOnePayslip"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> BrodcastOnePayslip([FromBody] ObjectToSaveViewModel objectToSave)
        {
            string url = objectToSave.model.url != null ? objectToSave.model.url.Value : "";
            Payslip payslip = JsonConvert.DeserializeObject<Payslip>(objectToSave.model.payslip.ToString());
            List<Payslip> payslips = new List<Payslip>();
            payslips.Add(payslip);
            ResponseData responseData = new ResponseData();
            if (payslip != null)
            {
                GetUserMail();
                DownloadReportDataViewModel downloadReportDataViewModel = _servicePayslip.GetPayslipReportSettings(payslip);
                responseData.objectData = await _serviceJasperReporting.GetPayslipReports(downloadReportDataViewModel, payslips, userMail);
                // Save the file Encrypted
                _servicePayslip.BrodcastOnePayslip(userMail, url, responseData.objectData, payslip, _smtpSettings);
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetByIdSuccessfull
                };
                return result;
            }
            else
            {
                throw new ArgumentException("");
            }
        }

        /// <summary>
        /// Download All session's payslip
        /// </summary>
        /// <param name="idSession">id session</param>
        /// <returns></returns>
        [HttpGet("downloadAllPayslip/{idSession}"), Authorize("PRINT_PAYSLIP")]
        public async Task<ResponseData> DownloadAllPayslip(int idSession)
        {
            ResponseData responseData = new ResponseData();
            if (idSession != 0)
            {
                GetUserMail();
                DownloadReportDataViewModel reportSetting = _servicePayslip.GetAllPayslipReportSettings(idSession, userMail, out IList<Payslip> payslips);
                responseData.objectData = await _serviceJasperReporting.MassiveDownLoad(reportSetting, userMail);
            }
            return responseData;
        }

        [HttpPost("getPayslipPreviewInformations"), Authorize("PAYSLIP_PREVIEW_EMPLOYEE")]
        public PayslipReportInformationsViewModel GetPayslipPreviewInformation([FromBody] PayslipViewModel payslipViewModel)
        {
            if (payslipViewModel == null)
            {
                throw new ArgumentException("");
            }
            PayslipReportInformationsViewModel report = _servicePayslip.GetPayslipPreviewInformation(payslipViewModel);
            return report;
        }

        /// <summary>
        /// Generate session payslip
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        /// <returns></returns>
        [HttpGet("generateSessionPayslip/{id}/{max}"), Authorize("GENERATE_PAYSLIP")]
        public ResponseData GeneratePayslip(int id, int max)
        {
            GetUserMail();
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _servicePayslip.GeneratePayslip(id, max, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return responseData;
        }

        /// <summary>
        /// Specific api for check if all session payslips are correct or not
        /// </summary>
        /// <param name="property"></param>
        /// <param name="value"></param>
        /// <param name="valueBeforUpdate"></param>
        /// <returns></returns>
        [HttpGet("checkAllPayslipIsCorrect/{idSession}"), Authorize("SHOW_PAYROLL_SESSION")]
        public bool CheckAllPayslipIsCorrect(int idSession)
        {
            return idSession != NumberConstant.Zero && _servicePayslip.FindByAsNoTracking(x => x.IdSession.Equals(idSession) &&
                (x.Status.Equals((int)PayslipStatus.Wrong) ||
                x.Status.Equals((int)PayslipStatus.NotCalculated))).Any();
        }

        /// <summary>
        /// Get payslip of selected employee
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("getPayslipHistory"), Authorize("LIST_PAYSLIPHISTORY")]
        public ResponseData GetPayslipHistory([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            if (objectToSave.model.predicate != null)
            {
                predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            DateTime startDate = objectToSave.model.StartDate.Value;
            DateTime endDate = objectToSave.model.EndDate.Value;
            ResponseData responseData = new ResponseData
            {
                flag = NumberConstant.One,
                objectData = _servicePayslip.GetPayslipHistory(predicate, startDate, endDate),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return responseData;
        }


        /// <summary>
        /// Download all payslips of selected employee
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("downloadAllPayslipOfSelectedEmployee"), Authorize("PRINT_PAYSLIP")]
        public async Task<ResponseData> DownloadAllPayslipOfSelectedEmployee([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            if (objectToSave.model.predicate != null)
            {
                predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            DateTime startDate = objectToSave.model.StartDate.Value;
            DateTime endDate = objectToSave.model.EndDate.Value;
            DownloadReportDataViewModel downloadReportDataViewModel = _servicePayslip.GetAllPayslipOfSelectedEmployeeReportSettings(predicate, startDate, endDate);
            ResponseData responseData = new ResponseData
            {
                objectData = await _serviceJasperReporting.MassiveDownLoad(downloadReportDataViewModel, userMail)
            };
            return responseData;
        }

        /// <summary>
        /// Check if there are source deductions to delete
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        [HttpGet("checkIfThereAreSourceDeductionsToDelete/{idSession}"), Authorize("DELETE_SESSION")]
        public bool CheckIfThereAreSourceDeductionsToDelete(int idSession)
        {
            return _servicePayslip.CheckIfThereAreSourceDeductionsToDelete(idSession);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("SHOW_PAYROLL_SESSION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPut("update"), Authorize("GENERATE_PAYSLIP")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
