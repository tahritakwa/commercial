using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceDocumentExpenseLine : IService<DocumentExpenseLineViewModel, DocumentExpenseLine>
    {
        DocumentExpenseLineViewModel CalculateTTCAmount(DocumentExpenseLineViewModel documentExpenseLine);
        void UpdateDocumentExpenseLine(IList<DocumentExpenseLine> documentExpenseLineViewModels);
        double CalculateTotalExpose(TotalLineExpenseViewModel documentExpenseLines);
        double CalculateCoefficientOfCostPrice(InputToCalculateCoefficientOfPriceCostViewModel priceCost);
        double CalculatePercentageCostPrice(InputToCalculateCoefficientOfPriceCostViewModel priceCost);
        double CalculateCostPricePercentage(InputToCalculateCoefficientOfPriceCostViewModel priceCost);

    }
}
