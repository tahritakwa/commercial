using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{

    public class ContactViewModel : GenericViewModel
    {
        public int? IdTiers { get; set; }
        public int? IdCompany { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Tel1 { get; set; }
        public string Tel2 { get; set; }
        public string Fax1 { get; set; }
        public string Fax2 { get; set; }
        public byte[] Picture { get; set; }
        public string Fonction { get; set; }
        public string Email { get; set; }
        public string WebSite { get; set; }
        public int? IdVille { get; set; }
        public string Adress { get; set; }
        public int Type { get; set; }
        public string HomePhone { get; set; }
        public string OtherPhone { get; set; }
        public string AssistantPhone { get; set; }
        public string AssistantName { get; set; }
        public string Linkedin { get; set; }
        public string Facebook { get; set; }
        public string Twitter { get; set; }
        public string UrlPicture { get; set; }
        public string ContactType { get; set; }
        public string Prefix { get; set; }
        public string Classification { get; set; }
        public string MapLocation { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string Description { get; set; }
        public string Label { get; set; }
        public int? IdAgency { get; set; }
        public DateTime? CreationDate { get; set; }
        public bool? WasLead { get; set; }
        public BankAgencyViewModel IdAgencyNavigation { get; set; }


        public ICollection<ContactTypeDocumentViewModel> ContactTypeDocument { get; set; }        
        public ICollection<DateToRememberViewModel> DateToRemember { get; set; }
        public ICollection<PhoneViewModel> Phone { get; set; }

        public int? IdAddress { get; set; }
        public AddressViewModel IdAddressNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public bool PictureToDelete { get; set; }

    }
}
