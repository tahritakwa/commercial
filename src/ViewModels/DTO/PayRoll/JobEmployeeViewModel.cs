using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class JobEmployeeViewModel : GenericViewModel
    {
        public int? IdEmployee { get; set; }
        public int? IdJob { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public JobViewModel IdJobNavigation { get; set; }
    }
}
