using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class UserFileModificationViewModel : GenericViewModel
    {
        
        public int IdUser { get; set; }
        public int IdFile { get; set; }

        public FileDriveViewModel IdFileNavigation { get; set; }
        public UserViewModel IdUserNavigation { get; set; }
    }
}
