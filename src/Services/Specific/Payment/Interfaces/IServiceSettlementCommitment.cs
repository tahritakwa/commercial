using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServiceSettlementCommitment : IService<SettlementCommitmentViewModel, SettlementCommitment>
    {
        IEnumerable<SettlementCommitmentViewModel> GetCommitmentForAddOperation(PredicateFormatViewModel predicateModel);
        IEnumerable<SettlementCommitmentViewModel> GetCommitmentForUpdateOperation(PredicateFormatViewModel predicateModel);
    }
}
