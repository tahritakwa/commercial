using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.ErpSettings
{
    public class MsgNotificationViewModel : GenericViewModel
    {
        public int IdMsg { get; set; }
        public int IdTargetedUser { get; set; }
        public bool Viewed { get; set; }
        public MessageViewModel IdMsgNavigation { get; set; }
        public DateTime? CreationDate { get; set; }
    }
}
