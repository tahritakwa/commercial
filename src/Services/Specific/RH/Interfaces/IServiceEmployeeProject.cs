using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceEmployeeProject : IService<EmployeeProjectViewModel, EmployeeProject>
    {
        IList<EmployeeProjectViewModel> GetProjectResources(int idProject);
        IList<EmployeeProjectViewModel> GetEmployeeAssignResources(int idProject);
        DataSourceResult<EmployeeViewModel> GetEmployeesAffectedToBillableProject(DateTime month, PredicateFormatViewModel predicateModel);
        List<ProjectViewModel> GetProjectsAffectedToTheEmployee(int IdEmployee, DateTime month);
        IList<EmployeeProjectViewModel> GetAssignationtHistoric(int idProject, int idEmployee);
    }
}
