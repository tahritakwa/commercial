using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.MasterViewModels
{
    public class MasterRoleViewModel : GenericMasterViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public int? IdCompany { get; set; }

        public virtual MasterCompanyViewModel IdCompanyNavigation { get; set; }
    }
}
