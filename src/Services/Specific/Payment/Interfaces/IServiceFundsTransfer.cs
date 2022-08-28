using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServiceFundsTransfer : IService<FundsTransferViewModel, FundsTransfer>
    {
        DataSourceResult<CashRegisterViewModel> GetSourceCashsByTransferType(int? transferType);
        DataSourceResult<CashRegisterViewModel> GetDestinationCashsByTransferType(int? transferType);
    }
}