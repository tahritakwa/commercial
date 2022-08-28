using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceDocumentWithholdingTax : IService<DocumentWithholdingTaxViewModel, DocumentWithholdingTax>
    {
        object AddDocumentWithholdingTax(List<DocumentWithholdingTaxViewModel> model, string userMail);
    }
}
