using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceEmployeeTeam : IService<EmployeeTeamViewModel, EmployeeTeam>
    {
        IList<EmployeeTeamViewModel> GetTeamResources(int idTeam);
        IList<EmployeeTeamViewModel> GetEmployeeAssignResources(int idTeam);
        IList<EmployeeTeamViewModel> GetAssignationtHistoric(int idTeam, int idEmployee);
        EmployeeTeamViewModel GetModelByConditionWithHistory(PredicateFormatViewModel predicate);
        void ValidateConditionAssignmentPercentage(EmployeeTeamViewModel employeeTeam);
        void UpdateStateAssignedEmployeeTeamJob(string connectionString);
    }
}