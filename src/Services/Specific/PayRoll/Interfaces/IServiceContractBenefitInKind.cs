using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceContractBenefitInKind : IService<ContractBenefitInKindViewModel, ContractBenefitInKind>
    {
        double GetBenefitInKindValue(PayslipViewModel payslipViewModel, BenefitInKindViewModel benefitInKindViewModel, bool dependOnTimeSheet, double daysOfWork, double monthNumberOfDays, out double dayOfWorkReallyWorked);
        IList<ContractBenefitInKind> UpdateContractsBenefitInKindState(IList<ContractBenefitInKind> contractBenefitInKinds);
    }
}
