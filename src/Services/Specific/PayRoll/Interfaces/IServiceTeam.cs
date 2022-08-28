using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceTeam : IService<TeamViewModel, Team>
    {
        DataSourceResult<TeamViewModel> GetTeamsByFilter(PredicateFormatViewModel predicateModel);
        IList<TeamViewModel> GetEmployeeTeamDropdown(string mailOfConnectedUser);
        TeamViewModel GetModelByConditionWithHistory(PredicateFormatViewModel predicate);
        IList<EmployeeViewModel> GetEmployeesOfTeamTypes(IList<string> labelTeamTypes);
    }
}
