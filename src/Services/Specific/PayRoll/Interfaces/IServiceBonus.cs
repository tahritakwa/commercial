using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceBonus : IService<BonusViewModel, Bonus>
    {
        IEnumerable<BonusViewModel> GetAvailableBonusOfContract(int idContract, DateTime payslipStartDate);
        IList<Payslip> CheckIfBonusIsAssociatedWithAnyPayslip(BonusViewModel bonusViewModel);
    }
}
