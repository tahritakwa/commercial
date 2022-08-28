using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Linq;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServiceUserPrivilege : IService<UserPrivilegeViewModel, UserPrivilege>
    {
        DataSourceResult<UserPrivilegeViewModel> GetUserPrivileges(PredicateFormatViewModel predicate);
        IQueryable<Employee> GetEmployeesWithConnectedUserPrivilege(string userMail, EmployeeViewModel employee, string privilege);
    }
}
