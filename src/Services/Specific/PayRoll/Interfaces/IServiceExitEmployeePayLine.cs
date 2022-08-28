using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceExitEmployeePayLine : IService<ExitEmployeePayLineViewModel, ExitEmployeePayLine>
    {
        void GeneratePayBalanceForExitEmployee(int idExitEmployee);
        DataSourceResult<ExitEmployeePayLineViewModel> GetListOfPayForExitEmployee(PredicateFormatViewModel predicate, int idEmployeeExit);
        ExitEmployeePayLineViewModel PrepareLineSalaryRlueViewModel(ExitEmployeePayLineViewModel model);
    }
}
