using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.Shared
{
    public class OfficeViewModel : GenericViewModel
    {
        public string OfficeName { get; set; }
        public string AddressLine1 { get; set; }
        public string AddressLine2 { get; set; }
        public string AddressLine3 { get; set; }
        public string AddressLine4 { get; set; }
        public string AddressLine5 { get; set; }
        public string Facebook { get; set; }
        public string LinkedIn { get; set; }
        public int? IdOfficeManager { get; set; }
        public DateTime CreationDate { get; set; }
        public int? IdCreationUser { get; set; }
        public string DeletedToken { get; set; }
        public string PhoneNumber { get; set; }
        public string Twitter { get; set; }
        public string Email { get; set; }
        public string Fax { get; set; }

        public  EmployeeViewModel IdOfficeManagerNavigation { get; set; }
        public  ICollection<EmployeeViewModel> Employee { get; set; }
        public  ICollection<MobilityRequestViewModel> MobilityRequestIdCurrentOfficeNavigation { get; set; }
        public  ICollection<MobilityRequestViewModel> MobilityRequestIdDestinationOfficeNavigation { get; set; }
        public ICollection<RecruitmentViewModel> Recruitment { get; set; }
        public ICollection<AddressViewModel> Address { get; set; }
        public ICollection<ContactViewModel> Contact { get; set; }
        public string City { get; set; }
        public string Country { get; set; }


    }
}
