using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServiceCashRegister : IService<CashRegisterViewModel, CashRegister>
    {
        DataSourceResult<CashRegisterItemViewModel> GetCashRegisterHierarchy(string userMail);
        dynamic GetCashRegisterVisibility(string userMail);
        CashRegisterViewModel GetCentralCash();
    }
}
