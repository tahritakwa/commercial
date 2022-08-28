using System;
using System.Collections.Generic;

namespace ViewModels.DTO.RH
{
    public class TrainingSeanceDayViewModel
    {
        public DayOfWeek DayOfWeek { get; set; }
        public IList<TrainingSeanceViewModel> TrainingSeanceLine { get; set; }
        public string DayName { get; set; }
    }
}