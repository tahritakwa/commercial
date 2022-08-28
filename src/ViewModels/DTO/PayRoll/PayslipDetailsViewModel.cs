using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class PayslipDetailsViewModel : GenericViewModel
    {
        public string Rule { get; set; }
        public double Gain { get; set; }
        public double Deduction { get; set; }
        public int Order { get; set; }
        public bool AppearsOnPaySlip { get; set; }
        public int IdPayslip { get; set; }
        public string DeletedToken { get; set; }
        public double NumberOfDays { get; set; }
        public int? IdSalaryRule { get; set; }
        public int? IdBonus { get; set; }
        public int? IdBenefitInKind { get; set; }
        public int? IdLoanInstallment { get; set; }
        public int? IdAdditionalHour { get; set; }

        public BenefitInKindViewModel IdBenefitInKindNavigation { get; set; }
        public BonusViewModel IdBonusNavigation { get; set; }
        public LoanInstallmentViewModel IdLoanInstallmentNavigation { get; set; }
        public PayslipViewModel IdPayslipNavigation { get; set; }
        public SalaryRuleViewModel IdSalaryRuleNavigation { get; set; }
    }
}
