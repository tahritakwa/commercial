using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.Administration.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Reporting.Classes
{
    public class RhServiceReporting : IRhServiceReporting
    {
        private readonly IServiceTimeSheetCountDays _serviceTimeSheetCountDays;
        private readonly IServiceTimeSheet _serviceTimeSheet;
        private readonly IServicePeriod _servicePeriod;
        private readonly IServiceProjectReduce _serviceProjectReduce;
        private readonly IServiceCompany _serviceCompany;
        private readonly IServiceExitEmployeeLeaveLine _serviceExitEmployeeLeaveLine;
        private readonly IRepository<ExitEmployee> _entityRepoExitEmployee;
        private readonly IRepository<LeaveType> _entityRepoLeaveType;




        CompanyViewModel companyViewModel;

        public RhServiceReporting(IServiceTimeSheetCountDays serviceTimeSheetCountDays,
            IServicePeriod servicePeriod,
            IServiceProjectReduce serviceProjectReduce,
            IServiceCompany serviceCompany,
            IServiceExitEmployeeLeaveLine serviceExitEmployeeLeaveLine,
            IRepository<ExitEmployee> entityRepoExitEmployee,
            IServiceTimeSheet serviceTimeSheet,
            IRepository<LeaveType> entityRepoLeaveType)
        {
            _serviceTimeSheetCountDays = serviceTimeSheetCountDays;
            _serviceProjectReduce = serviceProjectReduce;
            _servicePeriod = servicePeriod;
            _serviceCompany = serviceCompany;
            _serviceExitEmployeeLeaveLine = serviceExitEmployeeLeaveLine;
            _entityRepoExitEmployee = entityRepoExitEmployee;
            _serviceTimeSheet = serviceTimeSheet;
            _entityRepoLeaveType = entityRepoLeaveType;
            // Get company
            companyViewModel = _serviceCompany.GetCurrentCompany();

        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="idTimeSheet"></param>
        /// <returns></returns>
        public TimeSheetReportInformationsViewModel GetTimeSheetInformations(int idTimeSheet, int idProject)
        {
            // Get report company information
            ReportCompanyInformationViewModel reportCompanyInformationViewModel = _serviceCompany.GetReportCompanyInformation();
            TimeSheetViewModel timeSheetViewModel = _serviceTimeSheet.GetModelById(idTimeSheet);
            ProjectViewModel projectViewModel = _serviceProjectReduce.GetModelWithRelations(m => m.Id.Equals(idProject),
                m => m.IdTiersNavigation,
                mbox => mbox.IdContactNavigation);
            _serviceTimeSheetCountDays.CalculateTimeSheetDaysHours(timeSheetViewModel: timeSheetViewModel, idProjet: idProject, halfDay: companyViewModel.TimeSheetPerHalfDay);
            TimeSheetReportInformationsViewModel timeSheetReportInformationsViewModel = new TimeSheetReportInformationsViewModel(reportCompanyInformationViewModel)
            {                             
                ProjectName = !string.IsNullOrEmpty(projectViewModel.ProjectLabel) ? projectViewModel.ProjectLabel : projectViewModel.Name,
                EmployeeFullName = timeSheetViewModel.IdEmployeeNavigation.FullName,
                Month = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(timeSheetViewModel.Month.ToString("MMMM yyyy", CultureInfo.CreateSpecificCulture("fr-FR"))),
                NumberOfWorkedDays = timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Day,
                NumberOfWorkedHours = timeSheetViewModel.NumberOfDaysDayHour.NumberOfDaysWorked.Hour,
                NumberOfLeaveDays = timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays.Day,
                NumberOfLeaveHours = timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays.Hour,
                NumberOfDayOffDays = timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays.Day,
                NumberOfDayOffHours = timeSheetViewModel.NumberOfDaysDayHour.NumberOfLeavesDays.Hour,
                ClientFullName = projectViewModel.IdTiersNavigation != null ? projectViewModel.IdTiersNavigation.Name : companyViewModel.Name,
                ContactFullName = projectViewModel.IdContactNavigation != null ?
                    projectViewModel.IdContactNavigation.LastName + " " + projectViewModel.IdContactNavigation.FirstName : (companyViewModel.Contact != null ? companyViewModel.Contact.FirstOrDefault().FirstName : string.Empty),
                ContactEMail = projectViewModel.IdContactNavigation != null ? projectViewModel.IdContactNavigation.Email : (companyViewModel.Contact != null ? companyViewModel.Contact.FirstOrDefault().Email : string.Empty),               
            };
            return timeSheetReportInformationsViewModel;
        }

        /// <summary>
        /// Get timesheetlines for reporting
        /// </summary>
        /// <param name="idTimeSheet"></param>
        /// <returns></returns>
        public IEnumerable<TimeSheetLineReportInformationsViewModel> GetTimeSheetLines(int idTimeSheet, int idProject)
        {
            TimeSheetViewModel timeSheetViewModel = _serviceTimeSheet.GetModelById(idTimeSheet);
            IList<TimeSheetLineReportInformationsViewModel> lines = new List<TimeSheetLineReportInformationsViewModel>();
            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(timeSheetViewModel.TimeSheetDay.First().Day, timeSheetViewModel.TimeSheetDay.Last().Day);
            timeSheetViewModel.TimeSheetDay.ToList().ForEach(timesheetDay =>
            {
                PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(model => timesheetDay.Day.BetweenDateLimitIncluded(model.StartDate, model.EndDate));
                var groupedLines = timesheetDay.TimeSheetLine.Where(m => !m.IdLeave.HasValue
                    && m.IdProject.Equals(idProject)).GroupBy(m => m.Day).ToList();
                TimeSheetLineReportInformationsViewModel line = new TimeSheetLineReportInformationsViewModel
                {
                    DayNumber = timesheetDay.Day.Day.ToString(),
                    Day = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(timesheetDay.Day.ToString("dddd", CultureInfo.CreateSpecificCulture("fr-FR"))),
                    Hollidays = (int)timesheetDay.Day.DayOfWeek < curentPeriod.FirstDayOfWork || (int)timesheetDay.Day.DayOfWeek > curentPeriod.LastDayOfWork,
                    Details = string.Empty
                };
                if (groupedLines.Any())
                {
                    List<HoursViewModel> hours = curentPeriod.Hours.OrderBy(m => m.StartTime).ToList();
                    groupedLines.ForEach(groupeLine =>
                    {
                        List<TimeSheetLineViewModel> timeSheetLineViewModels = groupeLine.ToList();
                        var withDetails = timeSheetLineViewModels.Where(p => !string.IsNullOrEmpty(p.Details)).ToList();
                        var withoutDetails = timeSheetLineViewModels.Where(p => string.IsNullOrEmpty(p.Details)).ToList();
                        if (withoutDetails.Any())
                        {
                            withoutDetails.ForEach(e =>
                            {
                                DayHour dayHour = _servicePeriod.CalculateDateHourNumber(hours, e.StartTime, e.EndTime, companyViewModel.TimeSheetPerHalfDay);
                                line.ChargeInDay += dayHour.Day;
                                line.ChargeInHour += dayHour.Hour;
                            });
                            lines.AddLine(line);
                        }
                        if (withDetails.Any())
                        {
                            int counter = NumberConstant.Zero;
                            do
                            {
                                TimeSheetLineViewModel currentLine = withDetails.ElementAt(counter);
                                DayHour dayHour = _servicePeriod.CalculateDateHourNumber(hours, currentLine.StartTime, currentLine.EndTime, companyViewModel.TimeSheetPerHalfDay);
                                lines.AddLine(new TimeSheetLineReportInformationsViewModel(line)
                                {
                                    Details = currentLine.Details,
                                    ChargeInDay = dayHour.Day,
                                    ChargeInHour = dayHour.Hour
                                });
                                counter++;
                            }
                            while (counter < withDetails.Count);
                        }
                    });
                }
                else
                {
                    line.Details = timesheetDay.TimeSheetLine.Any(m => m.IdDayOff.HasValue) ?
                        timesheetDay.TimeSheetLine.FirstOrDefault(m => m.IdDayOff.HasValue).IdDayOffNavigation.Label : string.Empty;
                    line.ChargeInDay = NumberConstant.Zero;
                    line.ChargeInHour = NumberConstant.Zero;
                    lines.AddLine(line);
                }
            });
            return lines;
        }

        /// <summary>
        /// Get ExitEmployee Informations for reporting
        /// </summary>
        /// <param name="idExitEmployee"></param>
        /// <returns></returns>
        public ExitEmployeeInformationsViewModel GetExitEmployeeLeaveInformations(int idExitEmployee, int period, int idLeaveType)
        {
            // Get report company information
            ReportCompanyInformationViewModel reportCompanyInformationViewModel = _serviceCompany.GetReportCompanyInformation();
            ExitEmployee exitEmployee = _entityRepoExitEmployee.GetAllWithConditionsRelations(x => x.Id == idExitEmployee, x => x.IdEmployeeNavigation).FirstOrDefault();
            DateTime ExitPhysicalDate = exitEmployee.ExitPhysicalDate ?? DateTime.Now;
            ExitEmployeeInformationsViewModel exitEmployeeLeaveInformationsViewModel = new ExitEmployeeInformationsViewModel(reportCompanyInformationViewModel)
            {
                EmployeeFullName = exitEmployee.IdEmployeeNavigation.FullName,
                Email = exitEmployee.IdEmployeeNavigation.Email,
                ExitPhysicalDate = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(ExitPhysicalDate.ToString("dd/MM/yyyy", CultureInfo.CreateSpecificCulture("fr-FR"))),
                HiringDate = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(exitEmployee.IdEmployeeNavigation.HiringDate.ToString("dd/MM/yyyy", CultureInfo.CreateSpecificCulture("fr-FR"))),
                Label = _entityRepoLeaveType.FindSingleBy(x => x.Id == idLeaveType).Label,
                CompanyLogo = _serviceCompany.GetReportCompanyInformation().CompanyLogo,
                Rib = string.Empty,
                BankName = string.Empty
            };
            return exitEmployeeLeaveInformationsViewModel;

        }

        /// <summary>
        /// Get list of ExitEmployee Leave for reporting 
        /// </summary>
        /// <param name="idExitEmployee"></param>
        /// <returns></returns>
        public IList<ExitEmployeeLeaveLineViewModel> GetExitEmployeeLeaveLines(int idExitEmployee,int period , int idLeaveType)
        {
            List<ExitEmployeeLeaveLineViewModel> listOfExitEmployeeLeaveViewModel = _serviceExitEmployeeLeaveLine.GetAllModelsWithRelations(x => x.IdLeaveTypeNavigation)
                .OrderBy(x => x.IdLeaveType).ThenBy(x => x.Month).ThenBy(x => x.Year)
                .Where(x => x.IdExitEmployee == idExitEmployee && x.IdLeaveType == idLeaveType && x.IdLeaveTypeNavigation.Period == period).ToList();
            if (period == (int)LeaveTypePeriod.Monthly)
            {
                listOfExitEmployeeLeaveViewModel.ForEach(e => e.MonthString = e.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            }
            return listOfExitEmployeeLeaveViewModel;

        }

       
    }
}
