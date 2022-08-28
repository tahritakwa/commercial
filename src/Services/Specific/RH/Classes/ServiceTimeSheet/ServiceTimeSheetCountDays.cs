using Microsoft.Extensions.Caching.Memory;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Classes.ServiceTimeSheet
{
    public class ServiceTimeSheetCountDays : Service<TimeSheetViewModel, TimeSheet>, IServiceTimeSheetCountDays
    {
        private readonly IServicePeriod _servicePeriod;
        private readonly IRepository<Project> _repoProject;
        private readonly IRepository<DayOff> _repoDayOff;

        public ServiceTimeSheetCountDays(IServicePeriod servicePeriod,
            IRepository<DayOff> repoDayOff,
            IRepository<Project> repoProject, IRepository<TimeSheet> entityRepo,
            IUnitOfWork unitOfWork,
            ITimeSheetBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _repoDayOff = repoDayOff;
            _servicePeriod = servicePeriod;
            _repoProject = repoProject;
        }


        /// <summary>
        /// Calculate the number of days worked by TJM for a project by TimeSheet
        /// </summary>
        /// <param name="idTimeSheet"></param>
        /// <param name="idProject"></param>
        /// <returns></returns>
        public Dictionary<double, double> NumberOfDaysWorkedByProjectInTimeSheet(int idTimeSheet, int idProject)
        {
            Dictionary<double, DayHour> dayHourByTJM = new Dictionary<double, DayHour>();
            Dictionary<double, double> workedDaysByTJM = new Dictionary<double, double>();
            CompanyViewModel companyViewModel = GetCurrentCompany();
            if (idTimeSheet != NumberConstant.Zero)
            {
                TimeSheet timeSheet = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(model => model.Id.Equals(idTimeSheet),
                    model => model.TimeSheetLine).FirstOrDefault();
                timeSheet.TimeSheetLine = timeSheet.TimeSheetLine.Where(t => t.IdProject.Equals(idProject)).ToList();
                TimeSheetViewModel timeSheetViewModel = _builder.BuildEntity(timeSheet);
                Project project = _repoProject.GetSingleWithRelationsNotTracked(x => x.Id == idProject, x => x.EmployeeProject);
                project.EmployeeProject = project.EmployeeProject.Where(x => x.IdEmployee == timeSheet.IdEmployee && x.IsBillable).ToList();
                double ProjectTJM = (double)project.AverageDailyRate;
                double numberHoursOfPeriod = default;
                if (timeSheetViewModel != null && timeSheetViewModel.TimeSheetDay != null)
                {
                    DateTime timeSheetStartDate = new DateTime(timeSheetViewModel.Month.Year, timeSheetViewModel.Month.Month, NumberConstant.One);
                    DateTime timeSheetEndDate = timeSheetStartDate.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One);
                    IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(timeSheetStartDate, timeSheetEndDate);
                    CalculateTimeSheetDaysHours(timeSheetViewModel: timeSheetViewModel, halfDay: companyViewModel.TimeSheetPerHalfDay, idProjet: idProject);
                    timeSheetViewModel.TimeSheetDay.ToList().ForEach(timeSheetDayViewModel =>
                    {
                        if (timeSheetDayViewModel.TimeSheetLine != null && timeSheetDayViewModel.TimeSheetLine.Count > 0)
                        {
                            // Check TJM for the the day 
                            EmployeeProject employeeProjectViewModel = project.EmployeeProject.FirstOrDefault(
                            x => (x.UnassignmentDate.HasValue && timeSheetDayViewModel.Day.BetweenDateLimitIncluded(x.AssignmentDate, x.UnassignmentDate.Value))
                               || (!x.UnassignmentDate.HasValue && timeSheetDayViewModel.Day.AfterDateLimitIncluded(x.AssignmentDate))
                            );
                            double TJM = (employeeProjectViewModel != null && employeeProjectViewModel.AverageDailyRate.HasValue &&
                                employeeProjectViewModel.AverageDailyRate > NumberConstant.Zero) ? (double)employeeProjectViewModel.AverageDailyRate : ProjectTJM;
                            // Get period of the current start date
                            PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(model => timeSheetDayViewModel.Day.BetweenDateLimitIncluded(model.StartDate, model.EndDate));
                            numberHoursOfPeriod = _servicePeriod.CalculateDateHourNumber(curentPeriod.Hours.ToList(), curentPeriod.Hours.FirstOrDefault().StartTime, curentPeriod.Hours.LastOrDefault().EndTime,
                                                                                            companyViewModel.TimeSheetPerHalfDay).DayHourInDecimal;
                            timeSheetDayViewModel.TimeSheetLine.ToList().ForEach(line =>
                            {
                                DayHour lineDayHour = _servicePeriod.CalculateDateHourNumber(curentPeriod.Hours.ToList(), line.StartTime, line.EndTime,
                                                                                                companyViewModel.TimeSheetPerHalfDay);
                                if (!dayHourByTJM.Keys.ToList().Contains(TJM))
                                {
                                    dayHourByTJM.Add(TJM, new DayHour());
                                }
                                dayHourByTJM[TJM].Add(lineDayHour);
                            });
                        }
                    });
                    foreach (KeyValuePair<double, DayHour> item in dayHourByTJM)
                    {
                        _servicePeriod.DayHourRound(item.Value, numberHoursOfPeriod);
                        workedDaysByTJM[item.Key] = item.Value.Day + item.Value.Hour / numberHoursOfPeriod;
                    }
                }
            }
            return workedDaysByTJM;
        }


        /// <summary>
        /// Calculates the number of days of vacation leave validated, the number of holidays and the number of days worked.
        /// </summary>
        /// <param name="timeSheetViewModel"></param>
        /// <param name="periodViewModels"></param>
        public void CalculateTimeSheetDaysHours(TimeSheetViewModel timeSheetViewModel, bool halfDay, IList<PeriodViewModel> periodViewModels = null, int idProjet = 0)
        {
            if (periodViewModels == null)
            {
                periodViewModels = _servicePeriod.GetPeriodCrossBy(timeSheetViewModel.Month.Date,
                    timeSheetViewModel.Month.Date.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One));
            }
            if (timeSheetViewModel.Id > NumberConstant.Zero)
            {
                PeriodViewModel currentDatePeriod = default;
                int previousPeriodId = default;
                Expression<Func<TimeSheetDayViewModel, bool>> timeSheetDayPredicate = m => true;
                Expression<Func<TimeSheetLineViewModel, bool>> timeSheetLinePredicate = m => true;
                if (idProjet > NumberConstant.Zero)
                {
                    timeSheetDayPredicate = m => m.TimeSheetLine.Any(line => line.IdProject.Equals(idProjet));
                    timeSheetLinePredicate = m => m.IdProject.Equals(idProjet);
                }
                timeSheetViewModel.TimeSheetDay.AsQueryable().Where(timeSheetDayPredicate).ToList().ForEach(timeSheetDay =>
                {
                    currentDatePeriod = periodViewModels.FirstOrDefault(m => timeSheetDay.Day.Date.BetweenDateLimitIncluded(m.StartDate, m.EndDate));
                    timeSheetDay.Hollidays = (int)timeSheetDay.Day.DayOfWeek < currentDatePeriod.FirstDayOfWork || (int)timeSheetDay.Day.DayOfWeek > currentDatePeriod.LastDayOfWork;
                    timeSheetDay.TimeSheetLine.AsQueryable().Where(timeSheetLinePredicate).ToList().ForEach(timeSheetLine =>
                    {
                        DayHour dayHour = _servicePeriod.CalculateDateHourNumber(currentDatePeriod.Hours.ToList(), timeSheetLine.StartTime, timeSheetLine.EndTime, halfDay);
                        if (timeSheetLine.IdLeave.HasValue && ((timeSheetLine.Worked.HasValue && !timeSheetLine.Worked.Value) || !timeSheetLine.Worked.HasValue))
                        {
                            timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays.Add(dayHour);
                        }
                        else
                        {
                            timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Add(dayHour);
                        }
                        if (timeSheetLine.IdDayOff.HasValue && !timeSheetDay.Hollidays)
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
                    }
                    previousPeriodId = currentDatePeriod.Id;
                });
                double numberOfHour = _servicePeriod.CalculateHourNumber(currentDatePeriod.Hours);
                _servicePeriod.NumberOfDaysDayHourRound(timeSheetViewModel.NumberOfDaysDayHour, numberOfHour);
            }
            else
            {
                timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff.Day = _repoDayOff.FindByAsNoTracking(m =>
                    m.Date.BetweenDateLimitIncluded(timeSheetViewModel.Month, timeSheetViewModel.Month.LastDateOfMonth()) &&
                        !((int)m.Date.DayOfWeek < periodViewModels.FirstOrDefault(p => m.Date.BetweenDateLimitIncluded(p.StartDate, p.EndDate)).FirstDayOfWork ||
                        (int)m.Date.DayOfWeek > periodViewModels.FirstOrDefault(p => m.Date.BetweenDateLimitIncluded(p.StartDate, p.EndDate)).LastDayOfWork)).Count();
            }
            // Subtract from working days, dayoffs because they are not paid
            if (timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked > NumberConstant.Zero && timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff > NumberConstant.Zero)
            {
                double numberOfHourPerDay = _servicePeriod.CalculateHourNumber(periodViewModels.Last().Hours);
                timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Substract(timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysOff, numberOfHourPerDay);
                _servicePeriod.DayHourRound(timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked, numberOfHourPerDay);
            }
        }


    }
}
