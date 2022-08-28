using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.Shared
{

    public class UserFromExcelViewModel : GenericViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string EmployeeEmail { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }
        public string Phone { get; set; }
        public int? IdEmployee { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
    }
}
