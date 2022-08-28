using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceBenefitInKind : IService<BenefitInKindViewModel, BenefitInKind>
    {
        IList<BenefitInKindViewModel> GetAvailableBenefitInKindOfContract(int idContract, DateTime month);
        IList<Payslip> CheckIfBenefitInKindIsAssociatedWithAnyPayslip(BenefitInKindViewModel model);
    }
}
