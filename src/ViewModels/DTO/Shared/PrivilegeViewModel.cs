using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class PrivilegeViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public string Reference { get; set; }

        public ICollection<UserPrivilegeViewModel> UserPrivilege { get; set; }
    }
}
