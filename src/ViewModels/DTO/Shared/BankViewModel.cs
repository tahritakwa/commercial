using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.Shared
{
    public class BankViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string WebSite { get; set; }
        public int IdCountry { get; set; }
        public string AttachmentUrl { get; set; }
        public FileInfoViewModel LogoFileInfo { get; set; }
        public string DeletedToken { get; set; }
        public CountryViewModel IdCountryNavigation { get; set; }
        public int? IdPhone { get; set; }
        public virtual PhoneViewModel IdPhoneNavigation { get; set; }
        public virtual ICollection<BankAgencyViewModel> BankAgency { get; set; }

        public ICollection<BankAccountViewModel> BankAccount { get; set; }
        public ICollection<EmployeeViewModel> Employee { get; set; }
    }
}
