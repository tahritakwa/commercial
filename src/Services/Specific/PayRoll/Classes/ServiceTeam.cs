using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceTeam : Service<TeamViewModel, Team>, IServiceTeam
    {
        private readonly IServiceEmployee _serviceEmployee;

        public ServiceTeam(IServiceEmployee serviceEmployee,
             IRepository<Team> entityRepo,
             IUnitOfWork unitOfWork,
             ITeamBuilder reducedBuilder,
             IEntityAxisValuesBuilder builderEntityAxisValues,
             IRepository<EntityAxisValues> entityRepoEntityAxisValues)
            : base(entityRepo, unitOfWork, reducedBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceEmployee = serviceEmployee;
        }


        public override object AddModelWithoutTransaction(TeamViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckEmployeeTeamAssignmentPercentage(model);
            _serviceEmployee.ValidateResignedStatusEmployee(model.IdManager);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(TeamViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckEmployeeTeamAssignmentPercentage(model);
            if (!model.State)
            {
                model.EmployeeTeam.ToList().ForEach(eT => { eT.UnassignmentDate = DateTime.Now; });
            }
            if (model.State && !model.EmployeeTeam.Any())
            {
                model.EmployeeTeam.Add(new EmployeeTeamViewModel
                {
                    IdEmployee = model.IdManager,
                    IdTeam = model.Id,
                    AssignmentDate = DateTime.Now.AddDays(NumberConstant.One)
                });
            }
            _serviceEmployee.ValidateResignedStatusEmployee(model.IdManager);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
        /// <summary>
        /// Checks if the assignment percentage of the employee team does not null
        /// </summary>
        /// <param name="model"></param>
        private void CheckEmployeeTeamAssignmentPercentage(TeamViewModel model)
        {
            DateTime today = DateTime.Today;
            model.EmployeeTeam.ToList().ForEach(x =>
            {
                if (!x.AssignmentDate.HasValue)
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                            { nameof(Employee), _serviceEmployee.GetModelAsNoTracked(c => c.Id == x.IdEmployee).FullName }
                    };
                    throw new CustomException(CustomStatusCode.CannotAddEmployeeTeamWithoutAssignementDate, errorParams);
                }
                x.IsAssigned = model.State && (x.UnassignmentDate.HasValue && (DateTime.Compare(today, x.AssignmentDate.Value) >= NumberConstant.Zero && DateTime.Compare(today, x.UnassignmentDate.Value.AddDays(-NumberConstant.One)) <= NumberConstant.Zero) ||
                    !x.UnassignmentDate.HasValue && DateTime.Compare(today, x.AssignmentDate.Value) >= NumberConstant.Zero);
            });
            model.NumberOfAffected = model.EmployeeTeam.Where(x => x.IsAssigned).Count();
            if (model.EmployeeTeam.Any(m => m.IsAssigned))
            {
                List<EmployeeTeamViewModel> employeeTeam = model.EmployeeTeam.Where(x => x.IsAssigned && x.AssignmentPercentage == NumberConstant.Zero).ToList();
                if (employeeTeam.Any())
                {
                    IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                        { nameof(Employee), _serviceEmployee.GetModelAsNoTracked(c => c.Id == employeeTeam.First().IdEmployee).FullName }
                    };
                    throw new CustomException(CustomStatusCode.CONTROL_OF_PERCENTAGE_ASSIGNMENT_IS_NOT_NULL, errorParams);
                }
                EmployeeTeamViewModel employeeTeamViewModel = model.EmployeeTeam.FirstOrDefault(m => m.AssignmentDate.Value.BeforeDate(model.CreationDate.Date));
                if (employeeTeamViewModel != null)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { nameof(Employee),_serviceEmployee.GetModelAsNoTracked(c => c.Id == employeeTeamViewModel.IdEmployee).FullName }
                };
                    throw new CustomException(CustomStatusCode.ASSIGNMENT_DATE_MUST_BE_BEFOR_TEAM_CREATION_DATE, paramtrs);
                }
            }
        }

        public TeamViewModel GetModelByConditionWithHistory(PredicateFormatViewModel predicate)
        {
            TeamViewModel result = GetModelWithRelations(predicate);
            if (result.EmployeeTeam != null)
            {
                foreach (EmployeeTeamViewModel employee in result.EmployeeTeam)
                {
                    employee.IdEmployeeNavigation = _serviceEmployee.GetModelById(employee.IdEmployee);
                }
            }
            return result;

        }

        public DataSourceResult<TeamViewModel> GetTeamsByFilter(PredicateFormatViewModel predicateModel)
        {
            if (predicateModel.Filter.Any(x => x.Prop == PayRollConstant.Name))
            {
                predicateModel.Filter.Where(x => x.Prop == PayRollConstant.Name).FirstOrDefault().Value = predicateModel.Filter.Where(x => x.Prop == PayRollConstant.Name).FirstOrDefault().Value.ToString().ToLower();
            }
            if (predicateModel == null)
            {
                throw new ArgumentException("");
            }
            DataSourceResult<TeamViewModel> dataSourceResult = new DataSourceResult<TeamViewModel>();
            // Prepare the predicate
            PredicateFilterRelationViewModel<Team> predicateFilterRelationModel = PreparePredicate(predicateModel);
            // Compile the prdicate
            var prefix = predicateFilterRelationModel.PredicateWhere.Compile();
            if (predicateModel.Filter.Any() && (predicateModel.Filter.FirstOrDefault().Operation == Operation.Contains || predicateModel.Filter.FirstOrDefault().Operation == Operation.Equals))
            {
                string keyWord = Convert.ToString(predicateModel.Filter.FirstOrDefault().Value).Trim();

                if (predicateModel.Filter.FirstOrDefault().Prop == PayRollConstant.CreationDate)
                {
                    predicateFilterRelationModel.PredicateWhere = x => x.CreationDate.Equals(DateTime.Parse(keyWord));
                }
                if (predicateModel.Filter.FirstOrDefault().Prop == PayRollConstant.NumberOfAffected)
                {
                    predicateFilterRelationModel.PredicateWhere = x => x.NumberOfAffected.Equals(Convert.ToInt32(keyWord));
                }
                if (predicateModel.Filter.FirstOrDefault().Prop == PayRollConstant.IdEmployee)
                {
                    predicateFilterRelationModel.PredicateWhere = x => x.EmployeeTeam.Any(m => m.IdEmployee.Equals(Convert.ToInt32(keyWord)));
                }
                if (predicateModel.Filter.FirstOrDefault().Prop == PayRollConstant.Status)
                {
                    if (Convert.ToInt32(keyWord) == NumberConstant.Zero)
                    {
                        predicateFilterRelationModel.PredicateWhere = x => x.State.Equals(false);
                    }
                    else
                    {
                        predicateFilterRelationModel.PredicateWhere = x => x.State.Equals(true);
                    }
                }
                if (predicateModel.Filter.FirstOrDefault().Prop != PayRollConstant.CreationDate
                    && predicateModel.Filter.FirstOrDefault().Prop != PayRollConstant.NumberOfAffected
                    && predicateModel.Filter.FirstOrDefault().Prop != PayRollConstant.IdEmployee
                    && predicateModel.Filter.FirstOrDefault().Prop != PayRollConstant.Status)
                {
                    predicateFilterRelationModel.PredicateWhere = x => x.EmployeeTeam.Any(m => (m.IdEmployeeNavigation.FullName).Contains(keyWord)
                   || (m.IdEmployeeNavigation.FullName).Contains(keyWord)
                   || m.IdEmployeeNavigation.FirstName.Contains(keyWord)
                   || m.IdEmployeeNavigation.LastName.Contains(keyWord)
                   || m.IdEmployeeNavigation.Matricule.Contains(keyWord)
                   || m.IdEmployeeNavigation.Email.Contains(keyWord))
                   || x.IdManagerNavigation.FirstName.Contains(keyWord) || x.IdManagerNavigation.LastName.Contains(keyWord)
                   || (x.IdManagerNavigation.FirstName + " " + x.IdManagerNavigation.LastName).Contains(keyWord)
                   || (x.IdManagerNavigation.LastName + " " + x.IdManagerNavigation.FirstName).Contains(keyWord)
                   || (x.Name.ToLower()).Contains(keyWord);

                }
                dataSourceResult = GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
            }
            else
            {
                dataSourceResult = base.FindDataSourceModelBy(predicateModel);
            }
            return dataSourceResult;
        }

        public IList<TeamViewModel> GetEmployeeTeamDropdown(string mailOfConnectedUser)
        {
            EmployeeViewModel currentEmployee = _serviceEmployee.GetConnectedEmployee(mailOfConnectedUser);
            // Get All Teams
            IList<TeamViewModel> teams = GetAllModelsWithRelations(y => y.IdManagerNavigation, y => y.EmployeeTeam).OrderBy(x => x.Name).ToList();
            IList<TeamViewModel> filtredEmployeeTeam = new List<TeamViewModel>();
            // Filter 1 : Get the Teams where the connected user is member, manager or supperior of manager
            filtredEmployeeTeam = teams.Where(team => team.EmployeeTeam.Any(x => x.IdEmployee == currentEmployee.Id) || team.IdManager == currentEmployee.Id ||
            _serviceEmployee.IsUserInSuperHierarchicalEmployeeList(mailOfConnectedUser, team.IdManagerNavigation)).ToList();
            // Filter 2 : Get the teams (not in Filter 1) where the connected user is supperior of one member
            teams.ToList().ForEach(team =>
            {
                if (!filtredEmployeeTeam.Contains(team) && team.Employee != null)
                {
                    foreach (EmployeeViewModel employee in team.Employee)
                    {
                        if (_serviceEmployee.IsUserInSuperHierarchicalEmployeeList(mailOfConnectedUser, employee))
                        {
                            filtredEmployeeTeam.Add(team);
                            break;
                        }
                    }
                }
            });
            return filtredEmployeeTeam;
        }

        /// <summary>
        /// Returns the list of employees associated with one team having as a type code one of the types in parameter
        /// </summary>
        /// <param name="labelTeamTypes"></param>
        /// <returns></returns>
        public IList<EmployeeViewModel> GetEmployeesOfTeamTypes(IList<string> labelTeamTypes)
        {
            DateTime sysDate = DateTime.Now.Date; 
            IList<EmployeeViewModel> employeeViewModels = _serviceEmployee.FindModelsByNoTracked(x => x.EmployeeTeam.Any(et =>
                labelTeamTypes.Any(type => et.IdTeamNavigation.IdTeamTypeNavigation.Label.ToUpper(CultureInfo.InvariantCulture).Equals(type.ToUpper(CultureInfo.InvariantCulture))) &&
                (et.UnassignmentDate.HasValue && DateTime.Compare(sysDate, et.AssignmentDate) >= NumberConstant.Zero && DateTime.Compare(sysDate, et.UnassignmentDate.Value) <= NumberConstant.Zero ||
                !et.UnassignmentDate.HasValue && DateTime.Compare(et.AssignmentDate, sysDate) <= NumberConstant.Zero))).ToList();
            return employeeViewModels; 
        }
    }
}
