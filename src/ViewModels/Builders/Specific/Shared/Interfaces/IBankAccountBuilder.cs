using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Interfaces
{
    public interface IBankAccountBuilder : IBuilder<BankAccountViewModel, BankAccount>
    {
    }
}
