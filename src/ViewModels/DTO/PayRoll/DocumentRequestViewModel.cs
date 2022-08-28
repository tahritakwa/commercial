using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class DocumentRequestViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public DateTime SubmissionDate { get; set; }
        public DateTime DeadLine { get; set; }
        public string Description { get; set; }
        public int Status { get; set; }
        public string DeletedToken { get; set; }
        public int IdDocumentRequestType { get; set; }
        public int IdEmployee { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public int? TreatedBy { get; set; }
        public EmployeeViewModel TreatedByNavigation { get; set; }
        public DocumentRequestTypeViewModel IdDocumentRequestTypeNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual IList<CommentViewModel> Comments { get; set; }
        public string Code { get; set; }
    }
}
