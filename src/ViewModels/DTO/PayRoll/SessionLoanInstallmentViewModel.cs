using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SessionLoanInstallmentViewModel : GenericViewModel
    {
        public int IdSession { get; set; }
        public int IdLoanInstallment { get; set; }
        public int IdContract { get; set; }
        public double Value { get; set; }
        public string DeletedToken { get; set; }

        public virtual ContractViewModel IdContractNavigation { get; set; }
        public virtual LoanInstallmentViewModel IdLoanInstallmentNavigation { get; set; }
        public virtual SessionViewModel IdSessionNavigation { get; set; }
    }
}
