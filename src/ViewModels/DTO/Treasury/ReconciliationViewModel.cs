using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Treasury
{
    public class ReconciliationViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public DateTime ReconciliationDate { get; set; }
        public int IdBankAccount { get; set; }
        public bool? IsValidate { get; set; }
        public string DeletedToken { get; set; }
        public string AttachmentUrl { get; set; }
        public double? TotalDebit { get; set; }
        public double? TotalCredit { get; set; }
        public IList<FileInfoViewModel> ObservationsFilesInfo { get; set; }
        public virtual ICollection<DetailReconciliationViewModel> DetailReconciliation { get; set; }
        public virtual ICollection<SettlementViewModel> Settlement { get; set; }

        
    }
}