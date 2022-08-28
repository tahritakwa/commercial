using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.PayRoll
{
    public class ExpenseReportDetailsViewModel : GenericViewModel
    {
        public string Description { get; set; }
        public double Amount { get; set; }
        public int IdCurrency { get; set; }
        public DateTime Date { get; set; }
        public string AttachmentUrl { get; set; }
        public string DeletedToken { get; set; }
        public int IdExpenseReport { get; set; }
        public int IdExpenseReportDetailsType { get; set; }


        public CurrencyViewModel IdCurrencyNavigation { get; set; }
        public ExpenseReportViewModel IdExpenseReportNavigation { get; set; }
        public ExpenseReportDetailsTypeViewModel IdExpenseReportDetailsTypeNavigation { get; set; }

        public IList<FileInfoViewModel> FilesInfos { get; set; }

    }
}