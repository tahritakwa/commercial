using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class LeaveEmailViewModel : GenericViewModel
    {
        public int IdLeave { get; set; }
        public int IdEmail { get; set; }
        public string DeletedToken { get; set; }

        public virtual EmailViewModel IdEmailNavigation { get; set; }
        public virtual LeaveViewModel IdLeaveNavigation { get; set; }

    }
}
