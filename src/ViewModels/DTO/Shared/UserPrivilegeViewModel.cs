using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class UserPrivilegeViewModel : GenericViewModel
    {
        public int IdUser { get; set; }
        public int IdPrivilege { get; set; }
        public string DeletedToken { get; set; }
        public bool? SameLevelWithHierarchy { get; set; }
        public bool? SameLevelWithoutHierarchy { get; set; }
        public bool? SubLevel { get; set; }
        public bool? SuperiorLevelWithHierarchy { get; set; }
        public bool? SuperiorLevelWithoutHierarchy { get; set; }
        public bool? Management { get; set; }

        public PrivilegeViewModel IdPrivilegeNavigation { get; set; }
        public UserViewModel IdUserNavigation { get; set; }
    }
}
