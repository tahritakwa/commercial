using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceBankAccount : IService<BankAccountViewModel, BankAccount>
    {
        void AddBankAccountAssociatedToCompany(BankAccountViewModel model);
        DataSourceResult<ReducedBankAccountDataViewModel> GetBankAccountList(PredicateFormatViewModel predicateModel);
        ReducedBankAccountDataViewModel GetBankAccountWithCondition(PredicateFormatViewModel predicateModel);
        public BankAccountViewModel GetBankAccountForRhPaie();
    }
}
