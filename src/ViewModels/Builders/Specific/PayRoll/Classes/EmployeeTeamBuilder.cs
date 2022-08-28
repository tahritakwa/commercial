using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class EmployeeTeamBuilder : GenericBuilder<EmployeeTeamViewModel, EmployeeTeam>, IEmployeeTeamBuilder
    {
        private readonly ITeamBuilder _teamBuilder;

        public EmployeeTeamBuilder(ITeamBuilder teamBuilder)
        {
            _teamBuilder = teamBuilder;
        }

        public override EmployeeTeamViewModel BuildEntity(EmployeeTeam entity)
        {
            EmployeeTeamViewModel employeeTeamViewModel = base.BuildEntity(entity);
            if (employeeTeamViewModel != null && employeeTeamViewModel.IdTeamNavigation != null)
            {
                employeeTeamViewModel.IdTeamNavigation = _teamBuilder.BuildEntity(entity.IdTeamNavigation);
            }
            return employeeTeamViewModel;
        }
    }
}
