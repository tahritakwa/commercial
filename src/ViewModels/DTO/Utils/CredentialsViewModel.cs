using System.Collections.Generic;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Utils
{
    public class CredentialsViewModel
    {
        public int IdUser { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public string Email { get; set; }
        public int? IdEmployee { get; set; }
        public EmployeeViewModel Employee { get; set; }
        // For master
        public string LastConnectedCompany { get; set; }
        public IList<ReducedCompany> CompanyAssociatedCode { get; set; }
        public CompanyViewModel Company { get; set; }
        public string Language { get; set; }
        public string Message { get; set; }
        public int? IdTiers { get; set; }
        public int ActivityArea { get; set; }

        public ICollection<MasterUserCompanyViewModel> MasterUserCompany { get; set; }
    }
}
