using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TimeSheetBuilder : GenericBuilder<TimeSheetViewModel, TimeSheet>, ITimeSheetBuilder
    {
        private readonly ITimeSheetLineBuilder _timeSheetLineBuilder;

        public TimeSheetBuilder(ITimeSheetLineBuilder timeSheetLineBuilder)
        {
            _timeSheetLineBuilder = timeSheetLineBuilder;
        }

        public override TimeSheetViewModel BuildEntity(TimeSheet entity)
        {
            if (entity == null)
            {
                throw new ArgumentException("");
            }
            TimeSheetViewModel timeSheetViewModel = base.BuildEntity(entity);
            if (entity.TimeSheetLine.Any())
            {
                entity.TimeSheetLine = entity.TimeSheetLine.OrderBy(m => m.Day).ToList();                
                DateTime startDate = entity.TimeSheetLine.FirstOrDefault().Day;
                DateTime endDate = entity.TimeSheetLine.LastOrDefault().Day;
                timeSheetViewModel.TimeSheetDay = new List<TimeSheetDayViewModel>();
                while (DateTime.Compare(startDate, endDate) <= NumberConstant.Zero)
                {
                    TimeSheetDayViewModel timeSheetDayViewModel = new TimeSheetDayViewModel
                    {
                        Day = startDate,
                        WeekNumberInYear = CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(startDate, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday)
                    };
                    entity.TimeSheetLine.Where(model => DateTime.Compare(model.Day, startDate) == NumberConstant.Zero).ToList().ForEach(line =>
                    {
                        timeSheetDayViewModel.TimeSheetLine.Add(_timeSheetLineBuilder.BuildEntity(line));
                    });
                    timeSheetViewModel.TimeSheetDay.Add(timeSheetDayViewModel);
                    startDate = startDate.AddDays(NumberConstant.One);
                }
            }
            timeSheetViewModel.NumberOfDaysDayHour = new NumberOfDaysDayHour();
            return timeSheetViewModel;
        }

        public override TimeSheet BuildModel(TimeSheetViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            // Basic builder
            TimeSheet timeSheet = base.BuildModel(model);
            if (model.TimeSheetDay != null && model.TimeSheetDay.Any())
            {
                model.TimeSheetDay.ToList().ForEach(day =>
                {
                    day.TimeSheetLine.ToList().ForEach(line =>
                    {
                        timeSheet.TimeSheetLine.Add(_timeSheetLineBuilder.BuildModel(line));
                    });
                });
            }
            if (timeSheet.Status == (int)TimeSheetStatusEnumerator.PartiallyValidated && timeSheet.TimeSheetLine.All(m => m.Valid))
            {
                timeSheet.Status = (int)TimeSheetStatusEnumerator.Validated;
            }
            return timeSheet;
        }
    }
}
