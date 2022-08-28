using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceProject : IService<ProjectViewModel, Project>
    {
        IList<ProjectViewModel> EmployeeAssignedProjectAtDate(int idEmployee, DateTime startDate, DateTime? endDate = null);
        IList<EmployeeProjectViewModel> EmployeeAssignedProjectIncludedInDates(int idEmployee, IList<DateTime> listOfDates);
        IList<ProjectViewModel> EmployeeWorkedProjectAtDate(int idEmployee, DateTime startDate, DateTime endDate);
        DataSourceResult<ProjectViewModel> GetProjectDropdownForBillingSession(PredicateFormatViewModel predicateModel, DateTime month);
        ProjectViewModel GetModelByConditionWithHistory(PredicateFormatViewModel predicate);
        DataSourceResult<ProjectViewModel> GetFiltredProjectList(PredicateFormatViewModel predicate, DateTime? endDate, DateTime? startDate);
    }
}
