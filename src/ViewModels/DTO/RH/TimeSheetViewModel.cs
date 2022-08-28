using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class TimeSheetViewModel
    {
        public int Id { get; set; }
        public int IdEmployee { get; set; }
        public DateTime CreationDate { get; set; }
        public int Status { get; set; }
        public DateTime Month { get; set; }
        public int NumberOfWeek { get; set; }
        public NumberOfDaysDayHour NumberOfDaysDayHour { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public int? IdEmployeeTreated { get; set; }
        public IList<FileInfoViewModel> TimeSheetFileInfo { get; set; }
        public string AttachementFile { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public EmployeeViewModel IdEmployeeTreatedNavigation { get; set; }
        public ICollection<TimeSheetDayViewModel> TimeSheetDay { get; set; }
        public ICollection<DocumentViewModel> Document { get; set; }
        public IList<CommentViewModel> Comments { get; set; }
        public string Code { get; set; }
        public DateTime? ResignationDateEmployee { get; set; }
        public bool IsConnectedUserInHierarchy { get; set; }

        public ICollection<BillingEmployeeViewModel> BillingEmployee { get; set; }
    }
}