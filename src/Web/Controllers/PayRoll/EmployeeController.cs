using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Utils;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/employee")]
    public class EmployeeController : BaseController
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly SmtpSettings _smtpSettings;
        public EmployeeController(IServiceProvider serviceProvider, IOptions<SmtpSettings> smtpSettings
            , ILogger<EmployeeController> logger, IServiceEmployee serviceEmployee)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceEmployee = serviceEmployee;
            _smtpSettings = smtpSettings.Value;
        }

        [HttpPost, DisableRequestSizeLimit, Route("importFileEmployees"), Authorize("IMPORT_EMPLOYEE")]
        public ResponseData UploadFilesAsync([FromBody] FileInfoViewModel model)
        {
            var excelDataByteArray = Convert.FromBase64String(model.FileData);
            // When creating a stream, you need to reset the position, without it you will see that you always write files with a 0 byte length. 
            var excelDataStream = new MemoryStream(excelDataByteArray);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceEmployee.GenerateEmployeeListFromExcel(excelDataStream)
                },
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }

        [HttpPost, Route("insertEmployeesList"), Authorize("UPDATE_EMPLOYEE")]
        public ResponseData InsertEmployeesList([FromBody] IList<EmployeeViewModel> employeesList)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceEmployee.BulkAddWithoutTransaction(employeesList.Where(x => x.Id == NumberConstant.Zero).ToList(), userMail);
                _serviceEmployee.BulkUpdateModelWithoutTransaction(employeesList.Where(x => x.Id != NumberConstant.Zero).ToList(), userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
                return result;
            }
        }

        [HttpPost, Route("getHierarchicalEmployeesList"), Authorize("VIEW_SKILLS_MATRIX,LIST_EMPLOYEE,UPDATE_ANNUALINTERVIEW,LIST_ANNUALINTERVIEW,ADD_INTERVIEW,LIST_LEAVE,ADD_LEAVE,SHOW_LEAVE,ADD_RECRUITMENT," +
            "UPDATE_RECRUITMENT,ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,LIST_TIMESHEET,ADD_EXPENSEREPORT,UPDATE_EXPENSEREPORT,ADD_DOCUMENTREQUEST," +
            "UPDATE_DOCUMENTREQUEST,LIST_TRAININGREQUEST,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,OPEN_PAYROLL_SESSION,SHOW_PAYROLL_SESSION,SHOW_TIMESHEET,TIMESHEET_MY_TIMESHEET,ALL_TRAINING_REQUEST")]
        public ResponseData GetHierarchicalEmployeesList([FromBody] ObjectToSaveViewModel objectSaved)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            if (objectSaved.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectSaved.model.predicate.ToString());
                if (!RoleHelper.HasPermission(RHPermissionConstant.LIST_RESIGNED_EMPLOYEES))
                {
                    predicateFormatViewModel.Filter.Add(new FilterViewModel
                    {
                        Prop = nameof(Contract.IdEmployeeNavigation) + GenericConstants.Point + nameof(Contract.IdEmployeeNavigation.Status),
                        Operation = Operation.NotEquals,
                        Value = (int)EmployeeState.Resigned
                    });
                }
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployee.GetHierarchicalEmployeesList(userMail,
                objectSaved.model.withTheSuperior != null && objectSaved.model.withTheSuperior.Value,
                objectSaved.model.withTeamCollaborater != null && objectSaved.model.withTeamCollaborater.Value,
                predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpGet, Route("getConnectedEmployee"), Authorize("LIST_TRAININGREQUEST,ALL_TRAINING_REQUEST,LIST_EMPLOYEE,LIST_LEAVE,ADD_LEAVE,LIST_TIMESHEET,ADD_EXPENSEREPORT,UPDATE_EXPENSEREPORT,LIST_EXPENSEREPORT," +
            "ADD_DOCUMENTREQUEST,UPDATE_DOCUMENTREQUEST,ADD_INTERVIEW,LIST_ANNUALINTERVIEW,ADD_TRAININGREQUEST,LIST_ANNUALINTERVIEW,LIST_SHAREDDOCUMENT,LIST_OWNED_SHARED_DOCUMENT,TIMESHEET_MY_TIMESHEET,SHOW_TIMESHEET," +
            "ADD_TIMESHEET,SHOW_LEAVE,FABRICATION_PERMISSION")]
        public ResponseData GetConnectedEmployee()
        {
            GetUserMail();
            EmployeeViewModel defaultEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = defaultEmployee != null && defaultEmployee.Id != NumberConstant.Zero ? defaultEmployee :
                    _serviceEmployee.FindByAsNoTracking(x => true).FirstOrDefault(),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost, Route("getSuperiorsEmployeeAsUsers"), Authorize("LIST_EMPLOYEE,UPDATE_RECRUITMENTREQUEST,ADD_RECRUITMENTREQUEST,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData GetSuperiorsEmployeeAsUsers([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployee.GetSuperiorsEmployeeAsUsers(objectToSave.model.EmployeeId != null ? ((int)(objectToSave.model.EmployeeId.Value)) : 0,
                objectToSave.model.WithTheCurrentEmployee != null ? objectToSave.model.WithTheCurrentEmployee.Value : false),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost, Route("getEmployeeDetails"), Authorize("LIST_EMPLOYEE,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,VIEW_CATEGORY,ADD_CATEGORY,EDIT_CATEGORY,VIEW_ACTION,VIEW_ARCHIVED_ACTION," +
            "ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,ADD_INTERVIEW,UPDATE_INTERVIEW,DELAY_INTERVIEW_PERMISSION,FABRICATION_PERMISSION")]
        public ResponseData GetEmployeeDetails([FromBody] List<int> idEmployes)
        {
            if (idEmployes == null)
            {
                throw new ArgumentNullException();
            }
            Expression<Func<Employee, bool>> predicate = x => idEmployes.Contains(x.Id);
            if (!RoleHelper.HasPermission(RHPermissionConstant.LIST_RESIGNED_EMPLOYEES))
            {
                predicate = predicate.And(x => x.Status != (int)EmployeeState.Resigned);
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployee.FindModelBy(predicate),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpGet("getById/{id}"), Authorize("SHOW_EMPLOYEE,LIST_TEAM,ADD_INTERVIEW,ADD_OPPORTUNITY,EDIT_OPPORTUNITY,OWN_OPPORTUNITY,VIEW_OPPORTUNITY,UPDATE_JOB,ADD_JOB,FABRICATION_PERMISSION")]
        public override ResponseData GetById(int id)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployee.GetModelById(id, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };

            return result;
        }
        [HttpPost("getEmployeeByEmail"), Authorize("UPDATE_EMPLOYEE,ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,ADD_EXITEMPLOYEE,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER")]
        public ResponseData GetEmployeeByEmail([FromBody] string email)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployee.GetEmployeeByEmail(email, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };

            return result;
        }

        [HttpPost, Route("isUserInSuperHierarchicalEmployeeList"), Authorize("LIST_EMPLOYEE,ADD_EXITEMPLOYEE,SHOW_REVIEW")]
        public ResponseData IsUserInSuperHierarchicalEmployeeList([FromBody] EmployeeViewModel employee)
        {
            if (employee == null)
            {
                throw new ArgumentNullException(nameof(employee));
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployee.IsUserInSuperHierarchicalEmployeeList(userMail, employee),
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost, Route("generateAndSendSharedDocumentsPassword"), Authorize("UPDATE_EMPLOYEE,SEND_EMPLOYEE_SHARED_DOCUMENTS_PASSWORD")]
        public ResponseData SendSharedDocumentsPassword([FromBody] int employeeId)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            GetUserMail();
            _serviceEmployee.GetSharedDocumentsPasswordAndSendItEveryTime(employeeId, userMail, _smtpSettings);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpGet("getEmployeeWithSkill/{idSkill}"), Authorize("LIST_EMPLOYEE,VIEW_SKILLS_MATRIX,ADD_INTERVIEW,LIST_LEAVE,ADD_LEAVE,SHOW_LEAVE,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public IList<EmployeeViewModel> GetEmployeeWithSkill(int idSkill)
        {
            return _serviceEmployee.GetEmployeeWithSkill(idSkill);
        }

        [HttpGet("getEmployeeForProfile/{id}"), Authorize("LIST_EMPLOYEE,SHOW_USER")]
        public EmployeeViewModel GetEmployeeForProfile(int id)
        {
            GetUserMail();
            return _serviceEmployee.GetModelById(id, userMail);
        }

        /// <summary>
        /// return list of all employees who have at least one payslip in specefic year
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        [HttpPost("getEmployeesHasPayslip"), Authorize("LIST_EMPLOYEE,ADD_SOURCEDEDUCTIONSESSION,SHOW_SOURCEDEDUCTIONSESSION")]
        public ResponseData GetEmployeesHasPayslip([FromBody] int year)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var employeeViewModels = _serviceEmployee.GetEmployeesHasPayslip(year);
                result.listObject = new ListObject
                {
                    listData = employeeViewModels,
                    total = employeeViewModels.Count()
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            }
            return result;
        }

        /// <summary>
        /// Synchronize all employees
        /// </summary>
        /// <returns></returns>
        [HttpPost("synchronizeEmployees"), Authorize("LIST_EMPLOYEE")]
        public bool SynchronizeEmployees()
        {
            _serviceEmployee.SynchronizeEmployees();
            return true;
        }

        /// <summary>
        /// Check if connected employee has privileges or not
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet, Route("getConnectedEmployeePrivileges/{id}"), Authorize("LIST_EMPLOYEE,ADD_LEAVE,SHOW_LEAVE")]
        public ResponseData GetConnectedEmployeePrivileges(int id)
        {
            ResponseData result = new ResponseData()
            {
                flag = NumberConstant.One,
                objectData = _serviceEmployee.GetConnectedEmployeePrivileges(id),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        [HttpPost("getEmployeeDropdownWithPredicate"), Authorize("SHOW_REVIEW,ADD_INTERVIEW,ADD_TRAININGREQUEST,UPDATE_TRAININGREQUEST,ADD_LEAVE,SHOW_LEAVE,ADD_RECRUITMENTREQUEST,UPDATE_RECRUITMENTREQUEST," +
            "ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTOFFER,ADD_RECRUITMENT,UPDATE_RECRUITMENT,LIST_CONTRACT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,ADD_EXPENSEREPORT,UPDATE_EXPENSEREPORT,LIST_EXPENSEREPORT," +
            "ADD_DOCUMENTREQUEST,UPDATE_DOCUMENTREQUEST,LIST_LEAVE,LIST_ASSIGNMENT_ACTIVE,ADD_ASSIGNMENT_ACTIVE,LIST_EXITEMPLOYEE,LIST_ASSIGNMENT_ACTIVE,ADD_ASSIGNMENT_ACTIVE,LIST_TEAM,ADD_EMPLOYEE,UPDATE_EMPLOYEE,ADD_TEAM," +
            "ADD_SHAREDDOCUMENT,LIST_PAYSLIPHISTORY,LIST_RECRUITMENTREQUEST,VIEW_ORGANIZATIONCHART,LIST_LOAN,UPDATE_JOB,ADD_JOB,SHOW_TRAINING_REQUEST,SHOW_OFFICE,UPDATE_OFFICE,ADD_OFFICE,ADD_USER,UPDATE_USER,SHOW_USER,FABRICATION_PERMISSION")]
        public ResponseData GetEmployeeDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.GetEmployeeDropdownWithPredicate(model);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        [HttpGet("getNotAssociatedEmployees"), Authorize("LIST_EMPLOYEE,ADD_LEAVE,SHOW_LEAVE,LIST_GROUPUSERS")]
        public ResponseData GetNotAssociatedEmployees()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _serviceEmployee.GetNotAssociatedEmployees()
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        /// <summary>
        ///  Check if the connected user is in selected employee hierarchy
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("IsInConnectedUserHierarchy"), Authorize("LIST_EMPLOYEE,ADD_LEAVE")]
        public bool IsInConnectedUserHierarchy([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int connectedEmployeeId = objectToSave.model.ConnectedEmployeeId is null || objectToSave.model.ConnectedEmployeeId.Value is null
                ? 0 : (int)objectToSave.model.ConnectedEmployeeId.Value;
            int selectedEmployeeId = objectToSave.model.SelectedEmployeeId is null || objectToSave.model.SelectedEmployeeId.Value is null
                ? 0 : (int)objectToSave.model.SelectedEmployeeId.Value;
            return connectedEmployeeId == NumberConstant.Zero || selectedEmployeeId == NumberConstant.Zero
                ? false : _serviceEmployee.IsInConnectedUserHierarchy(connectedEmployeeId, selectedEmployeeId);
        }

        /// <summary>
        /// Get all organization charts of all employees
        /// </summary>
        /// <returns></returns>
        [HttpGet, Route("getAllEmployeesWithInferiors"), Authorize("LIST_EMPLOYEE,VIEW_ORGANIZATIONCHART")]
        public List<OrganizationChartViewModel> GetAllEmployeesWithInferiors()
        {
            return _serviceEmployee.GetAllEmployeesWithInferiors();
        }

        /// <summary>
        /// Get selected employee organization chart
        /// </summary>
        /// <param name="employeeId"></param>
        /// <returns></returns>
        [HttpGet, Route("selectedEmployeeOrganizationChart/{employeeId}"), Authorize("LIST_EMPLOYEE,VIEW_ORGANIZATIONCHART")]
        public OrganizationChartViewModel SelectedEmployeeOrganizationChart(int employeeId)
        {
            return _serviceEmployee.SelectedEmployeeOrganizationChart(employeeId);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("ADD_RECRUITMENT,FULL_RECRUITMENT,ADD_EMPLOYEEEXIT,UPDATE_EMPLOYEEEXIT,VIEW_SKILLS_MATRIX,ADD_INTERVIEW,LIST_LEAVE,ADD_LEAVE,SHOW_LEAVEREQUEST,LIST_LEAVEREMAININGBALANCE," +
            "ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,LIST_TIMESHEET,LIST_EXPENSEREPORT,LIST_DOCUMENTREQUEST,LIST_SHAREDDOCUMENT,SHOW_PAYROLL_SESSION,SHOW_TRAINING_SESSION,ALL_TRAINING_REQUEST,LIST_TRAININGREQUEST," +
            "UPDATE_INTERVIEW,DELAY_INTERVIEW_PERMISSION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            bool hasRole = RoleHelper.HasPermission(RHPermissionConstant.LIST_RESIGNED_EMPLOYEES);
            if (!hasRole && model.Filter.Any(x => x.Prop == nameof(Employee.Status) && Convert.ToInt32(x.Value) == (int)EmployeeState.Resigned))
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            if (!hasRole && model.Filter.Count == NumberConstant.One && model.Filter.Any(x => x.Prop == Constants.WITH_TEAM_MEMBERS))
            {
                model.Filter.Add(new FilterViewModel { Prop = nameof(Employee.Status), Value = (int)EmployeeState.Active });
                model.Filter.Add(new FilterViewModel { Prop = nameof(Employee.Status), Value = (int)EmployeeState.Resigning });
            }

            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("get"), Authorize("ADD_CATEGORY,EDIT_CATEGORY,ADD_CONTACT,ADD_ORGANISATION")]
        public override ResponseData Get([FromBody] PredicateFormatViewModel model)
        {
            return base.Get(model);
        }

        [HttpGet("get"), Authorize("ADD_CATEGORY,EDIT_CATEGORY,ADD_CONTACT,ADD_ORGANISATION")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        [HttpPost("getPredicate"), Authorize("VIEW_SKILLS_MATRIX")]
        public override ResponseData GetPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetPredicate(model);
        }

        [HttpGet("isConnectedUserTeamManagerOrHierarchic/{idSelectedEmployee}")]
        public bool IsConnectedUserTeamManagerOrHierarchic(int idSelectedEmployee)
        {
            return _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(idSelectedEmployee);
        }
        [HttpPost("getPictures")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }

        [HttpPost("getUnicity"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,SHOW_EMPLOYEE")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }
    }
}


