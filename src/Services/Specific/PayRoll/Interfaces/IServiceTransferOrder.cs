using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceTransferOrder : IService<TransferOrderViewModel, TransferOrder>
    {
        IList<TransferOrderDetailsViewModel> GetTransferOrderDetails(int idTransferOrder);
        object GenerateTransferDetails(TransferOrderViewModel transferOrderViewModel, string userMail);
        bool CheckUnicityTransferNumber(TransferOrderViewModel transferOrderViewModel);
        void CloseTransferOrder(int idTransferOrder);
    }
}
