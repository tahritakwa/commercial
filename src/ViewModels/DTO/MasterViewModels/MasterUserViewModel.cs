using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.MasterViewModels
{
    public class MasterUserViewModel : GenericMasterViewModel
    {
        public string DeletedToken { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public string LastConnectedCompany { get; set; }
        public string NewPassword { get; set; }
        public bool IsBtoB { get; set; }
        public bool IsUserOnline { get; set; }
        public bool MasterUserInCompany { get; set; }
        public bool AccountNonExpired { get; set; }
        public bool AccountNonLocked { get; set; }
        public bool Enabled { get; set; }
        public bool CredentialsNonExpired { get; set; }
        public string Language { get; set; }
        public ICollection<MasterRoleUserViewModel> MasterRoleUser { get; set; }
        public string UrlPicture { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public IList<ReducedCompany> CompanyAssociatedCode { get; set; }
        public virtual ICollection<MasterUserCompanyViewModel> MasterUserCompany { get; set; }
        public UserCompanyAssociatedViewModel UserCompanyAssociated { get; set; }
    }
}