using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class HoursViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public bool WorkTimeTable { get; set; }
        public int IdPeriod { get; set; }
        public string DeletedToken { get; set; }

        public PeriodViewModel IdPeriodNavigation { get; set; }
    }
}