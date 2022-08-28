using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServicePriceRequest : IService<PriceRequestViewModel, PriceRequest>
    {
        IList<CreatedDataViewModel> CreatePriceRquestFromProvisionning(IList<ObjectToOrder> Lines);
        object SendPriceRequestMail(int idPriceRequest, string informationType, UserViewModel user, SmtpSettings smtpSettings, string url);
        DocumentViewModel GeneratePurchaseOrder(DocumentLineWithPriceRequestViewModel priceRequest);
    }
}
