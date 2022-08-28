using Microsoft.AspNetCore.Authorization;
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
using ViewModels.DTO.Reporting.Payroll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/sourceDeduction")]
    public class SourceDeductionController : BaseController
    {
        private readonly IServiceSourceDeduction _serviceSourceDeduction;
        private readonly IServiceJasperReporting _serviceJasperReporting;
        private readonly SmtpSettings _smtpSettings;

        public SourceDeductionController(IServiceProvider serviceProvider,
            IServiceJasperReporting serviceJasperReporting,
            IOptions<SmtpSettings> smtpSettings,
            ILogger<SourceDeductionController> logger,
            IServiceSourceDeduction serviceSourceDeduction)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSourceDeduction = serviceSourceDeduction;
            _serviceJasperReporting = serviceJasperReporting;
            _smtpSettings = smtpSettings.Value;
        }

        /// <summary>
        /// Generate source deduction for a specific session
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        /// <returns></returns>
        [HttpGet("generateSourceDeduction/{id}/{max}"), Authorize("GENERATE_SOURCEDEDUCTION,REGENERATE_SOURCEDEDUCTION")]
        public ResponseData GenerateSourceDeduction(int id, int max)
        {
            GetUserMail();
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceSourceDeduction.GenerateSourceDeduction(id, max, userMail),
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
        [HttpGet("checkAllSourceDeductionIsCorrect/{idSession}"), Authorize("PRINT_SOURCEDEDUCTION,BROADCAST_SOURCEDEDUCTION")]
        public bool CheckAllSourceDeductionIsCorrect(int idSession)
        {
            return idSession != NumberConstant.Zero && _serviceSourceDeduction.FindByAsNoTracking(x => x.IdSourceDeductionSession.Equals(idSession) &&
                (x.Status.Equals((int)PayslipStatus.Wrong) ||
                x.Status.Equals((int)PayslipStatus.NotCalculated))).Any();
        }

        /// <summary>
        /// Download All session's source deduction
        /// </summary>
        /// <param name="idSession">id session</param>
        /// <returns></returns>
        [HttpGet("downloadAllSourceDeduction/{idSession}"), Authorize("PRINT_SOURCEDEDUCTION")]
        public async Task<ResponseData> DownloadAllSourceDeduction(int idSession)
        {
            ResponseData responseData = new ResponseData();
            GetUserMail();
            if (idSession != 0)
            {
                GetUserMail();
                DownloadReportDataViewModel reportSetting = _serviceSourceDeduction.GetAllSourceDeductionReportSettings(idSession, userMail, out IList<SourceDeduction> payslips);
                responseData.objectData = await _serviceJasperReporting.MassiveDownLoad(reportSetting, userMail);
            }
            return responseData;
        }

        /// <summary>
        /// Get source deduction informations for the report
        /// </summary>
        /// <param name="idSourceDeduction"></param>
        /// <returns></returns>
        [HttpGet("getSourceDeductionReportInformations/{idSourceDeduction}")]
        public SourceDeductionReportInformationsViewModel GetSourceDeductionReportInformations(int idSourceDeduction)
        {
            return _serviceSourceDeduction.GetSourceDeductionInformations(idSourceDeduction);
        }

        /// <summary>
        /// Get employer declaration for the specific month
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        [HttpGet("getEmployerDeclaration/{year}")]
        public EmployerDeclarationViewModel GetEmployerDeclarationViewModel(int year)
        {
            return _serviceSourceDeduction.GetEmployerDeclarationHeader(year);
        }

        /// <summary>
        /// Get employer declaration for the specific month
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        [HttpPost("getEmployerDeclaration")]
        public ResponseData GetEmployerDeclarationBody([FromBody] PredicateFormatViewModel predicateFormatViewModel)
        {
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceSourceDeduction.GetEmployerDeclarationBody(predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return responseData;
        }

        /// <summary>
        /// Distribution of payslips from the pay session to consecrated employees
        /// </summary>
        /// <param name="id">id session</param>
        /// <returns></returns>
        [HttpPost("broadcastSourceDeduction"), Authorize("BROADCAST_SOURCEDEDUCTION")]
        public async Task<ResponseData> BrodcastPayslip([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int id = objectToSave.model.idSourceDeduction != null ? System.Convert.ToInt32(objectToSave.model.idSourceDeduction.Value) : 0;
            string url = objectToSave.model.url != null ? objectToSave.model.url.Value : "";
            ResponseData responseData = new ResponseData();
            if (id != NumberConstant.Zero)
            {
                GetUserMail();
                IList<SourceDeduction> sourceDeductions;
                DownloadReportDataViewModel downloadReportDataViewModel = _serviceSourceDeduction.GetAllSourceDeductionReportSettings(id, userMail, out sourceDeductions);
                GetUserMail();
                responseData.objectData = await _serviceJasperReporting.GetSourceDeductionReports(downloadReportDataViewModel, sourceDeductions, userMail);
                // Save the files Encrypted
                _serviceSourceDeduction.BrodcastSourceDeduction(userMail, id, url, responseData.objectData, _smtpSettings);
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

        [HttpPost("broadcastOneSourceDeduction"), Authorize("BROADCAST_SOURCEDEDUCTION")]
        public async Task<ResponseData> BrodcastOneSourceDeduction([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int id = objectToSave.model.idSourceDeduction != null ? System.Convert.ToInt32(objectToSave.model.idSourceDeduction.Value) : 0;
            string url = objectToSave.model.url != null ? objectToSave.model.url.Value : "";
            SourceDeduction sourceDeduction = JsonConvert.DeserializeObject<SourceDeduction>(objectToSave.model.sourceDeduction.ToString());
            List<SourceDeduction> sourceDeductions = new List<SourceDeduction>();
            sourceDeductions.Add(sourceDeduction);
            ResponseData responseData = new ResponseData();
            if (sourceDeduction != null)
            {
                GetUserMail();
                DownloadReportDataViewModel downloadReportDataViewModel = _serviceSourceDeduction.GetSourceDeductionReportSettings(sourceDeduction);
                responseData.objectData = await _serviceJasperReporting.GetSourceDeductionReports(downloadReportDataViewModel, sourceDeductions, userMail);
                // Save the file Encrypted
                _serviceSourceDeduction.BrodcastOneSourceDeduction(userMail, id, url, responseData.objectData, sourceDeduction, _smtpSettings);
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

        [HttpPost("getDataSourcePredicate"), Authorize("ADD_SOURCEDEDUCTIONSESSION,SHOW_SOURCEDEDUCTIONSESSION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("regenerateOneSourceDeduction"), Authorize("REGENERATE_SOURCEDEDUCTION")]
        public ResponseData RegenerateOneSourceDeduction([FromBody] SourceDeductionViewModel model)
        {
            GetUserMail();
            _serviceSourceDeduction.UpdateModel(model, null, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_SOURCEDEDUCTION")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }
    }
}
