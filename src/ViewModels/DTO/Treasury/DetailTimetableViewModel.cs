using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Treasury
{
    public class DetailTimetableViewModel : GenericViewModel
    {
        public int? IdReconciliation { get; set; }
        public int? IdPayment { get; set; }
        public int? IdDetailTimetable { get; set; }
        public string DeletedToken { get; set; }

        public virtual DetailTimetableViewModel IdDetailTimetableNavigation { get; set; }
        public virtual ReconciliationViewModel IdReconciliationNavigation { get; set; }
    }
}