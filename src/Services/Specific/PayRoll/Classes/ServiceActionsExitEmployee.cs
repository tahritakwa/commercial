using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.CatalogEntities;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Catalog.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceActionsExitEmployee : Service<ExitActionEmployeeViewModel, ExitActionEmployee>, IServiceExitActionEmployee
    {
        private readonly IServiceMasterUser _serviceMasterUser;
        private readonly IRepository<Contract> _contractRepo;
        private readonly IRepository<Employee> _employeeEntityRepo;
        private readonly IRepository<EmployeeTeam> _employeeTeamEntityRepo;
        private readonly IRepository<TeamType> _teamTypeEntityRepo;
        private readonly IRepository<ExitEmployee> _exitEmployeeEntityRepo;

        public ServiceActionsExitEmployee(IRepository<ExitActionEmployee> entityRepo,
               IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IExitActionEmployeeBuilder builder,
               IServiceMasterUser serviceMasterUser,
               IRepository<Contract> contractRepo,
               IRepository<Employee> employeeEntityRepo,
               IRepository<EmployeeTeam> employeeTeamEntityRepo,
               IRepository<TeamType> teamTypeEntityRepo,
               IOptions<AppSettings> appSettings,
               IRepository<ExitEmployee> exitEmployeeEntityRepo,
               IEntityAxisValuesBuilder builderEntityAxisValues)
                : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
            {
            _serviceMasterUser = serviceMasterUser;
            _appSettings = appSettings.Value;
            _contractRepo = contractRepo;
            _employeeEntityRepo = employeeEntityRepo;
            _employeeTeamEntityRepo = employeeTeamEntityRepo;
            _teamTypeEntityRepo = teamTypeEntityRepo;
            _exitEmployeeEntityRepo = exitEmployeeEntityRepo;
            }

        /// <summary>
        /// get information of exit action employee
        /// </summary>
        /// <param name="exitActionEmployeeViewModel"></param>
        public dynamic GetExitActionEmployeeInformation(ExitActionEmployeeViewModel exitActionEmployeeViewModel)
        {
            ExitEmployee exitEmployee = _exitEmployeeEntityRepo.GetAllWithConditionsRelations(x => x.Id == exitActionEmployeeViewModel.IdExitEmployee, x => x.IdEmployeeNavigation).FirstOrDefault();
            if (exitActionEmployeeViewModel.IdExitActionNavigation != null)
            {
                switch (exitActionEmployeeViewModel.IdExitActionNavigation.Label)
                {
                    case "DESACTIVATED_ACTION":
                        return getExitEmployeeAccountInformation(exitEmployee);
                    case "CONTRACT_ACTION":
                        return getExitEmployeeContractInformation(exitEmployee);
                    case "TEAM_ACTION":
                        return getExitEmployeeTeamInformation(exitEmployee);
                    case "SUPERVISOR_ACTION":
                        return getExitEmployeeLowerSuperiorInformation(exitEmployee);
                    default:
                        break;
                }
            }
            return new ExpandoObject();
        }

        /// <summary>
        /// get account information of exit employee
        /// </summary>
        /// <param name="exitEmployeeViewModel"></param>
        public dynamic getExitEmployeeAccountInformation(ExitEmployee exitEmployee)
        {
            List<string> associetedCompany = new List<string>();
            MasterUser masterUserViewModel = _serviceMasterUser.GetAllModelsQueryable().Include(x => x.MasterUserCompany).ThenInclude(c => c.IdMasterCompanyNavigation)
              .Where(m => m.Email.Equals(exitEmployee.IdEmployeeNavigation.Email)).FirstOrDefault();

            // get associetedCompany of exit employee from masterUserCompany
            if (masterUserViewModel != null)
            {
                associetedCompany = masterUserViewModel.MasterUserCompany.Where(x => !x.IdMasterCompanyNavigation.IsDeleted).Select(x => x.IdMasterCompanyNavigation.Name).ToList();
            }            
            dynamic exitEmployeeAccountInformation = new ExpandoObject();
            exitEmployeeAccountInformation.EmployeeName = exitEmployee.IdEmployeeNavigation != null ? exitEmployee.IdEmployeeNavigation.FullName : string.Empty;
            exitEmployeeAccountInformation.Email = exitEmployee.IdEmployeeNavigation != null ? exitEmployee.IdEmployeeNavigation.Email : string.Empty;
            exitEmployeeAccountInformation.CompanyAssociatedName = associetedCompany;
            exitEmployeeAccountInformation.Action = "DESACTIVATED_ACTION";
            return exitEmployeeAccountInformation;
        }

        /// <summary>
        /// get contract information of exit employee
        /// </summary>
        /// <param name="exitEmployeeViewModel"></param>
        public dynamic getExitEmployeeContractInformation(ExitEmployee exitEmployee)
        {
            //get employee exit contract DateTime.Compare(date, endDate) <= NumberConstant.Zero
            Contract contract = _contractRepo.GetAllWithConditionsRelationsAsNoTracking(x =>
               x.IdEmployee == exitEmployee.IdEmployee && 
               ((x.EndDate.HasValue && DateTime.Compare(exitEmployee.ExitPhysicalDate.Value, x.StartDate) >= NumberConstant.Zero && DateTime.Compare(exitEmployee.ExitPhysicalDate.Value, x.EndDate.Value) <= NumberConstant.Zero)
               || (!x.EndDate.HasValue && DateTime.Compare(x.StartDate, exitEmployee.ExitPhysicalDate.Value) <= NumberConstant.Zero)), x => x.IdContractTypeNavigation , x => x.IdSalaryStructureNavigation).FirstOrDefault();
            dynamic exitEmployeeContractInformation = new ExpandoObject();
            exitEmployeeContractInformation.ContractType = contract != null && contract.IdContractTypeNavigation != null ? contract.IdContractTypeNavigation.Label : string.Empty;
            exitEmployeeContractInformation.StartDate = contract != null ? contract.StartDate : DateTime.Now;
            exitEmployeeContractInformation.EndDate = contract != null ? contract.EndDate : DateTime.Now;
            exitEmployeeContractInformation.SalaryStructureReference = contract != null && contract.IdSalaryStructureNavigation != null ? contract.IdSalaryStructureNavigation.SalaryStructureReference : string.Empty;
            exitEmployeeContractInformation.WorkingHours = contract != null ? contract.WorkingTime : null;
            exitEmployeeContractInformation.Action = "CONTRACT_ACTION";
            return exitEmployeeContractInformation;
        }

        /// <summary>
        /// get names of superior and lower employees of exit employee
        /// </summary>
        /// <param name="exitEmployeeViewModel"></param>
        public dynamic getExitEmployeeLowerSuperiorInformation(ExitEmployee exitEmployee)
        {
            //get employee
            Employee employee = _employeeEntityRepo.GetAllWithConditionsRelations(x => x.Id == exitEmployee.IdEmployee).ToList().FirstOrDefault();
            //get name of superior employee
            string superiorName = _employeeEntityRepo.GetAllWithConditionsRelations(x => x.Id == employee.IdUpperHierarchy).ToList().Select(x => x.FullName).FirstOrDefault();
            //get name list of lower employee
            List<string> lowerEmployeesName = _employeeEntityRepo.GetAllWithConditionsRelations(x => x.IdUpperHierarchy == employee.Id).ToList().Select(x=> x.FullName).ToList();
            dynamic exitEmployeeLowerSuperiorInformation = new ExpandoObject();

            exitEmployeeLowerSuperiorInformation.SuperiorExitEmployeeName = superiorName;
            exitEmployeeLowerSuperiorInformation.LowerExitEmployeeNames = lowerEmployeesName;
            exitEmployeeLowerSuperiorInformation.Action = "SUPERVISOR_ACTION";
            return exitEmployeeLowerSuperiorInformation;
        }

        /// <summary>
        /// get list of exit employee teams
        /// </summary>
        /// <param name="exitEmployeeViewModel"></param>
        public List<dynamic> getExitEmployeeTeamInformation(ExitEmployee exitEmployee)
        {
            //get employee exit teams   
            List<EmployeeTeam> employeeExitTeams = _employeeTeamEntityRepo.GetAllWithConditionsRelationsAsNoTracking(employeeTeam =>
            employeeTeam.IdEmployee == exitEmployee.IdEmployee &&
            ((employeeTeam.UnassignmentDate.HasValue && DateTime.Compare(exitEmployee.ExitPhysicalDate.Value, employeeTeam.AssignmentDate) >= NumberConstant.Zero && DateTime.Compare(exitEmployee.ExitPhysicalDate.Value, employeeTeam.UnassignmentDate.Value) <= NumberConstant.Zero)
            || (!employeeTeam.UnassignmentDate.HasValue && DateTime.Compare(employeeTeam.AssignmentDate, exitEmployee.ExitPhysicalDate.Value) <= NumberConstant.Zero)),x => x.IdTeamNavigation).ToList();

            List<dynamic> exitEmployeeTeamsInformation = new List<dynamic>();
            dynamic exitEmployeeTeam = new ExpandoObject();
            if (employeeExitTeams.Any())
            {
                employeeExitTeams.ForEach((t) =>
                {
                    exitEmployeeTeam.TeamName = t.IdTeamNavigation != null ? t.IdTeamNavigation.Name : string.Empty;
                    exitEmployeeTeam.ManagerName = t.IdTeamNavigation != null ? _employeeEntityRepo.FindSingleBy(x => x.Id == t.IdTeamNavigation.IdManager).FullName : string.Empty;
                    exitEmployeeTeam.TeamType = t.IdTeamNavigation != null ? _teamTypeEntityRepo.FindSingleBy(x => x.Id == t.IdTeamNavigation.IdTeamType).Label : string.Empty;
                    exitEmployeeTeam.AssignmentPercentage = t.AssignmentPercentage;
                    exitEmployeeTeam.Action = "TEAM_ACTION";
                    exitEmployeeTeamsInformation.Add(exitEmployeeTeam);
                });
            }
            return exitEmployeeTeamsInformation;
        }
    }
}
