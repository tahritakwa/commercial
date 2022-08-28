using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class ProjectViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? ExpectedEndDate { get; set; }
        public int ProjectType { get; set; }
        public int? IdTaxe { get; set; }
        public double? AverageDailyRate { get; set; }
        public int? IdTiers { get; set; }
        public string DeletedToken { get; set; }
        public int? IdSettlementMode { get; set; }
        public bool Default { get; set; }
        public int? IdContact { get; set; }
        public int? IdCurrency { get; set; }
        public bool IsBillable { get; set; }
        public string ReferenceProject { get; set; }
        public string ReferenceBc { get; set; }
        public string LabelInInvoice { get; set; }
        public int? IdBankAccount { get; set; }
        public string ProjectLabel { get; set; }
        public IList<FileInfoViewModel> FilesInfos { get; set; }
        public string AttachementFile { get; set; }
        public DateTime CreationDate { get; set; }
        public BankAccountViewModel IdBankAccountNavigation { get; set; }
        public virtual ContactViewModel IdContactNavigation { get; set; }
        public virtual CurrencyViewModel IdCurrencyNavigation { get; set; }
        public SettlementModeViewModel IdSettlementModeNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
        public TaxeViewModel IdTaxeNavigation { get; set; }
        public ICollection<EmployeeProjectViewModel> EmployeeProject { get; set; }
        public ICollection<BillingEmployeeViewModel> BillingEmployee { get; set; }
    }
}