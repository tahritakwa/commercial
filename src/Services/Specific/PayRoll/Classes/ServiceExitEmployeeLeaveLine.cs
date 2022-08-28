using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json.Linq;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Shared;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceExitEmployeeLeaveLine : Service<ExitEmployeeLeaveLineViewModel, ExitEmployeeLeaveLine>, IServiceExitEmployeeLeaveLine
    {
        private readonly IRepository<ExitEmployee> _entityExitEmployee;
        private readonly IServiceExitEmployee _serviceEmployeeExit;
        private readonly ILeaveBuilder _leaveBuilder;
        private readonly IRepository<Leave> _entityLeave;
        private readonly IServicePeriod _servicePeriod;

        public ServiceExitEmployeeLeaveLine(IServicePeriod servicePeriod, IRepository<ExitEmployeeLeaveLine> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IExitEmloyeeLeaveLineBuilder builder,
            IRepository<ExitEmployee> entityExitEmployee,
            IRepository<Leave> entityLeave,
           ILeaveBuilder leaveBuilder,
           IServiceExitEmployee serviceEmployeeExit,
           IEntityAxisValuesBuilder builderEntityAxisValues,
           ICompanyBuilder companyBuilder,
           IMemoryCache memoryCache)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _entityExitEmployee = entityExitEmployee;
            _servicePeriod = servicePeriod;
            _entityLeave = entityLeave;
            _serviceEmployeeExit = serviceEmployeeExit;
            _leaveBuilder = leaveBuilder;
        }

        /// <summary>
        /// Get list of leave and calculate leave resume
        /// </summary>
        /// <param name="employeeExit"></param>
        public void GenerateLeaveBalanceForExitEmployee(int idExitEmployee)
        {
            ExitEmployeeViewModel employeeExit = _serviceEmployeeExit.GetModelWithRelationsAsNoTracked(x => x.Id == idExitEmployee, x => x.IdEmployeeNavigation);
            if (!employeeExit.ExitPhysicalDate.HasValue)
            {
                throw new CustomException(CustomStatusCode.EmployeeExithasNoExitPhysicalDate);
            }
            if (employeeExit.IdEmployeeNavigation.HiringDate == null)
            {
                throw new CustomException(CustomStatusCode.EmployeeHasAnyContract);
            }
            // Remove existing paylines fo this employeeExit
            var exitEmployeePayLinesToRemove = _entityRepo.FindByAsNoTracking(x => x.IdExitEmployee == idExitEmployee);
            if (exitEmployeePayLinesToRemove.Any())
            {
                _entityRepo.RemoveRange(exitEmployeePayLinesToRemove.ToArray());
                // commit
                _unitOfWork.Commit();
            }
            IList<ExitEmployeeLeaveLineViewModel> listLinesOfLeave = new List<ExitEmployeeLeaveLineViewModel>();
            IList<LeaveViewModel> listOfMonthlyLeave = _entityLeave.GetAllWithConditionsRelationsAsNoTracking(x => x.IdEmployee == employeeExit.IdEmployee &&
                    x.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly && x.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted,
                    x => x.IdLeaveTypeNavigation).OrderByDescending(m => m.StartDate).ToList().Select(x => _leaveBuilder.BuildEntity(x)).ToList();

            IList<LeaveViewModel> listOfYearlyLeave = _entityLeave.GetAllWithConditionsRelationsAsNoTracking(x => x.IdEmployee == employeeExit.IdEmployee &&
                   x.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Yearly && x.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted,
                   x => x.IdLeaveTypeNavigation).OrderByDescending(m => m.StartDate).ToList().Select(x => _leaveBuilder.BuildEntity(x)).ToList();

            if (!listOfMonthlyLeave.Any() && !listOfYearlyLeave.Any())
            {
                throw new CustomException(CustomStatusCode.CannotGenerateLeaveBalance);
            }

            CalculateMonthlyLeaveResume(listOfMonthlyLeave, employeeExit, employeeExit.IdEmployeeNavigation.HiringDate.FirstDateOfMonth());
            CalculateAnnualLeaveResume(listOfYearlyLeave, employeeExit, employeeExit.IdEmployeeNavigation.HiringDate.FirstDateOfMonth());

            //update stateLeave "calculate" of the exit employee
            employeeExit.StateLeave = (int)ExitEmployeeStatePayEnumerator.Calculate;
            _serviceEmployeeExit.UpdateModelWithoutTransaction(employeeExit, null, null);


        }

        /// <summary>
        /// Calculate leave resume for Monthly Type 
        /// </summary>
        /// <param name="leaveViewModels"></param>
        /// <param name="employeeExit"></param>
        public void CalculateMonthlyLeaveResume(IList<LeaveViewModel> leaveViewModels, ExitEmployeeViewModel employeeExit, DateTime employeeHiringtDate)
        {
            List<ExitEmployeeLeaveLineViewModel> exitEmloyeeLeaveLineViewModels = new List<ExitEmployeeLeaveLineViewModel>();
            while (employeeHiringtDate.BeforeDate(employeeExit.ExitPhysicalDate.Value))
            {
                leaveViewModels.GroupBy(x => x.IdLeaveType).ToList().ForEach((Action<IGrouping<int, LeaveViewModel>>)(x =>
                {
                    exitEmloyeeLeaveLineViewModels.Add(new ExitEmployeeLeaveLineViewModel
                    {
                        IdExitEmployee = employeeExit.Id,
                        AcquiredParMonth = leaveViewModels.FirstOrDefault(l => l.IdLeaveType == x.Key).IdLeaveTypeNavigation.MaximumNumberOfDays,
                        TotalTakenPerMonth = NumberConstant.Zero,
                        DayTakenPerMonth = NumberConstant.Zero.ToString(),
                        Month = employeeHiringtDate,
                        IdLeaveType = x.Key,
                        TotalDayHourTakenPerMonth = new DayHour()
                    });
                }));
                employeeHiringtDate = employeeHiringtDate.AddMonths(NumberConstant.One);
            }
            exitEmloyeeLeaveLineViewModels.GroupBy(x => x.IdLeaveType.Value).ToList().ForEach(x =>
            {
                CalculExitEmloyeeLeaveLineFields(leaveViewModels.Where(l => l.IdLeaveType == x.Key).ToList(), x.ToList(), employeeExit);
            });
            base.BulkAddWithoutTransaction(exitEmloyeeLeaveLineViewModels, null);

        }

        /// <summary>
        /// Updates the fields of ExitEmloyeeLeaveLine
        /// </summary>
        /// <param name="listOfLeave"></param>
        /// <param name="listLinesOfLeave"></param>
        private void CalculExitEmloyeeLeaveLineFields(IList<LeaveViewModel> listOfLeave, List<ExitEmployeeLeaveLineViewModel> listLinesOfLeave, ExitEmployeeViewModel exitEmployee)
        {
            bool companyRegimeHalfDay = GetCurrentCompany().TimeSheetPerHalfDay;
            foreach (var leave in listOfLeave)
            {
                if (exitEmployee.ExitPhysicalDate.Value.BeforeDate(leave.EndDate))
                {
                    throw new CustomException(CustomStatusCode.EmployeeExitPhysicalDateBeforeLeaveDate);
                }
                List<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(leave.StartDate, leave.EndDate).ToList();
                if (leave.StartDate.Month == leave.EndDate.Month)
                {
                    ExitEmployeeLeaveLineViewModel currentExitEmployeeLeaveLine = listLinesOfLeave.Where(model => model.Month.EqualsDate(leave.StartDate.FirstDateOfMonth())).FirstOrDefault();
                    string res = leave.StartDate.Day == leave.EndDate.Day ?
                     leave.StartDate.Day.ToString() :
                     string.Concat(leave.StartDate.Day, "-", leave.EndDate.Day);
                    currentExitEmployeeLeaveLine.DayTakenPerMonth = currentExitEmployeeLeaveLine.DayTakenPerMonth.Equals(NumberConstant.Zero.ToString()) ?
                        res :
                        currentExitEmployeeLeaveLine.DayTakenPerMonth + string.Concat("+", res);
                    DayHour dayHour = _servicePeriod.CalculateNumberOfDaysAndHour(leave.StartDate, leave.EndDate, leave.StartTime, leave.EndTime, companyRegimeHalfDay);
                    PeriodViewModel endDatePeriod = periodViewModels.FirstOrDefault(m => leave.EndDate.LastDateOfMonth().BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                    currentExitEmployeeLeaveLine.LastNumberOfHourPerDay = _servicePeriod.CalculateDateHourNumber(endDatePeriod.Hours.ToList(), endDatePeriod.Hours.FirstOrDefault().StartTime, endDatePeriod.Hours.LastOrDefault().EndTime,
                                                                                        companyRegimeHalfDay).DayHourInDecimal;
                    currentExitEmployeeLeaveLine.TotalDayHourTakenPerMonth.Add(dayHour);
                }
                else
                {
                    DateTime startDate = leave.StartDate;
                    while (startDate.Month <= leave.EndDate.Month)
                    {
                        DayHour dayHour;
                        string dayTakenPerMonth;
                        ExitEmployeeLeaveLineViewModel currentExitEmployeeLeaveLine = listLinesOfLeave.Where(model => model.Month.EqualsDate(startDate.FirstDateOfMonth())).FirstOrDefault();
                        if (startDate.FirstDateOfMonth().EqualsDate(leave.StartDate.FirstDateOfMonth()))
                        {
                            dayTakenPerMonth = string.Concat(startDate.Day, "-", startDate.LastDateOfMonth().Day);
                            PeriodViewModel endDatePeriod = periodViewModels.FirstOrDefault(m => startDate.LastDateOfMonth().BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                            currentExitEmployeeLeaveLine.LastNumberOfHourPerDay = _servicePeriod.CalculateDateHourNumber(endDatePeriod.Hours.ToList(), endDatePeriod.Hours.FirstOrDefault().StartTime, endDatePeriod.Hours.LastOrDefault().EndTime,
                                                                                                companyRegimeHalfDay).DayHourInDecimal;
                            dayHour = _servicePeriod.CalculateNumberOfDaysAndHour(leave.StartDate, startDate.LastDateOfMonth(),
                                leave.StartTime, endDatePeriod.Hours.OrderByDescending(x => x.EndTime).First().EndTime, companyRegimeHalfDay);
                        }
                        else if (startDate.FirstDateOfMonth().EqualsDate(leave.EndDate.FirstDateOfMonth()))
                        {
                            dayTakenPerMonth = string.Concat(startDate.FirstDateOfMonth().Day, "-", leave.EndDate.Day);
                            PeriodViewModel startDatePeriod = periodViewModels.FirstOrDefault(m => startDate.FirstDateOfMonth().BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                            PeriodViewModel endDatePeriod = periodViewModels.FirstOrDefault(m => leave.EndDate.BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                            currentExitEmployeeLeaveLine.LastNumberOfHourPerDay = _servicePeriod.CalculateDateHourNumber(endDatePeriod.Hours.ToList(), endDatePeriod.Hours.FirstOrDefault().StartTime, endDatePeriod.Hours.LastOrDefault().EndTime,
                                                                                                companyRegimeHalfDay).DayHourInDecimal;
                            dayHour = _servicePeriod.CalculateNumberOfDaysAndHour(startDate.FirstDateOfMonth(), leave.EndDate,
                                startDatePeriod.Hours.OrderBy(x => x.StartTime).First().StartTime, leave.EndTime, companyRegimeHalfDay);
                        }
                        else
                        {
                            dayTakenPerMonth = string.Concat(startDate.FirstDateOfMonth().Day, "-", startDate.LastDateOfMonth().Day);
                            PeriodViewModel startDatePeriod = periodViewModels.FirstOrDefault(m => startDate.FirstDateOfMonth().BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                            PeriodViewModel endDatePeriod = periodViewModels.FirstOrDefault(m => startDate.LastDateOfMonth().BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                            currentExitEmployeeLeaveLine.LastNumberOfHourPerDay = _servicePeriod.CalculateDateHourNumber(endDatePeriod.Hours.ToList(), endDatePeriod.Hours.FirstOrDefault().StartTime, endDatePeriod.Hours.LastOrDefault().EndTime,
                                                                                                companyRegimeHalfDay).DayHourInDecimal;
                            dayHour = _servicePeriod.CalculateNumberOfDaysAndHour(startDate.FirstDateOfMonth(), startDate.LastDateOfMonth(),
                                startDatePeriod.Hours.OrderBy(x => x.StartTime).First().StartTime, endDatePeriod.Hours.OrderByDescending(x => x.EndTime).First().EndTime, companyRegimeHalfDay);
                        }
                        currentExitEmployeeLeaveLine.DayTakenPerMonth = currentExitEmployeeLeaveLine.DayTakenPerMonth.Equals(NumberConstant.Zero.ToString()) ?
                            dayTakenPerMonth : currentExitEmployeeLeaveLine.DayTakenPerMonth + string.Concat("+", dayTakenPerMonth);
                        currentExitEmployeeLeaveLine.TotalDayHourTakenPerMonth.Add(dayHour);
                        startDate = startDate.AddMonths(NumberConstant.One);
                    }
                }
            }
            ExitEmployeeLeaveLineViewModel previousLine = null;
            listLinesOfLeave.OrderBy(x => x.Month).ToList().ForEach(x =>
            {
                if (!x.DayTakenPerMonth.Equals(NumberConstant.Zero.ToString()))
                {
                    _servicePeriod.DayHourRound(x.TotalDayHourTakenPerMonth, x.LastNumberOfHourPerDay);
                    x.TotalTakenPerMonth = x.TotalDayHourTakenPerMonth.Day + x.TotalDayHourTakenPerMonth.Hour / x.LastNumberOfHourPerDay;
                }
                x.CumulativeTaken = previousLine is null ? x.TotalTakenPerMonth : previousLine.CumulativeTaken + x.TotalTakenPerMonth;
                x.CumulativeAcquired = previousLine is null ? x.AcquiredParMonth : previousLine.CumulativeAcquired + x.AcquiredParMonth;
                x.BalancePerMonth = x.CumulativeAcquired - x.CumulativeTaken;
                previousLine = x;
            });
        }

        /// <summary>
        /// Calculate leave resume for Annual Type 
        /// </summary>
        /// <param name="leaveViewModels"></param>
        /// <param name="employeeExit"></param>
        ///  <param name="employeeHiringtDate"></param>
        public void CalculateAnnualLeaveResume(IList<LeaveViewModel> leaveViewModels, ExitEmployeeViewModel employeeExit, DateTime employeeHiringtDate)
        {
            List<ExitEmployeeLeaveLineViewModel> exitEmloyeeLeaveLineViewModels = new List<ExitEmployeeLeaveLineViewModel>();

            // calculate leave lines for exit employee  = number of year worked * number of leave type
            while (employeeHiringtDate.Year <= employeeExit.ExitPhysicalDate.Value.Year)
            {
                leaveViewModels.GroupBy(x => x.IdLeaveType).ToList().ForEach(x =>
                {
                    exitEmloyeeLeaveLineViewModels.Add(new ExitEmployeeLeaveLineViewModel
                    {
                        IdExitEmployee = employeeExit.Id,
                        DayTakenPerYear = NumberConstant.Zero.ToString(),
                        AcquiredPerYear = leaveViewModels.FirstOrDefault(l => l.IdLeaveType == x.Key).IdLeaveTypeNavigation.MaximumNumberOfDays,
                        TotalTakenPerYear = NumberConstant.Zero,
                        Year = employeeHiringtDate.Year,
                        IdLeaveType = x.Key,
                    });
                });
                employeeHiringtDate = employeeHiringtDate.AddYears(NumberConstant.One);
            }
            foreach (var leave in leaveViewModels)
            {
                if (employeeExit.ExitPhysicalDate.Value.BeforeDateLimitIncluded(leave.EndDate))
                {
                    throw new CustomException(CustomStatusCode.EmployeeExitPhysicalDateBeforeLeaveDate);
                }
                ExitEmployeeLeaveLineViewModel currentExitEmployeeLeaveLine = exitEmloyeeLeaveLineViewModels.Where(model => model.Year == leave.StartDate.Year &&
                model.IdLeaveType == leave.IdLeaveType).FirstOrDefault();
                currentExitEmployeeLeaveLine.TotalTakenPerYear = currentExitEmployeeLeaveLine.TotalTakenPerYear + leave.NumberDaysLeave.Day;
                string dayTakenPerYear = string.Concat(leave.StartDate.Format(DateFormat.MonthDayDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language), "-",
                    leave.EndDate.Format(DateFormat.MonthDayDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
                currentExitEmployeeLeaveLine.DayTakenPerYear = currentExitEmployeeLeaveLine.DayTakenPerYear.Equals(NumberConstant.Zero.ToString()) ?
                            dayTakenPerYear : currentExitEmployeeLeaveLine.DayTakenPerYear + new StringBuilder().Append(" / ").Append(dayTakenPerYear);
            }
            ExitEmployeeLeaveLineViewModel previousLine = null;
            exitEmloyeeLeaveLineViewModels.OrderBy(x => x.Year).ToList().ForEach(x =>
            {
                x.CumulativeTaken = previousLine is null ? x.TotalTakenPerYear : previousLine.CumulativeTaken + x.TotalTakenPerYear;
                x.CumulativeAcquired = previousLine is null ? x.AcquiredPerYear : previousLine.CumulativeAcquired + x.AcquiredPerYear;
                x.BalancePerYear = x.CumulativeAcquired - x.CumulativeTaken;
                previousLine = x;
            });
            base.BulkAddWithoutTransaction(exitEmloyeeLeaveLineViewModels, null);
        }


        /// <summary>
        /// Get list of resume leave 
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public DataSourceResult<ExitEmployeeLeaveLineViewModel> GetListOfLeave(PredicateFormatViewModel predicate)
        {
            PredicateFilterRelationViewModel<ExitEmployeeLeaveLine> predicateFilterRelationModel = PreparePredicate(predicate);
            IList<ExitEmployeeLeaveLine> listOfExitEmployeeLeave = _entityRepo.GetAllAsNoTracking()
                                             .Include(x => x.IdLeaveTypeNavigation)
                                             .OrderBy(x => x.IdLeaveType).ThenBy(x => x.Month).ThenBy(x => x.Year)
                                             .Where(predicateFilterRelationModel.PredicateWhere).ToList();
            return new DataSourceResult<ExitEmployeeLeaveLineViewModel>
            {
                data = listOfExitEmployeeLeave.Skip((predicate.page - NumberConstant.One) * predicate.pageSize).Take(predicate.pageSize).Select(x => _builder.BuildEntity(x)).ToList(),
                total = listOfExitEmployeeLeave.Count
            };
        }

        /// <summary>
        /// Get All Leave Resume Report Settings
        /// </summary>
        /// <param name="idExitEmployee"></param>
        /// <param name="userMail"></param>
        /// <param name="exitEmployeeLeaveLines"></param>
        /// <returns></returns>
        public DownloadReportDataViewModel GetAllLeaveResumeReportSettings(int idExitEmployee, string userMail, out IList<ExitEmployeeLeaveLine> exitEmployeeLeaveLines)
        {
            ExitEmployee exitEmployee = _entityExitEmployee.GetAllWithConditionsRelations(p => p.Id == idExitEmployee, m => m.IdEmployeeNavigation).FirstOrDefault();
            exitEmployeeLeaveLines = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(m => m.IdExitEmployee == idExitEmployee,
               m => m.IdLeaveTypeNavigation, m => m.IdExitEmployeeNavigation).ToList();

            string zipFolderName = string.Concat(nameof(ExitEmployeeLeaveLine), GenericConstants.Underscore, exitEmployee.IdEmployeeNavigation.FullName, GenericConstants.Underscore,
                    exitEmployee.IdEmployeeNavigation.HiringDate.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
            GenericConstants.Underscore, exitEmployee.ExitPhysicalDate?.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            return BuildReportsName(exitEmployeeLeaveLines, exitEmployee, zipFolderName);
        }

        /// <summary>
        /// Prepare report settings for leave resume
        /// </summary>
        /// <param name="exitEmployeeLeaveLines"></param>
        /// <param name="exitEmployee"></param>
        /// <param name="zipFolderName"></param>
        /// <returns></returns>
        private DownloadReportDataViewModel BuildReportsName(IList<ExitEmployeeLeaveLine> exitEmployeeLeaveLines, ExitEmployee exitEmployee, string zipFolderName)
        {
            dynamic[] dynamicListIds = new dynamic[exitEmployeeLeaveLines.GroupBy(x => x.IdLeaveType).ToList().Count];
            int counter = NumberConstant.Zero;

            exitEmployeeLeaveLines.GroupBy(x => x.IdLeaveType).ToList().ForEach((Action<IGrouping<int?, ExitEmployeeLeaveLine>>)(x =>
            {
                dynamic report = new JObject();
                report.reportParameters = new JObject();
                report.reportParameters.idExitEmployee = exitEmployee.Id;
                report.reportParameters.period = x.ElementAt<ExitEmployeeLeaveLine>(NumberConstant.One).IdLeaveTypeNavigation.Period;
                report.reportParameters.idLeaveType = x.Key;

                StringBuilder reportName = new StringBuilder()
                                                .Append(nameof(ExitEmployeeLeaveLine)).Append(GenericConstants.Underscore)
                                                .Append(x.ElementAt<ExitEmployeeLeaveLine>(1).IdLeaveTypeNavigation.Label).Append(GenericConstants.Underscore)
                                                .Append(exitEmployee.IdEmployeeNavigation.FirstName).Append(GenericConstants.Underscore)
                                                .Append(exitEmployee.IdEmployeeNavigation.LastName).Append(GenericConstants.Underscore)
                                                .Append(x.Key);

                report.documentName = reportName.ToString();
                dynamicListIds[counter] = report;
                counter++;
            }));
            DownloadReportDataViewModel downloadReportDataViewModel = new DownloadReportDataViewModel
            {
                ReportName = "ExitEmployeeLeaveSummary",
                ReportFormatName = "pdf",
                ZipFolderName = zipFolderName,
                DynamicListIds = dynamicListIds
            };
            UpdateReportSettings(downloadReportDataViewModel);
            return downloadReportDataViewModel;
        }
    }
}
