using ViewModels.DTO.Shared;

namespace ViewModels.DTO.ErpSettings
{
    public class UserInfoViewModel
    {
        public int IdUserInfo { get; set; }
        public int IdUser { get; set; }
        public int IdInformation { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }

        public InformationViewModel IdInformationNavigation { get; set; }
        public UserViewModel IdUserNavigation { get; set; }
    }
}
