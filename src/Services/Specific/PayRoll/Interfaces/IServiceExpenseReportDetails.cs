using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceExpenseReportDetails :
        IService<ExpenseReportDetailsViewModel, ExpenseReportDetails>
    {
        object AddModelWithFiles(ExpenseReportDetailsViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        void UpdateModelWithFiles(ExpenseReportDetailsViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
    }  
}
