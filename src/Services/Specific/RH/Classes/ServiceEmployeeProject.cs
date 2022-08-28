using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.RH.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceEmployeeProject : Service<EmployeeProjectViewModel, EmployeeProject>, IServiceEmployeeProject
    {
        private readonly IServiceEmployeeReduce _serviceEmployeeReduce;
        private readonly IEmployeeBuilder _employeeBuilder;

        public ServiceEmployeeProject(IServiceEmployeeReduce serviceEmployeeReduce, IRepository<EmployeeProject> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IEmployeeProjectBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IEmployeeBuilder employeeBuilder)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _employeeBuilder = employeeBuilder;
            _serviceEmployeeReduce = serviceEmployeeReduce;
        }

        /// <summary>
        /// Returns the list of employees assigned to the project and employees who
        /// are not assigned to this project at the date and time of consultation
        /// </summary>
        /// <param name="idProject"></param>
        /// <returns></returns>
        public IList<EmployeeProjectViewModel> GetProjectResources(int idProject)
        {
            List<EmployeeProjectViewModel> employeeProjectViewModels = new List<EmployeeProjectViewModel>();
            IList<EmployeeProjectViewModel> assignResources = GetEmployeeAssignResources(idProject);
            employeeProjectViewModels.AddRange(assignResources);
            _serviceEmployeeReduce.GetAllModels().Where(model =>
                assignResources.All(resource => resource.IdEmployee != model.Id))
                .OrderBy(model => model.ReverseFullName).ToList().ForEach(employee =>
                    {
                        employeeProjectViewModels.Add(new EmployeeProjectViewModel
                        {
                            IdEmployee = employee.Id,
                            IdProject = idProject,
                            IdEmployeeNavigation = employee
                        });
                    });
            return employeeProjectViewModels;
        }

        /// <summary>
        /// Retrieves the list of employees assigned to the project who have not been released
        /// </summary>
        /// <param name="idProject"></param>
        /// <returns></returns>
        public IList<EmployeeProjectViewModel> GetEmployeeAssignResources(int idProject)
        {
            IList<EmployeeProjectViewModel> employeeProjectViewModels = FindModelsByNoTracked(model => model.IdProject == idProject &&
                (
                    !model.UnassignmentDate.HasValue ||
                    (model.UnassignmentDate.HasValue && DateTime.Compare(model.UnassignmentDate.Value.Date.AddDays(-NumberConstant.One), DateTime.Now.Date) >= NumberConstant.Zero)
                ),
                model => model.IdEmployeeNavigation)
                .OrderByDescending(x => x.AssignmentDate)
                .GroupBy(x => x.IdEmployee)
                .Select(x => x.FirstOrDefault())
                .ToList();
            return employeeProjectViewModels;
        }

        /// <summary>
        /// Get the List of employees affected to Billable projects in a period that has began in startDate
        /// </summary>
        /// <param name="startDate"></param>
        /// <returns></returns>
        public DataSourceResult<EmployeeViewModel> GetEmployeesAffectedToBillableProject(DateTime month, PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<EmployeeViewModel> dataSourceResult = new DataSourceResult<EmployeeViewModel>();
            PredicateFilterRelationViewModel<EmployeeProject> predicateFilterRelationModel = PreparePredicate(predicateModel);
            IQueryable<EmployeeProject> dataSourcelist = _entityRepo.GetAllWithConditionsRelationsQueryable(x => (
                             !x.IdProjectNavigation.Default && x.IdProjectNavigation.IsBillable && x.IsBillable &&
                             (
                                (x.AssignmentDate.Date.BeforeDate(month)
                                  && (
                                        !x.UnassignmentDate.HasValue
                                        || (x.UnassignmentDate.HasValue && x.UnassignmentDate.Value.Date.AddDays(-NumberConstant.One).AfterDateLimitIncluded(month.Date))
                                     )
                                )
                               ||
                               x.AssignmentDate.Date.BetweenDateLimitIncluded(month.Date, month.LastDateOfMonth())
                             )
                         ),
                         x => x.IdEmployeeNavigation, x => x.IdProjectNavigation).Where(predicateFilterRelationModel.PredicateWhere);
            dataSourceResult.data = dataSourcelist.Select(x => _employeeBuilder.BuildEntity(x.IdEmployeeNavigation)).ToList().Distinct(new EntityComparator<EmployeeViewModel>()).ToList();
            dataSourceResult.total = dataSourceResult.data.Count;
            return dataSourceResult;
        }

        /// <summary>
        /// Returns the list of projects to which the employee is assigned during the month in question
        /// </summary>
        /// <param name="IdEmployee"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public List<ProjectViewModel> GetProjectsAffectedToTheEmployee(int IdEmployee, DateTime month)
        {
            List<ProjectViewModel> list = GetModelsWithConditionsRelations(x => (
                                                       x.IdProjectNavigation.Default != true && x.IdProjectNavigation.IsBillable == true &&
                                                       x.IdEmployee == IdEmployee
                                                       && ((x.AssignmentDate.BeforeDate(month)
                                                             && (
                                                                !x.UnassignmentDate.HasValue
                                                                || (x.UnassignmentDate.HasValue && x.UnassignmentDate.Value.AddDays(-NumberConstant.One).AfterDateLimitIncluded(month))
                                                                )
                                                           )
                                                          || x.AssignmentDate.BetweenDateLimitIncluded(month, month.LastDateOfMonth())
                                                         ) && x.IsBillable == true
                                                       ),
                                                       x => x.IdProjectNavigation,
                                                       x => x.IdProjectNavigation.IdCurrencyNavigation)
                                              .Select(x => x.IdProjectNavigation).ToList()
                                              .Distinct(new EntityComparator<ProjectViewModel>()).ToList();
            return list;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idProject"></param>
        /// <param name="idEmployee"></param>
        /// <returns></returns>
        public IList<EmployeeProjectViewModel> GetAssignationtHistoric(int idProject, int idEmployee)
        {
            IList<EmployeeProjectViewModel> employeeProjectViewModels = FindByAsNoTracking(m => m.IdProject.Equals(idProject)
                && m.IdEmployee.Equals(idEmployee)
                && m.UnassignmentDate.HasValue
                && DateTime.Compare(m.UnassignmentDate.Value.Date, DateTime.Now.Date) < NumberConstant.One)
                .OrderByDescending(m => m.UnassignmentDate).ToList();
            return employeeProjectViewModels;
        }
    }
}
