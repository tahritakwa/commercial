using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ReducedLeaveTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public bool Paid { get; set; }
        public int MaximumNumberOfDays { get; set; }
        public bool RequiredDocument { get; set; }
    }
}
