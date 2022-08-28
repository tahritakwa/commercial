using System;

namespace ViewModels.DTO.ErpSettings
{
    public class DatePickerOptionsViewModel
    {
        public string start { get; set; }
        public string depth { get; set; }
        public DateTime? max { get; set; }
        public DateTime? min { get; set; }
        public string format { get; set; }
    }
}
