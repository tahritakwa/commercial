using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceEmployeeTeam : Service<EmployeeTeamViewModel, EmployeeTeam>, IServiceEmployeeTeam
    {
        private readonly IServiceEmployeeReduce _serviceEmployeeReduce;
        private readonly IRepository<Team> _entityTeam;
        private readonly ITeamBuilder _builderTeam;




        public ServiceEmployeeTeam(IServiceEmployeeReduce serviceEmployeeReduce,IRepository<EmployeeTeam> entityRepo, IRepository<Team> entityTeam, ITeamBuilder builderTeam,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IEmployeeTeamBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceEmployeeReduce = serviceEmployeeReduce;
            _entityTeam = entityTeam;
            _builderTeam = builderTeam;
        }

        /// <summary>
        /// Returns the list of employees assigned to the team and employees who
        /// are not assigned to this team at the date and time of consultation
        /// </summary>
        /// <param name="idTeam"></param>
        /// <returns></returns>
        public IList<EmployeeTeamViewModel> GetTeamResources(int idTeam)
        {
            List<EmployeeTeamViewModel> employeeTeamViewModels = new List<EmployeeTeamViewModel>();
            IList<EmployeeTeamViewModel> assignResources = GetEmployeeAssignResources(idTeam);
            employeeTeamViewModels.AddRange(assignResources);
            _serviceEmployeeReduce.GetAllModels().Where(model =>
                assignResources.All(resource => resource.IdEmployee != model.Id))
                .OrderBy(model => model.ReverseFullName).ToList().ForEach(employee =>
                {
                    employeeTeamViewModels.Add(new EmployeeTeamViewModel
                    {
                        IdEmployee = employee.Id,
                        IdTeam = idTeam,
                        IdEmployeeNavigation = employee
                    });
                });
            return employeeTeamViewModels;
        }

        /// <summary>
        /// Retrieves the list of employees assigned to the team who have not been released
        /// </summary>
        /// <param name="idTeam"></param>
        /// <returns></returns>
        public IList<EmployeeTeamViewModel> GetEmployeeAssignResources(int idTeam)
        {
            IList<EmployeeTeamViewModel> employeeTeamViewModels = FindModelsByNoTracked(model => model.IdTeam == idTeam  &&
                model.IsAssigned,
                model => model.IdEmployeeNavigation)
                .OrderByDescending(x => x.AssignmentDate)
                .GroupBy(x => x.IdEmployee)
                .Select(x => x.FirstOrDefault())
                .ToList();
            return employeeTeamViewModels;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idTeam"></param>
        /// <param name="idEmployee"></param>
        /// <returns></returns>
        public IList<EmployeeTeamViewModel> GetAssignationtHistoric(int idTeam, int idEmployee)
        {
            IList<EmployeeTeamViewModel> employeeTeamViewModels = FindByAsNoTracking(m => m.IdTeam.Equals(idTeam)
                && m.IdEmployee.Equals(idEmployee)
                && m.UnassignmentDate.HasValue
                && DateTime.Compare(m.UnassignmentDate.Value.Date, DateTime.Now.Date) < NumberConstant.One)
                .OrderByDescending(m => m.UnassignmentDate).ToList();
            return employeeTeamViewModels;
        }
        public EmployeeTeamViewModel GetModelByConditionWithHistory(PredicateFormatViewModel predicate)
        {
            EmployeeTeamViewModel result = GetModelWithRelations(predicate);
            return result;
        }
        /// <summary>
        /// Checks if the assignment percentage of the employee team 
        /// </summary>
        /// <param name="employeeTeam"></param>
        public void ValidateConditionAssignmentPercentage(EmployeeTeamViewModel employeeTeam)
        {
            List<string> listTeamNames = new List<string>();
            IList<EmployeeTeamViewModel> employeeTeamViewModels = FindModelsByNoTracked(m => m.IdEmployee == employeeTeam.IdEmployee
                && m.IsAssigned,
                x=>x.IdTeamNavigation).ToList();
            employeeTeamViewModels = employeeTeamViewModels.Except(employeeTeamViewModels.Where(x => x.Id == employeeTeam.Id)).ToList();
            List<EmployeeTeamViewModel> alreadyAffected = GetAssignationtHistoric(employeeTeam.IdTeam, employeeTeam.IdEmployee).ToList();
            // If the employeeteam is not unique by assignmentDate
            if (alreadyAffected.Any(m => m.UnassignmentDate.HasValue &&
            employeeTeam.AssignmentDate.Value.BetweenDateLimitIncluded(m.AssignmentDate.Value, m.UnassignmentDate.Value)))
            {
                EmployeeViewModel employee = _serviceEmployeeReduce.GetModelAsNoTracked(emp => emp.Id.Equals(employeeTeam.IdEmployee));
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { nameof(Employee), employee.FullName }
                    };
                throw new CustomException(CustomStatusCode.CANNOT_HAVE_MORE_THAN_ONE_ASIGNEMENT_WITH_SAME_DATE, paramtrs);
            }
            if (employeeTeamViewModels.Sum(e => e.AssignmentPercentage) + employeeTeam.AssignmentPercentage > NumberConstant.Hundred)
            {
                EmployeeViewModel employee = _serviceEmployeeReduce.GetModelAsNoTracked(emp => emp.Id.Equals(employeeTeam.IdEmployee));
                IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), employee.FullName },
                        { nameof(Team), employeeTeamViewModels.Select(x=>x.IdTeamNavigation.Name) }
                    };
                throw new CustomException(CustomStatusCode.VALIDATION_OF_PERCENTAGE_ASSIGNMENT_WITH_EMPLOYEE, errorParams);
            }
        }

        /// <summary>
        /// Check and update state Assigned employee team
        /// </summary>
        /// <param name="connectionString"></param>
        public void UpdateStateAssignedEmployeeTeamJob(string connectionString)
        {
            try
            {
                BeginTransaction(connectionString);
                DateTime today = DateTime.Today;
                IList<EmployeeTeam> teamViewModels = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(x => x.IdTeamNavigation.State, x => x.IdTeamNavigation).ToList();
                teamViewModels.ToList().ForEach(x =>
                {
                    x.IsAssigned = x.UnassignmentDate.HasValue && today.BetweenDateLimitIncluded(x.AssignmentDate, x.UnassignmentDate.Value.AddDays(-NumberConstant.One)) ||
                    !x.UnassignmentDate.HasValue && today.AfterDateLimitIncluded(x.AssignmentDate);
                    x.IdTeamNavigation.NumberOfAffected = x.IdTeamNavigation.EmployeeTeam.Count(e => e.IsAssigned);
                });
                BulkUpdateWithoutTransaction(teamViewModels);
                EndTransaction();
            }
            catch
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                throw;
            }
        }
    }
}
