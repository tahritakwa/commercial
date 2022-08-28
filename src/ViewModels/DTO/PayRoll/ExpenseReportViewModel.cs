using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExpenseReportViewModel : GenericViewModel
    {
        public string DeletedToken { get; set; }
        public string Purpose { get; set; }
        public DateTime SubmissionDate { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public int? TreatedBy { get; set; }
        public EmployeeViewModel TreatedByNavigation { get; set; }
        public int Status { get; set; }
        public int IdEmployee { get; set; }
        public double TotalAmount { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ICollection<ExpenseReportDetailsViewModel> ExpenseReportDetails { get; set; }
        public virtual IList<CommentViewModel> Comments { get; set; }
        public string Code { get; set; }
    }
}
