using Persistence.Entities;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Enumerators.RHEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.PayRoll.Classes.ServiceLeave
{
    /// <summary>
    /// Partial service dedicated to leave pay processing
    /// </summary>
    public partial class ServiceLeave
    {
        /// <summary>
        /// Calculate leave balances informations
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <returns></returns>
        public void CalculateNumberOfDaysAndHourOfLeaveBalance(LeaveViewModel leaveViewModel)
        {
            if (leaveViewModel == null)
            {
                throw new CustomException(CustomStatusCode.INVALID_START_AND_END_DATE);
            }
            if (leaveViewModel.IdLeaveType > NumberConstant.Zero)
            {
                leaveViewModel.IdLeaveTypeNavigation = _serviceLeaveType.GetModelAsNoTracked(lt => lt.Id == leaveViewModel.IdLeaveType);
                leaveViewModel.IdLeaveType = leaveViewModel.IdLeaveTypeNavigation.Id;
            }
            if (leaveViewModel.IdLeaveTypeNavigation != null)
            {
                // Reset balances to null
                leaveViewModel.PreviousYearTotalLeaveBalanceAcquired = null;
                leaveViewModel.CurrentYearTotalLeaveBalanceAcquired = null;
                leaveViewModel.TotalLeaveBalanceAcquired = null;
                leaveViewModel.PreviousYearCurrentBalance = null;
                leaveViewModel.CurrentYearCurrentBalance = null;
                leaveViewModel.LeaveBalanceRemaining = null;
                leaveViewModel.PreviousYearLeaveRemaining = null;
                leaveViewModel.CurrentYearLeaveRemaining = null;
                leaveViewModel.CurrentBalance = null;
                DateTime HiringDate = leaveViewModel.Id == NumberConstant.Zero ? _serviceEmployee.GetModelById(leaveViewModel.IdEmployee).HiringDate : leaveViewModel.IdEmployeeNavigation.HiringDate;

                DayHour dayHourLeaveBalance = new DayHour();
                // Retrieve the periods crossed by the start and end dates of the leave 
                IList<PeriodViewModel> periodViewModels = _servicePeriod.GetPeriodCrossBy(leaveViewModel.StartDate, leaveViewModel.EndDate);
                // Calculate leave number of days and hours
                leaveViewModel.NumberDaysLeave = _servicePeriod.CalculateNumberOfDaysAndHour(leaveViewModel.StartDate, leaveViewModel.EndDate, leaveViewModel.StartTime, leaveViewModel.EndTime,
                                                                                  GetCurrentCompany().TimeSheetPerHalfDay, periodViewModels, leaveViewModel.IdLeaveTypeNavigation.Calendar);
                // Calculate Hour number Of work by day  
                dayHourLeaveBalance.DayHourInDecimal = _servicePeriod.CalculateHourNumber(periodViewModels.FirstOrDefault(model => leaveViewModel.EndDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate)).Hours.ToList());
                if (leaveViewModel.IdLeaveTypeNavigation.Cumulable)
                {
                    CalculateCumulableLeavesBalance(leaveViewModel, HiringDate, dayHourLeaveBalance.DayHourInDecimal);
                }
                else
                {
                    CalculateNonCumulableLeavesBalance(leaveViewModel, HiringDate, dayHourLeaveBalance.DayHourInDecimal);
                }
                // Arround all leave balance properties
                _servicePeriod.DayHourRound(leaveViewModel.PreviousYearTotalLeaveBalanceAcquired, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.CurrentYearTotalLeaveBalanceAcquired, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.TotalLeaveBalanceAcquired, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.PreviousYearCurrentBalance, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.CurrentYearCurrentBalance, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.LeaveBalanceRemaining, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.PreviousYearLeaveRemaining, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.CurrentYearLeaveRemaining, dayHourLeaveBalance.DayHourInDecimal);
                _servicePeriod.DayHourRound(leaveViewModel.CurrentBalance, dayHourLeaveBalance.DayHourInDecimal);
            }
        }

        /// <summary>
        /// Calculation of leave balance for a type of cumulative leave
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="HiringDate"></param>
        /// <param name="numberHoursOfPeriod"></param>
        public void CalculateCumulableLeavesBalance(LeaveViewModel leaveViewModel, DateTime HiringDate, double numberHoursOfPeriod = 0)
        {
            DateTime today = DateTime.Today;
            DateTime firstDateOfYear = today.FirstDateOfYear();
            DateTime lastDateOfYear = today.LastDateOfYear();
            // Get current company for now if company work in hour or half day
            CompanyViewModel companyViewModel = GetCurrentCompany();
            if (leaveViewModel.IdLeaveTypeNavigation.ExpiryDate.HasValue)
            {
                DateTime expirationDate = new DateTime(firstDateOfYear.Year, leaveViewModel.IdLeaveTypeNavigation.ExpiryDate.Value.Month, leaveViewModel.IdLeaveTypeNavigation.ExpiryDate.Value.Day);
                DateTime begining = new DateTime(firstDateOfYear.Year - NumberConstant.One, NumberConstant.One, NumberConstant.One);
                begining = HiringDate.BeforeDate(begining) ? begining : HiringDate;
                IList<PeriodViewModel> periodViewModels = _servicePeriod.GetExistingPeriodCrossBy(begining, lastDateOfYear);
                if (leaveViewModel.StartDate.BeforeDateLimitIncluded(expirationDate) && leaveViewModel.EndDate.BeforeDateLimitIncluded(expirationDate))
                {
                    CalculateCumulableLeavesForLeaveStartDateBeforeAndEndDateBeforeExpirationDate(leaveViewModel, begining, expirationDate, periodViewModels,
                            companyViewModel.TimeSheetPerHalfDay, numberHoursOfPeriod);
                }
                else if (leaveViewModel.StartDate.BeforeDateLimitIncluded(expirationDate) && leaveViewModel.EndDate.AfterDate(expirationDate))
                {
                    CalculateCumulableLeavesForLeaveStartDateBeforeExpirationDateEndDateAfter(leaveViewModel, begining, expirationDate, periodViewModels,
                        companyViewModel.TimeSheetPerHalfDay, numberHoursOfPeriod);
                }
                else
                {
                    CalculateCumulableLeavesForLeaveAfterExpirationDate(leaveViewModel, begining, expirationDate, periodViewModels,
                        companyViewModel.TimeSheetPerHalfDay, numberHoursOfPeriod);
                }
            }
            else
            {
                CalculateCumulableLeavesWithoutExpirationDate(leaveViewModel, HiringDate, numberHoursOfPeriod);
            }
        }

        /// <summary>
        /// Leave balance calculation for a type of cumulable leave whose pending leave start date is lower than the expiration date and endate date greater than expiration date
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="leaveType"></param>
        /// <param name="beginingDate"></param>
        /// <param name="expirationDate"></param>
        /// <param name="periodViewModels"></param>
        /// <param name="perHalfDay"></param>
        /// <param name="numberHoursOfPeriod"></param>
        private void CalculateCumulableLeavesForLeaveStartDateBeforeExpirationDateEndDateAfter(LeaveViewModel leaveViewModel, DateTime beginingDate, DateTime expirationDate,
            IList<PeriodViewModel> periodViewModels, bool perHalfDay, double numberHoursOfPeriod)
        {
            // Retrieve the period corresponding to the expiration date
            PeriodViewModel expirationDatePeriod = periodViewModels.FirstOrDefault(x => expirationDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate));
            // Divide the leave into two parts. A first part corresponding to the part less than or equal to the expiration date
            LeaveViewModel leavePartBeforeExpirationDate = new LeaveViewModel
            {
                Id = leaveViewModel.Id,
                StartDate = leaveViewModel.StartDate,
                EndDate = expirationDate,
                StartTime = leaveViewModel.StartTime,
                EndTime = expirationDatePeriod.Hours.OrderBy(x => x.EndTime).LastOrDefault().EndTime,
                IdLeaveType = leaveViewModel.IdLeaveType,
                IdLeaveTypeNavigation = leaveViewModel.IdLeaveTypeNavigation,
                IdEmployee = leaveViewModel.IdEmployee,
                IdEmployeeNavigation = leaveViewModel.IdEmployeeNavigation
            };
            // Calculate the child leave balance corresponding to the part before the expiration date
            CalculateNumberOfDaysAndHourOfLeaveBalance(leavePartBeforeExpirationDate);
            CalculateCumulableLeavesForLeaveStartDateBeforeAndEndDateBeforeExpirationDate(leavePartBeforeExpirationDate, beginingDate, expirationDate, periodViewModels,
                            perHalfDay, numberHoursOfPeriod);
            // The day after the expiration date
            DateTime expirationDateNextDate = expirationDate.AddDays(NumberConstant.One);
            // Get the period corresponding to the day after the expiration date
            PeriodViewModel expirationXextDatePeriod = periodViewModels.FirstOrDefault(x => expirationDateNextDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate));
            // The second part of the leave which corresponds to the part after the expiration date
            LeaveViewModel leavePartAfterExpirationDate = new LeaveViewModel
            {
                Id = leaveViewModel.Id,
                StartDate = expirationDateNextDate,
                EndDate = leaveViewModel.EndDate,
                StartTime = expirationXextDatePeriod.Hours.OrderBy(x => x.StartTime).FirstOrDefault().StartTime,
                EndTime = leaveViewModel.EndTime,
                IdLeaveType = leaveViewModel.IdLeaveType,
                IdLeaveTypeNavigation = leaveViewModel.IdLeaveTypeNavigation,
                IdEmployee = leaveViewModel.IdEmployee,
                IdEmployeeNavigation = leaveViewModel.IdEmployeeNavigation
            };
            // Calculate the child leave balance corresponding to the part after the expiration date
            CalculateNumberOfDaysAndHourOfLeaveBalance(leavePartAfterExpirationDate);
            CalculateCumulableLeavesForLeaveAfterExpirationDate(leavePartAfterExpirationDate, beginingDate, expirationDate, periodViewModels,
                        perHalfDay, numberHoursOfPeriod);
            // The operations applicable on the two child leaves to get parent leave informations
            leaveViewModel.PreviousYearCurrentBalance = leavePartBeforeExpirationDate.PreviousYearCurrentBalance;
            leaveViewModel.CurrentYearCurrentBalance = leavePartBeforeExpirationDate.CurrentYearCurrentBalance;
            leaveViewModel.PreviousYearLeaveRemaining = leavePartBeforeExpirationDate.PreviousYearLeaveRemaining;
            leaveViewModel.CurrentBalance = leavePartBeforeExpirationDate.CurrentBalance;
            leaveViewModel.PreviousYearTotalLeaveBalanceAcquired = leavePartBeforeExpirationDate.PreviousYearTotalLeaveBalanceAcquired;
            leaveViewModel.CurrentYearTotalLeaveBalanceAcquired = leavePartBeforeExpirationDate.CurrentYearTotalLeaveBalanceAcquired;
            leaveViewModel.TotalLeaveBalanceAcquired = leavePartBeforeExpirationDate.TotalLeaveBalanceAcquired;
            leaveViewModel.CurrentYearLeaveRemaining = new DayHour(leavePartBeforeExpirationDate.CurrentYearLeaveRemaining);
            leaveViewModel.LeaveBalanceRemaining = new DayHour(leavePartBeforeExpirationDate.CurrentBalance);
            leaveViewModel.CurrentYearLeaveRemaining.Substract(leavePartAfterExpirationDate.NumberDaysLeave, numberHoursOfPeriod);
            leaveViewModel.LeaveBalanceRemaining.Substract(leavePartBeforeExpirationDate.NumberDaysLeave, numberHoursOfPeriod);
            leaveViewModel.LeaveBalanceRemaining.Substract(leavePartAfterExpirationDate.NumberDaysLeave, numberHoursOfPeriod);
            // Exclusive treatment for validated leave. The remaining balances must equal the current balances
            if (leaveViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                leaveViewModel.CurrentBalance = leaveViewModel.LeaveBalanceRemaining;
                leaveViewModel.CurrentYearCurrentBalance = leaveViewModel.CurrentYearLeaveRemaining;
                leaveViewModel.PreviousYearCurrentBalance = leaveViewModel.PreviousYearLeaveRemaining;
            }
        }

        /// <summary>
        /// Leave balance calculation for a type of cumulable leave whose pending leave start and end date is lower than the expiration date
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="leaveType"></param>
        /// <param name="beginingDate"></param>
        /// <param name="expirationDate"></param>
        /// <param name="periodViewModels"></param>
        /// <param name="perHalfDay"></param>
        /// <param name="numberHoursOfPeriod"></param>
        private void CalculateCumulableLeavesForLeaveStartDateBeforeAndEndDateBeforeExpirationDate(LeaveViewModel leaveViewModel, DateTime beginingDate, DateTime expirationDate,
           IList<PeriodViewModel> periodViewModels, bool perHalfDay, double numberHoursOfPeriod)
        {
            DateTime today = DateTime.Today;
            // To initialize the negative part of the balance for the last year
            DayHour dayHourToSubstractInCurrentYear = new DayHour();
            // Recover the leave of the past year
            List<Leave> leaves = _entityRepo.FindByAsNoTracking(p =>
                p.IdLeaveType == leaveViewModel.IdLeaveType &&
                p.IdEmployee == leaveViewModel.IdEmployee &&
                p.Id != leaveViewModel.Id &&
                (DateTime.Compare(p.EndDate.Date, beginingDate.Date) >= NumberConstant.Zero) 
                && (DateTime.Compare(p.StartDate, expirationDate) <= NumberConstant.Zero)
                && p.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Accepted)).OrderBy(x => x.StartDate).ToList();
            double previousYearPeriod = default;
            // Get the balance of leave acquired during the current year
            double currentYearMonth = default;
            if (beginingDate.Year < today.Year)
            {
                if (leaveViewModel.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly)
                {
                    previousYearPeriod = beginingDate.TotalMonths(beginingDate.LastDateOfYear().AddMonths(NumberConstant.One));
                    currentYearMonth = expirationDate.FirstDateOfYear().TotalMonths(today);
                }
                else
                {
                    previousYearPeriod = beginingDate.TotalYears(beginingDate.LastDateOfYear().AddMonths(NumberConstant.One));
                    currentYearMonth = expirationDate.FirstDateOfYear().TotalYears(today);
                }
            }
            else
            {
                currentYearMonth = leaveViewModel.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly ?
                    beginingDate.TotalMonths(today) :
                    beginingDate.TotalYears(today);
            }
            double balanceAcquired = previousYearPeriod * leaveViewModel.IdLeaveTypeNavigation.MaximumNumberOfDays;
            // Balance acquired last year
            leaveViewModel.PreviousYearCurrentBalance = new DayHour { Day = balanceAcquired };
            // Set previous year leave with previous year balance
            leaveViewModel.PreviousYearTotalLeaveBalanceAcquired = new DayHour { Day = balanceAcquired };
            // Set total balalnce leave with previous year balance
            leaveViewModel.TotalLeaveBalanceAcquired = new DayHour { Day = balanceAcquired };
            // Balance remaining from last year
            leaveViewModel.PreviousYearLeaveRemaining = new DayHour { Day = balanceAcquired };
            // Because the leave can undergo modifications on the edges, apply the deepCopyExpressionTree
            List<Leave> previousYearLeaves = leaves.Where(p => p.EndDate.AfterDateLimitIncluded(beginingDate) && p.StartDate.BeforeDateLimitIncluded(beginingDate.LastDateOfYear())).ToList().DeepCopyByExpressionTree();
            // Balance of leave taken from the previous year
            DayHour previourYearBalance = DayHourBetweenTwoDates(periodViewModels, previousYearLeaves, beginingDate, beginingDate.LastDateOfYear(), leaveViewModel.IdLeaveTypeNavigation.Calendar, perHalfDay);
            // Subtract leave balances already taken from the current balance
            leaveViewModel.PreviousYearLeaveRemaining.Substract(previourYearBalance, numberHoursOfPeriod);
            leaveViewModel.PreviousYearCurrentBalance.Substract(previourYearBalance, numberHoursOfPeriod);
            
            double currentYearBalanceAcquired = currentYearMonth * leaveViewModel.IdLeaveTypeNavigation.MaximumNumberOfDays;
            // Set current year leave with previous year balance
            leaveViewModel.CurrentYearTotalLeaveBalanceAcquired = new DayHour { Day = currentYearBalanceAcquired };
            leaveViewModel.CurrentYearCurrentBalance = new DayHour(leaveViewModel.CurrentYearTotalLeaveBalanceAcquired);
            leaveViewModel.CurrentYearLeaveRemaining = new DayHour(leaveViewModel.CurrentYearTotalLeaveBalanceAcquired);
            leaveViewModel.TotalLeaveBalanceAcquired.Add(leaveViewModel.CurrentYearTotalLeaveBalanceAcquired);

            // Soustraire du solde de l'an dernier le solde du congé courant
            leaveViewModel.PreviousYearLeaveRemaining.Substract(leaveViewModel.NumberDaysLeave, numberHoursOfPeriod);

            // This primary treatment is done if last year's balance is positive. We check if he has not taken leave for the current year counted for the past balance
            if (leaveViewModel.PreviousYearLeaveRemaining > NumberConstant.Zero)
            {
                List<Leave> currentYearLeaves = leaves.Where(p => p.EndDate.AfterDateLimitIncluded(expirationDate.FirstDateOfYear()) && p.StartDate.BeforeDateLimitIncluded(expirationDate)).ToList();
                // Balance of leave taken from the current year before the expiration date
                DayHour currentYearBalance = DayHourBetweenTwoDates(periodViewModels, currentYearLeaves, expirationDate.FirstDateOfYear(), expirationDate, leaveViewModel.IdLeaveTypeNavigation.Calendar, perHalfDay);
                leaveViewModel.PreviousYearLeaveRemaining.Substract(currentYearBalance, numberHoursOfPeriod);
                leaveViewModel.PreviousYearCurrentBalance.Substract(currentYearBalance, numberHoursOfPeriod);
                if (leaveViewModel.PreviousYearLeaveRemaining < NumberConstant.Zero)
                {
                    dayHourToSubstractInCurrentYear = new DayHour(Math.Abs(leaveViewModel.PreviousYearLeaveRemaining.Day), Math.Abs(leaveViewModel.PreviousYearLeaveRemaining.Hour));
                    // Subtract the negative portion of last year's remaining balance from the current year balance
                    leaveViewModel.CurrentYearLeaveRemaining.Substract(dayHourToSubstractInCurrentYear, numberHoursOfPeriod);
                    leaveViewModel.PreviousYearLeaveRemaining = new DayHour();
                }
            }
            else
            {
                DayHour negativeDayHourofPreviousYearRemaining = new DayHour(Math.Abs(leaveViewModel.PreviousYearLeaveRemaining.Day), Math.Abs(leaveViewModel.PreviousYearLeaveRemaining.Hour));
                leaveViewModel.PreviousYearLeaveRemaining = new DayHour();
                leaveViewModel.CurrentYearLeaveRemaining.Substract(negativeDayHourofPreviousYearRemaining, numberHoursOfPeriod);
            }
            if (leaveViewModel.PreviousYearCurrentBalance < NumberConstant.Zero)
            {
                dayHourToSubstractInCurrentYear = new DayHour(Math.Abs(leaveViewModel.PreviousYearCurrentBalance.Day), Math.Abs(leaveViewModel.PreviousYearCurrentBalance.Hour));
                leaveViewModel.PreviousYearCurrentBalance = new DayHour();
                leaveViewModel.CurrentYearCurrentBalance.Substract(dayHourToSubstractInCurrentYear, numberHoursOfPeriod);
                leaveViewModel.CurrentYearCurrentBalance = leaveViewModel.CurrentYearCurrentBalance < NumberConstant.Zero ? new DayHour() : leaveViewModel.CurrentYearCurrentBalance;
            }
            leaveViewModel.LeaveBalanceRemaining = leaveViewModel.PreviousYearLeaveRemaining + leaveViewModel.CurrentYearLeaveRemaining;
            // Exclusive treatment for validated leave. The remaining balances must equal the current balances
            if (leaveViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                leaveViewModel.PreviousYearCurrentBalance = leaveViewModel.PreviousYearLeaveRemaining;
                leaveViewModel.CurrentYearCurrentBalance = leaveViewModel.CurrentYearLeaveRemaining;
                leaveViewModel.CurrentBalance = leaveViewModel.LeaveBalanceRemaining;
            }
            else
            {
                leaveViewModel.CurrentBalance = new DayHour(leaveViewModel.LeaveBalanceRemaining);
                leaveViewModel.CurrentBalance.Add(leaveViewModel.NumberDaysLeave);
            }
        }

        /// <summary>
        /// Leave balance calculation for a type of cumulable leave whose pending leave start date is greater than the expiration date
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="leaveType"></param>
        /// <param name="beginingDate"></param>
        /// <param name="expirationDate"></param>
        /// <param name="periodViewModels"></param>
        /// <param name="perHalfDay"></param>
        /// <param name="numberHoursOfPeriod"></param>
        private void CalculateCumulableLeavesForLeaveAfterExpirationDate(LeaveViewModel leaveViewModel, DateTime beginingDate, DateTime expirationDate,
            IList<PeriodViewModel> periodViewModels, bool perHalfDay, double numberHoursOfPeriod)
        {
            DateTime today = DateTime.Today;
            DateTime lastDateOfYear = expirationDate.LastDateOfYear();
            // Récupérer les congés depuis l'année passée
            List<Leave> leaves = _entityRepo.FindByAsNoTracking(p =>
                p.IdLeaveType == leaveViewModel.IdLeaveType &&
                p.IdEmployee == leaveViewModel.IdEmployee &&
                p.Id != leaveViewModel.Id &&
                DateTime.Compare(p.EndDate.Date, beginingDate.Date) >= NumberConstant.Zero
                && p.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Accepted)).OrderBy(x => x.StartDate).ToList();

            double period = leaveViewModel.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly ? beginingDate.TotalMonths(beginingDate.LastDateOfYear().AddMonths(NumberConstant.One), isForLeaveBalance: true) :
                beginingDate.TotalYears(beginingDate.LastDateOfYear().AddMonths(NumberConstant.One));
            double balanceAcquired = period * leaveViewModel.IdLeaveTypeNavigation.MaximumNumberOfDays;
            // Balance acquired last year
            DayHour lastYearAcquiredBalance = new DayHour { Day = balanceAcquired };
            // Recover leave before expiration date 
            // Apply deepCopy because the leave can undergo modifications on the edges
            List<Leave> lastYearLeaves = leaves.Where(p => p.EndDate.AfterDateLimitIncluded(beginingDate) && p.StartDate.BeforeDateLimitIncluded(expirationDate)).OrderBy(x => x.StartDate).ToList().DeepCopyByExpressionTree();
            // Balance of leave before expiration date
            DayHour dayHourUntilExpirationDate = DayHourBetweenTwoDates(periodViewModels, lastYearLeaves, beginingDate, expirationDate, leaveViewModel.IdLeaveTypeNavigation.Calendar, perHalfDay);

            // Recover the balance of leave acquired during the current year
            double currentYearMonth = leaveViewModel.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly ? expirationDate.FirstDateOfYear().TotalMonths(today) :
                expirationDate.FirstDateOfYear().TotalYears(today);
            double currentYearBalanceAcquired = currentYearMonth * leaveViewModel.IdLeaveTypeNavigation.MaximumNumberOfDays;
            DayHour currentYearAcquired = new DayHour { Day = currentYearBalanceAcquired };
            leaveViewModel.TotalLeaveBalanceAcquired = new DayHour(currentYearAcquired);
            leaveViewModel.LeaveBalanceRemaining = new DayHour(currentYearAcquired);

            // Substract the previous year acquired balance for get balance taken current year
            dayHourUntilExpirationDate.Substract(lastYearAcquiredBalance, numberHoursOfPeriod);
            if (dayHourUntilExpirationDate > NumberConstant.Zero)
            {
                // If the value is greater than 0 then it is reconciled in the balance for the current year
                leaveViewModel.LeaveBalanceRemaining.Substract(dayHourUntilExpirationDate, numberHoursOfPeriod);
            }
            // Recover leave taken after the expiration date
            List<Leave> currentYearleavesafterExpirationDate = leaves.Where(p => p.StartDate.BetweenDateLimitIncluded(expirationDate.AddDays(NumberConstant.One), expirationDate.LastDateOfYear()) ||
                expirationDate.BetweenDateLimitIncluded(p.StartDate, p.EndDate)).ToList();
            DayHour currentYearBalanceAfterExpirationDate = DayHourBetweenTwoDates(periodViewModels, currentYearleavesafterExpirationDate, expirationDate.AddDays(NumberConstant.One), expirationDate.LastDateOfYear(), leaveViewModel.IdLeaveTypeNavigation.Calendar, perHalfDay);
            leaveViewModel.LeaveBalanceRemaining.Substract(currentYearBalanceAfterExpirationDate, numberHoursOfPeriod);
            // Subtract the balance of the current leave
            leaveViewModel.LeaveBalanceRemaining.Substract(leaveViewModel.NumberDaysLeave, numberHoursOfPeriod);
            // Exclusive treatment for validated leave. The remaining balances must equal the current balances
            if (leaveViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                leaveViewModel.CurrentBalance = leaveViewModel.LeaveBalanceRemaining;
            }
            else
            {
                leaveViewModel.CurrentBalance = new DayHour(leaveViewModel.LeaveBalanceRemaining);
                leaveViewModel.CurrentBalance.Add(leaveViewModel.NumberDaysLeave);
            }
        }

        /// <summary>
        /// Leave balance calculation for a type of non-cumulable leave
        /// </summary>
        /// <param name="leaveViewModel"></param>
        /// <param name="HiringDate"></param>
        /// <param name="numberHoursOfPeriod"></param>
        private void CalculateNonCumulableLeavesBalance(LeaveViewModel leaveViewModel, DateTime HiringDate, double numberHoursOfPeriod)
        {
            DateTime startDate = default;
            DateTime endDate = default;
            DateTime today = DateTime.Today;
            DateTime firstDateOfPeriod = default;
            DateTime lastDateOfPeriod = default;
            // Get current company for now if company work in hour or half day
            CompanyViewModel companyViewModel = GetCurrentCompany();
            double period = default;
            if (leaveViewModel.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly)
            {
                startDate = HiringDate.BeforeDate(DateTime.Today.FirstDateOfMonth().AddMonths(NumberConstant.MinusOne)) ? DateTime.Today.FirstDateOfMonth().AddMonths(NumberConstant.MinusOne) : HiringDate;
                endDate = startDate.LastDateOfMonth().AddDays(NumberConstant.One);
                period = startDate.TotalMonths(endDate);
                firstDateOfPeriod = today.FirstDateOfMonth();
                lastDateOfPeriod = today.LastDateOfMonth();
            }
            else
            {
                startDate = HiringDate.BeforeDate(DateTime.Today.FirstDateOfYear().AddYears(NumberConstant.MinusOne)) ? DateTime.Today.FirstDateOfYear().AddYears(NumberConstant.MinusOne) : HiringDate;
                endDate = startDate.AddYears(NumberConstant.One);
                period = startDate.TotalYears(endDate);
                firstDateOfPeriod = today.FirstDateOfYear();
                lastDateOfPeriod = today.LastDateOfYear();
            }
            // Get leave balance acquired during the current year
            DayHour currentYearAcquired = new DayHour { Day = period * leaveViewModel.IdLeaveTypeNavigation.MaximumNumberOfDays };
            leaveViewModel.TotalLeaveBalanceAcquired = new DayHour(currentYearAcquired);
            leaveViewModel.LeaveBalanceRemaining = new DayHour(currentYearAcquired);
            leaveViewModel.CurrentBalance = new DayHour(currentYearAcquired);
            // Get current period leaves
            List<Leave> periodCorrespondingLeaves = _entityRepo.FindByAsNoTracking(p =>
                p.IdLeaveType == leaveViewModel.IdLeaveType &&
                p.IdEmployee == leaveViewModel.IdEmployee &&
                p.Id != leaveViewModel.Id &&
                DateTime.Compare(p.EndDate.Date, firstDateOfPeriod.Date) >= NumberConstant.Zero
                && DateTime.Compare(p.StartDate, lastDateOfPeriod) <= NumberConstant.Zero
                && p.Status.Equals((int)AdministrativeDocumentStatusEnumerator.Accepted)).OrderBy(x => x.StartDate).ToList();
            // Get all periods cross by start and endate
            IList<PeriodViewModel> periodViewModels = _servicePeriod.GetExistingPeriodCrossBy(firstDateOfPeriod, lastDateOfPeriod);
            DayHour leavesTakenInPeriod = DayHourBetweenTwoDates(periodViewModels, periodCorrespondingLeaves, firstDateOfPeriod, lastDateOfPeriod,
                leaveViewModel.IdLeaveTypeNavigation.Calendar, companyViewModel.TimeSheetPerHalfDay);
            leaveViewModel.LeaveBalanceRemaining.Substract(leavesTakenInPeriod, numberHoursOfPeriod);
            // Subtract the balance of the current leave
            leaveViewModel.LeaveBalanceRemaining.Substract(leaveViewModel.NumberDaysLeave, numberHoursOfPeriod);
            // Exclusive treatment for validated leave. The remaining balances must equal the current balances
            if (leaveViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                leaveViewModel.CurrentBalance = leaveViewModel.LeaveBalanceRemaining;
            }
            else
            {
                leaveViewModel.CurrentBalance = new DayHour(leaveViewModel.LeaveBalanceRemaining);
                leaveViewModel.CurrentBalance.Add(leaveViewModel.NumberDaysLeave);
            }
        }

        /// <summary>
        /// Calculation of the duration of leave already taken between a start date and an end date
        /// </summary>
        /// <param name="periodViewModels"></param>
        /// <param name="leaves"></param>
        /// <param name="firstDateOfYear"></param>
        /// <param name="lastDateOfYear"></param>
        /// <param name="isCalenDar"></param>
        /// <param name="perHalfDay"></param>
        /// <param name="numberHoursOfPeriod"></param>
        /// <returns></returns>
        private DayHour DayHourBetweenTwoDates(IList<PeriodViewModel> periodViewModels, List<Leave> leaves, DateTime firstDateOfYear, DateTime lastDateOfYear, bool isCalenDar, bool perHalfDay, double numberHoursOfPeriod = 0)
        {
            DayHour dayHour = new DayHour();
            if (leaves.Any())
            {
                if (leaves.First().StartDate.BeforeDate(firstDateOfYear))
                {
                    leaves.First().StartDate = firstDateOfYear;
                    leaves.First().StartTime = periodViewModels.First(x => leaves.First().StartDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate)).Hours.OrderBy(x => x.StartTime).First().StartTime;
                }
                if (leaves.Last().EndDate.AfterDate(lastDateOfYear))
                {
                    leaves.Last().EndDate = lastDateOfYear;
                    leaves.Last().EndTime = periodViewModels.First(x => leaves.Last().EndDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate)).Hours.OrderBy(x => x.EndTime).Last().EndTime;
                }
                leaves.ForEach(leave =>
                {
                    DayHour currentLeaveDayHOur = _servicePeriod.CalculateNumberOfDaysAndHour(leave.StartDate, leave.EndDate, leave.StartTime,
                        leave.EndTime, perHalfDay, periodViewModels, isCalenDar);
                    dayHour.Add(currentLeaveDayHOur);
                });
                // Get period of the last date
                PeriodViewModel curentPeriod = periodViewModels.FirstOrDefault(model => leaves.Last().EndDate.BetweenDateLimitIncluded(model.StartDate, model.EndDate));
                numberHoursOfPeriod = numberHoursOfPeriod.IsApproximately(NumberConstant.Zero) ?
                    _servicePeriod.CalculateDateHourNumber(curentPeriod.Hours.ToList(), curentPeriod.Hours.FirstOrDefault().StartTime, curentPeriod.Hours.LastOrDefault().EndTime,
                                                                                perHalfDay).DayHourInDecimal :
                     numberHoursOfPeriod;
                _servicePeriod.DayHourRound(dayHour, numberHoursOfPeriod);
            }
            return dayHour;
        }

        /// <summary>
        /// Calculation of leave balance for a type of cumulative leave without expiration date
        /// </summary>
        /// <param name="leaveType"></param>
        /// <param name="leaveViewModel"></param>
        /// <param name="idEmployee"></param>
        /// <param name="HiringDate"></param>
        /// <param name="numberHoursOfPeriod"></param>
        public void CalculateCumulableLeavesWithoutExpirationDate(LeaveViewModel leaveViewModel, DateTime HiringDate, double numberHoursOfPeriod = 0)
        {
            //calculate the number of Month of work for each employee
            double period = leaveViewModel.IdLeaveTypeNavigation.Period == (int)LeaveTypePeriod.Monthly ? HiringDate.TotalMonths(DateTime.Today, isForLeaveBalance: true) : HiringDate.TotalYears(DateTime.Today);
            double balanceAcquired = period * leaveViewModel.IdLeaveTypeNavigation.MaximumNumberOfDays;
            leaveViewModel.TotalLeaveBalanceAcquired = new DayHour { Day = balanceAcquired };
            leaveViewModel.CurrentBalance = new DayHour { Day = balanceAcquired };
            leaveViewModel.LeaveBalanceRemaining = new DayHour { Day = balanceAcquired };
            DayHour balancealreadyTaken = CalculateNumberOfDaysAndHourOfAllLeaveRequest(leaveViewModel.IdLeaveTypeNavigation, leaveViewModel.IdEmployee, numberHoursOfPeriod, leaveViewModel.Id);
            leaveViewModel.CurrentBalance.Substract(balancealreadyTaken, numberHoursOfPeriod);
            leaveViewModel.LeaveBalanceRemaining.Substract(balancealreadyTaken, numberHoursOfPeriod);
            leaveViewModel.LeaveBalanceRemaining.Substract(leaveViewModel.NumberDaysLeave, numberHoursOfPeriod);
            // Exclusive treatment for validated leave. The remaining balances must equal the current balances, so not count current leave balance
            if (leaveViewModel.Status == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                leaveViewModel.CurrentBalance.Substract(leaveViewModel.NumberDaysLeave, numberHoursOfPeriod);
            }
        }
    }
}
