using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Interfaces
{
    public interface ISettlementCommitmentBuilder : IBuilder<SettlementCommitmentViewModel, SettlementCommitment>
    {
        SettlementCommitmentViewModel BuildFinancialEntity(FinancialCommitment entity);
    }
}
