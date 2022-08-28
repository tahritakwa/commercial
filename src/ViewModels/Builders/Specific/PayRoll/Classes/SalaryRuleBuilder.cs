using Persistence.Entities;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SalaryRuleBuilder : GenericBuilder<SalaryRuleViewModel, SalaryRule>, ISalaryRuleBuilder
    {
        public override SalaryRuleViewModel BuildEntity(SalaryRule entity)
        {
            //Build classic ViewModel by the entity
            var model = base.BuildEntity(entity);         
            //Instanciate the attribute Rules by new Dictionary<string, string>() and the salaryvalue and employervalue to 0
            if (entity != null)
            {
                model.Rules = new Dictionary<string, dynamic>();
                if (entity.IdRuleUniqueReferenceNavigation != null)
                {
                    model.Reference = entity.IdRuleUniqueReferenceNavigation.Reference;
                    model.IsBonus = false;
                }
            }
            return model; 
        }

        public override SalaryRule BuildModel(SalaryRuleViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model != null && !model.DependNumberDaysWorked)
            {
                entity.DependNumberDaysWorked = false;
            }
            return entity;
        }


        public SalaryRuleViewModel BuildSalaryRuleByBonus(BonusViewModel bonusViewModel)
        {
            if (bonusViewModel != null)
            {
                SalaryRuleViewModel salaryRuleViewModel = new SalaryRuleViewModel
                {
                    Id = bonusViewModel.Id,
                    Name = bonusViewModel.Name,
                    Description = bonusViewModel.Description,
                    AppearsOnPaySlip = true,
                    Applicability = bonusViewModel.IdCnssNavigation.SalaryRate.IsApproximately() && !bonusViewModel.IsTaxable ? (int)ApplicabilityViewModel.NET : (int)ApplicabilityViewModel.BASE,
                    RuleCategory = (int)RuleCategoryEnumerator.Salaried,
                    RuleType = (int)RuleTypeEnumerator.Gain,
                    Reference = bonusViewModel.Code, //A remplacer par une reference à venir 
                    IsBonus = true,
                    DependNumberDaysWorked = bonusViewModel.DependNumberDaysWorked,
                    Order = 1
                };
                return salaryRuleViewModel;
            }
            else
            {
                return new SalaryRuleViewModel();
            }
        }

        public SalaryRuleViewModel BuildSalaryRuleLoan(LoanInstallment loanInstallment)
        {
            if(loanInstallment != null)
            {
                SalaryRuleViewModel salaryRuleViewModel = new SalaryRuleViewModel
                {
                    Id = loanInstallment.Id,
                    Name = loanInstallment.IdLoanNavigation.CreditType == (int)CreditEnumerator.Loan ? PayRollConstant.Loan : PayRollConstant.Advance,
                    Description = null,
                    AppearsOnPaySlip = true,
                    Applicability = (int)ApplicabilityViewModel.NET,
                    RuleCategory = (int)RuleCategoryEnumerator.Salaried,
                    RuleType = (int)RuleTypeEnumerator.Retenue,
                    Reference = PayRollConstant.Loan,
                    IsLoan = true,
                    DependNumberDaysWorked = false,
                    Order = NumberConstant.Four,
                };
                return salaryRuleViewModel;
            }
            else
            {
                return new SalaryRuleViewModel();
            }
        }

        public SalaryRuleViewModel BuildSalaryRuleByBenefitInKind(BenefitInKindViewModel BenefitInKindViewModel)
        {
            if (BenefitInKindViewModel != null)
            {
                SalaryRuleViewModel salaryRuleViewModel = new SalaryRuleViewModel
                {
                    Id = BenefitInKindViewModel.Id,
                    Name = BenefitInKindViewModel.Name,
                    Description = BenefitInKindViewModel.Description,
                    AppearsOnPaySlip = true,
                    Applicability = BenefitInKindViewModel.IdCnssNavigation.SalaryRate.IsApproximately() && !BenefitInKindViewModel.IsTaxable ? (int)ApplicabilityViewModel.NET : (int)ApplicabilityViewModel.BASE,
                    RuleCategory = (int)RuleCategoryEnumerator.Salaried,
                    RuleType = (int)RuleTypeEnumerator.Gain,
                    Reference = BenefitInKindViewModel.Code, //A remplacer par une reference à venir 
                    IsBenefitInKind = true,
                    DependNumberDaysWorked = BenefitInKindViewModel.DependNumberDaysWorked,
                    Order = 1
                };
                return salaryRuleViewModel;
            }
            else
            {
                return new SalaryRuleViewModel();
            }
        }

        public SalaryRuleViewModel BuildSalaryRuleByAdditionalHour(AdditionalHour additionalHour)
        {
            if (additionalHour != null)
            {
                SalaryRuleViewModel salaryRuleViewModel = new SalaryRuleViewModel
                {
                    Id = additionalHour.Id,
                    Name = additionalHour.Name,
                    Description = additionalHour.Description,
                    AppearsOnPaySlip = true,
                    Applicability = (int)ApplicabilityViewModel.BASE,
                    RuleCategory = (int)RuleCategoryEnumerator.Salaried,
                    RuleType = (int)RuleTypeEnumerator.Gain,
                    Reference = additionalHour.Code, 
                    IsAdditionalHour = true,
                    DependNumberDaysWorked = false,
                    Order = 1
                };
                return salaryRuleViewModel;
            }
            else
            {
                return new SalaryRuleViewModel();
            }
        }
    }
}
