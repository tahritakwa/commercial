using Microsoft.Extensions.Caching.Memory;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.Administration.Classes.ServicePeriod
{
    public partial class ServicePeriod : Service<PeriodViewModel, Period>, IServicePeriod
    {
        private readonly IRepository<TimeSheetLine> _entityTimeSheetLIne;
        private readonly IRepository<TimeSheet> _entityRepoTimeSheet;
        private readonly IRepository<Leave> _entityRepoLeave;
        private readonly IRepository<DayOff> _entityRepoDayOff;
        private readonly IRepository<Payslip> _entityRepoPayslip;

        public ServicePeriod(IRepository<Period> entityRepo,
            IRepository<TimeSheetLine> entityTimeSheetLine,
            IRepository<TimeSheet> entityTimeSheet,
            IRepository<DayOff> entityRepoDayOff,
            IRepository<Leave> entityLeave,
            IRepository<Payslip> entityRepoPayslip,
            IRepository<Company> entityCompany,
            IUnitOfWork unitOfWork,
            IPeriodBuilder builder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            ICompanyBuilder companyBuilder,
            IMemoryCache memoryCache)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, companyBuilder, memoryCache)
        {
            _entityTimeSheetLIne = entityTimeSheetLine;
            _entityRepoTimeSheet = entityTimeSheet;
            _entityRepoDayOff = entityRepoDayOff;
            _entityRepoLeave = entityLeave;
            _entityRepoPayslip = entityRepoPayslip;
            _entityRepoCompany = entityCompany;
        }

        public override object AddModelWithoutTransaction(PeriodViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            PeriodContigutuousInAddMode(model);
            ValidatePeriod(model);
            ValidateHoursAndDayOff(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(PeriodViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            PeriodViewModel periodBeforUpdate = GetModelWithRelationsAsNoTracked(m => m.Id.Equals(model.Id), m => m.DayOff, m => m.Hours);
            PeriodContigutuousInUpdateMode(model, periodBeforUpdate);
            ValidatePeriod(model);
            ValidateHoursAndDayOff(model);
            CheckPeriodUpdatingAllowed(model, periodBeforUpdate);
            var result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            if (model.UpdatePayslipAndTimeSheet)
            {
                UpdatePayslipAssociateWithPeriod(model, periodBeforUpdate);
            }
            return result;
        }

        /// <summary>
        /// Update the timesheets and payslips affected by the changes if public holidays have been changed.
        /// </summary>
        /// <param name="contract"></param>
        private void UpdatePayslipAssociateWithPeriod(PeriodViewModel periodViewModel, PeriodViewModel periodBeforUpdate)
        {
            ObjectToSaveViewModel objectToSaveViewModel = CheckIfDayOffsUpdateCorruptedPayslipOrTimesheet(periodViewModel, periodBeforUpdate);
            if (!(objectToSaveViewModel is null))
            {
                IList<Payslip> payslips = (IList<Payslip>)objectToSaveViewModel.model.Payslip;
                IList<TimeSheet> timesheets = objectToSaveViewModel.model.TimeSheet;
                IList<DateTime> datesUpDate = (IList<DateTime>)objectToSaveViewModel.model.DayOff;
                if (payslips.Any(x => x.IdSessionNavigation.State == (int)SessionStateViewModel.Closed))
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Entity), nameof(Period)}
                    };
                    throw new CustomException(CustomStatusCode.CantUpdateEntityBecauseAnyPayslipIsUsedInClosedSesion, errorParams);
                }
                //if (timesheets.Any(x => x.Document.Any(d => d.DocumentTypeCode == DocumentEnumerator.SalesInvoice && d.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft)))
                //{
                //    throw new CustomException(CustomStatusCode.CANNOT_UPDATE_BECAUSE_INVOICED_TIMEHSEET_EXIST);
                //}
                // Mark payslips wrong
                payslips = payslips.Select(x => { x.Status = (int)PayslipStatus.Wrong; return x; }).ToList();
                // get updated payslips
                IList<DayOff> updatedDayOffs = _entityRepoDayOff.FindByAsNoTracking(x => datesUpDate.Any(m => m.EqualsDate(x.Date))).ToList();
                List<Leave> leavesToUpdates = _entityRepoLeave.FindByAsNoTracking(x => updatedDayOffs.Any(y => DateTime.Compare(y.Date.Date, x.StartDate.Date) >= NumberConstant.Zero && DateTime.Compare(y.Date.Date, x.EndDate.Date)
                <= NumberConstant.Zero) && !x.IdLeaveTypeNavigation.Calendar).ToList();
                /// This part of method add a public holiday TimeSheetLine if a DayOff has been added after submission of the CRA 
                /// Or if a DayOff has been deleted, replace the corresponding TimesheetLine with a project TimeSheetLine.
                timesheets.ToList().ForEach(timeSheet =>
                {
                    List<TimeSheetLine> timeSheetLines = new List<TimeSheetLine>();
                    timeSheet.TimeSheetLine.Where(timeSheetLine => datesUpDate.Contains(timeSheetLine.Day.Date)).ToList().ForEach(timeSheetLine =>
                    {
                        DayOff dayOff = updatedDayOffs.FirstOrDefault(c => c.Date.EqualsDate(timeSheetLine.Day));
                        if (dayOff is null)
                        {
                            timeSheetLine.Valid = false;
                            timeSheetLine.IdDayOff = null;
                        }
                        else
                        {
                            TimeSheetLine line = new TimeSheetLine
                            {
                                Day = dayOff.Date,
                                IdProject = null,
                                IdTimeSheet = timeSheet.Id,
                                IdDayOff = dayOff.Id,
                                StartTime = periodViewModel.Hours.OrderBy(x => x.StartTime).FirstOrDefault().StartTime,
                                EndTime = periodViewModel.Hours.OrderByDescending(x => x.EndTime).FirstOrDefault().EndTime,
                                Valid = false
                            };
                            if (timeSheetLine.IdLeave.HasValue)
                            {
                                // Update leave days and hours
                                UpdateLeaveDayAndHourNumbers(leavesToUpdates, timeSheetLine);
                            }
                            timeSheetLines.Add(line);
                        }
                    });
                    timeSheet.Status = (int)TimeSheetStatusEnumerator.ToReWork;
                    timeSheetLines.ForEach(line =>
                    {
                        timeSheet.TimeSheetLine.Add(line);
                    });
                });
                if (leavesToUpdates.Any())
                {
                    _entityRepoLeave.BulkUpdate(leavesToUpdates);
                }
                _entityRepoPayslip.BulkUpdate(payslips);
                _entityRepoTimeSheet.BulkUpdate(timesheets);
                // commit
                _unitOfWork.Commit();
            }
        }

        /// <summary>
        /// Update leave day and hour numbers
        /// </summary>
        /// <param name="leave"></param>
        private void UpdateLeaveDayAndHourNumbers(List<Leave> leavesToUpdates, TimeSheetLine timeSheetLine)
        {
            Leave leave = leavesToUpdates.FirstOrDefault(x => x.Id == timeSheetLine.IdLeave.Value);
            if (leave != null)
            {
                timeSheetLine.IsDeleted = true;
                if (leave.DaysNumber >= NumberConstant.One)
                {
                    leave.DaysNumber--;
                }
                else
                {
                    leave.HoursNumber = NumberConstant.Zero;
                }
            }
               
        }

        /// <summary>
        /// This method checks if any changes have been made to Day off that could impact the payslips and timesheets.
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="periodBeforUpdate"></param>
        /// <returns></returns>
        public ObjectToSaveViewModel CheckIfDayOffsUpdateCorruptedPayslipOrTimesheet(PeriodViewModel periodViewModel, PeriodViewModel periodBeforUpdate = null)
        {
            if (periodBeforUpdate is null)
            {
                periodBeforUpdate = GetModelWithRelationsAsNoTracked(m => m.Id.Equals(periodViewModel.Id), m => m.DayOff, m => m.Hours);
            }
            ObjectToSaveViewModel objectToSaveViewModel = new ObjectToSaveViewModel
            {
                model = new ExpandoObject(),
            };
            objectToSaveViewModel.model.DayOff = new List<DateTime>();
            objectToSaveViewModel.model.TimeSheet = new List<TimeSheet>();
            objectToSaveViewModel.model.Payslip = new List<Payslip>();
            List<DayOffViewModel> updatedDayOffs = periodViewModel.DayOff.Except((periodBeforUpdate.DayOff is null) ? new List<DayOffViewModel>() : periodBeforUpdate.DayOff, new DayOffComparer()).ToList();
            if (updatedDayOffs.Any())
            {
                List<DateTime> datesUpDate = updatedDayOffs.Select(x => x.Date.Date).ToList();
                // Get timesheets impacted by dayOff changes
                IList<TimeSheet> timesheets = _entityRepoTimeSheet.GetAllWithConditionsRelationsAsNoTracking(x => x.TimeSheetLine.Any(t => datesUpDate.Contains(t.Day.Date)),
                    m => m.TimeSheetLine,
                    //m => m.Document,
                    m => m.IdEmployeeNavigation).ToList();
                // Get payslips impacted by dayOff changes
                IList<Payslip> payslips = _entityRepoPayslip.GetAllWithConditionsRelationsAsNoTracking(x => datesUpDate.Any(d => d.FirstDateOfMonth() == x.Month.FirstDateOfMonth())
                    && x.IdSessionNavigation.DependOnTimesheet,
                    d => d.IdSessionNavigation,
                    d => d.IdEmployeeNavigation).ToList();
                if (timesheets.Any())
                {
                    timesheets.Select(x => 
                    {
                        x.TimeSheetLine.Select(y => { y.IdTimeSheetNavigation = null; return y; }).ToList();
                        x.IdEmployeeNavigation.TimeSheetIdEmployeeNavigation = null;
                        //x.Document = x.Document.Where(d => d.DocumentTypeCode == DocumentEnumerator.SalesInvoice).Select(y => { y.IdTimeSheetNavigation = null; return y; }).ToList();
                        return x;
                    }).ToList();
                }
                if (payslips.Any())
                {
                    payslips.Select(x => { x.IdSessionNavigation.Payslip = null; x.IdEmployeeNavigation.Payslip = null; return x; }).ToList();
                }
                objectToSaveViewModel.model.DayOff = datesUpDate;
                objectToSaveViewModel.model.TimeSheet = timesheets;
                objectToSaveViewModel.model.Payslip = payslips;
            }
            return objectToSaveViewModel;
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            PeriodViewModel periodViewModel = GetModelById(id);
            if (periodViewModel.CanEdit)
            {
                return base.DeleteModelwithouTransaction(id, tableName, userMail);
            }
            else
            {
                throw new CustomException(CustomStatusCode.CANT_DELETE_PERIOD);
            }
        }

        /// <summary>
        /// ValidateHoursAndDayOff: validate the contiguous of hours. validate the no duplication of dayOff
        /// </summary>
        /// <param name="model"></param>
        private void ValidateHoursAndDayOff(PeriodViewModel model)
        {
            // Validate the hours line
            IEnumerator<HoursViewModel> enumerator = model.Hours.Where(h => !h.IsDeleted).OrderBy(m => m.EndTime).GetEnumerator();
            if (enumerator.MoveNext())
            {
                HoursViewModel firstHours = enumerator.Current;
                ValidteHoursLine(firstHours);
                while (enumerator.MoveNext())
                {
                    HoursViewModel currentElement = enumerator.Current;
                    ValidteHoursLine(currentElement);
                    // Throw exception if the startTime of the line "i" is not contiguous with the endTime of the line "i-1"
                    if (!firstHours.EndTime.Equals(currentElement.StartTime))
                    {
                        IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                        {
                            {PayRollConstant.FRIST_HOUR_LABEL, firstHours.Label},
                            {PayRollConstant.SECOND_HOUR_LABEL, currentElement.Label}
                        };
                        throw new CustomException(CustomStatusCode.ContiguousHoursException, errorParams);
                    }
                    firstHours = currentElement;
                }
            }
            // Validate DaysOff
            // Check if the dayOff is not is not duplicate: considering date
            IEnumerable<IGrouping<DateTime, DayOffViewModel>> duplicateDayOff = model.DayOff.Where(x => !x.IsDeleted).GroupBy(x => x.Date.Date).Where(x => x.Count() > 1);
            if (duplicateDayOff.Any())
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(DayOff), duplicateDayOff.FirstOrDefault().Key.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                };
                throw new CustomException(CustomStatusCode.DuplicateDayOffException, paramtrs);
            }
        }

        /// <summary>
        /// Validate the model date constraints
        /// </summary>
        /// <param name="model"></param>
        private void ValidatePeriod(PeriodViewModel model)
        {
            // Check if the end date of the period is greater or equal the start date of the period
            if (DateTime.Compare(model.StartDate.Date, model.EndDate.Date) >= NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.STARTDATE_EXCEED_ENDDATE);
            }
            // Throw exception if the period doesn't have no hours line
            if (model.Hours.ToList().Count == 0)
            {
                throw new CustomException(CustomStatusCode.AddPeriodWithNoHoursException);
            }
            // Prevents the transaction over this period if there is an overlap with an already existing period
            IList<PeriodViewModel> periodViewModels = FindModelBy(period => period.Id != model.Id &&
                ( DateTime.Compare(model.StartDate.Date, period.StartDate.Date) >= NumberConstant.Zero
                && DateTime.Compare(model.StartDate.Date, period.StartDate.Date) <= NumberConstant.Zero) ||
                DateTime.Compare(model.EndDate.Date, period.StartDate.Date) >= NumberConstant.Zero 
                && DateTime.Compare(model.EndDate.Date, period.StartDate.Date) <= NumberConstant.Zero).ToList();
            if (periodViewModels.Any())
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    { nameof(Period), periodViewModels.First().Label }
                };
                throw new CustomException(CustomStatusCode.OVERLAPPING_PERIOD, errorParams);
            }
            // For all holidays in the period, check whether they are included between the start date and the end of the period
            model.DayOff.ToList().ForEach(dayOff =>
            {
                if ((DateTime.Compare(dayOff.Date.Date, model.StartDate.Date) < NumberConstant.Zero) ||
                    !dayOff.Date.BetweenDateLimitIncluded(model.StartDate, model.EndDate))
                {
                    throw new CustomException(customStatusCode: CustomStatusCode.HOLIDAY_DATE_NOT_INCLUDE_IN_PERIOD_DATE);
                }
            });
        }

        /// <summary>
        /// PeriodContigutuousInUpdateMode: methode that verify the contiguous of the period in update mode
        /// </summary>
        /// <param name="model"></param>
        private void PeriodContigutuousInUpdateMode(PeriodViewModel model, PeriodViewModel periodViewModelBeforUpdate)
        {
            // Throw exception if the period is not contiguous with the previous one or the next one    
            PeriodViewModel previousPeriod = FindModelsByNoTracked(x => x.Id != periodViewModelBeforUpdate.Id && (x.EndDate.Date.AddDays(1).CompareTo(periodViewModelBeforUpdate.StartDate.Date) == NumberConstant.Zero)).FirstOrDefault();
            PeriodViewModel nextPeriod = FindModelsByNoTracked(x => x.Id != periodViewModelBeforUpdate.Id && (x.StartDate.Date.CompareTo(periodViewModelBeforUpdate.EndDate.Date.AddDays(1)) == NumberConstant.Zero)).FirstOrDefault();
            // If previous period is not null: the startDate of the model can't be changed
            if (previousPeriod != null && (periodViewModelBeforUpdate.StartDate.Date.CompareTo(model.StartDate.Date) != NumberConstant.Zero))
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    {   nameof(DateTime.Date),
                        periodViewModelBeforUpdate.StartDate.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                    }
                };
                throw new CustomException(CustomStatusCode.PeriodUpdateStartDateContiguousException, errorParams);
            }
            // If next period is not null: the EndDate of the model can't be changed
            if (nextPeriod != null && (periodViewModelBeforUpdate.EndDate.Date.CompareTo(model.EndDate.Date) != NumberConstant.Zero))
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    {   nameof(DateTime.Date),
                        periodViewModelBeforUpdate.EndDate.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                    }
                };
                throw new CustomException(CustomStatusCode.PeriodUpdateEndDateContiguousException, errorParams);
            }
        }

        /// <summary>
        /// Check if the period change is allowed
        /// </summary>
        /// <param name="model"></param>
        private void CheckPeriodUpdatingAllowed(PeriodViewModel model, PeriodViewModel periodBeforUpdate)
        {
            if (model.CanExtendInLeft && model.StartDate.AfterDate(periodBeforUpdate.StartDate))
            {
                IList<DateTime> dateIntervals = periodBeforUpdate.StartDate.AllDatesUntilLimitIncluded(model.StartDate.AddDays(NumberConstant.MinusOne));
                var timeSheetLineResult = _entityTimeSheetLIne.FindByAsNoTracking(m => DateTime.Compare(m.Day.Date, dateIntervals.FirstOrDefault().Date) >= NumberConstant.Zero && 
                DateTime.Compare(m.Day.Date, dateIntervals.LastOrDefault().Date) <= NumberConstant.Zero).ToList();

                var leaveResult = _entityRepoLeave.FindByAsNoTracking(m => DateTime.Compare(m.StartDate.Date, dateIntervals.FirstOrDefault().Date) >= NumberConstant.Zero && 
                DateTime.Compare(m.StartDate.Date, dateIntervals.LastOrDefault().Date) <= NumberConstant.Zero ||
               DateTime.Compare(m.EndDate.Date, dateIntervals.FirstOrDefault().Date) >= NumberConstant.Zero 
               && DateTime.Compare(m.EndDate.Date, dateIntervals.LastOrDefault().Date) <= NumberConstant.Zero).ToList();
                if (timeSheetLineResult.Any() || leaveResult.Any())
                {
                    throw new CustomException(CustomStatusCode.CANT_UPDATE_PERIOD_STARTDATE);
                }
            }
            if (model.CanExtendInRight && model.EndDate.BeforeDate(periodBeforUpdate.EndDate))
            {
                IList<DateTime> dateIntervals = model.EndDate.AddDays(NumberConstant.One).AllDatesUntilLimitIncluded(periodBeforUpdate.EndDate);
                var timeSheetLineResult = _entityTimeSheetLIne.FindByAsNoTracking(m => DateTime.Compare(m.Day.Date, dateIntervals.FirstOrDefault().Date) >= NumberConstant.Zero
                && DateTime.Compare(m.Day.Date, dateIntervals.LastOrDefault().Date) <= NumberConstant.Zero).ToList();

                var leaveResult = _entityRepoLeave.FindByAsNoTracking(m => DateTime.Compare(m.StartDate.Date, dateIntervals.FirstOrDefault().Date) >= NumberConstant.Zero
                && DateTime.Compare(m.StartDate.Date, dateIntervals.LastOrDefault().Date) <= NumberConstant.Zero ||
                DateTime.Compare(m.EndDate.Date, dateIntervals.FirstOrDefault().Date) >= NumberConstant.Zero
                && DateTime.Compare(m.EndDate.Date, dateIntervals.LastOrDefault().Date) <= NumberConstant.Zero).ToList();
                if (timeSheetLineResult.Any() || leaveResult.Any())
                {
                    throw new CustomException(CustomStatusCode.CANT_UPDATE_PERIOD_ENDDATE);
                }
            }
        }

        /// <summary>
        /// PeriodContigutuous: methode that verify the contiguous of a new period
        /// </summary>
        /// <param name="model"></param>
        private void PeriodContigutuousInAddMode(PeriodViewModel model)
        {
            // Throw exception if the period is not contiguous with the previous one or with the next one    
            PeriodViewModel previousPeriod = FindModelsByNoTracked(x => x.Id != model.Id).OrderByDescending(x => x.EndDate).FirstOrDefault();
            PeriodViewModel nextPeriod = FindModelsByNoTracked(x => x.Id != model.Id).OrderByDescending(x => x.StartDate).LastOrDefault();
            if (previousPeriod != null && nextPeriod != null &&
                DateTime.Compare(previousPeriod.EndDate.Date.AddDays(1), model.StartDate.Date) != NumberConstant.Zero &&
                DateTime.Compare(nextPeriod.StartDate.Date, model.EndDate.Date.AddDays(1)) != NumberConstant.Zero)
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    {   PayRollConstant.NEXT_PERIOD,
                        nextPeriod.StartDate.AddDays(-1).Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                    },
                    {   PayRollConstant.PREVIOUS_PERIOD,
                        previousPeriod.EndDate.AddDays(1).Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)
                    }
                };
                throw new CustomException(CustomStatusCode.PeriodNotContiguousException, errorParams);
            }
        }

        /// <summary>
        /// ValidteHoursLine
        /// </summary>
        /// <param name="hoursViewModel"></param>
        private void ValidteHoursLine(HoursViewModel hoursViewModel)
        {
            // Throw exception if the startTime is greater than a endTime
            if (hoursViewModel.StartTime.CompareTo(hoursViewModel.EndTime) >= NumberConstant.Zero)
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    { PayRollConstant.CURRENT_HOUR_LABEL, hoursViewModel.Label }
                };
                throw new CustomException(CustomStatusCode.HoursTimeException, errorParams);
            }
        }

        /// <summary>
        /// Returns the period corresponding to the date in parameter
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public PeriodViewModel GetPeriodOfDate(DateTime date)
        {
            IList<PeriodViewModel> periodViewModels = GetModelsWithConditionsRelations(model =>
                (DateTime.Compare(date.Date, model.StartDate.Date) >= NumberConstant.Zero 
                && DateTime.Compare(date.Date, model.EndDate.Date) <= NumberConstant.Zero),
                model => model.Hours, model => model.DayOff).ToList();
            if (periodViewModels.Count != NumberConstant.One)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.DATE_MUST_HAVE_ONE_UNIQUE_PERIOD);
            }
            return periodViewModels.FirstOrDefault();
        }

        /// <summary>
        /// Get list of the periods crossed by the startDate and endDate
        /// If a date between the start date and the end date does not belong to any period, an exception is thrown
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public IList<PeriodViewModel> GetPeriodCrossBy(DateTime startDate, DateTime endDate)
        {
            IList<PeriodViewModel> periodViewModels = GetExistingPeriodCrossBy(startDate, endDate);
            if (periodViewModels.Count == NumberConstant.Zero)
            {
                throw new CustomException(customStatusCode: CustomStatusCode.DATE_MUST_HAVE_ONE_UNIQUE_PERIOD);
            }
            // Verify if the dates from startDate to endDate belong to periods
            DateTime beginDateToEndDate = startDate;
            do
            {
                bool isDateBelongToPeriode = periodViewModels.Any(period => beginDateToEndDate.BetweenDateLimitIncluded(period.StartDate, period.EndDate));
                if (!isDateBelongToPeriode)
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        {nameof(DateTime.Date), beginDateToEndDate.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                    };
                    throw new CustomException(CustomStatusCode.PeriodNotFoundException, errorParams);
                }
                beginDateToEndDate = beginDateToEndDate.AddDays(NumberConstant.One);
            }
            while ((endDate.Date - beginDateToEndDate.Date).Days > NumberConstant.Zero);
            return periodViewModels.OrderBy(m => m.StartDate).ToList();
        }

        /// <summary>
        /// Returns the existing periods to which the dates between the start date and the end date belong
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public IList<PeriodViewModel> GetExistingPeriodCrossBy(DateTime startDate, DateTime endDate)
        {
            return GetAllModelsQueryable(model =>
            DateTime.Compare(startDate.Date, model.StartDate.Date) >= NumberConstant.Zero && DateTime.Compare(startDate.Date, model.EndDate.Date) <= NumberConstant.Zero
            || (DateTime.Compare(startDate.Date, model.StartDate.Date) >= NumberConstant.Zero && DateTime.Compare(startDate.Date, model.EndDate.Date) <= NumberConstant.Zero &&
            DateTime.Compare(endDate.Date, model.StartDate.Date) >= NumberConstant.Zero && DateTime.Compare(endDate.Date, model.EndDate.Date) <= NumberConstant.Zero)
            ||(DateTime.Compare(endDate.Date, model.StartDate.Date) >= NumberConstant.Zero && DateTime.Compare(endDate.Date, model.EndDate.Date) <= NumberConstant.Zero),
               model => model.Hours, model => model.DayOff).ToList();
        }

        /// <summary>
        /// Returns the list of valid times for a date
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public IList<KeyValuePair<string, TimeSpan>> GetHoursPeriodOfDate(DateTime date)
        {
            PeriodViewModel periodViewModel = GetModelWithRelations(model => DateTime.Compare(date.Date, model.StartDate.Date) >= NumberConstant.Zero 
            && DateTime.Compare(date.Date, model.EndDate.Date) <= NumberConstant.Zero, model => model.Hours);
            if (periodViewModel == null)
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    {nameof(DateTime.Date), date.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                };
                throw new CustomException(CustomStatusCode.PeriodNotFoundException, errorParams);
            }
            bool perHalfDay = _entityRepoCompany.GetSingleNotTracked(m => true).TimeSheetPerHalfDay ?? false;
            List<KeyValuePair<string, TimeSpan>> keyPair = new List<KeyValuePair<string, TimeSpan>>();
            periodViewModel.Hours.ToList().ForEach(hour =>
            {
                keyPair.AddRange(GetPeriodHoursIntervalForDropdown(hour.StartTime, hour.EndTime, perHalfDay));
            });
            return keyPair.Distinct().OrderBy(x => x.Key).ToList();
        }

        /// <summary>
        /// Returns the list of valid times for list of hours
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public IList<KeyValuePair<string, TimeSpan>> GetHoursPeriodOfDate(List<HoursViewModel> hoursViewModels, bool timeSheetPerHalfDay)
        {
            List<KeyValuePair<string, TimeSpan>> keyPair = new List<KeyValuePair<string, TimeSpan>>();
            hoursViewModels.ToList().ForEach(hour =>
            {
                keyPair.AddRange(GetPeriodHoursIntervalForDropdown(hour.StartTime, hour.EndTime, timeSheetPerHalfDay));
            });
            return keyPair.Distinct().OrderBy(x => x.Key).ToList();
        }


        /// <summary>
        /// Find data source model by predicate. And check returned period validity
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public override DataSourceResult<PeriodViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<PeriodViewModel> dataSourceResult = base.FindDataSourceModelBy(predicateModel);
            // Retrieve the start date of the very first period and the end date of the last period in base
            var periodsMinAndMaxDates = GetAllModelsQueryable(m => true).ToList().GroupBy(t => NumberConstant.One)
                .Select(g => new { minStartDate = g.Min(p => p.StartDate), maxEndDate = g.Max(p => p.EndDate) }).FirstOrDefault();
            dataSourceResult.data.ToList().ForEach(periodViewModel =>
            {
                CheckPeriodValidity(periodViewModel, periodsMinAndMaxDates.minStartDate, periodsMinAndMaxDates.maxEndDate);
            });
            return dataSourceResult;
        }

        /// <summary>
        /// Get Period By ID and check this validity
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override PeriodViewModel GetModelById(int id)
        {
            // Retrieve the start date of the very first period and the end date of the last period in base
            var periodsMinAndMaxDates = GetAllModelsQueryable(m => true).ToList().GroupBy(t => NumberConstant.One)
                .Select(g => new { minStartDate = g.Min(p => p.StartDate), maxEndDate = g.Max(p => p.EndDate) }).FirstOrDefault();
            PeriodViewModel periodViewModel = GetModelWithRelationsAsNoTracked(model => model.Id.Equals(id), model => model.DayOff, model => model.Hours);
            CheckPeriodValidity(periodViewModel, periodsMinAndMaxDates.minStartDate, periodsMinAndMaxDates.maxEndDate);
            return periodViewModel;
        }

        /// <summary>
        /// Check if period can be extend in left (start date can be extend), extend in right (end date can be extend), or can edit the period
        /// </summary>
        /// <param name="periodViewModel"></param>
        /// <param name="minDate"></param>
        /// <param name="maxDate"></param>
        private void CheckPeriodValidity(PeriodViewModel periodViewModel, DateTime minDate, DateTime maxDate)
        {
            var timeSheetLineResult = _entityTimeSheetLIne.FindByAsNoTracking(m => DateTime.Compare(m.Day.Date, periodViewModel.StartDate.Date) >= NumberConstant.Zero 
            && DateTime.Compare(m.Day.Date, periodViewModel.EndDate.Date) <= NumberConstant.Zero).ToList();
            var leaveResult = _entityRepoLeave.FindByAsNoTracking(m =>( DateTime.Compare(m.StartDate.Date, periodViewModel.StartDate.Date) >= NumberConstant.Zero 
            && DateTime.Compare(m.StartDate.Date, periodViewModel.EndDate.Date) <= NumberConstant.Zero )||
            (DateTime.Compare(m.EndDate.Date, periodViewModel.StartDate.Date) >= NumberConstant.Zero
            && DateTime.Compare(m.EndDate.Date, periodViewModel.EndDate.Date) <= NumberConstant.Zero)).ToList();
            if (timeSheetLineResult.Any() || leaveResult.Any())
            {
                periodViewModel.CanEdit = false;
            }
            if (DateTime.Compare(periodViewModel.StartDate.Date, minDate.Date) == NumberConstant.Zero)
            {
                periodViewModel.CanExtendInLeft = true;
            }
            if (DateTime.Compare(periodViewModel.EndDate.Date, maxDate.Date) == NumberConstant.Zero)
            {
                periodViewModel.CanExtendInRight = true;
            }
        }

        /// <summary>
        /// GetEndTimeOfPeriod
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public KeyValuePair<string, TimeSpan> GetEndTimeOfPeriod(DateTime date)
        {
            KeyValuePair<string, TimeSpan> keyPair = GetHoursPeriodOfDate(date).OrderByDescending(h => h.Value).FirstOrDefault();
            return keyPair;
        }

        /// <summary>
        /// GetStartTimeOfPeriod
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public KeyValuePair<string, TimeSpan> GetStartTimeOfPeriod(DateTime date)
        {
            KeyValuePair<string, TimeSpan> keyPair = GetHoursPeriodOfDate(date).OrderByDescending(h => h.Value).LastOrDefault();
            return keyPair;
        }

        /// <summary>
        /// Verify if the date has a priod
        /// </summary>
        /// <param name="date"></param>
        public PeriodViewModel VerifyPeriodOfDate(DateTime date)
        {
            PeriodViewModel periodViewModel = GetModelWithRelations(model => DateTime.Compare(date.Date, model.StartDate.Date) >= NumberConstant.Zero 
            && DateTime.Compare(date.Date.Date, model.EndDate.Date) <= NumberConstant.Zero);
            if (periodViewModel == null)
            {
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                {
                    {nameof(DateTime.Date), date.Date.ToString(Constants.DATE_FORMAT_INVARIANT_CULTURE, CultureInfo.InvariantCulture)}
                };
                throw new CustomException(CustomStatusCode.PeriodNotFoundException, errorParams);
            }
            return periodViewModel;
        }

        /// <summary>
        /// Returns the list of time intervals between the company start time and the end time
        /// </summary>
        /// <returns></returns>
        private IList<KeyValuePair<string, TimeSpan>> GetPeriodHoursIntervalForDropdown(TimeSpan startTime, TimeSpan endTime, bool perHalfDay)
        {
            IList<KeyValuePair<string, TimeSpan>> keyPair = new List<KeyValuePair<string, TimeSpan>>();
            if (perHalfDay)
            {
                keyPair.Add(new KeyValuePair<string, TimeSpan>(string.Format(RHConstant.TimeSpanFormat,
                    startTime.Hours, startTime.Minutes), startTime));
                keyPair.Add(new KeyValuePair<string, TimeSpan>(string.Format(RHConstant.TimeSpanFormat,
                    endTime.Hours, endTime.Minutes), endTime));
            }
            else
            {
                int timeDiff = DateTime.Parse(endTime.ToString()).
                Subtract(DateTime.Parse(startTime.ToString())).Hours;
                keyPair.Add(new KeyValuePair<string, TimeSpan>(string.Format(RHConstant.TimeSpanFormat,
                    startTime.Hours, startTime.Minutes), startTime));
                for (int i = NumberConstant.One; i < timeDiff; i++)
                {
                    var time = startTime + new TimeSpan(i, NumberConstant.Zero, NumberConstant.Zero);
                    keyPair.Add(new KeyValuePair<string, TimeSpan>(string.Format(RHConstant.TimeSpanFormat,
                        time.Hours, time.Minutes), time));
                }
                keyPair.Add(new KeyValuePair<string, TimeSpan>(string.Format(RHConstant.TimeSpanFormat,
                    endTime.Hours, endTime.Minutes), endTime));
            }
            return keyPair;
        }

        /// <summary>
        /// Calculate number of working hours of list of period list hours
        /// </summary>
        /// <param name="hoursViewModels"></param>
        /// <returns></returns>
        public double CalculateHourNumber(IEnumerable<HoursViewModel> hoursViewModels)
        {
            double hour = default;
            hoursViewModels.Where(model => model.WorkTimeTable).ToList().ForEach(hours =>
            {
                hour += DurationBetweenStartTimeEndTime(hours.StartTime, hours.EndTime);
            });
            return hour;
        }

        /// <summary>
        /// Calculates the time between start time and end time
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        private double DurationBetweenStartTimeEndTime(TimeSpan startTime, TimeSpan endTime)
        {
            double hour = endTime.Hours - startTime.Hours;
            double min = endTime.Minutes - startTime.Minutes;
            hour += min / NumberConstant.Sixty;
            return hour;
        }
    }
}
