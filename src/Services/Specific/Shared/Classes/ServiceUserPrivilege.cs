using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceUserPrivilege : Service<UserPrivilegeViewModel, UserPrivilege>, IServiceUserPrivilege
    {
        private readonly IServicePrivilege _servicePrivilege;
        private readonly IRepository<User> _repoUser;
        private readonly IRepository<Employee> _repoEmployee;

        public ServiceUserPrivilege(IRepository<UserPrivilege> entityRepo,
              IUnitOfWork unitOfWork,
              IUserPrivilegeBuilder builder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
              IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues,
              IServicePrivilege servicePrivilege, IRepository<User> repoUser, IRepository<Employee> repoEmployee)
              : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _servicePrivilege = servicePrivilege;
            _repoUser = repoUser;
            _repoEmployee = repoEmployee;
        }

        public DataSourceResult<UserPrivilegeViewModel> GetUserPrivileges(PredicateFormatViewModel predicate)
        {
            DataSourceResult<UserPrivilegeViewModel> dataSourceResult = new DataSourceResult<UserPrivilegeViewModel>() ;
            List<UserPrivilegeViewModel> userPrivileges = new List<UserPrivilegeViewModel>();
            List<PrivilegeViewModel> notSetPrivileges = new List<PrivilegeViewModel>();
            userPrivileges = FindModelBy(predicate).ToList();
            var existingPrivileges = userPrivileges.Select(x => x.IdPrivilege);

            Expression<Func<Privilege, bool>> privilegePredicate = x => !existingPrivileges.Distinct().Contains(x.Id);
            notSetPrivileges = _servicePrivilege.GetAllModelsQueryable(privilegePredicate).ToList();

            if (notSetPrivileges.Count > NumberConstant.Zero)
            {
                notSetPrivileges.ForEach(privilege =>
                {
                    UserPrivilegeViewModel userPrivilege = new UserPrivilegeViewModel();
                    userPrivilege.IdPrivilege = privilege.Id;
                    userPrivilege.IdPrivilegeNavigation = privilege;
                    userPrivileges.Add(userPrivilege);
                });
            }
            userPrivileges = userPrivileges.OrderBy(x => x.IdPrivilegeNavigation.Label).ToList();
            dataSourceResult.data = userPrivileges;
            dataSourceResult.total = userPrivileges.Count;

            return dataSourceResult;
        }


        /// <summary>
        /// Get employees after checking connected employee privileges
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="employee"></param>
        /// <returns></returns>
        public IQueryable<Employee> GetEmployeesWithConnectedUserPrivilege(string userMail, EmployeeViewModel employee, string privilege)
        {
            IQueryable<Employee> employees = new List<Employee>().AsQueryable();
            //int userId = GetUserByUserMail(userMail).Id;
            User connectedUser = _repoUser.FindSingleBy(x => x.Email.Equals(userMail));
            UserPrivilegeViewModel connectedUserPrivilege = GetModelsWithConditionsRelations(x => x.IdUser == connectedUser.Id, x => x.IdPrivilegeNavigation)
                           .Where(x => x.IdPrivilegeNavigation.Reference.Equals(privilege)).FirstOrDefault();
            if (connectedUserPrivilege != null)
            {
                if (connectedUserPrivilege.Management.HasValue && connectedUserPrivilege.Management.Value)
                {
                    employees = employees.Union(_repoEmployee.QuerableGetAll().ToList());
                }
                else
                {
                    employees = employees.Union(SubLevelEmployees(connectedUserPrivilege, employee.Id));
                    employees = employees.Union(SameLevelEmployees(connectedUserPrivilege, employee.HierarchyLevel));
                    employees = employees.Union(SuperiorLevelEmployees(connectedUserPrivilege, employee.IdUpperHierarchy));
                }
            }
            return employees;
        }

        /// <summary>
        /// Check if id employee is in level of connected employee
        /// </summary>
        /// <param name="id"></param>
        /// <param name="level"></param>
        /// <returns></returns>
        private bool IsPartOfHierarchy(int id, string level)
        {
            return !string.IsNullOrEmpty(level) && level.Split(PayRollConstant.LevelSeparator).ToArray().Contains(id.ToString());
        }

        /// <summary>
        /// Get inferior employees
        /// </summary>
        /// <param name="connectedUserPrivilege"></param>
        /// <param name="employeeId"></param>
        /// <returns></returns>
        private IQueryable<Employee> SubLevelEmployees(UserPrivilegeViewModel connectedUserPrivilege, int employeeId)
        {
            IQueryable<Employee> employees = new List<Employee>().AsQueryable();
            if (connectedUserPrivilege.SubLevel.HasValue && connectedUserPrivilege.SubLevel.Value)
            {
                var employeesList = _repoEmployee.GetAllWithConditionsQueryable(x => x.Id != employeeId && !string.IsNullOrEmpty(x.HierarchyLevel))
                    .AsEnumerable().Where(x => IsPartOfHierarchy(employeeId, x.HierarchyLevel));
                employees = employees.Union(employeesList.ToList());
            }
            return employees;
        }

        /// <summary>
        /// Get same level employees with or without hierarchy
        /// </summary>
        /// <param name="connectedUserPrivilege"></param>
        /// <param name="employeeId"></param>
        /// <param name="employeeHierarchyLevel"></param>
        /// <returns></returns>
        private IQueryable<Employee> SameLevelEmployees(UserPrivilegeViewModel connectedUserPrivilege, string employeeHierarchyLevel)
        {
            IQueryable<Employee> employees = new List<Employee>().AsQueryable();
            if ((connectedUserPrivilege.SameLevelWithHierarchy.HasValue && connectedUserPrivilege.SameLevelWithHierarchy.Value)
                                       || (connectedUserPrivilege.SameLevelWithoutHierarchy.HasValue && connectedUserPrivilege.SameLevelWithoutHierarchy.Value))
            {
                Expression<Func<Employee, bool>> expression = x => x.HierarchyLevel == employeeHierarchyLevel;
                employees = employees.Union(_repoEmployee.GetAllWithConditionsQueryable(expression).ToList());
                if (connectedUserPrivilege.SameLevelWithHierarchy.HasValue && connectedUserPrivilege.SameLevelWithHierarchy.Value)
                {
                    List<int> employeesIds = _repoEmployee.GetAllWithConditionsQueryable(expression).Select(x => x.Id).ToList();
                    var employeesList = _repoEmployee.GetAll().Where(x => employeesIds.Any(m => IsPartOfHierarchy(m, x.HierarchyLevel))).ToList();
                    employees = employees.Union(employeesList);
                }
            }
            return employees;
        }

        /// <summary>
        /// Get superior employees with or without hierarchy
        /// </summary>
        /// <param name="connectedUserPrivilege"></param>
        /// <param name="idUpperEmployee"></param>
        /// <returns></returns>
        private IQueryable<Employee> SuperiorLevelEmployees(UserPrivilegeViewModel connectedUserPrivilege, int? idUpperEmployee)
        {
            IQueryable<Employee> employees = new List<Employee>().AsQueryable();
            if (((connectedUserPrivilege.SuperiorLevelWithHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithHierarchy.Value)
                                      || (connectedUserPrivilege.SuperiorLevelWithoutHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithoutHierarchy.Value))
                  && idUpperEmployee.HasValue)
            {
                string upperLevel = _repoEmployee.GetSingle(x => idUpperEmployee.HasValue && x.Id == idUpperEmployee.Value).HierarchyLevel;
                Expression<Func<Employee, bool>> expression = x => (upperLevel.NotNullOrEmpty() && upperLevel == x.HierarchyLevel) || (idUpperEmployee == x.Id);
                employees = employees.Union(_repoEmployee.GetAllWithConditionsQueryable(expression).ToList());
                if (connectedUserPrivilege.SuperiorLevelWithHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithHierarchy.Value)
                {
                    List<int> employeesIds = _repoEmployee.GetAllWithConditionsQueryable(expression).Select(x => x.Id).ToList();
                    employees = employees.Union(_repoEmployee.GetAll().Where(x => employeesIds.Any(m => IsPartOfHierarchy(m, x.HierarchyLevel))).ToList());
                }
            }
            return employees;
        }

    }
}
