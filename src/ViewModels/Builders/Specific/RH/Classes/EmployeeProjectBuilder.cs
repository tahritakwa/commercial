using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class EmployeeProjectBuilder : GenericBuilder<EmployeeProjectViewModel, EmployeeProject>, IEmployeeProjectBuilder
    {
        private readonly IProjectBuilder _projectBuilder;

        public EmployeeProjectBuilder(IProjectBuilder projectBuilder)
        {
            _projectBuilder = projectBuilder;
        }

        public override EmployeeProjectViewModel BuildEntity(EmployeeProject entity)
        {
            EmployeeProjectViewModel employeeProjectViewModel = base.BuildEntity(entity);
            if (employeeProjectViewModel.IdProjectNavigation != null)
            {
                employeeProjectViewModel.IdProjectNavigation = _projectBuilder.BuildEntity(entity.IdProjectNavigation);
            }
            return employeeProjectViewModel;
        }
    }
}
