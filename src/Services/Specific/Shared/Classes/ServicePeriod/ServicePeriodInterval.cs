using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;

namespace Services.Specific.Administration.Classes.ServicePeriod
{
    /// <summary>
    /// For methods of calculating date intervals
    /// </summary>
    public partial class ServicePeriod
    {

        /// <summary>
        /// It returns the number of days in the month in parameter.
        /// If the argument dependOnPeriod is true, the calculation takes into account 
        /// the periods of the month, otherwise it returns the number of calendar days in the month
        /// </summary>
        /// <param name="month"></param>
        /// <returns></returns>
        public double NumberOfDaysWorkedByCompanyInMonth(DateTime month)
        {
            CompanyViewModel companyViewModel = GetCurrentCompany();
            double daysInMonth = default;
            if (!companyViewModel.PayDependOnTimesheet)
            {
                return companyViewModel.DaysOfWork ?? DateTime.DaysInMonth(month.Year, month.Month);
            }
            if (companyViewModel.DaysOfWork.HasValue)
            {
                return companyViewModel.DaysOfWork.Value;
            }
            DateTime startDate = month.FirstDateOfMonth();
            DateTime endDate = month.LastDateOfMonth();
            IList<PeriodViewModel> periodViewModels = GetPeriodCrossBy(startDate, endDate);
            int counter = NumberConstant.One;
            if (periodViewModels.Count == NumberConstant.One)
            {
                return ValidDatesInIntervalDates(periodViewModels.First(), startDate, endDate, dayOffIsInValid: false).Count;
            }
            periodViewModels.OrderBy(m => m.StartDate).ToList().ForEach(periodViewModel =>
            {
                if (counter == NumberConstant.One)
                {
                    daysInMonth += ValidDatesInIntervalDates(periodViewModel, startDate, periodViewModel.EndDate, dayOffIsInValid: false).Count;
                }
                else if (counter == periodViewModels.Count)
                {
                    daysInMonth += ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, endDate, dayOffIsInValid: false).Count;
                }
                else
                {
                    daysInMonth += ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, periodViewModel.EndDate, dayOffIsInValid: false).Count;
                }
                counter++;
            });
            return daysInMonth;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public double NumberOfDaysWorkedCompanyBetweenDates(DateTime startDate, DateTime endDate)
        {
            double daysInMonth = default;
            IList<PeriodViewModel> periodViewModels = GetPeriodCrossBy(startDate, endDate);
            int counter = NumberConstant.One;
            if (periodViewModels.Count == NumberConstant.One)
            {
                return ValidDatesInIntervalDates(periodViewModels.First(), startDate, endDate, dayOffIsInValid: false).Count;
            }
            periodViewModels.OrderBy(m => m.StartDate).ToList().ForEach(periodViewModel =>
            {
                if (counter == NumberConstant.One)
                {
                    daysInMonth += ValidDatesInIntervalDates(periodViewModel, startDate, periodViewModel.EndDate, dayOffIsInValid: false).Count;
                }
                else if (counter == periodViewModels.Count)
                {
                    daysInMonth += ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, endDate, dayOffIsInValid: false).Count;
                }
                else
                {
                    daysInMonth += ValidDatesInIntervalDates(periodViewModel, periodViewModel.StartDate, periodViewModel.EndDate, dayOffIsInValid: false).Count;
                }
                counter++;
            });
            return daysInMonth;
        }

        /// <summary>
        /// It returns the number of days between the start date and the end date.
        /// If the pay engine depend on timeheet, the calculation takes into account the periods 
        /// corresponding to the start and end date interval. 
        /// Otherwise it returns the number of calendar days between the start date and the date
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public double NumberOfDaysInIntervalDates(DateTime startDate, DateTime endDate, bool dependOnTimeSheet)
        {
            return dependOnTimeSheet ?
                ValidDatesInIntervalDates(startDate, endDate, dayOffIsInValid: false).Count :
                startDate.AllDatesUntilLimitIncluded(endDate, GetCurrentCompany().DaysOfWeekWorked).Count;
        }


        /// <summary>
        /// Return the list of valid dates between the start date and the end date corresponding to a period. It ignores the days off of the period if withOutDayOff is false
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="dayOffIsInValid"></param>
        /// <returns></returns>
        public IList<DateTime> ValidDatesInIntervalDates(PeriodViewModel periodViewModel, bool dayOffIsInValid = true)
        {
            if (periodViewModel is null)
            {
                throw new ArgumentException("");
            }
            // Retrieve date between period startdate date and period enddate, start and end date included
            IList<DateTime> validDates = periodViewModel.StartDate.AllDatesUntilLimitIncluded(periodViewModel.EndDate);
            // Add to the list of invalid dates days off of this period
            IList<DateTime> invalidDates = (dayOffIsInValid == true && periodViewModel.DayOff != null && periodViewModel.DayOff.Count > NumberConstant.Zero) ?
                periodViewModel.DayOff.Select(model => model.Date).ToList() : new List<DateTime>();
            // Call overloaded one which accept in parameter the list of valid and invalid dates
            return ValidDatesInIntervalDates(periodViewModel, validDates, invalidDates);
        }

        /// <summary>
        /// Return the list of valid dates between the start date and the end date corresponding to a period. It ignores the days off of the period if withOutDayOff is false
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="dayOffIsInValid"></param>
        /// <returns></returns>
        public IList<DateTime> ValidDatesInIntervalDates(PeriodViewModel periodViewModel, DateTime startDate, DateTime endDate, bool dayOffIsInValid = true, bool isCalendar = false)
        {
            if (periodViewModel is null)
            {
                throw new ArgumentException("");
            }
            // Retrieve date between start date and end date, start and end date included
            IList<DateTime> validDates = startDate.AllDatesUntilLimitIncluded(endDate);
            // Add to the list of invalid dates days off of this period
            IList<DateTime> invalidDates = (dayOffIsInValid == true && periodViewModel.DayOff != null && periodViewModel.DayOff.Count > NumberConstant.Zero) ?
                periodViewModel.DayOff.Where(m => m.Date.BetweenDateLimitIncluded(startDate, endDate)).Select(m => m.Date).ToList() : new List<DateTime>();
            // Call overloaded one which accept in parameter the list of valid and invalid dates
            return ValidDatesInIntervalDates(periodViewModel, validDates, invalidDates, isCalendar);
        }

        /// <summary>
        /// Return the list of valid dates between the start date and the end date
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="dayOffIsInValid"></param>
        /// <returns></returns>
        public IList<DateTime> ValidDatesInIntervalDates(DateTime startDate, DateTime endDate, bool dayOffIsInValid = true)
        {
            List<DateTime> validDates = new List<DateTime>();
            List<DateTime> validDatesInInterval = new List<DateTime>();
            IList<PeriodViewModel> periodViewModels = GetPeriodCrossBy(startDate, endDate);
            periodViewModels.ToList().ForEach(periodViewModel =>
            {
                if (periodViewModel.EndDate.BeforeDate(endDate))
                {
                    validDatesInInterval = ValidDatesInIntervalDates(periodViewModel, startDate, periodViewModel.EndDate, dayOffIsInValid).ToList();
                    startDate = periodViewModel.EndDate.AddDays(NumberConstant.One);
                }
                else
                {
                    validDatesInInterval = ValidDatesInIntervalDates(periodViewModel, startDate, endDate, dayOffIsInValid).ToList();
                }
                validDates.AddRange(validDatesInInterval);
            });
            return validDates;
        }

        /// <summary>
        /// Return the list of valid dates, in the validDays collection without invalidDates and days not worked
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="validDays"></param>
        /// <param name="invalidDates"></param>
        /// <returns></returns>
        public IList<DateTime> ValidDatesInIntervalDates(PeriodViewModel periodViewModel, IList<DateTime> validDays, IList<DateTime> invalidDates, bool isCalendar = false)
        {
            if (periodViewModel is null)
            {
                throw new ArgumentException("");
            }
            List<int> numbers = GetListOfInvalidDayOfWeek(periodViewModel);
            validDays.ToList().ForEach(dateTime =>
            {
                if (numbers.Contains((int)dateTime.DayOfWeek))
                {
                    // Add to the list of invalid dates the days not worked
                    invalidDates.Add(dateTime);
                }
            });
            // Delete invalid dates from list of old valid dates
            validDays = isCalendar ? validDays : validDays.RemoveDate(invalidDates);
            return validDays;
        }


        /// <summary>
        /// Return list of DayOfWeek not worked in the period
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <returns></returns>
        public List<int> GetListOfInvalidDayOfWeek(PeriodViewModel periodViewModel)
        {
            if (periodViewModel.FirstDayOfWork < periodViewModel.LastDayOfWork)
            {
                List<int> numbers = Enumerable.Range(periodViewModel.LastDayOfWork + NumberConstant.One,
                    NumberConstant.Six - periodViewModel.LastDayOfWork).ToList();
                numbers.AddRange(Enumerable.Range(NumberConstant.Zero, periodViewModel.FirstDayOfWork).ToList());
                return numbers;
            }
            else if(periodViewModel.FirstDayOfWork == periodViewModel.LastDayOfWork)
            {
                List<int> numbers = Enum.GetValues(typeof(DayOfWeek)).OfType<DayOfWeek>().ToList().Select(x => (int)x).ToList();  
                numbers.RemoveAt(periodViewModel.FirstDayOfWork);
                return numbers;
            }
            else
            {
                return Enumerable.Range(periodViewModel.LastDayOfWork + NumberConstant.One,
                    periodViewModel.FirstDayOfWork - periodViewModel.LastDayOfWork - NumberConstant.One).ToList();
            }
        }
    }
}
