using Settings.Config;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Models;
using ViewModels.DTO.Payment;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{

    public class UserViewModel : GenericViewModel
    {
        public string FullName { get; set; }
        [Required(ErrorMessage = "An user firstname is required")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "An user lastname is required")]
        public string LastName { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public DateTime? Birthday { get; set; }
        [EmailAddress]
        [Key]
        [Required(ErrorMessage = "An user email is required")]
        public string Email { get; set; }
        [EmailAddress]
        public string AssociateEmployeeEmail { get; set; }
        public string WebSite { get; set; }
        [Required(ErrorMessage = "An user language is required")]
        public string Lang { get; set; }
        public byte[] Picture { get; set; }
        public string Phone { get; set; }
        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }
        public CompanyViewModel Company { get; set; }
        public string Language { get; set; }
        public string Message { get; set; }
        public int? IdUserParent { get; set; }
        public int? IdEmployee { get; set; }
        public bool IsUserOnline { get; set; }
        public bool? IsBtoB { get; set; }
        public bool? IsActif { get; set; }
        public string LastConnectedCompany { get; set; }
        public DateTime? LastConnection { get; set; }
        public string LastConnectedIpAdress { get; set; }
        public bool? IsTecDoc { get; set; }
        public bool? HasLeaveOrTimesheet { get; set; }
        public string Fax { get; set; }
        public string Linkedin { get; set; }
        public string Facebook { get; set; }
        public string Twitter { get; set; }
        public int? IdPhone { get; set; }
        public bool IsWithEmailNotification { get; set; }
        public string UrlPicture { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public ICollection<AddressViewModel> Address { get; set; }

        // Master user information
        public bool AccountNonExpired { get; set; }
        public bool AccountNonLocked { get; set; }
        public bool Enabled { get; set; }
        public bool CredentialsNonExpired { get; set; }

        public ICollection<MasterRoleUserViewModel> MasterRoleUser { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual PhoneViewModel IdPhoneNavigation { get; set; }

       
        public ICollection<MessageChatViewModel> MessageChat { get; set; }
        public virtual ICollection<UserDiscussionChatViewModel> UserDiscussionChat { get; set; }
        public AppSettings appSettings { get; set; }
        public ICollection<CandidateViewModel> Candidate { get; set; }
        public int? IdTiers { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
        public ICollection<MobilityRequestViewModel> MobilityRequest { get; set; }
        public IList<ReducedCompany> CompanyAssociatedCode { get; set; }
        public ICollection<MasterUserCompanyViewModel> MasterUserCompany { get; set; }
        public UserCompanyAssociatedViewModel userCompanyAssociated { get; set; }
        public ICollection<UserPrivilegeViewModel> UserPrivilege { get; set; }
        public ICollection<FileDriveViewModel> FileDrive { get; set; }
        public ICollection<UserFileAccessViewModel> UserFileAccess { get; set; }
        public ICollection<UserFileModificationViewModel> UserFileModification { get; set; }
        public ICollection<SessionCashViewModel> SessionCash { get; set; }

        public string ListRoles { get; set; }
        public string UserName { get; set; }
        public string company_code { get; set; }
    }
}
