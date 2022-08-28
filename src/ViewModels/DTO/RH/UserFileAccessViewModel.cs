using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class UserFileAccessViewModel : GenericViewModel
    {

        public int IdUser { get; set; }
        public int IdFile { get; set; }
        public bool ReadFile { get; set; }
        public bool WriteFile { get; set; }

        public FileDriveViewModel IdFileNavigation { get; set; }
        public UserViewModel IdUserNavigation { get; set; }
    }
}
