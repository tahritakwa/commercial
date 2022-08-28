using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class DayOffViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public DateTime Date { get; set; }
        public string DeletedToken { get; set; }
        public int IdPeriod { get; set; }

        public PeriodViewModel IdPeriodNavigation { get; set; }
    }
}