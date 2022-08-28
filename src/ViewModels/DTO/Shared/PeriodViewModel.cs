using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class PeriodViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int FirstDayOfWork { get; set; }
        public int LastDayOfWork { get; set; }
        public string DeletedToken { get; set; }
        public bool CanExtendInLeft { get; set; }
        public bool CanExtendInRight { get; set; }
        public bool UpdatePayslipAndTimeSheet { get; set; }

        public virtual ICollection<DayOffViewModel> DayOff { get; set; }
        public virtual ICollection<HoursViewModel> Hours { get; set; }
    }
}