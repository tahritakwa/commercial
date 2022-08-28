using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;

namespace Utils.Utilities.DataUtilities
{
    public static class DateTimeUtility
    {
        /// <summary>
        /// Check if a date is between two dates, with both edge dates included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool BetweenDateLimitIncluded(this DateTime date, DateTime startDate, DateTime endDate)
        {
            return DateTime.Compare(date.Date, startDate.Date) >= NumberConstant.Zero && DateTime.Compare(date.Date, endDate.Date) <= NumberConstant.Zero;
        }

        /// <summary>
        /// Check if a year is between two year, with both edge year included
        /// </summary>
        /// <param name="year"></param>
        /// <param name="startYear"></param>
        /// <param name="endYear"></param>
        /// <returns></returns>
        public static bool BetweenYearLimitIncluded(this int year, int startYear, int endYear)
        {
            return year >= startYear && year <= endYear;
        }

        /// <summary>
        /// Check if a date is between two dates, with both edge dates not included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool BetweenDateLimitNotIncluded(this DateTime date, DateTime startDate, DateTime endDate)
        {
            return DateTime.Compare(date.Date, startDate.Date) > NumberConstant.Zero && DateTime.Compare(date.Date, endDate.Date) < NumberConstant.Zero;
        }

        /// <summary>
        /// Check if a datetime is between two dates, with both edge dates included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool BetweenDateTimeLimitIncluded(this DateTime date, DateTime startDate, DateTime endDate)
        {
            return DateTime.Compare(date, startDate) >= NumberConstant.Zero && DateTime.Compare(date, endDate) <= NumberConstant.Zero;
        }

        /// <summary>
        /// Check if a datetime is between two dates, with both edge dates not included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool BetweenDateTimeLimitNotIncluded(this DateTime date, DateTime startDate, DateTime endDate)
        {
            return DateTime.Compare(date, startDate) > NumberConstant.Zero && DateTime.Compare(date, endDate) < NumberConstant.Zero;
        }

        /// <summary>
        /// Returns the list of dates between the calling date and a parameter date
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static IList<DateTime> AllDatesUntilLimitIncluded(this DateTime startDate, DateTime endDate, IList<DayOfWeek> dayOfWeeks = null)
        {
            DateTime start = default;
            DateTime end = default;
            IList<DateTime> allDates = new List<DateTime>();
            if (DateTime.Compare(startDate, endDate) > NumberConstant.Zero)
            {
                start = endDate;
                end = startDate;
            }
            else
            {
                start = startDate;
                end = endDate;
            }
            if (dayOfWeeks is null || dayOfWeeks.Count == NumberConstant.Zero)
            {
                while (start.Date <= end.Date)
                {
                    allDates.Add(start.Date);
                    start = start.Date.AddDays(NumberConstant.One);
                }
            }
            else
            {
                while (start.BeforeDateLimitIncluded(end))
                {
                    if (dayOfWeeks.Any(x => x.Equals(start.DayOfWeek)))
                    {
                        allDates.Add(start.Date);
                    }
                    start = start.AddDays(NumberConstant.One);
                }
            }
            return allDates;
        }

        /// <summary>
        /// Delete a list of dates from a date collection
        /// </summary>
        /// <param name="date"></param>
        /// <param name="toDeleteDate"></param>
        /// <returns></returns>
        public static IList<DateTime> RemoveDate(this IList<DateTime> date, IList<DateTime> toDeleteDate)
        {
            foreach (DateTime dateTime in toDeleteDate)
            {
                date.Remove(dateTime);
            }
            return date;
        }
        /// <summary>
        /// Check if a date is after the date passed in param
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool AfterDate(this DateTime date, DateTime startDate)
        {
            return DateTime.Compare(date.Date, startDate.Date) > NumberConstant.Zero;
        }
        /// <summary>
        /// Check if a date is after the date passed in param, with edge  included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool AfterDateLimitIncluded(this DateTime date, DateTime startDate)
        {
            return DateTime.Compare(date.Date, startDate.Date) >= NumberConstant.Zero;
        }
        /// <summary>
        /// Check if a date is before the date passed in param, with edge  included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool BeforeDate(this DateTime date, DateTime endDate)
        {
            return DateTime.Compare(date.Date, endDate.Date) < NumberConstant.Zero;
        }

        /// <summary>
        /// Check if frstDate is equals to secondDate
        /// </summary>
        /// <param name="firstDate"></param>
        /// <param name="secondDate"></param>
        /// <returns></returns>
        public static bool EqualsDate(this DateTime firstDate, DateTime secondDate)
        {
            return DateTime.Compare(firstDate.Date, secondDate.Date) == NumberConstant.Zero;
        }

        /// <summary>
        /// Check if a date is before the date passed in param
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static bool BeforeDateLimitIncluded(this DateTime date, DateTime endDate)
        {
            return DateTime.Compare(date, endDate) <= NumberConstant.Zero;
        }

        public static void Add(this DayHour firstDayHour, DayHour secondDayHour)
        {
            firstDayHour.Day += secondDayHour.Day;
            firstDayHour.Hour += secondDayHour.Hour;
            firstDayHour.DayHourInDecimal += secondDayHour.DayHourInDecimal;
        }

        public static void Substract(this DayHour firstDayHour, DayHour secondDayHour, double numberOfHourPerDay)
        {
            firstDayHour.Day += firstDayHour.Hour / numberOfHourPerDay;
            double tmp = secondDayHour.Day + secondDayHour.Hour / numberOfHourPerDay;
            double numberOfDays = firstDayHour.Day - tmp;
            firstDayHour.Day = Math.Truncate(numberOfDays);
            firstDayHour.Hour = (numberOfDays - firstDayHour.Day) * numberOfHourPerDay;
        }

        public static DateTime LastDateOfMonth(this DateTime dateTime)
        {
            return new DateTime(dateTime.Year, dateTime.Month, DateTime.DaysInMonth(dateTime.Year, dateTime.Month));
        }

        public static DateTime LastDateOfYear(this DateTime dateTime)
        {
            return new DateTime(dateTime.Year, NumberConstant.Twelve, NumberConstant.ThirtyOne);
        }

        public static DateTime FirstDateOfMonth(this DateTime dateTime)
        {
            return new DateTime(dateTime.Year, dateTime.Month, NumberConstant.One);
        }

        public static DateTime FirstDateOfYear(this DateTime dateTime)
        {
            return new DateTime(dateTime.Year, NumberConstant.One, NumberConstant.One);
        }

        public static DateTime FirstDateFromDayOfWeek(this DateTime date, DayOfWeek dayOfWeek)
        {
            int diff = (dayOfWeek - date.DayOfWeek + NumberConstant.Seven) % NumberConstant.Seven;
            return date.AddDays(diff).Date;
        }

        /// <summary>
        /// The day preceding the day in parameter
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static DateTime PreviousDate(this DateTime dateTime)
        {
            return dateTime.AddDays(-NumberConstant.One);
        }

        /// <summary>
        /// The day following the day in parameter
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static DateTime NextDate(this DateTime dateTime)
        {
            return dateTime.AddDays(NumberConstant.One);
        }

        public static DateTime GetDateOfNullableDateTime(this DateTime? dateTime)
        {
            return ((DateTime)dateTime).Date;
        }

        /// <summary>
        /// Get first day of each month between two given dates
        /// </summary>
        /// <param name="firstDate"></param>
        /// <param name="secondDate"></param>
        /// <returns></returns>
        public static IList<DateTime> GetFirstDatesOfMonths(this DateTime firstDate, DateTime secondDate)
        {
            List<DateTime> dates = new List<DateTime>();
            DateTime date = firstDate < secondDate ? firstDate.FirstDateOfMonth() : secondDate.FirstDateOfMonth();
            DateTime endDate = firstDate > secondDate ? firstDate.FirstDateOfMonth() : secondDate.FirstDateOfMonth();
            while (date.BeforeDateLimitIncluded(endDate))
            {
                dates.Add(date);
                date = date.AddMonths(NumberConstant.One);
            }
            return dates;
        }

        /// <summary>
        /// Allows you to check if a contract or a premium covers an entire month
        /// </summary>
        /// <param name="month"></param>
        /// <param name="remunerationStartDate"></param>
        /// <param name="remunerationEndDate"></param>
        /// <returns></returns>
        public static bool CheckDateCoverWholeMonth(this DateTime month, DateTime remunerationStartDate, DateTime? remunerationEndDate)
        {
            DateTime startDate = month.FirstDateOfMonth();
            DateTime endDate = month.LastDateOfMonth();
            if (remunerationStartDate.BeforeDateLimitIncluded(startDate))
            {
                if (remunerationEndDate.HasValue && remunerationEndDate.Value.BeforeDateLimitIncluded(endDate))
                {
                    endDate = remunerationEndDate.Value;
                }
            }
            else
            {
                startDate = remunerationStartDate;
                if (remunerationEndDate.HasValue && remunerationEndDate.Value.BeforeDateLimitIncluded(endDate))
                {
                    endDate = remunerationEndDate.Value;
                }
            }
            return startDate.EqualsDate(month.FirstDateOfMonth()) && endDate.EqualsDate(month.LastDateOfMonth());
        }

        /// <summary>
        /// Return number of months between two dates
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static double TotalMonths(this DateTime startDate, DateTime endDate, bool isForLeaveBalance = true)
        {
            double nbMonth = NumberConstant.Zero;
            if (endDate.BeforeDate(startDate))
            {
                DateTime temp = startDate;
                startDate = endDate;
                endDate = temp;
            }
            if (startDate.Month == endDate.Month && startDate.Year == endDate.Year)
            {
                return nbMonth;
            }
            if (isForLeaveBalance)
            {
                nbMonth += startDate.Day < DateTime.DaysInMonth(startDate.Year, startDate.Month) / NumberConstant.Two ? NumberConstant.One : NumberConstant.Half;
                startDate = startDate.AddMonths(NumberConstant.One).FirstDateOfMonth();
            }
            double restfMonth = Math.Abs(NumberConstant.Twelve * (startDate.Year - endDate.Year) + startDate.Month - endDate.Month);
            nbMonth += restfMonth;
            return nbMonth;
        }

        /// <summary>
        /// Return number of years between two dates
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static uint TotalYears(this DateTime startDate, DateTime endDate)
        {
            if (endDate.BeforeDate(startDate))
            {
                DateTime temp = startDate;
                startDate = endDate;
                endDate = temp;
            }
            uint nbMonth = Convert.ToUInt32((endDate - startDate).TotalDays / 365.25);
            return nbMonth;
        }
        /// <summary>
        /// Compare dates if the dates is an equals move to compare time 
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <returns></returns>
        public static bool AfterDateAndTimeLimitIncluded(this DateTime date, DateTime startDate)
        {
            bool verifyDate = DateTime.Compare(date.Date, startDate.Date) >= NumberConstant.Zero;
            bool verifyEqualsDate = DateTime.Compare(date.Date, startDate.Date) == NumberConstant.Zero;
            if (verifyEqualsDate)
            {
                return TimeSpan.Compare(date.TimeOfDay, startDate.TimeOfDay) >= NumberConstant.Zero;
            }
            else
            {
                return verifyDate;
            }
        }
    }
}
