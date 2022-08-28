using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;

namespace Services.Specific.Administration.Interfaces
{
    public interface IServicePeriod : IService<PeriodViewModel, Period>
    {
        IList<KeyValuePair<string, TimeSpan>> GetHoursPeriodOfDate(DateTime date);
        IList<KeyValuePair<string, TimeSpan>> GetHoursPeriodOfDate(List<HoursViewModel> hoursViewModels, bool timeSheetPerHalfDay);
        IList<DateTime> ValidDatesInIntervalDates(PeriodViewModel periodViewModel, bool withOutDayOff = true);
        IList<DateTime> ValidDatesInIntervalDates(PeriodViewModel periodViewModel, DateTime startDate, DateTime endDate, bool withOutDayOff = true, bool isCalendar = false);
        IList<DateTime> ValidDatesInIntervalDates(DateTime startDate, DateTime endDate, bool withOutDayOff = true);
        IList<DateTime> ValidDatesInIntervalDates(PeriodViewModel periodViewModel, IList<DateTime> validDays, IList<DateTime> invalidDates, bool isCalendar = false);
        double CalculateHourNumber(IEnumerable<HoursViewModel> hoursViewModels);
        PeriodViewModel GetPeriodOfDate(DateTime date);
        IList<PeriodViewModel> GetPeriodCrossBy(DateTime startDate, DateTime endDate);
        IList<PeriodViewModel> GetExistingPeriodCrossBy(DateTime startDate, DateTime endDate);
        KeyValuePair<string, TimeSpan> GetEndTimeOfPeriod(DateTime date);
        KeyValuePair<string, TimeSpan> GetStartTimeOfPeriod(DateTime date);
        PeriodViewModel VerifyPeriodOfDate(DateTime date);
        DayHour CalculateDateHourNumber(IEnumerable<HoursViewModel> hoursViewModels, TimeSpan startTime, TimeSpan endTime, bool halfDay);
        DayHour CalculateNumberOfDaysAndHour(DateTime startDate, DateTime endDate, TimeSpan startTime, TimeSpan endTime,
            bool halfDay, IEnumerable<PeriodViewModel> periodViewModels = null, bool isCalendar = false);
        void DayHourRound(DayHour dayHour, double numberOfHourPerDay);
        void NumberOfDaysDayHourRound(NumberOfDaysDayHour numberOfDaysDayHour, double numberOfHourPerDay);
        void CalculateOnePeriodNumberOfDaysAndHour(DayHour dayHour, DateTime startDate, DateTime endDate, TimeSpan startTime, TimeSpan endTime,
            PeriodViewModel periodViewModel, IEnumerable<DateTime> validDates, bool halfDay);
        double NumberOfDaysWorkedByCompanyInMonth(DateTime month);
        double NumberOfDaysWorkedCompanyBetweenDates(DateTime startDate, DateTime endDate);
        double NumberOfDaysInIntervalDates(DateTime startDate, DateTime endDate, bool dependOnTimeSheet);
        ObjectToSaveViewModel CheckIfDayOffsUpdateCorruptedPayslipOrTimesheet(PeriodViewModel periodViewModel, PeriodViewModel periodBeforUpdate = null);
        List<int> GetListOfInvalidDayOfWeek(PeriodViewModel periodViewModel);
    }
}
