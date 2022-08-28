using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Immobilisation;
using ViewModels.DTO.Models;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class ExitEmployeeViewModel : GenericViewModel
    {
        public int IdExitReason { get; set; }
        public int IdEmployee { get; set; }
        public DateTime ReleaseDate { get; set; }
        public int? Status { get; set; }
        public virtual IList<CommentViewModel> Comments { get; set; }
        public string ExitEmployeeAttachementFile { get; set; }
        public IList<FileInfoViewModel> ExitFileInfo { get; set; }
        public string CommentRh { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public int? TreatedBy { get; set; }
        public DateTime? LegalExitDate { get; set; }
        public bool? DamagingDeparture { get; set; }
        public DateTime ExitDepositDate { get; set; }
        public DateTime MinNoticePeriodDate { get; set; }
        public DateTime MaxNoticePeriodDate { get; set; }
        public DateTime? ExitPhysicalDate { get; set; }
        public int? StatePay { get; set; }
        public int? StateLeave { get; set; }
        public string DeletedToken { get; set; }
        public DateTime CreationDate { get; set; }
        public bool RecoveredMaterial { get; set; }

        public List<int> ListIdEmployeeMultiselect { get; set; }
        public ICollection<HistoryViewModel> History { get; set; }
        public ICollection<ExitEmailForEmployeeViewModel> ExitEmailForEmployee { get; set; }
        public ContractViewModel Contract { get; set; }
        public ICollection<InterviewViewModel> Interview { get; set; }
        public ICollection<ExitActionEmployeeViewModel> ExitActionEmployee { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ExitReasonViewModel IdExitReasonNavigation { get; set; }
        public ICollection<ExitEmployeeLeaveLineViewModel> ExitEmployeeLeaveLine { get; set; }
        public ICollection<ExitEmployeePayLineViewModel> ExitEmployeePayLine { get; set; }
    }
}