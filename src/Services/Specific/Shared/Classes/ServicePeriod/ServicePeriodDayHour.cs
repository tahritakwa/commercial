using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;

namespace Services.Specific.Administration.Classes.ServicePeriod
{
    /// <summary>
    /// For methods of calculating DayHour
    /// </summary>
    public partial class ServicePeriod
    {
        /// <summary>
        /// Calcul of the daysNumber and the hoursNumber  of the leave
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <returns></returns>
        public DayHour CalculateNumberOfDaysAndHour(DateTime startDate, DateTime endDate, TimeSpan startTime, TimeSpan endTime,
                                                    bool halfDay, IEnumerable<PeriodViewModel> periodViewModels = null, bool isCalendar = false)
        {
            DayHour dayHour = new DayHour();
            // Retrieve the periods crossed by the start and end dates of the leave
            IList<PeriodViewModel> intervalDatePeriods = periodViewModels is null ? GetPeriodCrossBy(startDate, endDate) :
                    periodViewModels.Where(model => startDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate) || 
                        (model.StartDate.BetweenDateLimitIncluded(startDate, endDate) && model.EndDate.BetweenDateLimitIncluded(startDate, endDate)) ||
                        endDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).ToList();
            if (!intervalDatePeriods.Any())
            {
                throw new CustomException(CustomStatusCode.ANY_PERIOD_DEFINED);
            }
            else if (intervalDatePeriods.Count == NumberConstant.One)
            {
                PeriodViewModel periodViewModel = intervalDatePeriods.FirstOrDefault();
                if (DateTime.Compare(startDate.Date, endDate.Date) == NumberConstant.Zero && startTime > endTime)
                {
                    throw new CustomException(CustomStatusCode.STARTTIME_EXCEED_ENDTIME);
                }
                IList<DateTime> validDates = isCalendar ? ValidDatesInIntervalDates(periodViewModel, startDate, endDate, isCalendar: true) :
                     ValidDatesInIntervalDates(periodViewModel, startDate, endDate);
                if (validDates.Count - NumberConstant.One < NumberConstant.Zero)
                {
                    dayHour = new DayHour();
                }
                else
                {
                    CalculateOnePeriodNumberOfDaysAndHour(dayHour, startDate, endDate, startTime, endTime, periodViewModel, validDates, halfDay);
                }
            }
            else
            {
                CalculateMoreThanOnePeriodNumberOfDaysAndHour(dayHour, startDate.Date, endDate.Date, startTime, endTime, intervalDatePeriods, halfDay, isCalendar);
            }
            double numberOfHour = CalculateHourNumber(intervalDatePeriods.FirstOrDefault(model => endDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).Hours);
            // If the number of hours is equal to the number of hours provided by the period of the end date, then it is a full day
            DayHourRound(dayHour, numberOfHour);
            return dayHour;
        }

        /// <summary>
        /// Rounds schedules and days against the maximum number of hours spent in a parameter
        /// </summary>
        /// <param name="dayHour"></param>
        /// <param name="numberOfHourPerDay"></param>
        public void DayHourRound(DayHour dayHour, double numberOfHourPerDay)
        {
            if (dayHour != null)
            {
                if (dayHour.Hour > numberOfHourPerDay)
                {
                    dayHour.Day += (int)(dayHour.Hour / numberOfHourPerDay);
                    dayHour.Hour %= numberOfHourPerDay;
                }
                else if (dayHour.Hour.IsApproximately(numberOfHourPerDay, within: 0.0001))
                {
                    dayHour.Hour = NumberConstant.Zero;
                    dayHour.Day++;
                }
                dayHour.Day = Math.Round(dayHour.Day, NumberConstant.Two);
                dayHour.Hour = Math.Round(dayHour.Hour, NumberConstant.Two);
            }
        }

        /// <summary>
        /// Rounds schedules and days against the maximum number of hours spent in a parameter
        /// </summary>
        /// <param name="numberOfDaysDayHour"></param>
        /// <param name="numberOfHourPerDay"></param>
        public void NumberOfDaysDayHourRound(NumberOfDaysDayHour numberOfDaysDayHour, double numberOfHourPerDay)
        {
            if (numberOfDaysDayHour.NumberOfDaysWorked != null)
            {
                DayHourRound(numberOfDaysDayHour.NumberOfDaysWorked, numberOfHourPerDay);
            }
            if (numberOfDaysDayHour.NumberOfLeavesDays != null)
            {
                DayHourRound(numberOfDaysDayHour.NumberOfLeavesDays, numberOfHourPerDay);
            }
            if (numberOfDaysDayHour.NumberOfDaysOff != null)
            {
                DayHourRound(numberOfDaysDayHour.NumberOfDaysOff, numberOfHourPerDay);
            }
        }

        /// <summary>
        /// Calculation of the number of days and the number of hours for a leave that spans a period
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="periodViewModels"></param>
        private void CalculateMoreThanOnePeriodNumberOfDaysAndHour(DayHour dayHour, DateTime startDate, DateTime endDate,
            TimeSpan startTime, TimeSpan endTime, IEnumerable<PeriodViewModel> periodViewModels, bool halfDay, bool isCalendar = false)
        {
            int counter = NumberConstant.One;
            IList<DateTime> validDates = new List<DateTime>();

            periodViewModels.OrderBy(m => m.StartDate).ToList().ForEach(periodViewModel =>
            {
                if (counter == NumberConstant.One)
                {
                    validDates = isCalendar ? ValidDatesInIntervalDates(periodViewModel, startDate, periodViewModel.EndDate, isCalendar: true): 
                    ValidDatesInIntervalDates(periodViewModel, startDate, periodViewModel.EndDate);               
                }
                else if (counter == periodViewModels.Count())
                {
                    validDates = isCalendar ? ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, endDate, isCalendar: true) : 
                    ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, endDate);
                }
                else
                {
                    validDates = isCalendar ? ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, periodViewModel.EndDate, isCalendar: true) : 
                    ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, periodViewModel.EndDate);
                }
                CalculateOnePeriodNumberOfDaysAndHour(dayHour, startDate, endDate, startTime, endTime, periodViewModel, validDates, halfDay);
                counter++;
            });
        }

        /// <summary>
        /// Calculation of the number of days and the number of hours for a leave that spans a period
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="periodViewModel"></param>
        /// <param name="validDates"></param>
        public void CalculateOnePeriodNumberOfDaysAndHour(DayHour dayHour, DateTime startDate, DateTime endDate, TimeSpan startTime, TimeSpan endTime,
            PeriodViewModel periodViewModel, IEnumerable<DateTime> validDates, bool halfDay)
        {
            validDates.ToList().ForEach(date =>
            {
                if (date.EqualsDate(startDate))
                {
                    if (startDate.EqualsDate(endDate))
                    {
                        dayHour.Add(CalculateDateHourNumber(periodViewModel.Hours.ToList(), startTime, endTime, halfDay));
                    }
                    else
                    {
                        dayHour.Add(CalculateDateHourNumber(periodViewModel.Hours.ToList(), startTime, periodViewModel.Hours.Max(h => h.EndTime), halfDay));
                    }
                }
                else
                {
                    if (date.EqualsDate(endDate.Date))
                    {
                        dayHour.Add(CalculateDateHourNumber(periodViewModel.Hours.ToList(), periodViewModel.Hours.Min(h => h.StartTime), endTime, halfDay));
                    }
                    else
                    {
                        dayHour.Day += NumberConstant.One;
                        dayHour.DayHourInDecimal += CalculateHourNumber(periodViewModel.Hours);
                    }
                }
            });
        }

        /// <summary>
        /// Calculates the number of hours and minutes between the start date and the end date by ignoring the unworked hours
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public DayHour CalculateDateHourNumber(IEnumerable<HoursViewModel> hoursViewModels, TimeSpan startTime, TimeSpan endTime, bool halfDay)
        {
            double hour = default;
            #region Arround of work days number
            if (halfDay)
            {
                DayHour dayHour = new DayHour();
                IList<HoursViewModel> workingHours = hoursViewModels.Where(m => m.WorkTimeTable).OrderBy(x => x.StartTime).ToList();
                if (workingHours.Count != NumberConstant.Two)
                {
                    throw new CustomException(CustomStatusCode.PERIOD_MUST_HAVE_TWO_WORKING_HOURS_FOR_TIMESHEET_PER_HALF_DAY);
                }
                if ((startTime.Equals(workingHours.First().EndTime) && endTime.Equals(workingHours.Last().StartTime)) ||
                    startTime.Equals(endTime))
                {
                    dayHour.Day = NumberConstant.Zero;
                    dayHour.DayHourInDecimal = NumberConstant.Zero;
                }
                else if (startTime.Equals(workingHours.First().StartTime) && endTime.Equals(workingHours.Last().EndTime))
                {
                    dayHour.Day = NumberConstant.One;
                    dayHour.DayHourInDecimal = CalculateHourNumber(hoursViewModels);
                }
                else
                {
                    dayHour.Day = 0.5;
                    dayHour.DayHourInDecimal = 0.5;
                }
                return dayHour;
            }
            #endregion
            if (startTime <= endTime)
            {
                hour = DurationBetweenStartTimeEndTime(startTime, endTime);
                hoursViewModels.Where(model => model.StartTime >= startTime && model.EndTime <= endTime && !model.WorkTimeTable).ToList().ForEach(hours =>
                {
                    hour -= DurationBetweenStartTimeEndTime(hours.StartTime, hours.EndTime);
                });
            }
            else
            {
                hour = DurationBetweenStartTimeEndTime(startTime, hoursViewModels.Max(hours => hours.EndTime)) +
                    DurationBetweenStartTimeEndTime(hoursViewModels.Min(hours => hours.StartTime), endTime);
                hoursViewModels.Where(model => model.StartTime >= startTime && model.EndTime <= endTime && !model.WorkTimeTable).ToList().ForEach(hours =>
                {
                    hour -= DurationBetweenStartTimeEndTime(hours.StartTime, hours.EndTime);
                });
            }
            double numberOfHoursPerDay = CalculateHourNumber(hoursViewModels);
            return new DayHour
            {
                Day = (int)(hour / numberOfHoursPerDay),
                Hour = Math.Round(hour % numberOfHoursPerDay, NumberConstant.Two),
                DayHourInDecimal = hour
            };
        }
    }
}
