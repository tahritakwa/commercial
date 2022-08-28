using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class TrainingSeanceViewModel : GenericViewModel
    {

        public DateTime? Date { get; set; }
        public TimeSpan StartHour { get; set; }
        public TimeSpan EndHour { get; set; }
        public string DeletedToken { get; set; }
        public int IdTrainingSession { get; set; }
        public string Details { get; set; }
        public int? DayOfWeek { get; set; }

        public TrainingSessionViewModel IdTrainingSessionNavigation { get; set; }

    }
}
