using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Administration
{
    public class CurrencyViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Symbole { get; set; }
        public string Description { get; set; }
        public string CurrencyInLetter { get; set; }
        public string FloatInLetter { get; set; }
        public int Precision { get; set; }
        public bool IsActive { get; set; }
        public ICollection<CurrencyRateViewModel> CurrencyRate { get; set; }
        public virtual ICollection<ExpenseViewModel> Expense { get; set; }
        public virtual ICollection<FinancialCommitmentViewModel> FinancialCommitment { get; set; }
        public ICollection<CurrencyRateViewModel> CurrencyRateDocument { get; set; }

    }
}
