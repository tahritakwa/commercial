using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceProject : Service<ProjectViewModel, Project>, IServiceProject
    {
        //private readonly IServiceEmployee _serviceEmployee;
        private readonly IRepository<Employee> _repoEmployee;
        private readonly IEmployeeBuilder _builderEmployee;
        private readonly IServiceTimeSheetLine _serviceTimeSheetLine;
        private readonly IServiceEmployeeProject _serviceEmployeeProject;
        private readonly IServiceCurrency _serviceCurrency;


        public ServiceProject(IServiceEmployeeProject serviceEmployeeProject, IRepository<Employee> repoEmployee, IEmployeeBuilder builderEmployee,
            IRepository<Project> entityRepo, IServiceCurrency serviceCurrency,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IProjectBuilder builder,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IEntityAxisValuesBuilder builderEntityAxisValues, IServiceTimeSheetLine serviceTimeSheetLine)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _repoEmployee = repoEmployee;
            _serviceEmployeeProject = serviceEmployeeProject;
            _serviceTimeSheetLine = serviceTimeSheetLine;
            _serviceCurrency = serviceCurrency;
            _builderEmployee = builderEmployee;
        }

        public override object AddModelWithoutTransaction(ProjectViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckProject(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        private void CheckProject(ProjectViewModel project)
        {
            CheckAverageDailyRate(project);
            CheckAssignementStartDateIsBetweenProjectDates(project);
            CheckAssignementDateIsBetweenProjectDates(project);
            CheckEmployeeProjectUnassignmentDate(project);
            FormateAverageDailyRate(project);
            ManageProjectAttachementFile(project);
            CheckEmployeeProjectValidityAssignmentDate(project);
        }

        /// <summary>
        /// Check if the average daily rate is too great or lower than one
        /// </summary>
        /// <param name="averageDailyRate"></param>
        private void CheckAverageDailyRate(ProjectViewModel model)
        {
            if (model.AverageDailyRate.Value > NumberConstant.OneBillion || model.AverageDailyRate.Value < NumberConstant.One)
            {
                throw new CustomException(CustomStatusCode.AverageDailyRateException);
            }
            EmployeeProjectViewModel employeeProject = model.EmployeeProject.Where(x => x.AverageDailyRate.HasValue
                && (x.AverageDailyRate.Value > NumberConstant.OneBillion || x.AverageDailyRate.Value < NumberConstant.One)).FirstOrDefault();
            if (employeeProject != null)
            {
                Employee employee = _repoEmployee.GetSingle(x => x.Id == employeeProject.IdEmployee);
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { nameof(Employee), employee.FullName }
                    };
                throw new CustomException(CustomStatusCode.EmployeeAverageDailyRateException, paramtrs);
            }
        }

        private void FormateAverageDailyRate(ProjectViewModel model)
        {
            int precisionValue = _serviceCurrency.GetModelById(model.IdCurrency.Value).Precision;
            if (precisionValue != NumberConstant.Zero)
            {
                model.AverageDailyRate = AmountMethods.FormatValue(model.AverageDailyRate, precisionValue);
            }
            foreach (EmployeeProjectViewModel employeeProject in model.EmployeeProject)
            {
                if (employeeProject.AverageDailyRate.HasValue)
                {
                    employeeProject.AverageDailyRate = AmountMethods.FormatValue(employeeProject.AverageDailyRate, precisionValue);
                }
            }
        }

        public override object UpdateModelWithoutTransaction(ProjectViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            CheckProject(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// Manage attachment file of project
        /// </summary>
        /// <param name="projectViewModel"></param>
        private void ManageProjectAttachementFile(ProjectViewModel projectViewModel)
        {
            if (string.IsNullOrEmpty(projectViewModel.AttachementFile))
            {
                if (projectViewModel.FilesInfos != null && projectViewModel.FilesInfos.Count != NumberConstant.Zero)
                {
                    projectViewModel.AttachementFile = Path.Combine(RHConstant.ProjectFileRootPath + projectViewModel.Name, Guid.NewGuid().ToString());
                    CopyFiles(projectViewModel.AttachementFile, projectViewModel.FilesInfos);
                }
            }
            else
            {
                if (projectViewModel.FilesInfos != null)
                {
                    DeleteFiles(projectViewModel.AttachementFile, projectViewModel.FilesInfos);
                    CopyFiles(projectViewModel.AttachementFile, projectViewModel.FilesInfos);
                }
            }
        }

        /// <summary>
        /// It checks to see if all project assignments have assignment dates greater than or equal to the project start date
        /// </summary>
        /// <param name="model"></param>
        private void CheckAssignementDateIsBetweenProjectDates(ProjectViewModel model)
        {
            IList<TimeSheetLineViewModel> conflictTimesheetLines = new List<TimeSheetLineViewModel>();
            IList<DateTime> conflictDates = new List<DateTime>();
            // If the project is not billable, for all assignments that are billed or have a percentage assignment value, initiate them to false and null, respectively.
            if (!model.IsBillable && model.EmployeeProject.Any(m => m.AssignmentPercentage.HasValue || m.IsBillable))
            {
                model.EmployeeProject.Where(m => m.AssignmentPercentage.HasValue || m.IsBillable).Select(m =>
                {
                    m.IsBillable = false; m.AssignmentPercentage = null; return m;
                }).ToList();
            }
            // If the contract has an end date, check if all contract assignments are included in the period from the start date to the end date   
            model.EmployeeProject.ToList().ForEach(newEmployeeProject =>
            {

                // If the assignment percentage on the project is less than 0 or greater than 100
                if (newEmployeeProject.AssignmentPercentage.HasValue &&
                (newEmployeeProject.AssignmentPercentage < NumberConstant.Zero || newEmployeeProject.AssignmentPercentage > NumberConstant.Hundred))
                {
                    Employee employee = _repoEmployee.FindByAsNoTracking(emp => emp.Id == newEmployeeProject.IdEmployee).FirstOrDefault();
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { nameof(Employee), employee.FullName }
                    };
                    throw new CustomException(CustomStatusCode.PERCENTAGE_MUST_BE_BETWEEN_ZERO_AND_HENDRED, paramtrs);
                }
                if (newEmployeeProject.Id != NumberConstant.Zero)
                {
                    EmployeeProjectViewModel oldEmployeeProjectViewModel = _serviceEmployeeProject.GetModelAsNoTracked(m => m.Id == newEmployeeProject.Id);
                    if (!oldEmployeeProjectViewModel.UnassignmentDate.HasValue && newEmployeeProject.UnassignmentDate.HasValue)
                    {
                        conflictTimesheetLines = _serviceTimeSheetLine.FindModelsByNoTracked(m => m.IdProject.Equals(model.Id) &&
                            DateTime.Compare(m.Day.Date, newEmployeeProject.UnassignmentDate.Value) >= NumberConstant.Zero &&
                            m.IdTimeSheetNavigation.IdEmployee.Equals(oldEmployeeProjectViewModel.IdEmployee),
                            m => m.IdTimeSheetNavigation).ToList();
                        ThrowAssignemenException(conflictTimesheetLines);
                    }
                    if (oldEmployeeProjectViewModel.UnassignmentDate.HasValue && newEmployeeProject.UnassignmentDate < oldEmployeeProjectViewModel.UnassignmentDate)
                    {
                        conflictDates = oldEmployeeProjectViewModel.UnassignmentDate.Value.AllDatesUntilLimitIncluded(newEmployeeProject.UnassignmentDate.Value);
                        conflictTimesheetLines = _serviceTimeSheetLine.FindModelsByNoTracked(m => m.IdProject.Equals(model.Id) &&
                           conflictDates.Any(d => DateTime.Compare(d.Date, m.Day.Date) == NumberConstant.Zero) &&
                           m.IdTimeSheetNavigation.IdEmployee.Equals(oldEmployeeProjectViewModel.IdEmployee),
                           m => m.IdTimeSheetNavigation).ToList();
                        ThrowAssignemenException(conflictTimesheetLines);
                    }
                    if (DateTime.Compare(newEmployeeProject.AssignmentDate.Value.Date, oldEmployeeProjectViewModel.AssignmentDate.Value.Date) > NumberConstant.Zero)
                    {
                        conflictDates = oldEmployeeProjectViewModel.AssignmentDate.Value.AllDatesUntilLimitIncluded(newEmployeeProject.AssignmentDate.Value);
                        conflictTimesheetLines = _serviceTimeSheetLine.FindModelsByNoTracked(m => m.IdProject.Equals(model.Id) &&
                        conflictDates.Any(d => DateTime.Compare(d.Date, m.Day.Date) == NumberConstant.Zero) &&
                           m.IdTimeSheetNavigation.IdEmployee.Equals(oldEmployeeProjectViewModel.IdEmployee),
                        m => m.IdTimeSheetNavigation).ToList();
                        ThrowAssignemenException(conflictTimesheetLines);
                    }
                }
                if (newEmployeeProject.UnassignmentDate.HasValue)
                {
                    // If the assignment date equals the Unassignment date, this assumes that there is no need to have an assignment
                    if (DateTime.Compare(newEmployeeProject.AssignmentDate.Value.Date, newEmployeeProject.UnassignmentDate.Value.Date) == NumberConstant.Zero)
                    {
                        if (newEmployeeProject.Id != NumberConstant.Zero)
                        {
                            _serviceEmployeeProject.DeleteModelwithouTransaction(newEmployeeProject.Id, nameof(EmployeeProject), "");
                        }
                        model.EmployeeProject.Remove(newEmployeeProject);
                    }
                    else if (DateTime.Compare(newEmployeeProject.UnassignmentDate.Value.Date, newEmployeeProject.AssignmentDate.Value.Date) < NumberConstant.Zero)
                    {
                        var employee = _repoEmployee.FindByAsNoTracking(emp => emp.Id.Equals(newEmployeeProject.IdEmployee)).FirstOrDefault();
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                                { nameof(Employee), employee.FullName }
                        };
                        throw new CustomException(CustomStatusCode.ASSIGNMENTDATE_MUST_BE_LOWER_THAN_UNASSIGNMENTDATE, paramtrs);
                    }
                }
                List<EmployeeProjectViewModel> alreadyAffected = _serviceEmployeeProject.GetAssignationtHistoric(model.Id, newEmployeeProject.IdEmployee).ToList();
                // If the employeeproject is not unique by assignmentDate
                if (alreadyAffected.Any(m => m.AssignmentDate.Value.Date == newEmployeeProject.AssignmentDate.Value.Date ||
                newEmployeeProject.AssignmentDate.Value.BetweenDateLimitIncluded(m.AssignmentDate.Value, m.UnassignmentDate.Value.AddDays(-NumberConstant.One))))
                {
                    var employee = _repoEmployee.FindByAsNoTracking(emp => emp.Id.Equals(newEmployeeProject.IdEmployee)).FirstOrDefault();
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                            { nameof(Employee), employee.FullName }
                    };
                    throw new CustomException(CustomStatusCode.CANNOT_HAVE_MORE_THAN_ONE_ASIGNEMENT_WITH_SAME_DATE, paramtrs);
                }
            });
        }

        /// <summary>
        /// Check if assignement startdate is greater tha project startdate according to project having end date or not
        /// </summary>
        /// <param name="model"></param>
        private void CheckAssignementStartDateIsBetweenProjectDates(ProjectViewModel model)
        {
            EmployeeProjectViewModel employeeProjectViewModel;
            if (model.ExpectedEndDate.HasValue)
            {
                model.EmployeeProject.Where(m => m.UnassignmentDate.HasValue && m.UnassignmentDate.Value.Date.AfterDate(model.ExpectedEndDate.Value.Date)).ToList().ForEach(m =>
                {
                    m.UnassignmentDate = model.ExpectedEndDate.Value.AddDays(NumberConstant.One);
                });
                employeeProjectViewModel = model.EmployeeProject.FirstOrDefault(m =>
                !m.AssignmentDate.Value.BetweenDateLimitIncluded(model.StartDate, model.ExpectedEndDate.Value) ||
                (m.UnassignmentDate.HasValue && !m.UnassignmentDate.Value.AddDays(-NumberConstant.One).BetweenDateLimitIncluded(model.StartDate, model.ExpectedEndDate.Value)));
            }
            // Otherwise ensure that all start dates of assignments are greater than or equal to the start date of the contract
            else
            {
                employeeProjectViewModel = model.EmployeeProject.FirstOrDefault(m =>
                    (m.AssignmentDate.HasValue && DateTime.Compare(m.AssignmentDate.Value.Date, model.StartDate.Date) < NumberConstant.Zero) ||
                    (m.UnassignmentDate.HasValue && DateTime.Compare(m.UnassignmentDate.Value.Date, model.StartDate.Date) < NumberConstant.Zero));
            }
            if (employeeProjectViewModel != null)
            {
                Employee employee = _repoEmployee.FindByAsNoTracking(emp => emp.Id.Equals(employeeProjectViewModel.IdEmployee)).FirstOrDefault();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { nameof(Employee), employee.FullName }
                };
                throw new CustomException(CustomStatusCode.ASSIGNMENT_STARDATE_MUST_BE_BETWEEN_PROJECT_STARTDATE_AND_ENDDATE, paramtrs);
            }
        }

        /// <summary>
        /// Checks if the end date of the project does not conflict with submitted CRA lines
        /// </summary>
        /// <param name="model"></param>
        private void CheckPojectDateValidity(ProjectViewModel model)
        {
            ProjectViewModel projectViewModelBeforeUpdate = GetModelAsNoTracked(m => m.Id.Equals(model.Id));
            if (!projectViewModelBeforeUpdate.ExpectedEndDate.HasValue && model.ExpectedEndDate.HasValue)
            {
                IList<TimeSheetLineViewModel> conflictTimesheetLines = _serviceTimeSheetLine.FindModelsByNoTracked(m => m.IdProject.Equals(model.Id) &&
                        DateTime.Compare(m.Day.Date, model.ExpectedEndDate.Value.Date) >= NumberConstant.Zero,
                        m => m.IdTimeSheetNavigation).ToList();
                ThrowAssignemenException(conflictTimesheetLines);
            }
            if (model.ExpectedEndDate.HasValue && projectViewModelBeforeUpdate.ExpectedEndDate.HasValue &&
                DateTime.Compare(model.ExpectedEndDate.Value.Date, projectViewModelBeforeUpdate.ExpectedEndDate.Value.Date) < NumberConstant.Zero)
            {
                IList<DateTime> conflictDates = model.ExpectedEndDate.Value.AllDatesUntilLimitIncluded(projectViewModelBeforeUpdate.ExpectedEndDate.Value);
                IList<TimeSheetLineViewModel> conflictTimesheetLines = _serviceTimeSheetLine.FindModelsByNoTracked(m => m.IdProject.Equals(model.Id) &&
                        conflictDates.Any(d => DateTime.Compare(d.Date, m.Day.Date) == NumberConstant.Zero),
                        m => m.IdTimeSheetNavigation).ToList();
                ThrowAssignemenException(conflictTimesheetLines);
            }
        }

        /// <summary>
        /// Propagates an exception if there is a TimeSheet lines that exits the assignment
        /// </summary>
        /// <param name="lines"></param>
        private void ThrowAssignemenException(IList<TimeSheetLineViewModel> lines)
        {
            if (lines.Any())
            {
                Employee employee = _repoEmployee.FindByAsNoTracking(emp => emp.Id == lines.FirstOrDefault().IdTimeSheetNavigation.IdEmployee).FirstOrDefault();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { nameof(Employee), employee.FullName }
                };
                throw new CustomException(CustomStatusCode.CANT_UPDATE_ASSIGNMENT_BECAUSE_USED_BY_TIMESHEETLINE, paramtrs);
            }
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            IEnumerable<TimeSheetLineViewModel> timeSheetLines = _serviceTimeSheetLine.FindModelsByNoTracked(m => m.IdProject.Equals(id));
            // Do not allow deletion when it is used in one or more Timesheet(s)
            if (timeSheetLines.Any())
            {
                throw new CustomException(CustomStatusCode.CANT_DELETE_PROJECT_BECAUSE_USED_IN_TIMESHEET);
            }
            return base.DeleteModelwithouTransaction(id, tableName, userMail);
        }

        /// <summary>
        /// Return the list of projects assigned to an employee on the date in parameter
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <returns></returns>
        public IList<ProjectViewModel> EmployeeAssignedProjectAtDate(int idEmployee, DateTime startDate, DateTime? endDate = null)
        {
            IList<ProjectViewModel> projectViewModels;
            if (endDate != null)
            {
                IList<DateTime> listOfDates = startDate.AllDatesUntilLimitIncluded(endDate.Value);
                IList<EmployeeProjectViewModel> employeeProjectViewModels = _serviceEmployeeProject.FindModelBy(model => model.IdEmployee.Equals(idEmployee) &&
                listOfDates.Any(m => model.AssignmentDate.BeforeDateLimitIncluded(m) ||
                (model.UnassignmentDate.HasValue && m.BetweenDateLimitIncluded(model.AssignmentDate, model.UnassignmentDate.Value.PreviousDate())))).ToList();
                projectViewModels = FindModelBy(model => employeeProjectViewModels.Any(assign => assign.IdProject.Equals(model.Id))).Distinct().ToList();
            }
            else
            {
                IList<EmployeeProjectViewModel> employeeProjectViewModels = _serviceEmployeeProject.FindModelBy(
                model => model.IdEmployee.Equals(idEmployee) &&
                ((model.AssignmentDate.BeforeDateLimitIncluded(startDate) && !model.UnassignmentDate.HasValue) ||
                (model.UnassignmentDate.HasValue && startDate.BetweenDateLimitIncluded(model.AssignmentDate, model.UnassignmentDate.Value.PreviousDate())))).ToList();
                projectViewModels = FindModelBy(model => employeeProjectViewModels.Any(assign => assign.IdProject.Equals(model.Id))).Distinct().ToList();
            }
            return projectViewModels;
        }

        /// <summary>
        /// Return the list of projects assigned to an employee on the date in parameter
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <returns></returns>
        public IList<EmployeeProjectViewModel> EmployeeAssignedProjectIncludedInDates(int idEmployee, IList<DateTime> listOfDates)
        {
            IList<EmployeeProjectViewModel> employeeProjectViewModels = _serviceEmployeeProject.FindModelsByNoTracked(model => model.IdEmployee.Equals(idEmployee), x => x.IdProjectNavigation).ToList();

            IList<EmployeeProjectViewModel> employeeProjectIncludedInDates = employeeProjectViewModels.Where(model => listOfDates.Any(m => model.AssignmentDate.Value.BeforeDateLimitIncluded(m) ||
         (model.UnassignmentDate.HasValue && m.BetweenDateLimitIncluded(model.AssignmentDate.Value, model.UnassignmentDate.Value.PreviousDate())))).ToList();
            return employeeProjectViewModels;
        }

        /// <summary>
        /// Return the list of the employee's worked projects in a specific month
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public IList<ProjectViewModel> EmployeeWorkedProjectAtDate(int idEmployee, DateTime startDate, DateTime endDate)
        {
            IList<ProjectViewModel> projectViewModels = _serviceTimeSheetLine.GetModelsWithConditionsRelations(model =>
                                            model.IdTimeSheetNavigation.IdEmployee == idEmployee
                                            && model.IdProject.HasValue
                                            && model.Day.BetweenDateLimitIncluded(startDate, endDate),
                                            model => model.IdProjectNavigation).
                                            Select(model => model.IdProjectNavigation).Distinct(new EntityComparator<ProjectViewModel>()).ToList();
            projectViewModels = (from project in projectViewModels
                                 orderby !string.IsNullOrEmpty(project.ProjectLabel) ? project.ProjectLabel : project.Name
                                 select project).OrderBy(x => x.Default).ToList();
            return projectViewModels;
        }

        public DataSourceResult<ProjectViewModel> GetProjectDropdownForBillingSession(PredicateFormatViewModel predicateModel, DateTime month)
        {
            PredicateFilterRelationViewModel<Project> predicateFilterRelationModel = PreparePredicate(predicateModel);
            DataSourceResult<ProjectViewModel> dataSource = new DataSourceResult<ProjectViewModel>();
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(x =>
                        (x.StartDate.Date.BeforeDateLimitIncluded(month.Date) &&
                            (
                                !x.ExpectedEndDate.HasValue
                                || (x.ExpectedEndDate.HasValue && x.ExpectedEndDate.Value.AfterDateLimitIncluded(month.Date))
                            )
                        )
                        ||
                        x.StartDate.Date.BetweenDateLimitIncluded(month, month.LastDateOfMonth())
                ).
                OrderByRelation(predicateModel.OrderBy).Where(predicateFilterRelationModel.PredicateWhere).ToList();
            dataSource.data = entities.Select(x => _builder.BuildEntity(x)).ToList();
            dataSource.total = entities.Count;
            return dataSource;
        }

        /// <summary>
        /// Update the UnassignmentDate of employeeProject
        /// </summary>
        private void CheckEmployeeProjectUnassignmentDate(ProjectViewModel projectViewModel)
        {
            if (projectViewModel.ExpectedEndDate.HasValue && projectViewModel.EmployeeProject.Count > NumberConstant.Zero)
            {
                projectViewModel.EmployeeProject.ToList().ForEach((employeeProject) =>
                {
                    if (employeeProject.AverageDailyRate <= NumberConstant.Zero)
                    {
                        employeeProject.AverageDailyRate = null;
                    }
                    if (!employeeProject.UnassignmentDate.HasValue)
                    {
                        employeeProject.UnassignmentDate = projectViewModel.ExpectedEndDate.Value.Date.AddDays(NumberConstant.One);
                    }
                }
                );
            }
        }

        private void CheckEmployeeProjectValidityAssignmentDate(ProjectViewModel projectViewModel)
        {
            if (projectViewModel.EmployeeProject.Count > NumberConstant.Zero)
            {
                IList<Employee> employees = _repoEmployee.FindByAsNoTracking(m =>
                   projectViewModel.EmployeeProject.Select(x => x.IdEmployee).Contains(m.Id)).ToList();
                employees.ToList().ForEach((employee) =>
                {
                    var emp = projectViewModel.EmployeeProject.FirstOrDefault(x => x.IdEmployee == employee.Id);
                    if (DateTime.Compare(emp.AssignmentDate.Value, employee.HiringDate) < NumberConstant.Zero)
                    {
                        IDictionary<string, dynamic> errorParams = new Dictionary<string, dynamic>
                    {
                            { nameof(Employee), employee.FullName }
                    };
                        throw new CustomException(CustomStatusCode.EMPLOYEE_PROJECT_VALIDITY_ASSIGNMENT_DATE, errorParams);
                    }
                });
            }
        }


        /// <summary>
        /// Get project
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public ProjectViewModel GetModelByConditionWithHistory(PredicateFormatViewModel predicate)
        {
            ProjectViewModel projectViewModel = GetModelWithRelations(predicate);
            projectViewModel.FilesInfos = GetFiles(projectViewModel.AttachementFile).ToList();
            if (projectViewModel.EmployeeProject != null)
            {
                foreach (EmployeeProjectViewModel employee in projectViewModel.EmployeeProject)
                {
                    employee.IdEmployeeNavigation = _builderEmployee.BuildEntity(_repoEmployee.FindByAsNoTracking(x => x.Id == employee.IdEmployee).FirstOrDefault());
                }
            }
            return projectViewModel;

        }

        public DataSourceResult<ProjectViewModel> GetFiltredProjectList(PredicateFormatViewModel predicate, DateTime? endDate, DateTime? startDate)
        {
            PredicateFilterRelationViewModel<Project> predicateFilterRelationModel = PreparePredicate(predicate);
            IQueryable<Project> projectQueryable = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                                              .Where(predicateFilterRelationModel.PredicateWhere).OrderByRelation(predicate.OrderBy);
            if (startDate.HasValue)
            {
                projectQueryable = projectQueryable
                                              .Where(x => x.StartDate.AfterDateLimitIncluded(startDate.Value));
            }
            if (endDate.HasValue)
            {
                projectQueryable = projectQueryable
                                              .Where(x => x.ExpectedEndDate.HasValue && x.ExpectedEndDate.Value.BeforeDateLimitIncluded(endDate.Value));
            }
            DataSourceResult<ProjectViewModel> dataSourceResult = new DataSourceResult<ProjectViewModel>();
            dataSourceResult.total = projectQueryable.Count();
            dataSourceResult.data = projectQueryable.Skip((predicate.page - 1) * predicate.pageSize).
                    Take(predicate.pageSize).ToList().Select(x => _builder.BuildEntity(x)).ToList();
            return dataSourceResult;
        }
    }
}
