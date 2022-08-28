using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceBank : IService<BankViewModel, Bank>
    {
        object updateBankWithFiles(BankViewModel bank, string userMail);
        object addBankWithFiles(BankViewModel bank, string userMail);
        List<BankAgencyViewModel> getAgeniesfromBank(int id);
    }
}
