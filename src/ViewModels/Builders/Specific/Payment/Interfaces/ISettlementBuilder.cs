using ModelView.Payment;
using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Interfaces
{
    public interface ISettlementBuilder : IBuilder<SettlementViewModel, Settlement>
    {
        ReducedSettlementList BuildEntityToReducedList(Settlement entity);
    }
}
