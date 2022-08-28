using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/session")]
    public class SessionController : BaseController
    {
        private readonly IServiceSession _serviceSession;

        public SessionController(IServiceProvider serviceProvider, ILogger<SessionController> logger, IServiceSession serviceSession)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSession = serviceSession;
        }

        [HttpGet("getSessionDetails/{id}"), Authorize("LIST_SESSION")]
        public ResponseData GetSessionDetails(int id)
        {
            ResponseData result = new ResponseData();
            if (id > 0)
            {
                result.flag = 1;
                result.objectData = _serviceSession.GetSessionDetails(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        /// <summary>
        /// Specific api for check if the session number is unique per month or not
        /// </summary>
        /// <param name="property"></param>
        /// <param name="value"></param>
        /// <param name="valueBeforUpdate"></param>
        /// <returns></returns>
        [HttpGet("getSessionBonusOrderedByBonusId/{id}"), Authorize("LIST_SESSION")]
        public dynamic GetSessionBonusByIdBonus(int id)
        {
            if (id > 0)
            {
                return _serviceSession.GetSessionBonusByIdBonus(id);
            }
            else
            {
                throw new ArgumentException("");
            }
        }

        /// <summary>
        /// Get session resume columns
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        [HttpGet("getAvailableSalaryRulesForResume/{idSession}"), Authorize("SHOW_SESSION")]
        public ResponseData GetAvailableSalaryRulesForResume(int idSession)
        {
            if (idSession == NumberConstant.Zero)
            {
                throw new ArgumentException("");
            }
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceSession.GetAvailableSalaryRulesForResume(idSession),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return responseData;
        }

        [HttpPost("getSessionResume"), Authorize("SHOW_SESSION")]
        public ResponseData GetSessionResume([FromBody] SessionResumeFilter sessionResumeFilter)
        {
            DataSourceResult<EmployeeResumeLine> resumeLines = _serviceSession.GetSessionResume(sessionResumeFilter);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = resumeLines,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get session per trimester
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        [HttpPost("getSessionOfTrimester"), Authorize("LIST_SESSION,ADD_CNSSDECLARATION,SHOW_CNSSDECLARATION")]
        public IList<SessionViewModel> SessionOfTrimester([FromBody] ObjectToSaveViewModel objectToSave)
        {
            DateTime dateTime = objectToSave.model.date;
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            return _serviceSession.SessionOfTrimester(predicate, dateTime);
        }

        [HttpPost("sessionsWithEmployeesWithTransferPaymentType"), Authorize("ADD_TRANSFERORDER,SHOW_TRANSFER_ORDER")]
        public IList<SessionViewModel> SessionsWithEmployeesWithTransferPaymentType([FromBody] DateTime month)
        {
            return _serviceSession.SessionsWithEmployeesWithTransferPaymentType(month);
        }
        /// <summary>
        /// Get data and list of available employees by contracts
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("getListOfAvailableEmployeesByContracts"), Authorize("SHOW_PAYROLL_SESSION,OPEN_PAYROLL_SESSION")]
        public ReturnedDataSessionViewModel GetListOfAvailableEmployeesByContracts([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            return _serviceSession.GetListOfAvailableEmployeesByContracts(predicate, idSession);
        }
        /// <summary>
        /// api to add a contract to session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addContractToSession"), Authorize("UPDATE_SESSION,OPEN_PAYROLL_SESSION")]
        public ObjectToSaveViewModel AddContractToSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idContract = JsonConvert.DeserializeObject<int>(objectToSave.model.id.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idSelected = JsonConvert.DeserializeObject<int>(objectToSave.model.idSelected.ToString());
            int idTimeSheet = JsonConvert.DeserializeObject<int>(objectToSave.model.idTimeSheet.ToString());
            return _serviceSession.AddContractToSession(idContract, idSession, idSelected, idTimeSheet);
        }
        /// <summary>
        /// api to add all contract to session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addAllContractsToSession"), Authorize("UPDATE_SESSION")]
        public IList<int> AddAllContractToSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            bool allSelected = JsonConvert.DeserializeObject<bool>(objectToSave.model.allSelected.ToString().ToLower());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            return _serviceSession.AddAllContractsToSession(predicate, allSelected, idSession);
        }
        /// <summary>
        /// api to get list of attendances
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("getListOfAttendances"), Authorize("SHOW_PAYROLL_SESSION")]
        public ReturnedDataAttendanceViewModel GetListOfAttendances([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            return _serviceSession.GetListOfAttendances(predicate, idSession);
        }
        /// <summary>
        /// api to get list of bonus session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("getListOfBonusesForSession"), Authorize("SHOW_PAYROLL_SESSION")]
        public ReturnedDataBonusViewModel GetListOfBonusesForSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            return _serviceSession.GetListOfBonusesForSession(predicate, idSession);
        }
        /// <summary>
        /// api to add a bonus to all contracts in session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addBonusToAllContracts"), Authorize("UPDATE_SESSION")]
        public IList<int> AddBonusToAllContracts([FromBody] ObjectToSaveViewModel objectToSave)
        {
            bool allSelected = JsonConvert.DeserializeObject<bool>(objectToSave.model.allSelected.ToString().ToLower());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idBonus.ToString());
            double value = objectToSave.model.value;
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            return _serviceSession.AddBonusToAllContracts(predicate, allSelected, idSession, idBonus, value);
        }
        /// <summary>
        /// api to add bonus to contract
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addBonusToContract"), Authorize("UPDATE_SESSION")]
        public ResponseData AddBonusToContract([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idContract = JsonConvert.DeserializeObject<int>(objectToSave.model.id.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idSelected = JsonConvert.DeserializeObject<int>(objectToSave.model.idSelected.ToString());
            int idBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idBonus.ToString());
            double value = objectToSave.model.value;
            _serviceSession.AddBonusToContract(idContract, idSession, idSelected, idBonus, value);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// api to update bonus type in session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("updateBonusType"), Authorize("UPDATE_SESSION")]
        public ResponseData UpdateBonusType([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idOldBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idOldBonus.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idBonus.ToString());
            _serviceSession.UpdateBonusType(idSession, idBonus, idOldBonus);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// api to check the existance of a bonus type in session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("checkBonusExistanceInSession"), Authorize("UPDATE_SESSION")]
        public ObjectToSaveViewModel CheckBonusExistanceInSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idBonus.ToString());
            return _serviceSession.CheckBonusExistanceInSession(idSession, idBonus);
        }
        /// <summary>
        /// api to delete bonus from session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("deleteBonusFromSession"), Authorize("UPDATE_SESSION")]
        public ResponseData DeleteBonusFromSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idBonus.ToString());
            _serviceSession.DeleteBonusFromSession(idSession, idBonus);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// api to get list of loan installment for session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("getListOfLoanInstallmentForSession"), Authorize("SHOW_PAYROLL_SESSION")]
        public ReturnedDataLoanViewModel GetListOfLoanInstallmentForSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            return _serviceSession.GetListOfLoanInstallmentForSession(predicate, idSession);
        }
        /// <summary>
        /// api to add loan installment to contract session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addLoanInstallmentToSession"), Authorize("UPDATE_SESSION")]
        public ResponseData AddLoanInstallmentToSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idContract = JsonConvert.DeserializeObject<int>(objectToSave.model.id.ToString());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idSelected = JsonConvert.DeserializeObject<int>(objectToSave.model.idSelected.ToString());
            int idLoanInstallment = JsonConvert.DeserializeObject<int>(objectToSave.model.idLoanInstallment.ToString());
            double value = objectToSave.model.value;
            _serviceSession.AddLoanInstallmentToSession(idContract, idSession, idSelected, idLoanInstallment, value);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// api to add all the loan installments in session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addAllLoanInstallmentToSession"), Authorize("UPDATE_SESSION")]
        public ResponseData AddAllLoanInstallmentToSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            bool allSelected = JsonConvert.DeserializeObject<bool>(objectToSave.model.allSelected.ToString().ToLower());
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            _serviceSession.AddAllLoanInstallmentToSession(predicate, allSelected, idSession);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// api to update all bonus values for a spesific bonus type in session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("updateAllBonusValues"), Authorize("UPDATE_SESSION")]
        public ResponseData UpdateAllBonusValues([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idSession = JsonConvert.DeserializeObject<int>(objectToSave.model.idSession.ToString());
            int idBonus = JsonConvert.DeserializeObject<int>(objectToSave.model.idBonus.ToString());
            double value = objectToSave.model.value;
            _serviceSession.UpdateAllBonusValues(idSession, idBonus, value);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// api to update session state in every step
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("updateSessionStates"), Authorize("SHOW_PAYROLL_SESSION,UPDATE_SESSION")]
        public ResponseData UpdateSessionStates([FromBody] ObjectToSaveViewModel objectToSave)
        {
            SessionViewModel sessionViewModel = JsonConvert.DeserializeObject<SessionViewModel>(objectToSave.model.session.ToString());
            _serviceSession.UpdateSessionStates(sessionViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull,
                objectData = sessionViewModel
            };
            return result;
        }


        /// <summary>
        /// api to close session
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("closeSession"), Authorize("CLOSE_PAYSLIPSESSION")]
        public ResponseData CloseSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            SessionViewModel sessionViewModel = JsonConvert.DeserializeObject<SessionViewModel>(objectToSave.model.session.ToString());

            _serviceSession.CloseSession(sessionViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull,
                objectData = sessionViewModel
            };
            return result;
        }

        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_PAYSLIP")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }

        [HttpPost, Route("insert"), Authorize("OPEN_PAYROLL_SESSION")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
    }
}
