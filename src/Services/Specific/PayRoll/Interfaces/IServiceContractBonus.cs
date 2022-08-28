using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceContractBonus : IService<ContractBonusViewModel, ContractBonus>
    {
        double GetBonusValue(PayslipViewModel payslipViewModel, BonusViewModel bonusViewModel, bool dependOnTimeSheet, double daysOfWork, double monthNumberOfDays, out double dayOfWorkReallyWorked);
        IList<ContractBonus> UpdateContractsBonusState(IList<ContractBonus> contractBonuses);
    }
}
