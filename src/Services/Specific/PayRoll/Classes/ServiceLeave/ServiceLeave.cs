using Infrastruture.Utility;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Classes;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes.ServiceLeave
{

    public partial class ServiceLeave : Service<LeaveViewModel, Leave>, IServiceLeave
    {
        #region constants
        public const string CREATOR = "{CREATOR}";
        public const string DOC_CODE = "{DOC_CODE}";
        public const string PROFIL = "{PROFIL}";

        #endregion

        #region fields
        private readonly IServiceEmployee _serviceEmployee;
        private readonly ILeaveBuilder _leaveBuilder;
        private readonly IServiceComment _serviceComment;
        private readonly IServicePeriod _servicePeriod;
        private readonly IServiceMessage _serviceMessage;
        private readonly IServiceEmail _serviceEmail;
        private readonly IServiceLeaveEmail _serviceLeaveEmail;
        private readonly IServiceLeaveType _serviceLeaveType;
        private readonly IServiceTimeSheetReduce _serviceTimeSheetReduce;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IServiceUser _serviceUser;
        private readonly IUserBuilder _userBuilder;
        private readonly IRepository<EmployeeTeam> _repositoryEmployeeTeam;
        private readonly SmtpSettings _smtpSettings;
        private readonly IRepository<Employee> _entityRepoEmployee;
        #endregion

        public ServiceLeave(IServicePeriod servicePeriod, IRepository<Leave> entityRepo,
           
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            ILeaveBuilder builder, IRepository<Entity> entityRepoEntity,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IServiceEmployee serviceEmployee,
            IServiceComment serviceComment,
            IServiceMessage serviceMessage,
            IServiceEmail serviceEmail,
            IServiceLeaveEmail serviceLeaveEmail,
            IServiceTimeSheetReduce serviceTimeSheetReduce,
            IServiceLeaveType serviceLeaveType,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification,
            IServiceMsgNotification serviceMessageNotification,
            IRepository<EmployeeTeam> repositoryEmployeeTeam,
            IServiceUser serviceUser,
            IUserBuilder userBuilder, IOptions<SmtpSettings> smtpSettings, IRepository<Employee> entityRepoEmployee)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                    entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceEmployee = serviceEmployee;
            _leaveBuilder = builder;
            _serviceComment = serviceComment;
            _servicePeriod = servicePeriod;
            _serviceMessage = serviceMessage;
            _serviceEmail = serviceEmail;
            _serviceLeaveEmail = serviceLeaveEmail;
            _serviceTimeSheetReduce = serviceTimeSheetReduce;
            _serviceLeaveType = serviceLeaveType;
            _serviceMessageNotification = serviceMessageNotification;
            _serviceUser = serviceUser;
            _userBuilder = userBuilder;
            _repositoryEmployeeTeam = repositoryEmployeeTeam;
            _smtpSettings = smtpSettings.Value;
            _entityRepoEmployee = entityRepoEmployee;
        }

        /// <summary>
        /// Add leave model
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(LeaveViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (!RoleHelper.HasPermission("ADD_LEAVE"))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
            model.CreationDate = DateTime.Now;
            model.Status = (int)AdministrativeDocumentStatusEnumerator.Waiting;
            // Get connected user
            UserViewModel currentUser = _serviceEmployee.GetUserByUserMail(userMail);
            model.TransactionUserId = currentUser.Id;
            if (model.IdEmployee == NumberConstant.Zero)
            {
                // Set request user by the current user
                model.IdEmployee = currentUser != null ? currentUser.IdEmployee.Value : throw new ArgumentException("");
            }
            _serviceEmployee.ValidateResignedStatusEmployee(model.IdEmployee, model.EndDate);

            // Manage leave attachement file
            ManageLeaveAttachementFile(model);
            //validation before the leave to save
            LeaveRequestCheckValidity(model);
            // Prevent the add of leave if the period of leave covers that of a validated CRA

            IList<TimeSheetViewModel> timeSheetViewModels = _serviceTimeSheetReduce.FindModelsByNoTracked(m => m.IdEmployee.Equals(model.IdEmployee)
                && m.Status.Equals((int)TimeSheetStatusEnumerator.Validated)
                && (DateTime.Compare(model.StartDate.Date, m.Month) >= NumberConstant.Zero 
                && DateTime.Compare(model.StartDate.Date, m.Month.AddMonths(1).AddDays(-1).Date) <= NumberConstant.Zero
                   || DateTime.Compare(model.EndDate.Date, m.Month) >= NumberConstant.Zero
                   && DateTime.Compare(model.EndDate.Date, m.Month.AddMonths(1).AddDays(-1).Date) <= NumberConstant.Zero)).ToList();
            if (timeSheetViewModels.Any())
            {
                throw new CustomException(CustomStatusCode.CANNOT_SUBMIT_LEAVE_BECAUSE_TIMESHEET_HAS_INOICE);
            }
            // set leave date and hours
            CheckLeaveDateAndTime(model);
            CreatedDataViewModel entity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            model = GetModelWithRelationsAsNoTracked(x => x.Id == entity.Id, x => x.IdEmployeeNavigation, x => x.IdLeaveTypeNavigation);
            SendMailAndNotifForLeave(userMail, null, model, Constants.ADDING, _smtpSettings);
            return entity;
        }

        /// <summary>
        /// Update Leave
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(LeaveViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted || model.Status == (int)AdministrativeDocumentStatusEnumerator.Refused)
            {
                ValidateOrRefuseLeaveCheck(model);
            }
            LeaveViewModel oldLeave = GetModelWithRelationsAsNoTracked(x => x.Id == model.Id, x => x.IdEmployeeNavigation, x => x.IdLeaveTypeNavigation);
            if (model.Status != oldLeave.Status)
            {
                if ((!(((RoleHelper.HasPermission("VALIDATE_LEAVE") || RoleHelper.HasPermission("VALIDATEALL_LEAVE")) && model.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
                        || ((RoleHelper.HasPermission("REFUSE_LEAVE") || RoleHelper.HasPermission("REFUSEALL_LEAVE")) && model.Status == (int)AdministrativeDocumentStatusEnumerator.Refused)
                        ||(RoleHelper.HasPermission("DELETEALL_LEAVE") && model.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
                        || model.IsConnectedUserInHierarchy) && oldLeave.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
                    || (oldLeave.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted && !(model.IsConnectedUserInHierarchy
                        || (RoleHelper.HasPermission("CANCEL_LEAVE") && model.Status == (int)AdministrativeDocumentStatusEnumerator.Canceled))))
                {
                    throw new CustomException(CustomStatusCode.Unauthorized);
                }
                if (oldLeave.Status == (int)AdministrativeDocumentStatusEnumerator.Refused ||
                   oldLeave.Status == (int)AdministrativeDocumentStatusEnumerator.Canceled)
                { // we can not change a status already refused or canceled  
                    throw new CustomException(CustomStatusCode.LeaveUpdateViolation);
                }
                else
                {
                    // Get connected employee
                    EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee();
                    if (connectedEmployee.Id != NumberConstant.Zero)
                    {
                        model.TreatedBy = connectedEmployee.Id;
                    }
                    model.TreatmentDate = DateTime.Now;
                }
            }
            else if (!(RoleHelper.HasPermission("UPDATE_LEAVE") || _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(model.IdEmployee)
                 || model.IdEmployee == _serviceEmployee.GetConnectedEmployee(userMail).Id))
            {
                 throw new CustomException(CustomStatusCode.Unauthorized);
            }
            if (model.Status != (int)AdministrativeDocumentStatusEnumerator.Canceled)
            {
                _serviceEmployee.ValidateResignedStatusEmployee(model.IdEmployee, model.EndDate);
            }
            // Manage leave attachement file
            ManageLeaveAttachementFile(model);
            //Verif if the leave is not validate
            if (model.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted || model.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
            {
                LeaveRequestCheckValidity(model);
            }
            // Set all already recorded TimeSheet that intersects with the leave period, status to ToReWork
            CheckIfThisPeriodHasTimeSheet(leaveViewModel: model, userMail: userMail, smtpSettings: _smtpSettings);
            // set leave date and hours
            CheckLeaveDateAndTime(model);
            // Update Model 
            var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            string action = "";
            switch (model.Status)
            {
                case (int)AdministrativeDocumentStatusEnumerator.Accepted:
                    action = Constants.VALIDATION;
                    break;
                case (int)AdministrativeDocumentStatusEnumerator.Refused:
                    action = Constants.REJECTION;
                    break;
                case (int)AdministrativeDocumentStatusEnumerator.Canceled:
                    action = Constants.CANCELLATION;
                    break;
                default:
                    action = Constants.UPDATING;
                    break;
            }
            SendMailAndNotifForLeave(userMail, oldLeave, model, action, _smtpSettings);
            return result;
        }

        public bool CheckUserIsTeamManagerOrUpperHierrarchy(int idEmployee, string userMail)
        {
            return _serviceEmployee.CheckUserIsTeamManagerOrUpperHierrarchy(idEmployee, userMail);
        }

        /// <summary>
        /// Validate leave request
        /// </summary>
        /// <param name="leaveViewModel"></param>
        public void ValidateLeaveRequest(LeaveViewModel leaveViewModel)
        {
            LeaveRequestCheckValidity(leaveViewModel);
            leaveViewModel.Status = (int)AdministrativeDocumentStatusEnumerator.Accepted;
            UpdateModelWithoutTransaction(leaveViewModel, null, ActiveAccountHelper.GetConnectedUserEmail());
        }

        /// <summary>
        /// Manage Leave file attachement
        /// </summary>
        /// <param name="leaveViewModel"></param>
        private void ManageLeaveAttachementFile(LeaveViewModel leaveViewModel)
        {
            if (string.IsNullOrEmpty(leaveViewModel.LeaveAttachementFile))
            {
                if (leaveViewModel.LeaveFileInfo != null && leaveViewModel.LeaveFileInfo.Count != NumberConstant.Zero)
                {
                    EmployeeViewModel employee = _serviceEmployee.GetModelById(leaveViewModel.IdEmployee);
                    leaveViewModel.LeaveAttachementFile = Path.Combine(PayRollConstant.PayRollFileRootPath + employee.FirstName + employee.LastName, Guid.NewGuid().ToString());

                    CopyFiles(leaveViewModel.LeaveAttachementFile, leaveViewModel.LeaveFileInfo);
                }
            }
            else
            {
                if (leaveViewModel.LeaveFileInfo != null)
                {
                    DeleteFiles(leaveViewModel.LeaveAttachementFile, leaveViewModel.LeaveFileInfo);
                    CopyFiles(leaveViewModel.LeaveAttachementFile, leaveViewModel.LeaveFileInfo);
                }

            }
        }

        /// <summary>
        /// Delete the leave if the leaveStatus is waiting
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            LeaveViewModel leaveViewModel = GetModelWithRelationsAsNoTracked(m => m.Id.Equals(id), x => x.IdEmployeeNavigation, x => x.IdLeaveTypeNavigation);
            if (!(RoleHelper.HasPermission("DELETE_LEAVE") || _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(leaveViewModel.IdEmployee)
                || leaveViewModel.IdEmployee == _serviceEmployee.GetConnectedEmployee(userMail).Id))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
            if (leaveViewModel.Status != (int)AdministrativeDocumentStatusEnumerator.Waiting)
            {
                throw new CustomException(CustomStatusCode.LeaveDeleteViolation);
            }
            List<LeaveEmailViewModel> emails = _serviceLeaveEmail.FindModelBy(x => x.IdLeave == id).ToList();
            List<int> emailsIds = new List<int>();
            if (emails != null && emails.Any())
            {
                emailsIds = emails.Select(x => x.IdEmail).ToList();
            }
            // delete all emails related to the leave
            foreach (int idEmail in emailsIds)
            {
                _serviceEmail.DeleteModelwithouTransaction(idEmail, null, userMail);
            }
            SendMailAndNotifForLeave(userMail, null, leaveViewModel, Constants.DELETION, _smtpSettings);
            return base.DeleteModelwithouTransaction(id, tableName, userMail);
        }

        /// <summary>
        /// For any already recorded TimeSheet that intersects with the leave period, set the TimeSheet statut to ToReWork
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="userMail"></param>
        private void CheckIfThisPeriodHasTimeSheet(LeaveViewModel leaveViewModel, string userMail, SmtpSettings smtpSettings)
        {
            if (leaveViewModel.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Accepted) ||
                leaveViewModel.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Canceled))
            {
                IList<TimeSheetViewModel> timeSheetViewModels = _serviceTimeSheetReduce.FindModelsByNoTracked(model => model.IdEmployee.Equals(leaveViewModel.IdEmployee)
                    && (model.Status.Equals((int)TimeSheetStatusEnumerator.Validated) || model.Status.Equals((int)TimeSheetStatusEnumerator.PartiallyValidated)
                        || model.Status.Equals((int)TimeSheetStatusEnumerator.Sended))
                    && ( DateTime.Compare(leaveViewModel.StartDate.Date, model.Month.Date) >= NumberConstant.Zero
                        && DateTime.Compare(leaveViewModel.StartDate.Date, model.Month.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One).Date) <= NumberConstant.Zero
                    || DateTime.Compare(leaveViewModel.EndDate.Date, model.Month.Date) >= NumberConstant.Zero
                        && DateTime.Compare(leaveViewModel.EndDate.Date, model.Month.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One).Date) <= NumberConstant.Zero),
                    model => model.TimeSheetLine, model => model.IdEmployeeNavigation
                    ).ToList();//ModelOfItem => ModelOfItem.Document
                if (timeSheetViewModels.Any())
                {
                    timeSheetViewModels.ToList().ForEach(model =>
                    {
                        if (leaveViewModel.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Canceled) && (model.Document != null && model.Document.Any()))
                        {
                            throw new CustomException(CustomStatusCode.CANNOT_CANCEL_LEAVE_BECAUSE_TIMESHEET_HAS_INOICE);
                        }
                        model.Status = (int)TimeSheetStatusEnumerator.ToReWork;
                        model.TimeSheetDay.ToList().ForEach(m =>
                        {
                            m.TimeSheetLine.ToList().ForEach(line => line.Valid = false);
                        });
                        SendMailAndNotifForTimesheetCorrection(userMail, model, smtpSettings);
                    });
                    _serviceTimeSheetReduce.BulkUpdateModelWithoutTransaction(timeSheetViewModels, userMail);
                }
            }
        }

        /// <summary>
        /// Get employees under connected user leaves, and if he is team manager get 
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="predicateModel"></param>
        /// <param name="month"></param>
        /// <param name="onlyFirstLevelOfHierarchy"></param>
        /// <param name="isAdmin"></param>
        /// <returns></returns>
        public DataSourceResult<LeaveViewModel> GetEmployeeLeaveRequests(string userMail, PredicateFormatViewModel predicateModel, DateTime? month, bool onlyFirstLevelOfHierarchy = false, bool isAdmin = false)
        {
            DataSourceResult<LeaveViewModel> dataSourceResult = new DataSourceResult<LeaveViewModel>();
            List<EmployeeViewModel> employeesList = new List<EmployeeViewModel>();
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            Expression<Func<Leave, bool>> leavePredicate = x => true;
            Expression<Func<Leave, bool>> teammPredicate = x => true;
            if (predicateModel.Filter.Any(p => p.Prop == nameof(Leave.IdEmployee)))
            {
                List<int> idTeamManagers = predicateModel.Filter.Where(p => p.Prop == nameof(Leave.IdEmployee)).Select(p => Convert.ToInt32(p.Value)).ToList();
                predicateModel.Filter = predicateModel.Filter.Where(p => p.Prop != nameof(Leave.IdEmployee)).ToList();
                leavePredicate = x => x.IdEmployeeNavigation.EmployeeTeam.Any(m =>
                    idTeamManagers.Contains(m.IdTeamNavigation.IdManager) && m.IdTeamNavigation.State &&
                    (m.UnassignmentDate.HasValue && DateTime.Compare(x.CreationDate.Date, m.AssignmentDate.Date) >= NumberConstant.Zero
                        && DateTime.Compare(x.CreationDate.Date, m.UnassignmentDate.Value.Date) <= NumberConstant.Zero
                        || !m.UnassignmentDate.HasValue && DateTime.Compare(x.CreationDate.Date, m.AssignmentDate.Date) >= NumberConstant.Zero));
            }
            if (predicateModel.Filter.Any(p => p.Prop == nameof(EmployeeTeam.IdTeam)))
            {
                List<int> idTeams = predicateModel.Filter.Where(p => p.Prop == nameof(EmployeeTeam.IdTeam)).Select(p => Convert.ToInt32(p.Value)).ToList();
                teammPredicate = x => x.IdEmployeeNavigation.EmployeeTeam.Any(m =>
                    idTeams.Contains(m.IdTeam) && m.IdTeamNavigation.State && m.IsAssigned &&
                    (m.UnassignmentDate.HasValue
                        && DateTime.Compare(x.CreationDate.Date, m.AssignmentDate.Date) >= NumberConstant.Zero && DateTime.Compare(x.CreationDate.Date, m.UnassignmentDate.Value.Date) <= NumberConstant.Zero
                        || !m.UnassignmentDate.HasValue && DateTime.Compare(x.CreationDate.Date, m.AssignmentDate.Date) >= NumberConstant.Zero));
                predicateModel.Filter = predicateModel.Filter.Where(p => p.Prop != nameof(EmployeeTeam.IdTeam)).ToList();
                leavePredicate = leavePredicate.And(teammPredicate);
            }
            PredicateFilterRelationViewModel<Leave> predicateFilterRelationModel = PreparePredicate(predicateModel);
            IQueryable<Leave> leaveQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(leavePredicate, predicateFilterRelationModel.PredicateRelations)
                                .Where(predicateFilterRelationModel.PredicateWhere)
                                .BuildOrderBysQue(predicateModel.OrderBy);
            
            dataSourceResult.total = leaveQuery.Count();
            var leaves = leaveQuery.ToList().Where(x => x.IdEmployeeNavigation.Id == connectedEmployee.Id ||
                !string.IsNullOrEmpty(x.IdEmployeeNavigation.HierarchyLevel)
                    && x.IdEmployeeNavigation.HierarchyLevel.Split(PayRollConstant.LevelSeparator, StringSplitOptions.None).ToArray().Contains(connectedEmployee.Id.ToString()));
            if (month.HasValue)
            {
                leaves = leaves.Where(model => DateTime.Compare(new DateTime(month.Value.Year, month.Value.Month, NumberConstant.One).Date,
                    new DateTime(model.StartDate.Year, model.StartDate.Month, NumberConstant.One).Date) >= NumberConstant.Zero
                    && DateTime.Compare(new DateTime(month.Value.Year, month.Value.Month, NumberConstant.One).Date, new DateTime(model.EndDate.Year, model.EndDate.Month, NumberConstant.One).Date) <= NumberConstant.Zero);
            }
            leaves.Skip((predicateModel.page - NumberConstant.One) * predicateModel.pageSize).Take(predicateModel.pageSize);
            dataSourceResult.data = leaves.Select(_leaveBuilder.BuildEntity).Select(x => { x.IsConnectedUserInHierarchy = _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(x.IdEmployee); return x; }).ToList();
            return dataSourceResult;
        }

        /// <summary>
        /// Get the leaves of the connected employee
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public DataSourceResult<LeaveViewModel> GetEmployeeConnectedLeave(PredicateFormatViewModel predicateModel, string userMail)
        {
            PredicateFilterRelationViewModel<Leave> predicateFilterRelationModel = PreparePredicate(predicateModel);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            if (!predicateModel.Filter.Any())
            {
                predicateModel.Filter = new List<FilterViewModel>();
            }
            predicateFilterRelationModel.PredicateWhere = x => x.IdEmployee.Equals(connectedEmployee.Id);
            return GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
        }


        /// <summary>
        /// Calcul of the daysNumber and the hoursNumber of all accepted and waiting leave requests by idEmployee
        /// </summary>
        /// /// <param name="idLeaveType"></param>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public DayHour CalculateNumberOfDaysAndHourOfAllLeaveRequest(LeaveTypeViewModel leaveType, int idEmployee, double numberHoursOfPeriod = 0, int idCurrentLeave = 0)
        {
            DayHour dayHour = new DayHour();
            List<Leave> leaves = _entityRepo.FindByAsNoTracking(p =>
                p.IdLeaveType == leaveType.Id &&
                p.Id != idCurrentLeave &&
                p.IdEmployee == idEmployee
                && p.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Accepted)).OrderBy(x => x.StartDate).ToList();
            if (leaves.Any())
            {
                CompanyViewModel companyViewModel = GetCurrentCompany();
                IList<PeriodViewModel> periodViewModels = _servicePeriod.GetExistingPeriodCrossBy(leaves.First().StartDate, leaves.Last().EndDate);
                leaves.ForEach(leave =>
                {
                    DayHour currentLeaveDayHOur = _servicePeriod.CalculateNumberOfDaysAndHour(leave.StartDate, leave.EndDate, leave.StartTime,
                        leave.EndTime, companyViewModel.TimeSheetPerHalfDay, periodViewModels, leaveType.Calendar);
                    dayHour.Add(currentLeaveDayHOur);
                });
                // Get period of the clast date
                PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(model => leaves.Last().EndDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate));
                numberHoursOfPeriod = numberHoursOfPeriod.IsApproximately(NumberConstant.Zero) ?
                    _servicePeriod.CalculateDateHourNumber(curentPeriod.Hours.ToList(), curentPeriod.Hours.FirstOrDefault().StartTime, curentPeriod.Hours.LastOrDefault().EndTime,
                                                                                companyViewModel.TimeSheetPerHalfDay).DayHourInDecimal :
                     numberHoursOfPeriod;
                _servicePeriod.DayHourRound(dayHour, numberHoursOfPeriod);
            }
            return dayHour;
        }


        /// <summary>
        /// Validate the leave request
        /// </summary>
        /// <param name="leaveViewModel"></param>
        private void LeaveRequestCheckValidity(LeaveViewModel leaveViewModel)
        {
            LeaveTypeViewModel leaveType = leaveViewModel.IdLeaveTypeNavigation;
            if (leaveType.ExpiryDate.HasValue && leaveViewModel.StartDate.AfterDate(leaveType.ExpiryDate.Value))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.DATE,  leaveType.ExpiryDate.Value.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                throw new CustomException(CustomStatusCode.LeaveTypeExpirationDateViolation, paramtrs);
            }
            if ((leaveViewModel.LeaveFileInfo == null || leaveViewModel.LeaveFileInfo.Count == NumberConstant.Zero) && leaveViewModel.LeaveAttachementFile == null && leaveType.RequiredDocument)
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { PayRollConstant.LEAVE_TYPE, leaveType.Label }
                    };
                throw new CustomException(CustomStatusCode.LeaveWithJustificationViolation, paramtrs);
            }
            Company company = _entityRepoCompany.GetSingleNotTracked(m => true);
            DayHour dayHour = _servicePeriod.CalculateNumberOfDaysAndHour(leaveViewModel.StartDate, leaveViewModel.EndDate,
                leaveViewModel.StartTime, leaveViewModel.EndTime, company.TimeSheetPerHalfDay.Value);
            // The leave is valid if the daysNumber > 0 or hoursNumber > 0
            if (dayHour.DayHourInDecimal.Equals(NumberConstant.Zero) && leaveViewModel.Status != (int)AdministrativeDocumentStatusEnumerator.Canceled)
            {
                throw new CustomException(CustomStatusCode.LeaveDateViolation);
            }
            CalculateNumberOfDaysAndHourOfLeaveBalance(leaveViewModel);
            if (!leaveViewModel.IdLeaveTypeNavigation.AuthorizedOvertaking && ((leaveViewModel.CurrentBalance != null && leaveViewModel.CurrentBalance < NumberConstant.Zero) ||
                (leaveViewModel.CurrentYearLeaveRemaining != null && leaveViewModel.CurrentYearLeaveRemaining < NumberConstant.Zero)))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), leaveViewModel.IdEmployeeNavigation.FullName }
                    };
                throw new CustomException(CustomStatusCode.OVERTAKING_OF_LEAVE_IS_NOT_AUTHORIZED, paramtrs);
            }
            // Get all leave of this employee for the years covered by the years mentioned in the start date and the end date of the leave
            List<LeaveViewModel> allEmployeeLeaveForThisPeriod = GetAllModelsQueryable(model => !model.Id.Equals(leaveViewModel.Id)
                && model.Status != (int)AdministrativeDocumentStatusEnumerator.Refused
                && model.Status != (int)AdministrativeDocumentStatusEnumerator.Canceled
                && model.IdEmployee.Equals(leaveViewModel.IdEmployee)
                && model.StartDate.Year >= leaveViewModel.StartDate.Year - NumberConstant.One
                && model.EndDate.Year <= leaveViewModel.EndDate.Year + NumberConstant.One).AsEnumerable()
                .OrderBy(m => m.StartDate).ToList();
            // Construct a start date equal to the start date of the leave plus the start time
            DateTime LeaveViewModelStartDate = new DateTime(leaveViewModel.StartDate.Year, leaveViewModel.StartDate.Month,
                leaveViewModel.StartDate.Day, leaveViewModel.StartTime.Hours,
                leaveViewModel.StartTime.Minutes, NumberConstant.Zero);
            LeaveViewModelStartDate = LeaveViewModelStartDate.Add(new TimeSpan(NumberConstant.Zero, NumberConstant.One, NumberConstant.Zero));
            // Construct an end date equal to the end date of the leave plus the end time
            DateTime LeaveViewModeEndDate = new DateTime(leaveViewModel.EndDate.Year, leaveViewModel.EndDate.Month,
                leaveViewModel.EndDate.Day, leaveViewModel.EndTime.Hours,
                leaveViewModel.EndTime.Minutes, NumberConstant.Zero);
            LeaveViewModeEndDate = LeaveViewModeEndDate.Add(new TimeSpan(NumberConstant.Zero, -NumberConstant.One, NumberConstant.Zero));
            // Browse the list of holidays and check if there is any overlap
            allEmployeeLeaveForThisPeriod.ForEach(model =>
            {
                DateTime modelStartDateTime = model.StartDate.Add(new TimeSpan(model.StartTime.Hours, model.StartTime.Minutes, NumberConstant.Zero));
                DateTime modelEndDateTime = model.EndDate.Add(new TimeSpan(model.EndTime.Hours, model.EndTime.Minutes, NumberConstant.Zero));
                if (LeaveViewModelStartDate.BetweenDateTimeLimitIncluded(modelStartDateTime, modelEndDateTime) ||
                    LeaveViewModeEndDate.BetweenDateTimeLimitIncluded(modelStartDateTime, modelEndDateTime) ||
                    (LeaveViewModelStartDate.BeforeDate(modelStartDateTime) && LeaveViewModeEndDate.AfterDate(modelEndDateTime)) ||
                    (LeaveViewModelStartDate.AfterDate(modelStartDateTime) && LeaveViewModeEndDate.BeforeDate(modelEndDateTime)))
                {
                    throw new CustomException(CustomStatusCode.LeaveRequestViolation);
                }
            });
        }

        /// <summary>
        /// Get the start time of the period to set the hours dropdown
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public KeyValuePair<string, TimeSpan> GetStartTimeOfPeriod(DateTime date)
        {
            return _servicePeriod.GetStartTimeOfPeriod(date);
        }

        /// <summary>
        /// Get the end time of the period to set the hours dropdown
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public KeyValuePair<string, TimeSpan> GetEndTimeOfPeriod(DateTime date)
        {
            return _servicePeriod.GetEndTimeOfPeriod(date);
        }

        /// <summary>
        ///  Returns the list of valid times for a date 
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public IList<KeyValuePair<string, TimeSpan>> GetHoursPeriodOfDate(DateTime date)
        {
            return _servicePeriod.GetHoursPeriodOfDate(date);
        }

        /// <summary>
        /// Verify if the date has a period
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public PeriodViewModel VerifyPeriodOfDate(DateTime date)
        {
            return _servicePeriod.VerifyPeriodOfDate(date);
        }

        /// <summary>
        /// Retourne le congé subdivisé en deux, le premier avec un solde restant égal à zero et le second représentant le surplus
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <returns></returns>
        public IList<LeaveViewModel> GetTwoLeavesDecomposedFromNegativeBalanceLeave(LeaveViewModel leaveViewModel)
        {
            PeriodViewModel currentPeriod = default;
            LeaveViewModel overTakeLeave = new LeaveViewModel
            {
                IdEmployee = leaveViewModel.IdEmployee,
                EndDate = leaveViewModel.EndDate,
                EndTime = leaveViewModel.EndTime,
                IdLeaveTypeNavigation = leaveViewModel.IdLeaveTypeNavigation
            };
            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(leaveViewModel.StartDate, leaveViewModel.EndDate);
            if (leaveViewModel.IdLeaveTypeNavigation.Calendar)
            {
                leaveViewModel.EndDate = leaveViewModel.EndDate.AddDays(leaveViewModel.LeaveBalanceRemaining.Day);
                currentPeriod = periodViewModels.First(x => leaveViewModel.EndDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate));
                overTakeLeave.StartDate = leaveViewModel.EndDate.AddDays(NumberConstant.One);
                overTakeLeave.StartTime = currentPeriod.Hours.OrderBy(x => x.StartTime).FirstOrDefault().StartTime;
            }
            else
            {
                DayHour dayHourForSubstract = new DayHour(NumberConstant.One, NumberConstant.Zero);
                IList<int> listOfInvalidDayOfWeek = default;
                while (leaveViewModel.LeaveBalanceRemaining.Day < NumberConstant.Zero)
                {
                    leaveViewModel.EndDate = leaveViewModel.EndDate.AddDays(NumberConstant.MinusOne);
                    currentPeriod = periodViewModels.First(x => leaveViewModel.EndDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate));
                    listOfInvalidDayOfWeek = _servicePeriod.GetListOfInvalidDayOfWeek(currentPeriod);
                    if (!listOfInvalidDayOfWeek.Contains((int)leaveViewModel.EndDate.DayOfWeek))
                    {
                        leaveViewModel.LeaveBalanceRemaining.Day++;
                    }
                }
                // 
                leaveViewModel.EndTime = currentPeriod.Hours.OrderByDescending(x => x.EndTime).FirstOrDefault().EndTime;
                // Initialiser 
                overTakeLeave.StartDate = leaveViewModel.EndDate.AddDays(NumberConstant.One);
                // 
                while(listOfInvalidDayOfWeek.Contains((int)overTakeLeave.StartDate.DayOfWeek))
                {
                    overTakeLeave.StartDate = overTakeLeave.StartDate.AddDays(NumberConstant.One);
                    currentPeriod = periodViewModels.First(x => overTakeLeave.StartDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate));
                    listOfInvalidDayOfWeek = _servicePeriod.GetListOfInvalidDayOfWeek(currentPeriod);
                }
                overTakeLeave.StartTime = currentPeriod.Hours.OrderBy(x => x.StartTime).FirstOrDefault().StartTime;
            }
            // Calculer le solde de congé diminuer de la partie négative
            CalculateNumberOfDaysAndHourOfLeaveBalance(leaveViewModel);
            return new List<LeaveViewModel>
            {
                leaveViewModel,
                overTakeLeave
            };;
        }

        /// <summary>
        /// get by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override LeaveViewModel GetModelById(int id)
        {
            LeaveViewModel leaveRequest = GetModelAsNoTracked(x => x.Id == id, x => x.IdLeaveTypeNavigation, x => x.IdEmployeeNavigation);
            // get comments related to the current leave
            if (leaveRequest != null)
            {
                leaveRequest.IsConnectedUserInHierarchy = _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(leaveRequest.IdEmployee);
                leaveRequest.Comments = _serviceComment.GetComments("LeaveRequest", id);
                leaveRequest.LeaveFileInfo = GetFiles(leaveRequest.LeaveAttachementFile).ToList();
            }
            return leaveRequest;
        }

        /// <summary>
        /// Send email and notification for leave
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="oldLeave"></param>
        /// <param name="leave"></param>
        /// <param name="action"></param>
        /// <param name="smtpSetting"></param>
        public void SendMailAndNotifForLeave(string userMail, LeaveViewModel oldLeave, LeaveViewModel leave, string action, SmtpSettings smtpSetting)
        {
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(leave.IdEmployee);
            EmailViewModel generatedEmail = new EmailViewModel();
            LeaveEmailViewModel leaveEmail;
            string mailBody;

            foreach (UserViewModel user in userList)
            {
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // prepare emailSubject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.LeaveRequest, user.Lang);
                // Prepare emailBody 
                string msg = EmailFirstLine(connectedEmployee.FullName, leave.IdEmployeeNavigation.FullName, action, leave.Code, administrativeDocumentConstant);
                if (action == Constants.UPDATING)
                {
                    mailBody = PrepareInterviewMailBodyForUpdateCase(administrativeDocumentConstant, msg, oldLeave, leave, user.Lang);
                }
                else
                {
                    mailBody = PrepareInterviewMailBody(administrativeDocumentConstant, msg, leave, user.Lang);
                }
                // generate the email
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = NumberConstant.One,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = user.Email
                };
                // add the email in the db
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // add the leaveMail relation 
                leaveEmail = new LeaveEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdLeave = leave.Id
                };
                _serviceLeaveEmail.AddModelWithoutTransaction(leaveEmail, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSetting);
            }

            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["DOC_CREATOR"] = connectedEmployee.FullName,
                ["DOC_CODE"] = leave.Code,
                ["PROFIL"] = leave.IdEmployeeNavigation.FullName
            };
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(GetInformationType(action),
               generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.LeaveNotification,
               userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }

        /// <summary>
        /// Get information type
        /// </summary>
        /// <param name="action"></param>
        /// <returns></returns>
        private string GetInformationType(string action)
        {
            string type = "";
            switch (action)
            {
                case "ADDING":
                    type = Constants.ADD_LEAVE_REQUEST;
                    break;
                case "UPDATING":
                    type = Constants.UPDATE_LEAVE_REQUEST;
                    break;
                case "DELETION":
                    type = Constants.DELETE_LEAVE_REQUEST;
                    break;
                case "VALIDATION":
                    type = Constants.VALIDATE_LEAVE_REQUEST;
                    break;
                case "REJECTION":
                    type = Constants.REFUSE_LEAVE_REQUEST;
                    break;
                case "CANCELLATION":
                    type = Constants.CANCEL_LEAVE_REQUEST;
                    break;
                default:
                    break;
            }
            return type;
        }
        /// <summary>
        /// Prepare first line of email
        /// </summary>
        /// <param name="connectedEmployeeName"></param>
        /// <param name="leaveEmployeeName"></param>
        /// <param name="action"></param>
        /// <param name="code"></param>
        /// <param name="administrativeDocumentConstant"></param>
        /// <returns></returns>
        private string EmailFirstLine(string connectedEmployeeName, string leaveEmployeeName, string action, string code, AdministrativeDocumentConstant administrativeDocumentConstant)
        {
            StringBuilder header = new StringBuilder();
            header.Append(connectedEmployeeName).Append(" ");
            switch (action)
            {
                case "ADDING":
                    header.Append(administrativeDocumentConstant.AddingLeaveRequest);
                    if (!connectedEmployeeName.Equals(leaveEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.For);
                    }
                    break;
                case "UPDATING":
                    header.Append(administrativeDocumentConstant.UpdatingLeaveRequest).Append(" ").Append(code);
                    if (!connectedEmployeeName.Equals(leaveEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.Of);
                    }
                    break;
                case "DELETION":
                    header.Append(administrativeDocumentConstant.DeletingLeaveRequest);
                    if (!connectedEmployeeName.Equals(leaveEmployeeName))
                    {
                        header.Append(" ").Append(administrativeDocumentConstant.Of);
                    }
                    break;
                case "VALIDATION":
                    header.Append(administrativeDocumentConstant.ValidatingLeaveRequest);
                    break;
                case "REJECTION":
                    header.Append(administrativeDocumentConstant.RejectingLeaveRequest);
                    break;
                case "CANCELLATION":
                    header.Append(administrativeDocumentConstant.CancellingLeaveRequest);
                    break;
                default:
                    break;
            }
            if (!connectedEmployeeName.Equals(leaveEmployeeName))
            {
                header.Append(" ").Append(leaveEmployeeName);
            }
            return header.ToString();
        }

        public void PrepareAndSendMail(MailBrodcastConfigurationViewModel configMail, string userMail, string action,
            LeaveViewModel oldLeave, SmtpSettings smtpSettings)
        {

            MessageViewModel msgVM = _serviceMessage.GetModelWithRelations(x => x.Id == configMail.IdMsg, x => x.IdInformationNavigation);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            LeaveViewModel leave;
            if (action == "DELETION")
            {
                leave = oldLeave;
            }
            else
            {
                // we can not getModel after deletion
                leave = GetModelById(configMail.Model.Id);
            }
            EmailViewModel generatedEmail;
            LeaveEmailViewModel leaveEmail;
            string mailBody;

            foreach (string email in configMail.users)
            {
                UserViewModel user = _serviceEmployee.GetUserByUserMail(email);
                AdministrativeDocumentConstant administrativeDocumentConstant = new AdministrativeDocumentConstant(user.Lang);
                // prepare emailSubject
                string emailSubject = AdministrativeDocumentInfosBuilder.PrepareSubject(action, administrativeDocumentConstant.LeaveRequest, user.Lang);
                // Prepare emailBody 
                string msg = AdministrativeDocumentInfosBuilder.PrepareMessage(user, connectedEmployee, msgVM, configMail);
                if (action == "UPDATING")
                {
                    mailBody = PrepareInterviewMailBodyForUpdateCase(administrativeDocumentConstant, msg, oldLeave, leave, user.Lang);
                }
                else
                {
                    mailBody = PrepareInterviewMailBody(administrativeDocumentConstant, msg, leave, user.Lang);
                }
                // generate the email
                generatedEmail = new EmailViewModel
                {
                    AttemptsToSendNumber = NumberConstant.One,
                    Subject = emailSubject,
                    Body = mailBody,
                    Status = (int)EmailEnumerator.Draft,
                    Sender = userMail,
                    Receivers = email
                };
                // add the email in the db
                int generatedEmailId = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
                generatedEmail.Id = generatedEmailId;
                // add the leaveMail relation 
                leaveEmail = new LeaveEmailViewModel
                {
                    IdEmail = generatedEmailId,
                    IdLeave = configMail.Model.Id
                };
                _serviceLeaveEmail.AddModelWithoutTransaction(leaveEmail, null, userMail);
                // send the email
                _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            }

        }

        string PrepareInterviewMailBody(AdministrativeDocumentConstant administrativeDocumentConstant, string msg, LeaveViewModel leave, string culture)
        {
            string startDate = DateUtility.GenerateDateByCulture(leave.StartDate, culture);
            string endDate = DateUtility.GenerateDateByCulture(leave.EndDate, culture);
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.LeaveRequestEmailTemplate);
            body = body.Replace("{MESSAGE}", msg.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{CODE}", leave.Code, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DESCRIPITION}", leave.Description, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{LEAVE_TYPE}", leave.IdLeaveTypeNavigation.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{START_DATE}", startDate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{START_TIME}", leave.StartTime.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{END_DATE}", endDate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{END_TIME}", leave.EndTime.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DAYS_NUMBER}", leave.NumberDaysLeave.Day.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{HOURS_NUMBER}", leave.NumberDaysLeave.Hour.ToString(), StringComparison.OrdinalIgnoreCase);
            return body;
        }
        string PrepareInterviewMailBodyForUpdateCase(AdministrativeDocumentConstant administrativeDocumentConstant, string msg, LeaveViewModel oldLeave, LeaveViewModel leave, string culture)
        {

            string startDateBeforeUpdate = DateUtility.GenerateDateByCulture(oldLeave.StartDate, culture);
            string endDateBeforeUpdate = DateUtility.GenerateDateByCulture(oldLeave.EndDate, culture);
            string startDateAfterUpdate = DateUtility.GenerateDateByCulture(leave.StartDate, culture);
            string endDateAfterUpdate = DateUtility.GenerateDateByCulture(leave.EndDate, culture);
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@administrativeDocumentConstant.LeaveRequestEmailUpdateTemplate);
            body = body.Replace("{MESSAGE}", msg.ToString(), StringComparison.OrdinalIgnoreCase);
            // Replace template by the leave details Before update
            body = body.Replace("{DESCRIPITION_OLD_LEAVE}", oldLeave.Description, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{OLD_LEAVE_TYPE}", oldLeave.IdLeaveTypeNavigation.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{START_DATE_OLD_LEAVE}", startDateBeforeUpdate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{START_TIME_OLD_LEAVE}", oldLeave.StartTime.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{END_DATE_OLD_LEAVE}", endDateBeforeUpdate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{END_TIME_OLD_LEAVE}", oldLeave.EndTime.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DAYS_NUMBER_OLD_LEAVE}", oldLeave.NumberDaysLeave.Day.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{HOURS_NUMBER_OLD_LEAVE}", oldLeave.NumberDaysLeave.Hour.ToString(), StringComparison.OrdinalIgnoreCase);
            // Replace template by the new leave details After update
            body = body.Replace("{DESCRIPITION_NEW_LEAVE}", leave.Description, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{NEW_LEAVE_TYPE}", leave.IdLeaveTypeNavigation.Label, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{START_DATE_NEW_LEAVE}", startDateAfterUpdate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{START_TIME_NEW_LEAVE}", leave.StartTime.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{END_DATE_NEW_LEAVE}", endDateAfterUpdate, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{END_TIME_NEW_LEAVE}", leave.EndTime.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{DAYS_NUMBER_NEW_LEAVE}", leave.NumberDaysLeave.Day.ToString(), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{HOURS_NUMBER_NEW_LEAVE}", leave.NumberDaysLeave.Hour.ToString(), StringComparison.OrdinalIgnoreCase);
            return body;

        }

        private void SendMailAndNotifForTimesheetCorrection(string userMail, TimeSheetViewModel timeSheetViewModel, SmtpSettings smtpSettings)
        {
            string monthAndYear;
            EmailViewModel generatedEmail = new EmailViewModel();
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
            {
                ["EMPLOYEE"] = timeSheetViewModel.IdEmployeeNavigation.FullName
            };
            // Send mail to all superiors of the employee
            List<UserViewModel> userList = _serviceEmployee.GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(timeSheetViewModel.IdEmployee);
            userList.ForEach((user) =>
            {
                if (user.Lang != null && user.Lang.Equals("en"))
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(timeSheetViewModel.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("en-En")));
                }
                else
                {
                    monthAndYear = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(timeSheetViewModel.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR")));
                }
                parameters["MONTH"] = monthAndYear.ToString();
                generatedEmail = PrepareAndSendMailForTimesheetCorrection(user.Lang, user.Email, userMail, timeSheetViewModel, monthAndYear.ToString(), smtpSettings);
            });
            _serviceMessageNotification.PrepareAndNotifyUsersWithoutTransaction(Constants.CORRECTION_REQUEST_TIMESHEET,
            generatedEmail.Id, JsonConvert.SerializeObject(parameters), (int)MessageTypeEnumerator.TimesheetNotif,
            userMail, parameters, userList.Where(x => x.Id > NumberConstant.Zero).Select(x => _userBuilder.BuildModel(x)).ToList(), GetCurrentCompany().Code);
        }

        public EmailViewModel PrepareAndSendMailForTimesheetCorrection(string receiverLang, string receiverEmail, string userMail, TimeSheetViewModel timeSheet,
           string monthAndYear, SmtpSettings smtpSettings)
        {
            EmailConstant emailConstant = new EmailConstant(receiverLang ?? "fr");
            string subject = PrepareMailSubjectForTimesheetCorrection(emailConstant, monthAndYear);
            string body = PrepareMailBodyForTimesheetCorrection(emailConstant, timeSheet, monthAndYear);
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = NumberConstant.One,
                Subject = subject,
                Body = body,
                Status = (int)EmailEnumerator.Draft,
                Sender = userMail,
                Receivers = receiverEmail
            };
            // add the email in the db
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, smtpSettings);
            return generatedEmail;
        }
        public string PrepareMailSubjectForTimesheetCorrection(EmailConstant emailConstant, string monthAndYear)
        {
            StringBuilder subject = new StringBuilder();
            subject.Append(emailConstant.TimeSheet).Append(" ").Append(monthAndYear);
            subject.Append(emailConstant.TimesheetCorrectionSubject);
            return subject.ToString();
        }

        public string PrepareMailBodyForTimesheetCorrection(EmailConstant emailConstant, TimeSheetViewModel timeSheet, string monthaAndYear)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@emailConstant.TimeSheetTemplate);
            StringBuilder message = new StringBuilder();
            message.Append(emailConstant.TimesheeRequestCorrection).Append(monthaAndYear).Append(emailConstant.TimesheetEmployeeName)
                               .Append(timeSheet.IdEmployeeNavigation.FullName).Append(" ").Append(emailConstant.TimesheetCorrectionRequestMessage);
            body = body.Replace("{MESSAGE}", message.ToString(), StringComparison.OrdinalIgnoreCase);
            return body;
        }

        /// <summary>
        /// This method check the validity of the date and hours and set the leave date and times to their best value
        /// </summary>
        /// <param name="model"></param>
        private void CheckLeaveDateAndTime(LeaveViewModel model)
        {
            IList<KeyValuePair<string, TimeSpan>> periodHoursOfStartDate;
            IList<KeyValuePair<string, TimeSpan>> periodHoursOfEndDate;
            // Verify the hours validity in the period of the startDate
            periodHoursOfStartDate = _servicePeriod.GetHoursPeriodOfDate(model.StartDate);
            periodHoursOfEndDate = periodHoursOfStartDate;
            if (periodHoursOfStartDate.All(x => x.Value != model.StartTime))
            {
                IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters[nameof(TimeSpan)] = model.StartTime;
                throw new CustomException(CustomStatusCode.HoursNotFoundInPeriodException, parameters);
            }

            // Get the hours of the endDate
            if (model.StartDate.Date.BeforeDate(model.EndDate.Date))
            {
                periodHoursOfEndDate = _servicePeriod.GetHoursPeriodOfDate(model.EndDate);
            }
            // Verify the hours validity in the period of the endDate
            if (periodHoursOfEndDate.All(x => x.Value != model.EndTime))
            {
                IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();
                parameters[nameof(TimeSpan)] = model.EndTime;
                throw new CustomException(CustomStatusCode.HoursNotFoundInPeriodException, parameters);
            }

            // Set leave dates and hours to their best value
            if (model.StartDate.Date.BeforeDate(model.EndDate.Date))
            {
                KeyValuePair<string, TimeSpan> periodEndHours = periodHoursOfStartDate.OrderByDescending(h => h.Value).FirstOrDefault();
                // If the model startTime is the endHours of the period
                if (model.StartTime.CompareTo(periodEndHours.Value) == NumberConstant.Zero)
                {
                    model.StartDate = model.StartDate.Date.AddDays(NumberConstant.One);
                    KeyValuePair<string, TimeSpan> newPeriodStartHours = _servicePeriod.GetStartTimeOfPeriod(model.StartDate);
                    model.StartTime = newPeriodStartHours.Value;
                }
                KeyValuePair<string, TimeSpan> periodStartTime = periodHoursOfEndDate.OrderByDescending(h => h.Value).LastOrDefault();
                // If the model endTime is the startTime of the period
                if (model.EndTime.CompareTo(periodStartTime.Value) == NumberConstant.Zero)
                {
                    model.EndDate = model.EndDate.Date.AddDays(-NumberConstant.One);
                    KeyValuePair<string, TimeSpan> newPeriodEndHours = _servicePeriod.GetEndTimeOfPeriod(model.EndDate);
                    model.EndTime = newPeriodEndHours.Value;
                }
            }
        }
        /// <summary>
        /// get lives selected by ids
        /// </summary>
        /// <param name="listIdLeaves"></param>
        /// <returns></returns>
        public List<LeaveViewModel> GetLeaveFromListId(List<int> listIdLeaves)
        {
            List<LeaveViewModel> listedWaitingLeaves = _entityRepo.QuerableGetAll().Include(x => x.IdEmployeeNavigation.User)
                          .Include(x => x.IdEmployeeNavigation.User).ThenInclude(x => x.UserPrivilege).ThenInclude(x => x.IdPrivilegeNavigation)
                          .Include(x => x.IdEmployeeNavigation.User)
                          .Include(x => x.IdLeaveTypeNavigation)
                          .Where(x => listIdLeaves.Contains(x.Id) && x.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting)
                          .Select(y => _builder.BuildEntity(y)).ToList();

            foreach (LeaveViewModel l in listedWaitingLeaves)
            {
                l.LeaveFileInfo = GetFiles(l.LeaveAttachementFile).ToList();
            }
            return listedWaitingLeaves;

        }
        /// <summary>
        /// Validate many leaves
        /// </summary>
        /// <param name="listOfLeaves"></param>
        /// <param name="userMail"></param>
        public void ValidateMassiveLeaves(List<LeaveViewModel> listOfLeaves, string userMail)
        {
            try
            {
                BeginTransaction();
                listOfLeaves.ForEach((leave) =>
                {
                    ValidateLeaveRequest(leave);
                });
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
        }
        /// <summary>
        /// DeleteMassiveLeave
        /// </summary>
        /// <param name="listIdLeaves"></param>
        /// <param name="userMail"></param>
        public void DeleteMassiveLeave(List<int> listIdLeaves, string userMail)
        {
            listIdLeaves.ForEach((id) =>
            {
                DeleteModel(id, nameof(Leave), userMail);
            });
        }
        /// <summary>
        /// RefuseMassiveLeave
        /// </summary>
        /// <param name="listIdLeaves"></param>
        /// <param name="userMail"></param>
        public void RefuseMassiveLeave(List<int> listIdLeaves, string userMail)
        {
            listIdLeaves.ForEach((x) =>
            {
                LeaveViewModel leave = GetModelById(x);
                leave.IdLeaveTypeNavigation.AuthorizedOvertaking = true;
                leave.Status = (int)AdministrativeDocumentStatusEnumerator.Refused;
                UpdateModelWithoutTransaction(leave, null, userMail);
            });
        }

        /// <summary>
        /// Check if user is trying to validate or refuse his request
        /// </summary>
        /// <param name="leave"></param>
        private void ValidateOrRefuseLeaveCheck(LeaveViewModel leave)
        {
            int idOfConnectedEmployee = ActiveAccountHelper.GetConnectedUserCredential().IdEmployee ?? NumberConstant.Zero;
            if (idOfConnectedEmployee != NumberConstant.Zero && idOfConnectedEmployee == leave.IdEmployee)
            {
                if (leave.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
                {
                    throw new CustomException(CustomStatusCode.ConnectedUserCannotValidateHisRequest);
                }
                else
                {
                    throw new CustomException(CustomStatusCode.ConnectedUserCannotRefuseHisRequest);
                }
            }
        }
        /// <summary>
        /// Add multiple leaves
        /// </summary>
        /// <param name="listOfLeaves"></param>
        public void AddMassiveLeaves(List<LeaveViewModel> listOfLeaves)
        {
            try
            {
                BeginTransaction();
                listOfLeaves.ToList().ForEach(leave =>
                {
                    if (leave.Id == NumberConstant.Zero)
                    {
                        AddModelWithoutTransaction(leave, null, ActiveAccountHelper.GetConnectedUserEmail());
                    }
                    else
                    {
                        UpdateModelWithoutTransaction(leave, null, ActiveAccountHelper.GetConnectedUserEmail());
                    }
                });
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }

        }

        /// <summary>
        /// send leave balance remaining email to all employees
        /// </summary>
        /// <param name="leaveBalanceRemainingFilter"></param>
        /// <param name="userMail"></param>
        public void MassiveSendLeaveBalanceRemainingEmails(LeaveBalanceRemainingFilter leaveBalanceRemainingFilter, string userMail)
        {
            //get employees
            List<Employee> employees = leaveBalanceRemainingFilter.EmployeesId.Any() ? 
                _entityRepoEmployee.GetAllAsNoTracking().Where(e => leaveBalanceRemainingFilter.EmployeesId.Contains(e.Id)).Include(y => y.LeaveBalanceRemaining).ThenInclude(z => z.IdLeaveTypeNavigation).Include(w => w.User).ToList() :
               _entityRepoEmployee.GetAllAsNoTracking().Include(y => y.LeaveBalanceRemaining).ThenInclude(z => z.IdLeaveTypeNavigation).Include(w => w.User).ToList();
            employees.ForEach(employee =>
            {
                if(leaveBalanceRemainingFilter.LeaveTypeId != NumberConstant.Zero)
                {
                    employee.LeaveBalanceRemaining = employee.LeaveBalanceRemaining.Where(x => x.IdLeaveType == leaveBalanceRemainingFilter.LeaveTypeId).ToList();
                }
                SendLeaveBalanceRemainingEmail(employee, userMail);
            });
        }
        /// <summary>
        /// prepare and send leave balance remaining email to employee
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="idLeaveType"></param>
        /// <param name="userMail"></param>
        public void SendLeaveBalanceRemainingEmail(Employee employee, string userMail)
        {
            LeaveBalanceRemainingEmailConstant leaveBalanceRemainingEmailConstant = new LeaveBalanceRemainingEmailConstant(employee.User != null &&
                employee.User.Any() ? employee.User.FirstOrDefault().Lang ?? "fr" : "fr");
            // prepare email subject
            string emailSubject = PrepareLeaveBalanceRemainingEmailSubject(leaveBalanceRemainingEmailConstant);
            // prepare email body
            string emailBody = PrepareLeaveBalanceRemainingEmailBody(leaveBalanceRemainingEmailConstant, employee.LeaveBalanceRemaining.ToList(), employee.User != null &&
                employee.User.Any() ? employee.User.FirstOrDefault().Lang ?? "fr" : "fr");
            EmailViewModel generatedEmail = new EmailViewModel
            {
                AttemptsToSendNumber = NumberConstant.One,
                Subject = emailSubject,
                Body = emailBody,
                Sender = userMail,
                Receivers = employee.User != null && employee.User.Any() ? employee.User.FirstOrDefault().Email : employee.Email
            };
            // add the email in the db
            generatedEmail.Id = ((CreatedDataViewModel)_serviceEmail.AddModelWithoutTransaction(generatedEmail, null, userMail)).Id;
            // send the email
            _serviceEmail.PrepareAndSendEmail(generatedEmail, userMail, _smtpSettings);
        }
        /// <summary>
        /// prepare leave balance remaining email subject
        /// </summary>
        /// <param name="leaveBanlanceRemainingConstant"></param>
        /// <returns></returns>
        string PrepareLeaveBalanceRemainingEmailSubject(LeaveBalanceRemainingEmailConstant leaveBanlanceRemainingConstant)
        {
            string emailSubject = leaveBanlanceRemainingConstant.LeaveBalanceRemainingSubject;
            emailSubject = emailSubject.Replace("{YEAR}", DateTime.Now.Year.ToString(), StringComparison.OrdinalIgnoreCase);
            return emailSubject;
        }
        /// <summary>
        /// prepare leave balance remaining email body
        /// </summary>
        /// <param name="leaveBanlanceRemainingConstant"></param>
        /// <param name="leaveBalanceRemaining"></param>
        /// <returns></returns>
        string PrepareLeaveBalanceRemainingEmailBody(LeaveBalanceRemainingEmailConstant leaveBanlanceRemainingConstant, List<LeaveBalanceRemaining> leaveBalanceRemainingList, string lang)
        {
            string body = _serviceEmail.GetEmailHtmlContentFromFile(@leaveBanlanceRemainingConstant.LeaveBalanceRemainingTemplate);
            string leaveBalanceRemainingListInHtmlFormat = @BuildLeaveBalanceRemainingListInHtmlFormat(leaveBalanceRemainingList, lang);
            body = body.Replace("{MONTH}", DateTime.Now.FirstDateOfMonth().AddDays(-NumberConstant.One).ToString("dd/MM"), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{LEAVE_BALANCE_DETAILS}", leaveBalanceRemainingListInHtmlFormat, StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_GENDER}", lang.GetTheCurrentLanguageCivilityFromGender(leaveBalanceRemainingList.FirstOrDefault().IdEmployeeNavigation.Sex), StringComparison.OrdinalIgnoreCase);
            body = body.Replace("{EMPLOYEE_NAME}", leaveBalanceRemainingList.FirstOrDefault().IdEmployeeNavigation.FirstName, StringComparison.OrdinalIgnoreCase);
            return body;
        }

        private string BuildLeaveBalanceRemainingListInHtmlFormat(List<LeaveBalanceRemaining> leaveBalanceRemainingList, string lang)
        {
            StringBuilder htmlFormat = new StringBuilder();
            foreach (LeaveBalanceRemaining leaveBalance in leaveBalanceRemainingList)
            {
                htmlFormat.Append("<tr>");
                htmlFormat.Append("<td>");
                htmlFormat.Append(leaveBalance.IdLeaveTypeNavigation.Label);
                htmlFormat.Append("</td>");
                htmlFormat.Append("<td>");
                htmlFormat.Append(leaveBalance.CumulativeAcquiredDay);
                htmlFormat.Append(lang.Equals("fr") ? "j et " : "d and ");
                htmlFormat.Append(leaveBalance.CumulativeAcquiredHour);
                htmlFormat.Append("h");
                htmlFormat.Append("</td>");
                htmlFormat.Append("<td>");
                htmlFormat.Append(leaveBalance.CumulativeTakenDay);
                htmlFormat.Append(lang.Equals("fr") ? "j et " : "d and ");
                htmlFormat.Append(leaveBalance.CumulativeTakenHour);
                htmlFormat.Append("h");
                htmlFormat.Append("</td>");
                htmlFormat.Append("<td>");
                htmlFormat.Append(leaveBalance.RemainingBalanceDay);
                htmlFormat.Append(lang.Equals("fr") ? "j et " : "d and ");
                htmlFormat.Append(leaveBalance.RemainingBalanceHour);
                htmlFormat.Append("h");
                htmlFormat.Append("</td>");
                if (leaveBalance.IdLeaveTypeNavigation.ExpiryDate != null)
                {
                    DateTime ExpiryDate = (DateTime)leaveBalance.IdLeaveTypeNavigation.ExpiryDate;
                    htmlFormat.Append("<td>");
                    htmlFormat.Append(lang.Equals("fr") ? "Le solde de congé au " : "Leave balance until ");
                    htmlFormat.Append("<strong>");
                    htmlFormat.Append(DateTime.Now.LastDateOfYear().AddYears(-NumberConstant.One).ToString("dd/MM/yyyy"));
                    htmlFormat.Append("</strong>");
                    htmlFormat.Append(lang.Equals("fr") ? " est à consommer avant le " : " is to be consumed before ");
                    htmlFormat.Append("<strong>");
                    htmlFormat.Append("<span class='ql-font-serif' style='color: red; '>");
                    htmlFormat.Append(ExpiryDate.AddDays(NumberConstant.One).ToString("dd/MM/yyyy"));
                    htmlFormat.Append("</span>");
                    htmlFormat.Append("</strong>");
                    htmlFormat.Append("</td>");
                }
                else
                {
                    htmlFormat.Append("<td>");
                    htmlFormat.Append("-");
                    htmlFormat.Append("</td>");
                }
                htmlFormat.Append("</tr>");
            }
            return htmlFormat.ToString();
        }

    }
}
