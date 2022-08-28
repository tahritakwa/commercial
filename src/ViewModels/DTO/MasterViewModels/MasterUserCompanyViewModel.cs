using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.MasterViewModels
{
    public class MasterUserCompanyViewModel : GenericMasterViewModel
    {
        public int IdMasterUser { get; set; }
        public int IdMasterCompany { get; set; }
        public string CodeCompany { get; set; }
        public string DeletedToken { get; set; }
        public bool? IsActif { get; set; }
        public MasterCompanyViewModel IdMasterCompanyNavigation { get; set; }
        public MasterUserViewModel IdMasterUserNavigation { get; set; }
    }
}
