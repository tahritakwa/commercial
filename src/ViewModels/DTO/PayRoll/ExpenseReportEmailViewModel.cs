using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class ExpenseReportEmailViewModel : GenericViewModel
    {
        public int IdExpenseReport { get; set; }
        public int IdEmail { get; set; }
        public string DeletedToken { get; set; }

        public virtual EmailViewModel IdEmailNavigation { get; set; }
        public virtual LeaveViewModel IdLeaveNavigation { get; set; }

    }
}
