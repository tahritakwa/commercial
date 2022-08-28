using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceEmployee : IService<EmployeeViewModel, Employee>
    {
        IList<EmployeeViewModel> GenerateEmployeeListFromExcel(Stream excelDataStream);
        void GetHierarchicalEmployeeList(string employeeMail, List<EmployeeViewModel> employees,
            bool withTheSuperior = false, PredicateFilterRelationViewModel<Employee> predicateFilterRelationViewModel = null);
        List<EmployeeViewModel> GetHierarchicalEmployeesList(string userMail, bool withTheSuperior = false, bool withTeamCollaborater = false, PredicateFormatViewModel predicateModel = null);
        EmployeeViewModel GetConnectedEmployee(string userMail);
        EmployeeViewModel GetConnectedEmployee();
        UserViewModel GetUserByUserMail(string userMail);
        UserViewModel GetUserByIdEmployee(int idEmployee);
        List<UserViewModel> GetSuperiorsEmployeeAsUsers(int employeeId, bool withCurrentEmployee);
        bool IsUserInSuperHierarchicalEmployeeList(string userMail, EmployeeViewModel employee);
        EmployeeViewModel GetModelById(int id, string userMail);
        string GetSharedDocumentsPasswordAndSendItEveryTime(int employeeId, string userMail, SmtpSettings smtpSettings);
        string GetSharedDocumentsPasswordAndSendItIfFirstGeneration(Employee employee, string userMail, SmtpSettings smtpSettings);
        IList<EmployeeViewModel> GetEmployeeInConnectedUserTeam(string userMail);
        bool CheckUserIsTeamManagerOrUpperHierrarchy(int idEmployee, string userMail);
        List<UserViewModel> GetEmployeeUpperHierrarchicAndTeamManagerAsUsersForMailing(int idEmployee);
        IList<EmployeeViewModel> GetEmployeeWithSkill(int idSkill);
        IList<EmployeeViewModel> GetEmployeesHasPayslip(int year);
        void SynchronizeEmployees();
        bool CheckConnectedUserHasPrivilege(EmployeeViewModel selectedEmployee, string userMail, string reference);
        dynamic GetConnectedEmployeePrivileges(int id);
        int IdSuperiorOfEmployeeByLevel(int superiorLevel, string levelOfEmployee);
        DataSourceResult<ReducedEmployeeViewModel> GetEmployeeDropdownWithPredicate(PredicateFormatViewModel predicateModel);
        IList<Employee> GetLowerEmployees(Employee employee);
        bool IsPartOfHierarchy(int id, string level);
        IList<EmployeeViewModel> GetNotAssociatedEmployees();
        bool IsInConnectedUserHierarchy(int connectedEmployeeId, int selectedEmployeeId);
        void ValidateResignedStatusEmployee(int idEmployee, DateTime? date = null);
        List<OrganizationChartViewModel> GetAllEmployeesWithInferiors();
        OrganizationChartViewModel SelectedEmployeeOrganizationChart(int employeeId);
        void UpdateEmployeesStatusJob(string connectionString, string userMail);
        EmployeeViewModel GetEmployeeByEmail(string email, string userMail);
        bool IsConnectedUserTeamManagerOrHierarchic(int idSelectedEmployee);
        int GetConnectedEmployeeId(string userMail);
    }
}
