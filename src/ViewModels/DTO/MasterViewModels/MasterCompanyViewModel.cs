using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.MasterViewModels
{
    public class MasterCompanyViewModel : GenericMasterViewModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string DeletedToken { get; set; }
        public string DataBaseName { get; set; }
        public string GarageDataBaseName { get; set; }
        public int IdMasterDbSettings { get; set; }

        public virtual ICollection<MasterUserCompanyViewModel> UserCompany { get; set; }
        public virtual ICollection<CompanyLicenceViewModel> CompanyLicence { get; set; }
        public virtual MasterDbSettingsViewModel IdMasterDbSettingsNavigation { get; set; }
        public virtual ICollection<MasterRoleUserViewModel> MasterRoleUser { get; set; }
    }
}
