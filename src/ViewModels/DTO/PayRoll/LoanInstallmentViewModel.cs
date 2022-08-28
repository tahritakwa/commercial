using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class LoanInstallmentViewModel : GenericViewModel
    {
        public DateTime Month { get; set; }
        public int State { get; set; }
        public string DeletedToken { get; set; }
        public double Amount { get; set; }
        public int IdLoan { get; set; }

        public virtual LoanViewModel IdLoanNavigation { get; set; }
        public ICollection<SessionLoanInstallmentViewModel> SessionLoanInstallment;
    }
}
