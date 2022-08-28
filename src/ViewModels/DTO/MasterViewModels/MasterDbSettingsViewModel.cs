using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.MasterViewModels
{
    public class MasterDbSettingsViewModel : GenericMasterViewModel
    {
        public string Server { get; set; }
        public string UserId { get; set; }
        public string UserPassword { get; set; }
        public string DataBaseName { get; set; }

        public virtual ICollection<MasterCompanyViewModel> Company { get; set; }
    }
}
