using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Interfaces
{
    public interface ISalaryRuleBuilder : IBuilder<SalaryRuleViewModel, SalaryRule>
    {
        SalaryRuleViewModel BuildSalaryRuleByBonus(BonusViewModel bonusViewModel);
        SalaryRuleViewModel BuildSalaryRuleByBenefitInKind(BenefitInKindViewModel BenefitInKindViewModel);
        SalaryRuleViewModel BuildSalaryRuleLoan(LoanInstallment loanInstallment);
        SalaryRuleViewModel BuildSalaryRuleByAdditionalHour(AdditionalHour additionalHour);
    }
}
