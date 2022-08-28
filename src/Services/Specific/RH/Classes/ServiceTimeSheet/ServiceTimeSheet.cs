using Infrastruture.Utility;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
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
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.RH.Classes.ServiceTimeSheet
{
    public partial class ServiceTimeSheet : Service<TimeSheetViewModel, TimeSheet>, IServiceTimeSheet
    {
        private readonly IServiceEmployee _serviceEmployee;
        private readonly IServicePeriod _servicePeriod;
        private readonly IServiceProject _serviceProject;
        private readonly IServiceDayOff _serviceDayOff;
        private readonly IServiceTimeSheetLine _serviceTimeSheetLine;
        private readonly ITimeSheetLineBuilder _timeSheetLineBuilder;
        private readonly IServiceEmail _serviceEmail;
        private readonly IRepository<Document> _repoDocument;
        private readonly IRepository<Leave> _repoLeave;
        private readonly IDocumentBuilder _documentBuilder;
        private readonly IUserBuilder _userBuilder;
        private readonly IServiceMsgNotification _serviceMessageNotification;
        private readonly IReducedTimeSheetBuilder _reducedTimeSheetBuilder;
        private readonly IServiceComment _serviceComment;
        private readonly IServiceTimeSheetCountDays _serviceTimeSheetCountDays;
        private readonly SmtpSettings _smtpSettings;

        public ServiceTimeSheet(IRepository<TimeSheet> entityRepo, IServiceEmployee serviceEmployee,
            IServiceTimeSheetLine serviceTimeSheetLine, IServiceProject serviceProject, IServiceDayOff serviceDayOff, IRepository<Entity> entityRepoEntity,
            IServicePeriod servicePeriod, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
            ITimeSheetBuilder builder, ITimeSheetLineBuilder timeSheetLineBuilder,
            IServiceEmail serviceEmail, IUserBuilder userBuilder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification,
            IOptions<AppSettings> appSettings,
            IServiceMsgNotification serviceMessageNotification,
            IRepository<Leave> repoLeave,
            IRepository<Company> entityRepoCompany,
            IRepository<Document> repoDocument,
            IDocumentBuilder documentBuilder,
            IReducedTimeSheetBuilder reducedTimeSheetBuilder,
            ICompanyBuilder companyBuilder,
            IServiceTimeSheetCountDays serviceTimeSheetCountDays,
            IMemoryCache memoryCache, IServiceComment serviceComment, IOptions<SmtpSettings> smtpSettings)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                    entityRepoEntity, entityRepoEntityCodification, entityRepoCodification, companyBuilder, memoryCache)
        {
            _repoLeave = repoLeave;
            _servicePeriod = servicePeriod;
            _serviceDayOff = serviceDayOff;
            _serviceProject = serviceProject;
            _serviceEmployee = serviceEmployee;
            _serviceTimeSheetLine = serviceTimeSheetLine;
            _timeSheetLineBuilder = timeSheetLineBuilder;
            _repoDocument = repoDocument;
            _documentBuilder = documentBuilder;
            _serviceEmail = serviceEmail;
            _serviceMessageNotification = serviceMessageNotification;
            _userBuilder = userBuilder;
            _reducedTimeSheetBuilder = reducedTimeSheetBuilder;
            _serviceComment = serviceComment;
            _serviceTimeSheetCountDays = serviceTimeSheetCountDays;
            _smtpSettings = smtpSettings.Value;
        }

        public override object AddModelWithoutTransaction(TimeSheetViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model.Status == (int)TimeSheetStatusEnumerator.ToDo)
            {
                model.Status = (int)TimeSheetStatusEnumerator.Draft;
            }
            model.Month = model.Month.FirstDateOfMonth();
            CheckTimeSheetDayValidity(model);
            ManageTimeSheetAttachementFile(model);
            CreatedDataViewModel entity = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            if (entity != null && model.Status == (int)TimeSheetStatusEnumerator.Sended)
            {
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                SendNotifForTimesheetSubmission(userMail, connectedEmployee, entity.Id);
            }
            return entity;
        }

        /// <summary>
        /// Calculates the number of days worked for a company configuration dependent on the CRA
        /// </summary>
        /// <param name="contractViewModel"></param>
        /// <param name="idEmployee"></param>
        /// <param name="month"></param>
        /// <param name="daysOfWork"></param>
        /// <param name="attendanceViewModel"></param>
        public AttendanceViewModel NumberOfDaysWorkedByContractDependOnTimeSheet(ContractViewModel contractViewModel, DateTime month, double daysOfWork, bool isForPreview = false)
        {
            DateTime startDate = contractViewModel.StartDate.BeforeDateLimitIncluded(month.FirstDateOfMonth())
                        ? month.FirstDateOfMonth() : contractViewModel.StartDate;
            DateTime endDate = contractViewModel.EndDate.HasValue && contractViewModel.EndDate.Value.BeforeDateLimitIncluded(month.LastDateOfMonth())
                ? contractViewModel.EndDate.Value : month.LastDateOfMonth();
            AttendanceViewModel attendanceViewModel = new AttendanceViewModel
            {
                IdEmployee = contractViewModel.IdEmployee,
                IdContract = contractViewModel.Id,
                StartDate = contractViewModel.StartDate.BeforeDate(month) ? month :
                                contractViewModel.StartDate,
                EndDate = contractViewModel.EndDate.HasValue &&
                            contractViewModel.EndDate.Value.BeforeDateLimitIncluded(month.LastDateOfMonth())
                            ? contractViewModel.EndDate.Value : month.LastDateOfMonth()
            };
            if (isForPreview)
            {
                attendanceViewModel.NumberDaysWorked = _servicePeriod.NumberOfDaysWorkedCompanyBetweenDates(startDate, endDate);
                attendanceViewModel.NumberDaysPaidLeave = NumberConstant.Zero;
                attendanceViewModel.NumberDaysNonPaidLeave = NumberConstant.Zero;
            }
            else
            {
                NumberOfDaysDayHour numberOfDaysDayHour = GetNumberOfDayWorkedPerContract(startDate, endDate, contractViewModel.IdEmployee, month);
                PeriodViewModel periodViewModel = _servicePeriod.GetPeriodOfDate(endDate);
                double hours = _servicePeriod.CalculateHourNumber(periodViewModel.Hours);
                DayHour dayHour = numberOfDaysDayHour.NumberOfDaysWorked + numberOfDaysDayHour.NumberOfDaysOff;
                attendanceViewModel.NumberDaysWorked = dayHour.Day + dayHour.Hour / hours;
                attendanceViewModel.NumberDaysPaidLeave = numberOfDaysDayHour.NumberOfPaidLeavesDays.Day + numberOfDaysDayHour.NumberOfPaidLeavesDays.Hour / hours;
                attendanceViewModel.NumberDaysNonPaidLeave = numberOfDaysDayHour.NumberOfUnPaidLeavesDays.Day + numberOfDaysDayHour.NumberOfPaidLeavesDays.Hour / hours;
            }
            // Check if the work period covers the whole month or not
            bool workedEntireMonth = startDate.EqualsDate(month.FirstDateOfMonth()) && endDate.EqualsDate(month.LastDateOfMonth());
            double numberOfDaysWorkedAccordingTimeheet = _servicePeriod.NumberOfDaysWorkedCompanyBetweenDates(month.FirstDateOfMonth(), month.LastDateOfMonth());
            // If the period worked covers the whole month and the number of days provided by the company exceeds the maximum provided by the month Timesheet, add the difference
            if (daysOfWork > numberOfDaysWorkedAccordingTimeheet && workedEntireMonth)
            {
                attendanceViewModel.NumberDaysWorked += daysOfWork - numberOfDaysWorkedAccordingTimeheet;
            }
            // If the period worked covers the whole month take the sum of the number of days worked, unpaid paid leave.
            // Otherwise take the maximum number of days that can be worked between the start date and the end date
            attendanceViewModel.MaxNumberOfDaysAllowed = workedEntireMonth ?
                attendanceViewModel.NumberDaysWorked + attendanceViewModel.NumberDaysPaidLeave + attendanceViewModel.NumberDaysNonPaidLeave :
                _servicePeriod.NumberOfDaysWorkedCompanyBetweenDates(startDate, endDate);
            attendanceViewModel.NumberDaysWorked = Math.Round(attendanceViewModel.NumberDaysWorked, NumberConstant.Two);
            attendanceViewModel.NumberDaysPaidLeave = Math.Round(attendanceViewModel.NumberDaysPaidLeave, NumberConstant.Two);
            attendanceViewModel.NumberDaysNonPaidLeave = Math.Round(attendanceViewModel.NumberDaysNonPaidLeave, NumberConstant.Two);
            return attendanceViewModel;
        }

        public override object UpdateModelWithoutTransaction(TimeSheetViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // User want to Change the status 
            TimeSheetViewModel oldTimeSheetViewModel = GetModelAsNoTracked(x => x.Id == model.Id);
            if (oldTimeSheetViewModel.Status == (int)TimeSheetStatusEnumerator.Validated && model.Status != (int)TimeSheetStatusEnumerator.ToReWork)
            {
                // we can not change a status already refused or canceled  
                throw new CustomException(CustomStatusCode.TIMESHEET_UPDATE_VIOLATION);
            }
            CheckTimeSheetDayValidity(model);
            model.Month = new DateTime(model.Month.Year, model.Month.Month, NumberConstant.One);
            if (model.Status != oldTimeSheetViewModel.Status && model.Status == (int)TimeSheetStatusEnumerator.Validated)
            {
                // check if user has the right to validate the request 
                IList<int> hierarchicalEmployeesList = _serviceEmployee.GetHierarchicalEmployeesList(userMail).Select(x => x.Id).ToList();
                if (!hierarchicalEmployeesList.Contains(model.IdEmployee))
                {
                    throw new CustomException(CustomStatusCode.HAVENOT_PERMISSION_FORVLIDATE_OR_REFUSE);
                }
                else
                {   // Get connected user
                    UserViewModel currentUser = _serviceEmployee.GetUserByUserMail(userMail);
                    // Set TreatedBy by the IdEmployee related to the current user
                    model.IdEmployeeTreated = currentUser != null ? currentUser.IdEmployee.Value : throw new ArgumentException("");
                    model.TreatmentDate = DateTime.Now;
                }
            }
            // Send notif for timesheet submission
            if (model.Status != oldTimeSheetViewModel.Status && model.Status == (int)TimeSheetStatusEnumerator.Sended)
            {
                EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
                SendNotifForTimesheetSubmission(userMail, connectedEmployee, model.Id);
            }
            ManageTimeSheetAttachementFile(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// It allows to mark a CRA in the state to be corrected
        /// </summary>
        /// <param name="idTimeSheet"></param>
        /// <param name="userMail"></param>
        public void TimeSheetFixRequest(int idTimeSheet, string userMail)
        {
            TimeSheet timeSheet = _entityRepo.GetSingleWithRelationsNotTracked(m => m.Id.Equals(idTimeSheet),
                m => m.TimeSheetLine,
                m => m.IdEmployeeNavigation);
            //m => m.Document
            if (!(RoleHelper.HasPermission("CORRECT_TIMESHEET") || _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(timeSheet.IdEmployee)))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
            //if (timeSheet.Document.Any(d => d.DocumentTypeCode == DocumentEnumerator.SalesInvoice && d.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft))
            //{
            //    throw new CustomException(CustomStatusCode.CANNOT_MAKE_FIX_REQUEST);
            //}
            timeSheet.Status = (int)TimeSheetStatusEnumerator.ToReWork;
            timeSheet.TimeSheetLine.ToList().ForEach(m => m.Valid = false);
            // update collection entity                
            UpdateCollections(timeSheet, userMail);
            // update entity
            _entityRepo.Update(timeSheet);
            //Send mail 
            SendMailAndNotifForTimesheetCorrection(userMail, _reducedTimeSheetBuilder.BuildEntity(timeSheet));
            // commit 
            _unitOfWork.Commit();
        }

        /// <summary>
        /// It allows us to mark a set of timesheets to be corrected state 
        /// </summary>
        /// <param name="listOfTimesheets"></param>
        /// <param name="userMail"></param>
        public void MassiveTimeSheetFixRequest(List<int> listOfTimesheets, string userMail)
        {
            listOfTimesheets.ForEach(id =>
            {
                TimeSheetViewModel timeSheet = GetModelById(id);
                if (timeSheet.Document.Any())
                {
                    throw new CustomException(CustomStatusCode.CANNOT_MAKE_FIX_REQUEST);
                }
                timeSheet.Status = (int)TimeSheetStatusEnumerator.ToReWork;
                timeSheet.TimeSheetDay.Select(x => { x.TimeSheetLine.Select(m => { m.Valid = false; m.IdTimeSheetNavigation = null; return m; }).ToList(); return x; }).ToList();
                ValidateTimeSheet(timeSheet, userMail);
            });
        }
        /// <summary>
        /// Ensures non-overlapping schedules of CRA lines for a day
        /// </summary>
        /// <param name="model"></param>
        private void CheckTimeSheetDayValidity(TimeSheetViewModel model)
        {
            if (model.Month.Date.AfterDate(DateTime.Now.Date))
            {
                throw new CustomException(CustomStatusCode.CANT_ADD_NEXT_MONTH_TIMESHEET);
            }
            CompanyViewModel companyViewModel = GetCurrentCompany();
            // Get first day of current month
            DateTime startDate = new DateTime(model.Month.Year, model.Month.Month, NumberConstant.One);
            // Get last day of current month
            DateTime endDate = startDate.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One);

            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(startDate, endDate);

            model.TimeSheetDay.ToList().ForEach(timeSheetDayViewModel =>
            {
                IEnumerator<TimeSheetLineViewModel> enumerator = timeSheetDayViewModel.TimeSheetLine
                    .Where(m => !m.IsDeleted && !m.IdDayOff.HasValue)
                    .OrderBy(line => line.StartTime)
                    .GetEnumerator();
                if (enumerator.MoveNext())
                {
                    PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(m => timeSheetDayViewModel.Day.BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                    IList<HoursViewModel> hoursViewModels = curentPeriod.Hours.OrderBy(m => m.StartTime).ToList();
                    TimeSheetLineViewModel previousLine = enumerator.Current;
                    if (!previousLine.StartTime.Equals(hoursViewModels.First().StartTime) && !timeSheetDayViewModel.Hollidays)
                    {
                        IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                        {
                            { RHConstant.Date, previousLine.Day.Date },
                            { nameof(TimeSheetLineViewModel.StartTime), hoursViewModels.First().StartTime },
                            { nameof(TimeSheetLineViewModel.EndTime), hoursViewModels.Last().EndTime }
                        };
                        throw new CustomException(CustomStatusCode.TIMESHEETDAYDOESNTCOVERHOURS, errorParams);
                    }
                    if (!timeSheetDayViewModel.Hollidays)
                    {
                        DayHour dayHour;
                        timeSheetDayViewModel.TimeSheetLine.ToList().ForEach(timeSheetLine =>
                        {
                            dayHour = new DayHour();
                            _servicePeriod.CalculateOnePeriodNumberOfDaysAndHour(dayHour, timeSheetDayViewModel.Day, timeSheetDayViewModel.Day,
                                timeSheetLine.StartTime, timeSheetLine.EndTime, curentPeriod, new List<DateTime> { timeSheetDayViewModel.Day },
                                companyViewModel.TimeSheetPerHalfDay);
                            if (dayHour.DayHourInDecimal.Equals(NumberConstant.Zero))
                            {
                                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                                {
                                    { RHConstant.Date, previousLine.Day.Date }
                                };
                                throw new CustomException(CustomStatusCode.CANNOT_SUBMIT_TIMESHEETLINE_TOTAL_TIME_EQUAL_ZERO, errorParams);
                            }
                        });
                    }
                    while (enumerator.MoveNext())
                    {
                        TimeSheetLineViewModel currentLine = enumerator.Current;
                        if (currentLine.StartTime < previousLine.EndTime)
                        {
                            IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                            {
                                { RHConstant.Date, currentLine.Day.Date }
                            };
                            throw new CustomException(CustomStatusCode.TIMESHEET_LINE_OVERLAP, errorParams);
                        }
                        if (currentLine.StartTime > previousLine.EndTime && !timeSheetDayViewModel.Hollidays &&
                            !curentPeriod.Hours.Any(m => !m.WorkTimeTable && m.EndTime.Equals(currentLine.StartTime) && m.StartTime.Equals(previousLine.EndTime)))
                        {
                            IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                            {
                                { RHConstant.Date, previousLine.Day.Date },
                                { nameof(TimeSheetLineViewModel.StartTime), hoursViewModels.First().StartTime },
                                { nameof(TimeSheetLineViewModel.EndTime), hoursViewModels.Last().EndTime }
                            };
                            throw new CustomException(CustomStatusCode.TIMESHEETDAYDOESNTCOVERHOURS, errorParams);
                        }
                        previousLine = currentLine;
                    }
                    if (!enumerator.Current.EndTime.Equals(hoursViewModels.Last().EndTime) && !timeSheetDayViewModel.Hollidays)
                    {
                        IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                            {
                                { RHConstant.Date, previousLine.Day.Date },
                                { nameof(TimeSheetLineViewModel.StartTime), hoursViewModels.First().StartTime },
                                { nameof(TimeSheetLineViewModel.EndTime), hoursViewModels.Last().EndTime }
                            };
                        throw new CustomException(CustomStatusCode.TIMESHEETDAYDOESNTCOVERHOURS, errorParams);
                    }
                }
            });
        }


        /// <summary>
        /// Validate timesheet
        /// </summary>
        /// <param name="timeSheetViewModel"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public TimeSheetViewModel ValidateTimeSheet(TimeSheetViewModel timeSheetViewModel, string userMail)
        {
            if (!(RoleHelper.HasPermission("VALIDATE_TIMESHEET") || RoleHelper.HasPermission("MASSIVE_VALIDATE_TIMESHEET") || RoleHelper.HasPermission("MASSIVE_FIX_TIMESHEET")
                || _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(timeSheetViewModel.IdEmployee)))
            {
                throw new CustomException(CustomStatusCode.Unauthorized);
            }
            if (timeSheetViewModel.TimeSheetDay.Any(m => m.WaitingLeave.HasValue))
            {
                throw new CustomException(CustomStatusCode.CANT_VALIDATE_TIMESHEET_BECAUSE_WAITING_LEAVE_EXIST);
            }
            CheckTimeSheetDayValidity(timeSheetViewModel);
            EmployeeViewModel connectedEmployee = _serviceEmployee.GetConnectedEmployee(userMail);
            if (connectedEmployee.Id != NumberConstant.Zero)
            {
                timeSheetViewModel.IdEmployeeTreated = connectedEmployee.Id;
            }
            timeSheetViewModel.TreatmentDate = DateTime.Now;
            TimeSheet timeSheet = _builder.BuildModel(timeSheetViewModel);
            // update collection entity                
            UpdateCollections(timeSheet, userMail);
            // update entity
            _entityRepo.Update(timeSheet);
            // commit 
            _unitOfWork.Commit();
            timeSheetViewModel = GetModelAsNoTracked(x => x.Id == timeSheet.Id, x => x.IdEmployeeNavigation, x => x.IdEmployeeTreatedNavigation);
            SendMailAndNotifForTimesheetValidation(userMail, connectedEmployee, timeSheetViewModel);
            return timeSheetViewModel;
        }

        /// <summary>
        /// Validate timesheet and all lines (timesheet with state submited or partially validated)
        /// </summary>
        /// <param name="timeSheetId"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object DefinitiveValidateTimeSheet(int idTimeSheet, string userMail)
        {
            TimeSheetViewModel timeSheet = GetModelById(idTimeSheet);
            int idOfConnectedEmployee = ActiveAccountHelper.GetConnectedUserCredential().IdEmployee ?? NumberConstant.Zero;
            if (idOfConnectedEmployee != NumberConstant.Zero && idOfConnectedEmployee == timeSheet.IdEmployee)
            {
                throw new CustomException(CustomStatusCode.ConnectedUserCannotValidateHisRequest);
            }
            timeSheet.TimeSheetDay.Select(x => { x.TimeSheetLine.Select(y => { y.IdTimeSheetNavigation = null; y.IdDayOffNavigation = null; y.Valid = true; return y; }).ToList(); return x; }).ToList();
            timeSheet.Status = (int)TimeSheetStatusEnumerator.Validated;
            return ValidateTimeSheet(timeSheet, userMail);
        }

        public bool CheckUserIsTeamManagerOrUpperHierrarchy(int idEmployee, string userMail)
        {
            return _serviceEmployee.CheckUserIsTeamManagerOrUpperHierrarchy(idEmployee, userMail);
        }

        /// <summary>
        /// Prepare Mail body depending with the timsheet state
        /// </summary>
        /// <param name="emailConstant"></param>
        /// <param name="timeSheet"></param>
        /// <returns></returns>
        public string checkInfoType(ReducedTimeSheetViewModel timeSheet)
        {
            string informationType = "";
            if (timeSheet.Id == NumberConstant.Zero)
            {
                informationType = Constants.TIMESHEET_SUBMISSION_REQUEST;
            }
            else
            {
                switch (timeSheet.Status)
                {
                    case (int)TimeSheetStatusEnumerator.Draft:
                        informationType = Constants.TIMESHEET_FILL_REQUEST;
                        break;

                    case (int)TimeSheetStatusEnumerator.ToReWork:
                        informationType = Constants.TIMESHEET_CORRECTION_REQUEST;
                        break;
                    case (int)TimeSheetStatusEnumerator.Sended:
                        informationType = Constants.TIMESHEET_VALIDATION_REQUEST;
                        break;
                    case (int)TimeSheetStatusEnumerator.PartiallyValidated:
                        informationType = Constants.TIMESHEET_VALIDATION_REQUEST;
                        break;
                    default:
                        break;
                }
            }
            return informationType;
        }


        /// <summary>
        /// Manage timesheet file attachement
        /// </summary>
        /// <param name="timeSheetViewModel"></param>
        private void ManageTimeSheetAttachementFile(TimeSheetViewModel timeSheetViewModel)
        {
            if (string.IsNullOrEmpty(timeSheetViewModel.AttachementFile))
            {
                if (timeSheetViewModel.TimeSheetFileInfo != null && timeSheetViewModel.TimeSheetFileInfo.Count != NumberConstant.Zero)
                {
                    EmployeeViewModel employee = _serviceEmployee.GetModelById(timeSheetViewModel.IdEmployee);
                    timeSheetViewModel.AttachementFile = Path.Combine(RHConstant.RhFileRootPath + employee.FirstName + employee.LastName, Guid.NewGuid().ToString());
                    CopyFiles(timeSheetViewModel.AttachementFile, timeSheetViewModel.TimeSheetFileInfo);
                }
            }
            else
            {
                if (timeSheetViewModel.TimeSheetFileInfo != null)
                {
                    DeleteFiles(timeSheetViewModel.AttachementFile, timeSheetViewModel.TimeSheetFileInfo);
                    CopyFiles(timeSheetViewModel.AttachementFile, timeSheetViewModel.TimeSheetFileInfo);
                }
            }
        }

        /// <summary>
        /// Retrieve the employee's timeSheet as a parameter for the current month. If the employee has already returned one
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public TimeSheetViewModel GetEmployeeTimeSheet(int idEmployee, DateTime month)
        {
            if (idEmployee.Equals(NumberConstant.Zero))
            {
                throw new ArgumentException("");
            }
            EmployeeViewModel employeeViewModel = _serviceEmployee.GetModelAsNoTracked(m => m.Id.Equals(idEmployee));
            // Get first day of current month
            DateTime startDate = employeeViewModel != null && employeeViewModel.HiringDate.AfterDate(month.FirstDateOfMonth()) ? employeeViewModel.HiringDate : month.FirstDateOfMonth();
            // Get last day of current month
            DateTime endDate = employeeViewModel.ResignationDate.HasValue
                && employeeViewModel.ResignationDate.Value.BeforeDateLimitIncluded(startDate.LastDateOfMonth()) ?
                employeeViewModel.ResignationDate.Value : startDate.LastDateOfMonth();
            return CreateEmployeeCurrentMonthTimeSheet(idEmployee, employeeViewModel.ResignationDate, startDate, endDate);
        }

        /// <summary>
        /// Returns a new Timesheet for the employee for the current month if he does not have one. 
        /// If not, returned the one he has already submitted in the meantime
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        private TimeSheetViewModel CreateEmployeeCurrentMonthTimeSheet(int idEmployee, DateTime? resignationDate, DateTime startDate, DateTime endDate)
        {
            TimeSheetViewModel timeSheetViewModel;
            PeriodViewModel curentPeriod;
            CompanyViewModel companyViewModel = GetCurrentCompany();
            DateTime month = new DateTime(startDate.Year, startDate.Month, NumberConstant.One);
            // Get the default project
            List<ProjectViewModel> defaultProject = _serviceProject.FindModelBy(model => model.Default.Equals(true)).OrderBy(x => x.Name).ToList();
            // Check if user have any time sheet for the current month
            TimeSheet timeSheet = _entityRepo.GetAllWithConditionsRelationsQueryable(model => model.IdEmployee.Equals(idEmployee)
                && DateTime.Compare(model.Month, month).Equals(NumberConstant.Zero)).Include(model => model.TimeSheetLine)
                .ThenInclude(model => model.IdLeaveNavigation).ThenInclude(model => model.IdLeaveTypeNavigation).FirstOrDefault();
            bool isConnectedUserInHierarchy = _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(idEmployee);
            if (timeSheet != null)
            {
                timeSheetViewModel = _builder.BuildEntity(timeSheet);
                timeSheetViewModel.IsConnectedUserInHierarchy = isConnectedUserInHierarchy;
                return GetExistingTimeSheet(timeSheetViewModel);
            }
            // Else this employee hasn't any timesheet for the current month, create new one for him
            else
            {
                // Create new Timesheet for this employee and associate the current month
                timeSheetViewModel = new TimeSheetViewModel
                {
                    IdEmployee = idEmployee,
                    Month = month,
                    TimeSheetDay = new List<TimeSheetDayViewModel>(),
                    ResignationDateEmployee = resignationDate,
                    IsConnectedUserInHierarchy = isConnectedUserInHierarchy
                };
                // Get list of the periods crossed by the startDate and endDate
                IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(startDate, endDate);
                IList<DateTime> timesheetListDates = startDate.AllDatesUntilLimitIncluded(endDate);
                // Get employee leaves
                IList<Leave> employeeMonth = _repoLeave.GetAllWithConditionsRelations(model => model.IdEmployee == idEmployee &&
                 (model.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted ||  model.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting),
                 model => model.IdLeaveTypeNavigation).ToList();
                IList<Leave> employeeMonthLeaves = employeeMonth.Where(model => timesheetListDates.Any(x => x.BetweenDateLimitIncluded(model.StartDate, model.EndDate))).ToList();

                // fetch accepted leaves
                IList<Leave> acceptedLeaves = employeeMonthLeaves.Where(x => x.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted).ToList();
                // fetch accepted leaves
                IList<Leave> waintingLeaves = employeeMonthLeaves.Where(x => x.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting).ToList();
                // Add new TimeSheet Line for each day of current month
                List<DateTime> dateTimes = startDate.AllDatesUntilLimitIncluded(endDate).ToList();
                // Get the list of employee assignments to projects during the current month
                IList<EmployeeProjectViewModel> employeeProjectViewModels = _serviceProject.EmployeeAssignedProjectIncludedInDates(idEmployee, dateTimes);
                // Initialize concurrent Bag for contain list of timesheet day
                ConcurrentBag<TimeSheetDayViewModel> concurrentBag = new ConcurrentBag<TimeSheetDayViewModel>();
                Parallel.ForEach(dateTimes, currentDate =>
                {
                    // Get period of the current start date
                    curentPeriod = periodViewModels.FirstOrDefault(model => DateTime.Compare(currentDate.Date, model.StartDate.Date) >= NumberConstant.Zero
                    && DateTime.Compare(currentDate.Date, model.EndDate.Date) <= NumberConstant.Zero);
                    TimeSheetDayViewModel timeSheetDayViewModel = new TimeSheetDayViewModel
                    {
                        Day = currentDate,
                        Hollidays = (int)currentDate.DayOfWeek < curentPeriod.FirstDayOfWork || (int)currentDate.DayOfWeek > curentPeriod.LastDayOfWork,
                        WeekNumberInYear = CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(currentDate, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday)
                    };
                    // Check if a waiting leave is not defined at this date. If this is the case, mark this day as likely to produce errors
                    List<Leave> currentDateWaitingLeaveLeaves = waintingLeaves.Where(model => currentDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).ToList();
                    SetLeaveWaitingStatusInTimeSheetDay(timeSheetDayViewModel, currentDateWaitingLeaveLeaves);
                    // The list of possible times for this day
                    timeSheetDayViewModel.Hours = _servicePeriod.GetHoursPeriodOfDate(curentPeriod.Hours.ToList(), companyViewModel.TimeSheetPerHalfDay);
                    // Get list of projects assigned to the employee on this date
                    List<ProjectViewModel> projectViewModels = employeeProjectViewModels.Where(x =>
                            (x.AssignmentDate.Value.BeforeDateLimitIncluded(currentDate) && !x.UnassignmentDate.HasValue) ||
                            (x.UnassignmentDate.HasValue && currentDate.BetweenDateLimitIncluded(x.AssignmentDate.Value, x.UnassignmentDate.Value.PreviousDate())))
                        .Select(x => _timeSheetLineBuilder.BuildProjectDay(x.IdProjectNavigation)).ToList();
                    if (projectViewModels.Any())
                    {
                        // Order the list of projects
                        projectViewModels = (from project in projectViewModels
                                             orderby !string.IsNullOrEmpty(project.ProjectLabel) ? project.ProjectLabel : project.Name
                                             select project).ToList();
                    }
                    projectViewModels.AddRange(defaultProject);
                    timeSheetDayViewModel.Project = projectViewModels;
                    if (curentPeriod.DayOff != null && curentPeriod.DayOff.Any(dayOff => dayOff.Date.EqualsDate(currentDate)))
                    {
                        CreateDayOffTimeSheetLine(timeSheetDayViewModel, curentPeriod, curentPeriod.DayOff.FirstOrDefault(dayOff => dayOff.Date.EqualsDate(currentDate)));
                    }
                    else
                    {
                        IList<Leave> currentDateAcceptedLeaves = acceptedLeaves.Where(model => currentDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).ToList();
                        CreateValidTimeSheetLine(timeSheetDayViewModel, curentPeriod, currentDate, companyViewModel.TimeSheetPerHalfDay, currentDateAcceptedLeaves);
                    }
                    concurrentBag.Add(timeSheetDayViewModel);
                });
                timeSheetViewModel.TimeSheetDay = concurrentBag.OrderBy(x => x.Day).ToList();
            }
            return timeSheetViewModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="timeSheetDayViewModel"></param>
        /// <param name="dayOffViewModel"></param>
        private void CreateDayOffTimeSheetLine(TimeSheetDayViewModel timeSheetDayViewModel, PeriodViewModel periodViewModel, DayOffViewModel dayOffViewModel)
        {
            TimeSheetLineViewModel timeSheetLineViewModel = _timeSheetLineBuilder.BuildEntity(new TimeSheetLine
            {
                Day = dayOffViewModel.Date,
            });
            if (timeSheetDayViewModel.Project.Any())
            {
                timeSheetLineViewModel.IdProject = timeSheetDayViewModel.Project.FirstOrDefault().Id;
            }
            timeSheetLineViewModel.IdDayOff = dayOffViewModel.Id;
            timeSheetLineViewModel.IdDayOffNavigation = dayOffViewModel;
            timeSheetLineViewModel.StartTime = timeSheetDayViewModel.Hours.FirstOrDefault().Value;
            timeSheetLineViewModel.EndTime = (int)dayOffViewModel.Date.DayOfWeek < periodViewModel.FirstDayOfWork || (int)dayOffViewModel.Date.DayOfWeek > periodViewModel.LastDayOfWork
            ? timeSheetDayViewModel.Hours.FirstOrDefault().Value : timeSheetDayViewModel.Hours.LastOrDefault().Value;
            timeSheetDayViewModel.TimeSheetLine.Add(timeSheetLineViewModel);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="timeSheetDayViewModel"></param>
        /// <param name="periodViewModel"></param>
        /// <param name="date"></param>
        /// <param name="idEmployee"></param>
        private void CreateValidTimeSheetLine(TimeSheetDayViewModel timeSheetDayViewModel, PeriodViewModel periodViewModel, DateTime date, bool timeSheetPerHalfDay, IList<Leave> leaves = null)
        {
            int counter = NumberConstant.Zero;
            if (leaves != null)
            {
                do
                {
                    TimeSheetLineViewModel timeSheetLineViewModel = _timeSheetLineBuilder.BuildEntity(new TimeSheetLine
                    {
                        Day = date,
                    });
                    if (timeSheetDayViewModel.Project.Any())
                    {
                        timeSheetLineViewModel.IdProject = timeSheetDayViewModel.Project.FirstOrDefault().Id;
                    }
                    if (counter >= leaves.Count || timeSheetDayViewModel.Hollidays)
                    {
                        timeSheetLineViewModel.StartTime = timeSheetDayViewModel.Hours.FirstOrDefault().Value;
                        timeSheetLineViewModel.EndTime = (int)date.DayOfWeek < periodViewModel.FirstDayOfWork || (int)date.DayOfWeek > periodViewModel.LastDayOfWork
                        ? timeSheetDayViewModel.Hours.FirstOrDefault().Value : timeSheetDayViewModel.Hours.LastOrDefault().Value;
                    }
                    else
                    {
                        Leave leave = leaves[counter];
                        timeSheetLineViewModel.IdLeave = leave.Id;
                        timeSheetLineViewModel.StartTime = leave.StartDate.EqualsDate(timeSheetDayViewModel.Day) ? leave.StartTime : timeSheetDayViewModel.Hours.FirstOrDefault().Value;
                        timeSheetLineViewModel.EndTime = leave.EndDate.EqualsDate(timeSheetDayViewModel.Day) ? leave.EndTime : timeSheetDayViewModel.Hours.LastOrDefault().Value;
                        timeSheetLineViewModel.Worked = leave.IdLeaveTypeNavigation.Worked;
                        timeSheetLineViewModel.WaitingLeaveTypeName = leave.IdLeaveTypeNavigation.Label;
                    }
                    if (counter >= leaves.Count || timeSheetDayViewModel.Hollidays || (timeSheetLineViewModel.Worked.HasValue && timeSheetLineViewModel.Worked.Value))
                    {
                        DayHour dayHour = _servicePeriod.CalculateDateHourNumber(periodViewModel.Hours.ToList(),
                            timeSheetLineViewModel.StartTime, timeSheetLineViewModel.EndTime, timeSheetPerHalfDay);
                        timeSheetLineViewModel.DayHour = dayHour;
                    }
                    timeSheetDayViewModel.TimeSheetLine.Add(timeSheetLineViewModel);
                    counter++;
                }
                while (counter < leaves.Count);
            }
            else
            {
                TimeSheetLineViewModel timeSheetLineViewModel = _timeSheetLineBuilder.BuildEntity(new TimeSheetLine
                {
                    Day = date,
                });
                if (timeSheetDayViewModel.Project.Any())
                {
                    timeSheetLineViewModel.IdProject = timeSheetDayViewModel.Project.FirstOrDefault().Id;
                }
                timeSheetLineViewModel.StartTime = timeSheetDayViewModel.Hours.FirstOrDefault().Value;
                timeSheetLineViewModel.EndTime = (int)date.DayOfWeek < periodViewModel.FirstDayOfWork || (int)date.DayOfWeek > periodViewModel.LastDayOfWork
                ? timeSheetDayViewModel.Hours.FirstOrDefault().Value : timeSheetDayViewModel.Hours.LastOrDefault().Value;
                DayHour dayHour = _servicePeriod.CalculateDateHourNumber(periodViewModel.Hours.ToList(),
                    timeSheetLineViewModel.StartTime, timeSheetLineViewModel.EndTime, timeSheetPerHalfDay);
                timeSheetLineViewModel.DayHour = dayHour;
                timeSheetLineViewModel.Valid = false;
                timeSheetDayViewModel.TimeSheetLine.Add(timeSheetLineViewModel);
            }
        }

        /// <summary>
        /// Get model by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override TimeSheetViewModel GetModelById(int id)
        {
            TimeSheetViewModel timeSheetViewModel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(model => model.Id.Equals(id),
               model => model.IdEmployeeNavigation)
              .Include(model => model.TimeSheetLine)
              .ThenInclude(model => model.IdLeaveNavigation)
              .ThenInclude(model => model.IdLeaveTypeNavigation)
              .Select(x => _builder.BuildEntity(x))
              .FirstOrDefault();
            if (timeSheetViewModel != null)
            {
                timeSheetViewModel.IsConnectedUserInHierarchy = _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(timeSheetViewModel.IdEmployee);
                List<Document> documents = _repoDocument.GetAllWithConditionsRelationsAsNoTracking(x => x.IdTimeSheet == id && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice).ToList();
                timeSheetViewModel.Document = documents.Select(_documentBuilder.BuildEntity).ToList();
                // get comments related to the current timesheet
                timeSheetViewModel.Comments = _serviceComment.GetComments(nameof(TimeSheet), timeSheetViewModel.IdEmployee);
                return GetExistingTimeSheet(timeSheetViewModel);
            }
            else
            {
                return timeSheetViewModel;
            }
        }


        /// <summary>
        /// Get an existing timesheet. 
        /// Retrieve the existing timesheet line in the database and for the days on which the employee took a leave, add fictitious lines for the front-end visualization
        /// </summary>
        /// <param name="timeSheetViewModel"></param>
        /// <returns></returns>
        private TimeSheetViewModel GetExistingTimeSheet(TimeSheetViewModel timeSheetViewModel)
        {
            DateTime startDate = timeSheetViewModel.Month.FirstDateOfMonth();
            DateTime endDate = timeSheetViewModel.Month.LastDateOfMonth();
            // Get the default project
            List<ProjectViewModel> defaultProject = _timeSheetLineBuilder.BuildProjectDay(_serviceProject.FindModelBy(model => model.Default)).ToList();
            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(startDate, endDate);
            // Get employee leaves
            IList<DateTime> timesheetListDates = startDate.AllDatesUntilLimitIncluded(endDate);
            // Get the list of employee assignments to projects during the current month
            IList<EmployeeProjectViewModel> employeeProjectViewModels = _serviceProject.EmployeeAssignedProjectIncludedInDates(timeSheetViewModel.IdEmployee, timesheetListDates);
            // Get employee waiting, validated and canceled leaves

            IList<Leave> employeeMonth = _repoLeave.GetAllWithConditionsRelations(model => model.IdEmployee == timeSheetViewModel.IdEmployee &&
              model.Status != (int)AdministrativeDocumentStatusEnumerator.Refused,
                model => model.IdLeaveTypeNavigation).ToList();
            IList<Leave> employeeMonthLeaves = employeeMonth.Where(model => timesheetListDates.Any(x => x.BetweenDateLimitIncluded(model.StartDate, model.EndDate))).ToList();

            // fetch accepted leaves
            IList<Leave> canceledLeaves = employeeMonthLeaves.Where(x => x.Status == (int)AdministrativeDocumentStatusEnumerator.Canceled).ToList();
            // fetch accepted leaves
            IList<Leave> waintingLeaves = employeeMonthLeaves.Where(x => x.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting).ToList();
            // fetch accepted leaves
            IList<Leave> acceptedLeaves = employeeMonthLeaves.Where(x => x.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted).ToList();
            CompanyViewModel companyViewModel = GetCurrentCompany();
            var watch = System.Diagnostics.Stopwatch.StartNew();
            Parallel.ForEach(timeSheetViewModel.TimeSheetDay, timeSheetDay =>
            {
                // Get period of the current timesheet day date
                PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(model => timeSheetDay.Day.BetweenDateLimitIncluded(model.StartDate, model.EndDate));
                // Set if this day is hollidays or not 
                timeSheetDay.Hollidays = (int)timeSheetDay.Day.DayOfWeek < curentPeriod.FirstDayOfWork || (int)timeSheetDay.Day.DayOfWeek > curentPeriod.LastDayOfWork;
                // The list of possible times for this day
                timeSheetDay.Hours = _servicePeriod.GetHoursPeriodOfDate(curentPeriod.Hours.ToList(), companyViewModel.TimeSheetPerHalfDay);
                // Get list of projects assigned to the employee on this date
                List<ProjectViewModel> projectViewModels = employeeProjectViewModels.Where(x =>
                        (x.AssignmentDate.Value.BeforeDateLimitIncluded(timeSheetDay.Day) && !x.UnassignmentDate.HasValue) ||
                        (x.UnassignmentDate.HasValue && timeSheetDay.Day.BetweenDateLimitIncluded(x.AssignmentDate.Value, x.UnassignmentDate.Value.PreviousDate())))
                    .Select(x => _timeSheetLineBuilder.BuildProjectDay(x.IdProjectNavigation)).ToList();
                if (projectViewModels.Any())
                {
                    // Order the list of projects
                    projectViewModels = (from project in projectViewModels
                                         orderby !string.IsNullOrEmpty(project.ProjectLabel) ? project.ProjectLabel : project.Name
                                         select project).ToList();
                }
                projectViewModels.AddRange(defaultProject);
                // The list of possible project for this day
                timeSheetDay.Project = projectViewModels;
                timeSheetDay.TimeSheetLine.ToList().ForEach(line =>
                {
                    line.DayHour = _servicePeriod.CalculateDateHourNumber(curentPeriod.Hours.ToList(), line.StartTime, line.EndTime, companyViewModel.TimeSheetPerHalfDay);
                    if (line.IdDayOff.HasValue)
                    {
                        // Check if current date is dayOff 
                        DayOffViewModel dayOffViewModel = curentPeriod.DayOff.FirstOrDefault(d => d.Id == line.IdDayOff.Value);
                        // If dayoff doesn't exist anymore, set IdDayOff to null
                        if (dayOffViewModel != null)
                        {
                            line.IdDayOffNavigation = dayOffViewModel;
                        }
                        else
                        {
                            line.IdDayOff = null;
                        }
                    }
                });
                List<Leave> currentDateWaitingLeaves = waintingLeaves.Where(model => timeSheetDay.Day.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).ToList();
                SetLeaveWaitingStatusInTimeSheetDay(timeSheetDay, currentDateWaitingLeaves);
                List<Leave> currentDateCanceledLeaves = canceledLeaves.Where(model => timeSheetDay.Day.BetweenDateLimitIncluded(model.StartDate, model.EndDate) && timeSheetDay.TimeSheetLine.Any(x => x.IdLeave == model.Id)).ToList();
                DeleteCanceledLeaveTimeSheetLine(timeSheetDay, curentPeriod, companyViewModel.TimeSheetPerHalfDay, currentDateCanceledLeaves);
                List<Leave> currentDateAcceptededLeaves = acceptedLeaves.Where(model => timeSheetDay.Day.BetweenDateLimitIncluded(model.StartDate, model.EndDate) && timeSheetDay.TimeSheetLine.All(x => x.IdLeave != model.Id)).ToList();
                AddNewLeaveValidatedTimeSheetLine(timeSheetDay, curentPeriod, companyViewModel.TimeSheetPerHalfDay, currentDateAcceptededLeaves);
                timeSheetDay.TimeSheetLine = timeSheetDay.TimeSheetLine.OrderBy(x => x.StartTime).ToList();
            });
            watch.Stop();
            var elapsedMs = watch.ElapsedMilliseconds;
            timeSheetViewModel.TimeSheetFileInfo = GetFiles(timeSheetViewModel.AttachementFile).ToList();
            return timeSheetViewModel;
        }

        /// <summary>
        /// For any validated leave forming part of the CRA, which has been canceled,
        /// deleted the corresponding timeSheetLine
        /// </summary>
        /// <param name="timeSheetDayViewModel"></param>
        private void DeleteCanceledLeaveTimeSheetLine(TimeSheetDayViewModel timeSheetDayViewModel, PeriodViewModel curentPeriod, bool timeSheetPerHalfDay, List<Leave> currentDateCanceledLeaves)
        {
            timeSheetDayViewModel.TimeSheetLine.Select(x =>
            {
                if (currentDateCanceledLeaves.Any(m => m.Id == x.IdLeave))
                {
                    x.IsDeleted = true;
                }
                return x;
            }).ToList();
            if (!timeSheetDayViewModel.TimeSheetLine.Any() || timeSheetDayViewModel.TimeSheetLine.All(m => m.IsDeleted))
            {
                // Add the line of this leave as TimeSheetLine
                CreateValidTimeSheetLine(timeSheetDayViewModel, curentPeriod, timeSheetDayViewModel.Day, timeSheetPerHalfDay);
            }
        }

        /// <summary>
        /// Add the new CRA lines corresponding to the new validated leaves of this employee
        /// </summary>
        /// <param name="timeSheetDayViewModel"></param>
        /// <param name="idEmployee"></param>
        private void AddNewLeaveValidatedTimeSheetLine(TimeSheetDayViewModel timeSheetDayViewModel, PeriodViewModel periodViewModel, bool timeSheetPerHalfDay, IList<Leave> leaves)
        {
            if (leaves.Any() && !timeSheetDayViewModel.Hollidays && !timeSheetDayViewModel.TimeSheetLine.Any(m => m.IdDayOff.HasValue))
            {
                // Add the line of this leave as TimeSheetLine
                CreateValidTimeSheetLine(timeSheetDayViewModel, periodViewModel, timeSheetDayViewModel.Day, timeSheetPerHalfDay, leaves);
            }
        }

        /// <summary>
        /// If the day in question has a waiting leave, report it
        /// </summary>
        /// <param name="timeSheetDayViewModel"></param>
        /// <param name="idEmployee"></param>
        private void SetLeaveWaitingStatusInTimeSheetDay(TimeSheetDayViewModel timeSheetDayViewModel, List<Leave> leaves)
        {
            if (leaves.Any() && !timeSheetDayViewModel.Hollidays && !timeSheetDayViewModel.TimeSheetLine.Any(m => m.IdDayOff.HasValue))
            {
                timeSheetDayViewModel.WaitingLeave = leaves.FirstOrDefault().Id;
                timeSheetDayViewModel.WaitingLeaveTypeName = leaves.FirstOrDefault().IdLeaveTypeNavigation.Label;
            }
        }

        /// <summary>
        /// Return a non-submissible Timesheet
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        private TimeSheetViewModel CreatePreviousMonthTimeSheet(int idEmployee, DateTime? resignationDate, DateTime startDate, DateTime endDate)
        {
            // Create new Timesheet for this employee and associate the current month
            TimeSheetViewModel timeSheetViewModel = new TimeSheetViewModel
            {
                IdEmployee = idEmployee,
                Month = startDate,
                TimeSheetDay = new List<TimeSheetDayViewModel>(),
                ResignationDateEmployee = resignationDate
            };
            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(timeSheetViewModel.Month, timeSheetViewModel.Month.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One));
            IList<DateTime> timesheetListDates = startDate.AllDatesUntilLimitIncluded(endDate);
            IList<Leave> employeeMonth = _repoLeave.GetAllWithConditionsRelations(model => model.IdEmployee == idEmployee &&
                       model.Status == (int)AdministrativeDocumentStatusEnumerator.Waiting, model => model.IdLeaveTypeNavigation).ToList();
            IList<Leave> waintingLeaves = employeeMonth.Where(model => timesheetListDates.Any(x => x.BetweenDateLimitIncluded(model.StartDate, model.EndDate))).ToList();

            List<DateTime> dateTimes = startDate.AllDatesUntilLimitIncluded(endDate).ToList();
            // Initialize concurrent Bag for contain list of timesheet day
            ConcurrentBag<TimeSheetDayViewModel> concurrentBag = new ConcurrentBag<TimeSheetDayViewModel>();
            // Add new TimeSheet Line for each day of current month
            Parallel.ForEach(dateTimes, currentDate =>
            {
                // Get period of the current timesheet day date
                PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(model => currentDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate));
                TimeSheetDayViewModel timeSheetDayViewModel = new TimeSheetDayViewModel
                {
                    Day = currentDate,
                    Hollidays = (int)currentDate.DayOfWeek < curentPeriod.FirstDayOfWork || (int)currentDate.DayOfWeek > curentPeriod.LastDayOfWork,
                    WeekNumberInYear = CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(currentDate, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday)
                };
                List<Leave> currentDateWaitingLeaveLeaves = waintingLeaves.Where(model => currentDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).ToList();
                SetLeaveWaitingStatusInTimeSheetDay(timeSheetDayViewModel, currentDateWaitingLeaveLeaves);
                concurrentBag.Add(timeSheetDayViewModel);
            });
            timeSheetViewModel.TimeSheetDay = concurrentBag.OrderBy(x => x.Day).ToList();
            return timeSheetViewModel;
        }

        /// <summary>
        /// Returns the list of Timesheets of the year in parameter for the employee in parameter
        /// if the employee does not have a Timesheet for certain months, fictitious Timesheets are generated
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public IList<TimeSheetViewModel> GetYearTimeSheet(int idEmployee, DateTime year)
        {
            // Timesheet already generated for the employee in parameter for the year in parameter
            IList<TimeSheetViewModel> timeSheetViewModels;
            if (year.Year > DateTime.Now.Year)
            {
                return new List<TimeSheetViewModel>();
            }
            else
            {
                EmployeeViewModel employeeViewModel = _serviceEmployee.GetModelById(idEmployee);
                DateTime firstMonth = new DateTime(year.Year, NumberConstant.One, NumberConstant.One);
                DateTime lastMonth;
                lastMonth = year.Year == DateTime.Now.Year ?
                  new DateTime(year.Year, DateTime.Now.Month, NumberConstant.One).AddMonths(NumberConstant.One).AddDays(-NumberConstant.One)
                : year.LastDateOfYear();
                if (employeeViewModel.HiringDate.BetweenDateLimitIncluded(firstMonth, lastMonth))
                {
                    firstMonth = employeeViewModel.HiringDate.FirstDateOfMonth();
                }
                else if (employeeViewModel.HiringDate.AfterDate(lastMonth))
                {
                    return new List<TimeSheetViewModel>();
                }
                if (employeeViewModel.ResignationDate.HasValue && employeeViewModel.ResignationDate.Value.BetweenDateLimitIncluded(firstMonth, lastMonth))
                {
                    lastMonth = employeeViewModel.ResignationDate.Value;
                }
                IList<PeriodViewModel> periodViewModels = _servicePeriod.GetExistingPeriodCrossBy(firstMonth, lastMonth);
                timeSheetViewModels = FindModelsByNoTracked(model => model.IdEmployee.Equals(idEmployee) && model.Month.Year.Equals(lastMonth.Year),
                    model => model.TimeSheetLine).ToList();
                timeSheetViewModels.ToList().ForEach(model =>
                {
                    _serviceTimeSheetCountDays.CalculateTimeSheetDaysHours(model, GetCurrentCompany().TimeSheetPerHalfDay, periodViewModels);
                });
                while (firstMonth.BeforeDateLimitIncluded(lastMonth))
                {
                    if (!timeSheetViewModels.Any(model => model.Month.EqualsDate(firstMonth)))
                    {
                        timeSheetViewModels.Add(new TimeSheetViewModel
                        {
                            IdEmployee = idEmployee,
                            Month = firstMonth,
                            NumberOfDaysDayHour = new NumberOfDaysDayHour()
                        });
                    }
                    firstMonth = firstMonth.AddMonths(NumberConstant.One);
                }
            }
            bool isConnectedUserInHierarchy = _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(idEmployee);
            return timeSheetViewModels.OrderByDescending(model => model.Month).Select(x => { x.IsConnectedUserInHierarchy = isConnectedUserInHierarchy; return x; }).ToList();
        }

        /// <summary>
        /// Returns the number of days worked by an employee according to the month in parameter
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="dateTime"></param>
        public NumberOfDaysDayHour GetNumberOfDayWorkedPerContract(DateTime startDate, DateTime endDate, int idEmployee, DateTime month)
        {
            TimeSheet timeSheet = _entityRepo.GetAllAsNoTracking().Include(m => m.TimeSheetLine).ThenInclude(m => m.IdLeaveNavigation).ThenInclude(m => m.IdLeaveTypeNavigation)
                                            .Where(m => m.IdEmployee.Equals(idEmployee) && m.Month.EqualsDate(month.FirstDateOfMonth()))
                                            .FirstOrDefault();
            TimeSheetViewModel timeSheetViewModel = GetExistingTimeSheet(_builder.BuildEntity(timeSheet));
            PeriodViewModel currentDatePeriod = default;
            int previousPeriodId = default;
            CompanyViewModel companyViewModel = GetCurrentCompany();
            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(timeSheetViewModel.Month.Date,
                timeSheetViewModel.Month.Date.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One));
            timeSheetViewModel.TimeSheetDay.AsQueryable()
                .Where(m => m.Day.Date.BetweenDateLimitIncluded(startDate.Date, endDate.Date)).ToList().ForEach(timeSheetDay =>
            {
                currentDatePeriod = periodViewModels.FirstOrDefault(m => timeSheetDay.Day.Date.BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                timeSheetDay.TimeSheetLine.ToList().ForEach(timeSheetLine =>
                {
                    DayHour dayHour = _servicePeriod.CalculateDateHourNumber(currentDatePeriod.Hours.ToList(), timeSheetLine.StartTime, timeSheetLine.EndTime,
                        companyViewModel.TimeSheetPerHalfDay);
                    if (timeSheetLine.IdLeave.HasValue && !timeSheetLine.IdLeaveNavigation.IdLeaveTypeNavigation.Worked)
                    {
                        if (timeSheetLine.IdLeaveNavigation.IdLeaveTypeNavigation.Paid)
                        {
                            timeSheetViewModel.NumberOfDaysDayHour.NumberOfPaidLeavesDays.Add(dayHour);
                        }
                        else
                        {
                            timeSheetViewModel.NumberOfDaysDayHour.NumberOfUnPaidLeavesDays.Add(dayHour);
                        }
                        timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays.Add(dayHour);
                    }
                    else
                    {
                        timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Add(dayHour);
                    }
                    if (timeSheetLine.IdDayOff.HasValue)
                    {
                        timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff.Day += NumberConstant.One;
                    }
                });
                // This indicates a change of period during the month concerned
                if (previousPeriodId != currentDatePeriod.Id && previousPeriodId != default)
                {
                    PeriodViewModel lastPeriodViewModel = periodViewModels.First(x => x.Id == previousPeriodId);
                    double currentPeriodHour = _servicePeriod.CalculateHourNumber(lastPeriodViewModel.Hours);
                    _servicePeriod.DayHourRound(timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked, currentPeriodHour);
                    _servicePeriod.DayHourRound(timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff, currentPeriodHour);
                    _servicePeriod.DayHourRound(timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays, currentPeriodHour);
                    _servicePeriod.DayHourRound(timeSheetViewModel.NumberOfDaysDayHour.NumberOfPaidLeavesDays, currentPeriodHour);
                    _servicePeriod.DayHourRound(timeSheetViewModel.NumberOfDaysDayHour.NumberOfUnPaidLeavesDays, currentPeriodHour);
                }
                previousPeriodId = currentDatePeriod.Id;
            });
            double numberOfHour = _servicePeriod.CalculateHourNumber(currentDatePeriod.Hours);
            _servicePeriod.NumberOfDaysDayHourRound(timeSheetViewModel.NumberOfDaysDayHour, numberOfHour);
            // Subtract from working days, dayoffs because they are not paid
            if (timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Day > NumberConstant.Zero &&
                timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff.Day > NumberConstant.Zero)
            {
                timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Day -= timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff.Day;
            }
            return timeSheetViewModel.NumberOfDaysDayHour;
        }





        /// <summary>
        /// Calculate the number of hours from the selected intervals on the front
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public DayHour TimeValueChange(DateTime date, TimeSpan startTime, TimeSpan endTime)
        {
            DayHour dayHour = _servicePeriod.CalculateDateHourNumber(_servicePeriod.GetPeriodOfDate(date).Hours.ToList(), startTime, endTime,
                                                                     GetCurrentCompany().TimeSheetPerHalfDay);
            return dayHour;
        }

        public override DataSourceResult<TimeSheetViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicate)
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            PredicateFilterRelationViewModel<TimeSheet> predicateFilterRelationModel = PreparePredicate(predicate);
            // Get All TimeSheet view Models
            IList<TimeSheetViewModel> timeSheetViewModels = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                                            .Include(model => model.TimeSheetLine)
                                                            .OrderByRelation(predicate.OrderBy)
                                                            .Where(predicateFilterRelationModel.PredicateWhere)
                                                            .ToList()
                                                            .Select(x => _builder.BuildEntity(x)).ToList();
            timeSheetViewModels.ToList().ForEach(model =>
            {
                _serviceTimeSheetCountDays.CalculateTimeSheetDaysHours(timeSheetViewModel: model, halfDay: companyViewModel.TimeSheetPerHalfDay);
            });
            DataSourceResult<TimeSheetViewModel> dataSourceResult = new DataSourceResult<TimeSheetViewModel>();
            dataSourceResult.total = timeSheetViewModels.Count;
            dataSourceResult.data = timeSheetViewModels;
            return dataSourceResult;
        }

        /// <summary>
        /// Get employees timesheets
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="predicate"></param>
        /// <param name="isAdmin"></param>
        /// <returns></returns>
        public DataSourceResult<TimeSheetViewModel> GetEmployeeTimeSheetRequests(string userMail, PredicateFormatViewModel predicate, bool isAdmin)
        {
            DataSourceResult<TimeSheetViewModel> dataSourceResult = new DataSourceResult<TimeSheetViewModel>();
            List<EmployeeViewModel> employeesList = new List<EmployeeViewModel>();

            employeesList = GetEmployeesWithSpecificConditions(userMail, predicate, isAdmin);
            // Get employees ids
            List<int> employeesListIds = employeesList.Select(y => y.Id).ToList();

            predicate.Operator = Operator.And;
            Expression<Func<TimeSheet, bool>> timeSheetPredicate = x => employeesListIds.Distinct().Contains(x.IdEmployee);
            PredicateFilterRelationViewModel<TimeSheet> predicateFilterRelationModel = PreparePredicate(predicate);

            // Get list of timesheets for employees if it exists
            IQueryable<TimeSheet> timeSheetQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(timeSheetPredicate, predicateFilterRelationModel.PredicateRelations)
                                .Include(model => model.TimeSheetLine)
                                .Include(model => model.IdEmployeeNavigation)
                                .Where(predicateFilterRelationModel.PredicateWhere)
                                .BuildOrderBysQue(predicate.OrderBy)
                                .Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize);

            PredicateFormatViewModel predicateWithNotToDoStatus = new PredicateFormatViewModel();
            List<int> idsEmployeeWithNotToDoStatus = new List<int>();
            // If there is status to do from predicate, create another query to get emlpoyees which have stored timesheet
            if ((predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Status)) == NumberConstant.Zero) || (predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Status)) != NumberConstant.Zero
                   && predicate.Filter.Where(x => x.Prop == nameof(TimeSheet.Status)).Select(x => Convert.ToInt32(x.Value)).ToList().Contains((int)TimeSheetStatusEnumerator.ToDo)))
            {
                PredicateFilterRelationViewModel<TimeSheet> predicateFilterRelationModelWithStatusNotToDo;
                if (predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Status)) == NumberConstant.Zero)
                {
                    predicateFilterRelationModelWithStatusNotToDo = PreparePredicate(predicate);
                }
                else
                {
                    predicateWithNotToDoStatus.Relation = predicate.Relation;
                    predicateWithNotToDoStatus.Filter = predicate.Filter.Where(x => x.Prop != nameof(TimeSheet.Status)).ToList();
                    predicateWithNotToDoStatus.page = predicate.page;
                    predicateWithNotToDoStatus.pageSize = predicate.pageSize;
                    predicateWithNotToDoStatus.Operator = predicate.Operator;
                    predicateFilterRelationModelWithStatusNotToDo = PreparePredicate(predicateWithNotToDoStatus);
                }
                IQueryable<TimeSheet> timeSheetWithStatusNotToDoQuery = _entityRepo.GetAllWithConditionsRelationsQueryable(timeSheetPredicate, predicateFilterRelationModelWithStatusNotToDo.PredicateRelations)
                                    .Include(model => model.TimeSheetLine)
                                    .Include(model => model.IdEmployeeNavigation)
                                    .Where(predicateFilterRelationModelWithStatusNotToDo.PredicateWhere);
                if (predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Status)) != NumberConstant.Zero)
                {
                    timeSheetWithStatusNotToDoQuery
                                    .Where(model => predicate.Filter.Where(x => x.Prop == nameof(TimeSheet.Status) && (Convert.ToInt32(x.Value)) == model.Status).Any());
                }
                timeSheetWithStatusNotToDoQuery.BuildOrderBysQue(predicate.OrderBy);
                idsEmployeeWithNotToDoStatus = timeSheetWithStatusNotToDoQuery.Select(_builder.BuildEntity).ToList().Select(x => x.IdEmployee).ToList();
            }

            // Get timesheets
            IList<TimeSheetViewModel> timeSheetViewModels = timeSheetQuery.Select(_builder.BuildEntity).ToList();
            int total = 0;
            total += predicate.Filter
                .Count(x => x.Prop == nameof(EmployeeTeam.IdTeam)) == NumberConstant.Zero ?
                _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere) : NumberConstant.Zero;
            // Create to do timesheet for employees who don't have cra.
            dataSourceResult = GetTimeSheetsWithSpecificCondition(timeSheetViewModels, predicate, idsEmployeeWithNotToDoStatus, employeesList, total);
            return dataSourceResult;
        }

        /// <summary>
        /// Prepare employee list for timesheet grid
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="predicate"></param>
        /// <param name="isAdmin"></param>
        /// <returns></returns>
        private List<EmployeeViewModel> GetEmployeesWithSpecificConditions(string userMail, PredicateFormatViewModel predicate, bool isAdmin)
        {
            List<EmployeeViewModel> employeesList = new List<EmployeeViewModel>();

            List<int> filteredEmlpoyeesId = new List<int>();
            List<int> managersIds = new List<int>();
            DateTime month = (DateTime)predicate.Filter.Where(x => x.Prop == nameof(TimeSheet.Month)).Select(x => x.Value).FirstOrDefault();
            List<int> employees = predicate.Filter.Where(x => x.Prop == nameof(TimeSheet.IdEmployee)).Select(x => Convert.ToInt32(x.Value)).ToList();
            List<int> teams = predicate.Filter.Where(x => x.Prop == nameof(EmployeeTeam.IdTeam))
                .Select(x => Convert.ToInt32(x.Value)).ToList();
            // Get employees from predicate if it exists
            if (employees.Count > NumberConstant.Zero)
            {
                if (teams.Count == NumberConstant.Zero)
                {
                    // Get only selected employees when there is team selected
                    filteredEmlpoyeesId = employees;
                }
                else
                {
                    // Get managers ids from predicate
                    managersIds = employees;
                }
            }
            // Get employeees list
            if (isAdmin)
            {
                employeesList = _serviceEmployee.GetModelsWithConditionsRelations(x => x.HiringDate.FirstDateOfMonth().BeforeDateLimitIncluded(month), x => x.EmployeeTeam).ToList();
            }
            else
            {
                List<EmployeeViewModel> inferiorEmployees = new List<EmployeeViewModel>();
                inferiorEmployees = _serviceEmployee.GetHierarchicalEmployeesList(userMail, true, true).Where(x => x.HiringDate.FirstDateOfMonth().BeforeDateLimitIncluded(month)).ToList();
                employeesList.AddRange(inferiorEmployees);
            }
            if (filteredEmlpoyeesId.Count > NumberConstant.Zero)
            {
                employeesList = employeesList.Where(x => filteredEmlpoyeesId.Contains(x.Id)).ToList();
            }
            if (teams.Count > NumberConstant.Zero)
            {
                DateTime today = DateTime.Today.Date;
                employeesList = employeesList.Where(x => x.EmployeeTeam != null && x.EmployeeTeam.Any(m =>
                    m.IsAssigned &&
                    teams.Contains(m.IdTeam))).ToList();
                if (managersIds.Count > NumberConstant.Zero)
                {
                    Expression<Func<Employee, bool>> employeePredicate = x => managersIds.Distinct().Contains(x.Id);
                    var managers = _serviceEmployee.GetAllModelsQueryable(employeePredicate).ToList();
                    employeesList.AddRange(managers);
                }
            }
            return employeesList.Distinct(new EmployeeComparer()).ToList();
        }

        /// <summary>
        /// Create timesheets for employees who don't have cra on specific month
        /// </summary>
        /// <param name="timeSheetViewModels"></param>
        /// <param name="predicate"></param>
        /// <param name="idsEmployeeWithNotToDoStatus"></param>
        /// <param name="employeesList"></param>
        /// <param name="total"></param>
        /// <returns></returns>
        private DataSourceResult<TimeSheetViewModel> GetTimeSheetsWithSpecificCondition(IList<TimeSheetViewModel> timeSheetViewModels, PredicateFormatViewModel predicate, List<int> idsEmployeeWithNotToDoStatus,
             List<EmployeeViewModel> employeesList, int total)
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            // If there is no status specified or the status is to do, create timesheets for employees which don't have timesheet stored
            DataSourceResult<TimeSheetViewModel> dataSourceResult = new DataSourceResult<TimeSheetViewModel>();
            if ((predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Month)) != NumberConstant.Zero)
                && (predicate.Filter.Count(x => x.Prop == string.Concat(nameof(TimeSheet.IdEmployeeNavigation), ".", nameof(TimeSheet.IdEmployeeNavigation.FullName))) == NumberConstant.Zero)
                && (predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.TreatmentDate)) == NumberConstant.Zero)
                && ((predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Status)) == NumberConstant.Zero) || (predicate.Filter.Count(x => x.Prop == nameof(TimeSheet.Status)) != NumberConstant.Zero
                && predicate.Filter.Where(x => x.Prop == nameof(TimeSheet.Status)).Select(x => x.Value).ToList().Select(s => Convert.ToInt32(s)).Contains((int)TimeSheetStatusEnumerator.ToDo))))
            {
                List<EmployeeViewModel> remainingEmployeeIds = new List<EmployeeViewModel>();
                List<int> existingEmployeeIds = idsEmployeeWithNotToDoStatus.Count > NumberConstant.Zero ? idsEmployeeWithNotToDoStatus : timeSheetViewModels.Select(x => x.IdEmployee).ToList();
                if (predicate.Filter.Count(x => x.Prop.Contains(string.Concat(nameof(TimeSheet.IdEmployeeNavigation), ".", nameof(TimeSheet.IdEmployeeNavigation.FirstName)))) != NumberConstant.Zero)
                {
                    employeesList = employeesList.Where(x => x.FirstName.ToLower(CultureInfo.CurrentCulture).Trim().
                        Contains(predicate.Filter.Where(y => y.Prop.Contains(string.Concat(nameof(TimeSheet.IdEmployeeNavigation), ".", nameof(TimeSheet.IdEmployeeNavigation.FirstName))))
                        .Select(z => Convert.ToString(z.Value)).FirstOrDefault().ToLower(CultureInfo.CurrentCulture).Trim())).ToList();
                }
                if (predicate.Filter.Count(x => x.Prop.Contains(string.Concat(nameof(TimeSheet.IdEmployeeNavigation), ".", nameof(TimeSheet.IdEmployeeNavigation.LastName)))) != NumberConstant.Zero)
                {
                    employeesList = employeesList.Where(x => x.LastName.ToLower(CultureInfo.CurrentCulture).Trim().Contains(predicate.Filter
                        .Where(y => y.Prop.Contains(string.Concat(nameof(TimeSheet.IdEmployeeNavigation), ".", nameof(TimeSheet.IdEmployeeNavigation.LastName))))
                        .Select(z => Convert.ToString(z.Value)).FirstOrDefault().ToLower(CultureInfo.CurrentCulture).Trim())).ToList();
                }
                remainingEmployeeIds.AddRange(Enumerable.Repeat(new EmployeeViewModel(), total));
                remainingEmployeeIds.AddRange(employeesList.Where(x => !existingEmployeeIds.Contains(x.Id)).ToList());
                total = timeSheetViewModels.Count == employeesList.Count ? employeesList.Count :
                    employeesList.Where(x => !existingEmployeeIds.Contains(x.Id)).ToList().Count;
                remainingEmployeeIds = remainingEmployeeIds.Skip((predicate.page - NumberConstant.One) * predicate.pageSize)
                   .Take(predicate.pageSize).ToList();
                remainingEmployeeIds.Where(x => x.Id != NumberConstant.Zero).ToList().ForEach(employee =>
                {
                    if ((idsEmployeeWithNotToDoStatus.Count > NumberConstant.Zero && !idsEmployeeWithNotToDoStatus.Contains(employee.Id) &&
                    employee.Id != NumberConstant.Zero) || idsEmployeeWithNotToDoStatus.Count == NumberConstant.Zero)
                    {
                        TimeSheetViewModel timeSheetViewModel = new TimeSheetViewModel
                        {
                            IdEmployee = employee.Id,
                            IdEmployeeNavigation = employee,
                            Month = (DateTime)predicate.Filter.Where(x => x.Prop == nameof(TimeSheet.Month)).Select(x => x.Value).FirstOrDefault()
                        };
                        timeSheetViewModel.NumberOfDaysDayHour = new NumberOfDaysDayHour();
                        timeSheetViewModels.Add(timeSheetViewModel);
                    }
                });
            }
            // Calculate days worked, leave days and days off
            timeSheetViewModels.ToList().ForEach(model =>
            {
                _serviceTimeSheetCountDays.CalculateTimeSheetDaysHours(timeSheetViewModel: model, halfDay: companyViewModel.TimeSheetPerHalfDay);
                model.IsConnectedUserInHierarchy = _serviceEmployee.IsConnectedUserTeamManagerOrHierarchic(model.IdEmployee);
            });
            dataSourceResult.total = total;
            dataSourceResult.data = timeSheetViewModels;
            return dataSourceResult;
        }


        /// <summary>
        /// Get available employee for current month
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public IList<TimeSheetViewModel> GetAvailableEmployeeByTimeSheet(DateTime endDate)
        {
            DateTime startDate = endDate.FirstDateOfMonth();
            IList<EmployeeViewModel> employeeViewModels = _serviceEmployee.GetModelsWithConditionsRelations(
                x => x.HiringDate.BeforeDateLimitIncluded(endDate) &&
                x.Contract.Any(y => y.StartDate.BeforeDateLimitIncluded(endDate) && (!y.EndDate.HasValue || y.EndDate.Value.AfterDateLimitIncluded(startDate))) &&
                (!x.ResignationDate.HasValue || x.ResignationDate >= startDate), x => x.Contract).ToList();
            IList<TimeSheetViewModel> timeSheets = FindModelsByNoTracked(m => m.Month.EqualsDate(endDate.FirstDateOfMonth())
                && employeeViewModels.Any(e => e.Id == m.IdEmployee), m => m.IdEmployeeNavigation).ToList();
            employeeViewModels.Where(m => !timeSheets.Any(t => t.IdEmployee == m.Id)).ToList().ForEach(employee =>
            {
                timeSheets.Add(new TimeSheetViewModel
                {
                    IdEmployeeNavigation = employee,
                    IdEmployee = employee.Id,
                    Status = (int)TimeSheetStatusEnumerator.ToDo
                });
            });
            return timeSheets;
        }
        /// <summary>
        /// GetTimesheetFromListId
        /// </summary>
        /// <param name="listIdTimesheets"></param>
        /// <returns></returns>
        public List<TimeSheetViewModel> GetTimesheetFromListId(List<int> listIdTimesheets)
        {
            List<TimeSheetViewModel> listedTimesheets = new List<TimeSheetViewModel>();
            listIdTimesheets.ForEach((x) =>
            {
                listedTimesheets.Add(GetModelById(x));
            });
            return listedTimesheets;
        }
        /// <summary>
        /// ValidateMassiveTimesheets
        /// </summary>
        /// <param name="listOfTimesheets"></param>
        /// <param name="userMail"></param>
        public void ValidateMassiveTimesheets(List<TimeSheetViewModel> listOfTimesheets, string userMail)
        {
            try
            {
                BeginTransaction();
                listOfTimesheets.ForEach((x) =>
                {
                    DefinitiveValidateTimeSheet(x.Id, userMail);
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

    }
}
