using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceCodification : IService<CodificationViewModel, Codification>
    {
        List<object> getCodification(dynamic entity, string property, bool isApproved, bool isClaim = false, bool isDepositInvoice = false);
    }
}
