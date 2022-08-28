using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class SalaryRuleViewModel : RuleUniqueReferenceViewModel
    {
        public int IdRuleUniqueReference { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Order { get; set; }
        public string Rule { get; set; }
        //For generate the salary en employer rule and values requireements
        public IDictionary<string, dynamic> Rules { get; set; }
        // For numberdaysworked
        public double NumberDaysWorked { get; set; }
        public bool IsBonus { get; set; }
        public bool IsBenefitInKind { get; set; }
        public bool IsAdditionalHour { get; set; }
        public int RuleType { get; set; }
        public bool AppearsOnPaySlip { get; set; }
        public int Applicability { get; set; }
        public int RuleCategory { get; set; }
        public int? IdContributionRegister { get; set; }
        public bool DependNumberDaysWorked { get; set; }
        public bool? UsedinNewsPaper { get; set; }
        public SubTreeViewModel ParsedSalaryRule { get; set; }
        public bool IsLoan { get; set; }
        public bool UpdatePayslip { get; set; }
        public ICollection<SalaryRuleValidityPeriodViewModel> SalaryRuleValidityPeriod { get; set; }
        public ContributionRegisterViewModel IdContributionRegisterNavigation { get; set; }
        public RuleUniqueReferenceViewModel IdRuleUniqueReferenceNavigation { get; set; }
        public ICollection<PayslipDetailsViewModel> PayslipDetails { get; set; }
        public ICollection<SalaryStructureSalaryRuleViewModel> SalaryStructureSalaryRule { get; set; }
        public ICollection<SalaryStructureValidityPeriodSalaryRuleViewModel> SalaryStructureValidityPeriodSalaryRule { get; set; }
    }
}
