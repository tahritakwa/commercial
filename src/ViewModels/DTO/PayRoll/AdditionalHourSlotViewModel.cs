using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class AdditionalHourSlotViewModel : GenericViewModel
    {
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public string DeletedToken { get; set; }
        public int IdAdditionalHour { get; set; }
        public virtual AdditionalHourViewModel IdAdditionalHourNavigation { get; set; }
    }
}
