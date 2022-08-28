using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceEmployeeSkills : Service<EmployeeSkillsViewModel, EmployeeSkills>, IServiceEmployeeSkills
    {
        internal readonly IRepository<Employee> _entityEmployee;
        internal readonly IRepository<Team> _entityTeam;
        internal readonly IRepository<ReviewSkills> _entityReviewSkills;
        internal readonly IRepository<Review> _entityReview;
        private readonly IServiceSkills _serviceSkills;
        private readonly IEmployeeBuilder _employeeBuilder;

        public ServiceEmployeeSkills(IRepository<EmployeeSkills> entityRepo, IUnitOfWork unitOfWork,            IRepository<Team> entityTeam,
            IEmployeeSkillsBuilder employeeSkillsbuilder, IEntityAxisValuesBuilder builderEntityAxisValues,
            IServiceEmployee serviceEmployee, IRepository<Employee> entityEmployee, IEmployeeBuilder employeeBuilder,
            IServiceSkills serviceSkills,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<ReviewSkills> entityReviewSkills,
            IRepository<Review> entityReview)
            : base(entityRepo, unitOfWork, employeeSkillsbuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityEmployee = entityEmployee;
            _entityTeam = entityTeam;
            _employeeBuilder = employeeBuilder;
            _serviceSkills = serviceSkills;
            _entityReviewSkills = entityReviewSkills;
            _entityReview = entityReview;
        }
        /// <summary>
        /// Displays skills matrix for each employee
        /// </summary>
        /// <param name="employeeSkillsMatrixFilterPredicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<EmployeeSkillsMatrixLine> GetSkillsMatrix(EmployeeSkillsMatrixFilter employeeSkillsMatrixFilter)
        {
            List<EmployeeSkillsMatrixLine> skillsMatrix = new List<EmployeeSkillsMatrixLine>();
            // Total of returned list
            var total = 0;
            // Skills To dispaly in the matrix
            List<int> skillsList = employeeSkillsMatrixFilter.SkillsLevels.Any() 
                ? employeeSkillsMatrixFilter.SkillsLevels.Select(x => x.IdSkills).ToList() 
                : _serviceSkills.GetAllModels().Select(x => x.Id).ToList();
            if (skillsList.Any())
            {
                bool displayAllEmployees = employeeSkillsMatrixFilter.SkillsLevels.Any(x => x.MinLevel == 0 && x.MaxLevel > 0);
                IList<Employee> employeeQueryable;
                if (!displayAllEmployees)
                {
                    employeeQueryable = _entityEmployee.QuerableGetAll()
                                        .Include(x => x.EmployeeTeam)
                                        .ThenInclude(x => x.IdTeamNavigation)
                                        .Include(x => x.EmployeeSkills)
                                        .ThenInclude(x => x.IdSkillsNavigation)
                                        .Where(
                                         x => x.EmployeeTeam.Count > 0 && 
                                         (employeeSkillsMatrixFilter.IdTeam == NumberConstant.Zero &&  (x.EmployeeTeam.FirstOrDefault().IdTeam == null || x.EmployeeTeam.FirstOrDefault().IdTeam > NumberConstant.Zero)
                                         || (employeeSkillsMatrixFilter.IdTeam != NumberConstant.Zero && x.EmployeeTeam.Count > 0 && (x.EmployeeTeam.FirstOrDefault().IdTeam == employeeSkillsMatrixFilter.IdTeam) && x.EmployeeTeam.FirstOrDefault().IsAssigned))
                                         &&
                                         ((!employeeSkillsMatrixFilter.EmployeesId.Any()) || (employeeSkillsMatrixFilter.EmployeesId.Contains(x.Id)))
                                         
                                      )
                                     .OrderByDescending(x => x.EmployeeTeam.Count > 0 ? x.EmployeeTeam.FirstOrDefault().IdTeam: 0).ThenBy(c => c.FirstName)
                                      .ToList();
                }
                else
                {
                    employeeQueryable = _entityEmployee.QuerableGetAll()
                                     .Include(x => x.EmployeeTeam)
                                     .ThenInclude(x => x.IdTeamNavigation)
                                     .Include(x => x.EmployeeSkills)
                                     .ThenInclude(x => x.IdSkillsNavigation)
                                     .Where(
                                        x =>
                                        (employeeSkillsMatrixFilter.IdTeam == NumberConstant.Zero && x.EmployeeTeam.Count > 0 && (x.EmployeeTeam.FirstOrDefault().IdTeam == null || x.EmployeeTeam.FirstOrDefault().IdTeam > NumberConstant.Zero)
                                        || (employeeSkillsMatrixFilter.IdTeam != NumberConstant.Zero && x.EmployeeTeam.Count > 0 && (x.EmployeeTeam.FirstOrDefault().IdTeam == employeeSkillsMatrixFilter.IdTeam) && x.EmployeeTeam.FirstOrDefault().IsAssigned))
                                        &&
                                        ((!employeeSkillsMatrixFilter.EmployeesId.Any()) || (employeeSkillsMatrixFilter.EmployeesId.Contains(x.Id)))
                                     )
                                     .OrderByDescending(x => x.EmployeeTeam.Count > 0 ? x.EmployeeTeam.FirstOrDefault().IdTeam : 0).ThenBy(c => c.FirstName)
                                     .ToList();
                }

                total = employeeQueryable.Count;
                var listEmployees = employeeQueryable.Skip((employeeSkillsMatrixFilter.Page - 1) * employeeSkillsMatrixFilter.PageSize)
                                       .Take(employeeSkillsMatrixFilter.PageSize)
                                       .Select(x => _employeeBuilder.BuildEntity(x))
                                       .ToList();

                foreach (EmployeeViewModel employee in listEmployees)
                {
                    EmployeeSkillsMatrixLine matrixLine = new EmployeeSkillsMatrixLine
                    {
                        Employee = employee
                    };
                    if (employee.EmployeeTeam.Count > 0)
                    {
                        matrixLine.Team = _entityTeam.GetSingleNotTracked(x => x.Id == employee.EmployeeTeam.FirstOrDefault().IdTeam).Name;
                    }
                    else
                    {
                        matrixLine.Team = "Unassigned";
                    }
                    Dictionary<int, int> EmployeeSkills = new Dictionary<int, int>();
                    foreach (int id in skillsList)
                    {
                        if (employeeSkillsMatrixFilter.SkillsLevels.Any())
                        {
                            var skillsRate = employeeSkillsMatrixFilter.SkillsLevels.Where(x => x.IdSkills == id).First();
                            IList<EmployeeSkillsViewModel> models = new List<EmployeeSkillsViewModel>();
                            if (employee.EmployeeSkills != null)
                            {
                                models = employee.EmployeeSkills
                                             .Where(x => x.IdSkills == skillsRate.IdSkills
                                                    && x.Rate >= skillsRate.MinLevel
                                                    && x.Rate <= skillsRate.MaxLevel).ToList();
                            }
                            EmployeeSkills[id] = (models.Any()) ? models.First().Rate : 0;
                        }
                        else
                        {
                            if ((employee.EmployeeSkills != null) && (employee.EmployeeSkills.Any()))
                            {
                                var models = employee.EmployeeSkills
                                                .Where(x => x.IdSkills == id).ToList();
                                EmployeeSkills[id] = (models.Any()) ? models.First().Rate : 0;
                            }
                            else
                            {
                                EmployeeSkills[id] = 0;
                            }

                        }
                    }
                    matrixLine.Skills = EmployeeSkills;
                    skillsMatrix.Add(matrixLine);
                }

            }

            return new DataSourceResult<EmployeeSkillsMatrixLine> { data = skillsMatrix, total = total };
        }
        /// <summary>
        /// Add or update a specific rating value in the skills Matrix
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <returns></returns>
        public object changeRating(EmployeeSkillsViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            IList<EmployeeSkillsViewModel> employeesListSkillsViewModel = FindModelsByNoTracked(x => x.IdEmployee == model.IdEmployee
            && x.IdSkills == model.IdSkills).ToList();
            if (employeesListSkillsViewModel.Any())
            {
                EmployeeSkillsViewModel employeeSkillsViewModel = employeesListSkillsViewModel.First();
                // it's an update opération
                employeeSkillsViewModel.Rate = model.Rate;
                base.UpdateModel(employeeSkillsViewModel, entityAxisValuesModelList, userMail);
                return employeeSkillsViewModel;

            }
            else
            {
                // do add 
                return base.AddModel(model, entityAxisValuesModelList, userMail);
            }
        }


        /// <summary>
        /// Get the employee old skills, for the annual interview
        /// </summary>
        /// <param name="idReview"></param>
        /// <returns></returns>
        public DataSourceResult<EmployeeSkillsViewModel> GetPastReviewSkillsList(int idReview)
        {
            // Get the current review
            Review review = _entityReview.GetSingleNotTracked(x => x.Id == idReview);
            // Get the employee skills list of the current Review
            IList<ReviewSkills> reviewSkills = _entityReviewSkills.GetAllWithConditionsQueryable(x => x.IdReview == review.Id).ToList();
            // Get the employeeSkills which are not in the current reviewSkills
            DataSourceResult<EmployeeSkillsViewModel> dataSourceResult = new DataSourceResult<EmployeeSkillsViewModel>();
            var queryableList = GetAllModelsQueryable(x => x.IdEmployee == review.IdEmployeeCollaborator && reviewSkills.All(r => r.IdSkills != x.IdSkills));
            dataSourceResult.total = queryableList.Count();
            dataSourceResult.data = queryableList.ToList();
          
            return dataSourceResult;
        }
    }
}
