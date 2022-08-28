using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.MasterViewModels
{
    public class MasterRoleUserViewModel : GenericMasterViewModel
    {
        public int IdMasterUser { get; set; }
        public int IdRole { get; set; }
        public int IdMasterCompany { get; set; }

        public virtual MasterUserViewModel IdMasterUserNavigation { get; set; }
        public virtual MasterRoleViewModel IdRoleNavigation { get; set; }
        public virtual MasterCompanyViewModel IdMasterCompanyNavigation { get; set; }
    }
}
