using System.Collections.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.ErpSettings
{
    public class MessageViewModel
    {
        public MessageViewModel()
        {
            MsgNotification = new HashSet<MsgNotificationViewModel>();
        }
        public int Id { get; set; }
        public int IdCreator { get; set; }
        public int IdInformation { get; set; }
        public int EntityReference { get; set; }
        public string CodeEntity { get; set; }
        public int? TypeMessage { get; set; }
        public InformationViewModel IdInformationNavigation { get; set; }
        public ICollection<MsgNotificationViewModel> MsgNotification { get; set; }
        public IList<UserViewModel> users { get; set; }
        public IList<TiersViewModel> tiers { get; set; }
    }
}
