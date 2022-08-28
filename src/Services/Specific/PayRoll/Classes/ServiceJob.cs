using Microsoft.Extensions.Options;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceJob : Service<JobViewModel, Job>, IServiceJob
    {
        private IServiceJobEmployee _serviceJobEmployee;
        private IServiceJobSkills _serviceJobSkills;
        private IServiceSkills _serviceSkills;
        private readonly IServiceUserPrivilege _serviceUserPrivilege;
        private readonly IRepository<User> _userRepo;
        public readonly IReducedJobBuilder _reducedBuilder;

        public ServiceJob(IRepository<Job> entityRepo,
            IUnitOfWork unitOfWork, IJobBuilder builder, IServiceJobEmployee serviceJobEmployee, IServiceJobSkills serviceJobSkills,
            IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany, IReducedJobBuilder reducedBuilder,
             IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IServiceSkills serviceSkills, IServiceUserPrivilege serviceUserPrivilege, IRepository<User> userRepo)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceJobEmployee = serviceJobEmployee;
            _serviceJobSkills = serviceJobSkills;
            _reducedBuilder = reducedBuilder;
            _serviceSkills = serviceSkills;
            _serviceUserPrivilege = serviceUserPrivilege;
            _userRepo = userRepo;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        /// <summary>
        /// Check if id job is in job level of connected employee
        /// </summary>
        /// <param name="id"></param>
        /// <param name="level"></param>
        /// <returns></returns>
        public bool IsPartOfHierarchy(int id, string level)
        {
            return !string.IsNullOrEmpty(level) && level.Split(PayRollConstant.LevelSeparator).ToArray().Contains(id.ToString());
        }

        /// <summary>
        /// return list of jobs
        /// </summary>
        /// <returns></returns>
        public List<JobViewModel> GetListOfJobs()
        {
            // Get list of jobs
            List<JobViewModel> listOfAllJobs = GetAllModelsWithRelations(w => w.IdUpperJobNavigation, w => w.JobEmployee, w => w.JobSkills).ToList();

            // List of JobEmployee
            List<JobEmployeeViewModel> listOfAllJobsEmployee = _serviceJobEmployee.GetAllModelsWithRelations(w => w.IdEmployeeNavigation, w => w.IdJobNavigation,
                /*w => w.IdEmployeeNavigation.IdTeamNavigation,*/ w => w.IdEmployeeNavigation.JobEmployee).ToList();
            List<JobSkillsViewModel> listOfAllJobsSkills = _serviceJobSkills.GetAllModelsWithRelations(w => w.IdSkillNavigation, w => w.IdJobNavigation).ToList();

            // Get list of jobs with jobs children
            List<JobViewModel> listOfHiarchicJobs = GetChildrens(listOfAllJobs
                .Where(c => c.IdUpperJob == null).ToList(), listOfAllJobs, listOfAllJobsEmployee, listOfAllJobsSkills).OrderBy(x => x.Designation).ToList();
            return listOfHiarchicJobs;
        }

        /// <summary>
        /// Return the list of jobs recursively
        /// </summary>
        /// <param name="List"></param>
        /// <param name="ListGlobal"></param>
        /// <returns> the List Component view Model </returns>
        public List<JobViewModel> GetChildrens(List<JobViewModel> List, List<JobViewModel> ListGlobal, List<JobEmployeeViewModel> listOfAllJobsEmployee,
            List<JobSkillsViewModel> listOfAllJobsSkills)
        {

            if (List != null)
            {
                foreach (JobViewModel job in List)
                {
                    if (job.JobEmployee != null && job.JobEmployee.Any())
                    {
                        job.JobEmployee = listOfAllJobsEmployee.Where(x => x.IdJob == job.Id).ToList();

                        foreach (JobEmployeeViewModel jobEmpl in job.JobEmployee)
                        {
                            if (jobEmpl.IdEmployeeNavigation != null)
                            {
                                jobEmpl.IdEmployeeNavigation.PictureFileInfo = GetFilesContent(jobEmpl.IdEmployeeNavigation.Picture).FirstOrDefault();
                            }
                        }
                    }
                    if (job.JobSkills != null && job.JobSkills.Any())
                    {
                        job.JobSkills = listOfAllJobsSkills.Where(x => x.IdJob == job.Id).ToList();
                    }
                    job.Text = job.Designation;
                    job.Items = ListGlobal.Where(c => c.IdUpperJob == job.Id).ToList();
                    if (!job.Items.Any())
                    {
                        job.Items = null;
                    }
                    else
                    {
                        GetChildrens(job.Items.ToList(), ListGlobal, listOfAllJobsEmployee, listOfAllJobsSkills);
                    }
                }
            }
            return List;
        }
        /// <summary>
        /// GetModelById
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public override JobViewModel GetModelById(int id)
        {
            JobViewModel jobViewModel = base.GetModelById(id);
            // List of JobEmployee
            List<JobEmployeeViewModel> listOfJobsEmployee = _serviceJobEmployee.GetModelsWithConditionsRelations(w => w.IdJob == id, w => w.IdEmployeeNavigation, w => w.IdJobNavigation,
                /*w => w.IdEmployeeNavigation.IdTeamNavigation,*/ w => w.IdEmployeeNavigation.JobEmployee).ToList();
            List<JobSkillsViewModel> listOfJobsSkills = _serviceJobSkills.GetModelsWithConditionsRelations(w => w.IdJob == id, w => w.IdSkillNavigation, w => w.IdJobNavigation).ToList();
            jobViewModel.JobEmployee = listOfJobsEmployee;
            jobViewModel.JobSkills = listOfJobsSkills;
            return jobViewModel;
        }

        public override object AddModelWithoutTransaction(JobViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // Don't add a job which designation is null (contains only white space
            if (model.Designation.Trim().Length == NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.NullJobAddException);
            }
            IList<JobViewModel> oldJobList = GetAllModels().ToList();
            // Throw exception if the designation of the job to add already exist
            oldJobList.ToList().ForEach((x) =>
            {
                if (string.Compare(x.Designation, model.Designation, CultureInfo.CurrentCulture, CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols) == NumberConstant.Zero)
                {
                    throw new CustomException(CustomStatusCode.JobAddException);
                }
            });
            if (model.IdUpperJob.HasValue)
            {
                JobViewModel upperJob = GetModelById(model.IdUpperJob.Value);
                model.HierarchyLevel = UpdateHierarchyLevel(upperJob);
            }
            else
            {
                model.HierarchyLevel = null;
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        /// <summary>
        /// UpdateModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(JobViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // If the upperJob of the model also has for upperJob the model itself
            if (model.IdUpperJob.HasValue)
            {
                JobViewModel upperJobViewModel = GetModelAsNoTracked(x => x.Id == model.IdUpperJob);
                CheckExistenceOfJobInUpperJob(model, upperJobViewModel);
                model.HierarchyLevel = UpdateHierarchyLevel(upperJobViewModel);
            }
            else
            {
                model.HierarchyLevel = null;
            }
            // Verify if they are two same skills
            if (model.JobSkills.Count > NumberConstant.Zero)
            {
                IEnumerable<IGrouping<int, JobSkillsViewModel>> duplicatedSkills = model.JobSkills.GroupBy(x => x.IdSkill).Where(x => x.Count() > 1);
                if (duplicatedSkills.Any())
                {
                    SkillsViewModel skills = _serviceSkills.GetModelAsNoTracked(x => x.Id == duplicatedSkills.FirstOrDefault().Key);
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        {nameof(Skills), skills.Label}
                    };
                    throw new CustomException(CustomStatusCode.DuplicateSkillsException, paramtrs);
                }
            }
            // save entity traceability
            dynamic entity = _builder.BuildModel(model);

            UpdateJobEmployee(model, userMail);
            UpdateJobSkill(model, userMail);
            entity.JobEmployee.Clear();
            entity.JobSkills.Clear();

            // update collection entity                
            UpdateCollections(entity, userMail);

            // update entity
            _entityRepo.Update(entity);

            // commit 
            _unitOfWork.Commit();

            // Synchronize all jobs after updated job hierarchy level has changed
            SynchronizeJobs();
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        // Update hierarchy level
        private string UpdateHierarchyLevel(JobViewModel upperJob)
        {
            string hierarchyLevel = null;
            if (upperJob.HierarchyLevel.NotNullOrEmpty())
            {
                hierarchyLevel = upperJob.HierarchyLevel + PayRollConstant.LevelSeparator + upperJob.Id.ToString();
            }
            else
            {
                hierarchyLevel = upperJob.Id.ToString();
            }
            return hierarchyLevel;
        }

        private void CheckExistenceOfJobInUpperJob(JobViewModel model, JobViewModel upperJobViewModel)
        {

            if (IsPartOfHierarchy(model.Id, upperJobViewModel.HierarchyLevel))
            {
                IDictionary<string, dynamic> param = new Dictionary<string, dynamic>
                    {
                        { Constants.SUPERIOR_EMPLOYEE_NAME, upperJobViewModel.Designation},
                        { Constants.INFERIOR_EMPLOYEE_NAME, model.Designation}
                    };
                throw new CustomException(CustomStatusCode.JobHierarchyLevelViolation, param);
            }
            else if (model.Id == model.IdUpperJob)
            {
                throw new CustomException(CustomStatusCode.JobUpdateException);
            }
        }

        /// <summary>
        /// Update collection of Job Employee on update employee
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void UpdateJobEmployee(JobViewModel model, string userMail)
        {
            List<JobEmployeeViewModel> oldJobEmployee = _serviceJobEmployee.FindModelBy(x => x.IdJob == model.Id).ToList();
            List<JobEmployeeViewModel> newJobEmployee = model.JobEmployee.ToList();
            newJobEmployee.ForEach(x => x.IdJob = model.Id);

            List<JobEmployeeViewModel> addedJobEmployee = newJobEmployee.Except(oldJobEmployee).ToList();
            List<JobEmployeeViewModel> deletedJobEmployee = oldJobEmployee.Except(newJobEmployee).ToList();

            foreach (JobEmployeeViewModel jobEmployee in addedJobEmployee)
            {
                _serviceJobEmployee.AddModelWithoutTransaction(jobEmployee, new List<EntityAxisValuesViewModel>(), userMail);
            }
            foreach (JobEmployeeViewModel jobEmployee in deletedJobEmployee)
            {
                _serviceJobEmployee.DeleteModelPhysicallyWhithoutTransaction(jobEmployee.Id, userMail);
            }
        }

        /// <summary>
        /// Update collection of Job Employee on update employee
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void UpdateJobSkill(JobViewModel model, string userMail)
        {
            List<JobSkillsViewModel> oldJobSkill = _serviceJobSkills.FindModelBy(x => x.IdJob == model.Id).ToList();
            List<JobSkillsViewModel> newJobSkill = model.JobSkills.ToList();
            newJobSkill.ForEach(x => x.IdJob = model.Id);

            List<JobSkillsViewModel> addedJobSkill = newJobSkill.Except(oldJobSkill).ToList();
            List<JobSkillsViewModel> deletedJobSkill = oldJobSkill.Except(newJobSkill).ToList();

            foreach (JobSkillsViewModel jobSkill in addedJobSkill)
            {
                _serviceJobSkills.AddModelWithoutTransaction(jobSkill, new List<EntityAxisValuesViewModel>(), userMail);
            }
            foreach (JobSkillsViewModel jobSkill in deletedJobSkill)
            {
                _serviceJobSkills.DeleteModelPhysicallyWhithoutTransaction(jobSkill.Id, userMail);
            }
        }

        /// <summary>
        /// Synchronize job hierarchical level
        /// </summary>
        public void SynchronizeJobs()
        {
            List<Job> jobsWithNoUpperHierarchy = _entityRepo.GetAllWithConditionsQueryable(x => x.IdUpperJob == null).ToList();
            List<Job> jobsToUpdate = new List<Job>();
            jobsWithNoUpperHierarchy.ForEach(job =>
            {
                jobsToUpdate.AddRange(GetLowerJob(job));
            });
            if (jobsToUpdate.Count > NumberConstant.Zero)
            {
                BulkUpdateWithoutTransaction(jobsToUpdate);
            }
        }

        // Recursive method which update every job hierarchical level
        private IList<Job> GetLowerJob(Job job)
        {
            List<Job> jobs = new List<Job>();
            List<Job> lowerJobs = _entityRepo.GetAllWithConditionsQueryable(x => x.IdUpperJob == job.Id).ToList();
            if (lowerJobs.Count > NumberConstant.Zero)
            {
                if (job.HierarchyLevel.NotNullOrEmpty())
                {
                    lowerJobs = lowerJobs.Select(x => { x.HierarchyLevel = job.HierarchyLevel + PayRollConstant.LevelSeparator + job.Id.ToString(); return x; }).ToList();
                }
                else
                {
                    lowerJobs = lowerJobs.Select(x => { x.HierarchyLevel = job.Id.ToString(); return x; }).ToList();
                }
                jobs.AddRange(lowerJobs);
                lowerJobs.ForEach(lower =>
                {
                    jobs.AddRange(GetLowerJob(lower));
                });
            }
            return jobs;
        }

        /// <summary>
        /// Get jobs from connected employee job privilege
        /// </summary>
        /// <param name="connectedEmployeeId"></param>
        /// <returns></returns>
        private IQueryable<Job> CheckConnectedEmployeePrivilegeJob(int connectedEmployeeId)
        {
            IQueryable<Job> jobs = new List<Job>().AsQueryable();
            string userMail = ActiveAccountHelper.GetConnectedUserEmail();
            int userId = _userRepo.GetSingleNotTracked(x => x.Email == userMail).Id;
            UserPrivilegeViewModel connectedUserPrivilege = _serviceUserPrivilege.GetModelsWithConditionsRelations(x => x.IdUser == userId
                                        && x.IdPrivilegeNavigation.Reference == Constants.JOB, x => x.IdPrivilegeNavigation).FirstOrDefault();
            List<JobEmployeeViewModel> jobsOfConnectedEmployee = _serviceJobEmployee.GetModelsWithConditionsRelations(x => x.IdEmployee == connectedEmployeeId, x => x.IdJobNavigation).ToList();
            if (connectedUserPrivilege != null && jobsOfConnectedEmployee.Count > NumberConstant.Zero)
            {
                List<JobViewModel> connectedEmployeeJobs = jobsOfConnectedEmployee.Select(x => x.IdJobNavigation).ToList();
                connectedEmployeeJobs.ForEach(job =>
               {
                   if (connectedUserPrivilege.Management.HasValue && connectedUserPrivilege.Management.Value)
                   {
                       jobs = jobs.Union(_entityRepo.QuerableGetAll());
                   }
                   else
                   {
                       jobs = jobs.Union(SubLevelJobs(connectedUserPrivilege, job.Id));
                       jobs = jobs.Union(SameLevelJobs(connectedUserPrivilege, job.Id, job.HierarchyLevel));
                       jobs = jobs.Union(SuperiorLevelJobs(connectedUserPrivilege, job.IdUpperJob));
                   }
               });
            }
            return jobs;
        }

        /// <summary>
        /// Get inferior jobs
        /// </summary>
        /// <param name="connectedUserPrivilege"></param>
        /// <param name="jobId"></param>
        /// <returns></returns>
        private IQueryable<Job> SubLevelJobs(UserPrivilegeViewModel connectedUserPrivilege, int jobId)
        {
            IQueryable<Job> jobs = new List<Job>().AsQueryable();
            if (connectedUserPrivilege.SubLevel.HasValue && connectedUserPrivilege.SubLevel.Value)
            {
                Expression<Func<Job, bool>> expression = x => (!string.IsNullOrEmpty(x.HierarchyLevel) && IsPartOfHierarchy(jobId, x.HierarchyLevel));
                jobs = jobs.Union(_entityRepo.GetAllWithConditionsQueryable(expression));
            }
            return jobs;
        }


        /// <summary>
        /// Get same level employees with or without hierarchy
        /// </summary>
        /// <param name="connectedUserPrivilege"></param>
        /// <param name="jobId"></param>
        /// <param name="jobHierarchyLevel"></param>
        /// <returns></returns>
        private IQueryable<Job> SameLevelJobs(UserPrivilegeViewModel connectedUserPrivilege, int jobId, string jobHierarchyLevel)
        {
            IQueryable<Job> jobs = new List<Job>().AsQueryable();
            if ((connectedUserPrivilege.SameLevelWithHierarchy.HasValue && connectedUserPrivilege.SameLevelWithHierarchy.Value)
                                       || (connectedUserPrivilege.SameLevelWithoutHierarchy.HasValue && connectedUserPrivilege.SameLevelWithoutHierarchy.Value))
            {
                Expression<Func<Job, bool>> expression = x => x.HierarchyLevel == jobHierarchyLevel;
                jobs = jobs.Union(_entityRepo.GetAllWithConditionsQueryable(expression));
                if (connectedUserPrivilege.SameLevelWithHierarchy.HasValue && connectedUserPrivilege.SameLevelWithHierarchy.Value)
                {
                    List<int> jobsIds = GetAllModelsQueryable(expression).Select(x => x.Id).ToList();
                    jobs = jobs.Union(_entityRepo.GetAllWithConditionsQueryable(x => jobsIds.Any(m => IsPartOfHierarchy(m, x.HierarchyLevel))));
                }
            }
            return jobs;
        }

        /// <summary>
        /// Get superior jobs with or without hierarchy
        /// </summary>
        /// <param name="connectedUserPrivilege"></param>
        /// <param name="idUpperJob"></param>
        /// <returns></returns>
        private IQueryable<Job> SuperiorLevelJobs(UserPrivilegeViewModel connectedUserPrivilege, int? idUpperJob)
        {
            IQueryable<Job> jobs = new List<Job>().AsQueryable();
            if (((connectedUserPrivilege.SuperiorLevelWithHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithHierarchy.Value)
                                      || (connectedUserPrivilege.SuperiorLevelWithoutHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithoutHierarchy.Value))
                  && idUpperJob.HasValue)
            {
                string upperLevel = _entityRepo.GetSingle(x => idUpperJob.HasValue && x.Id == idUpperJob.Value).HierarchyLevel;
                Expression<Func<Job, bool>> expression = x => upperLevel == x.HierarchyLevel;
                jobs = jobs.Union(_entityRepo.GetAllWithConditionsQueryable(expression));
                if (connectedUserPrivilege.SuperiorLevelWithHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithHierarchy.Value)
                {
                    List<int> jobsIds = GetAllModelsQueryable(expression).Select(x => x.Id).ToList();
                    jobs = jobs.Union(_entityRepo.GetAllWithConditionsQueryable(x => jobsIds.Any(m => IsPartOfHierarchy(m, x.HierarchyLevel))));
                }
            }
            return jobs;
        }

        /// <summary>
        /// Get jobs ids from job privilege
        /// </summary>
        /// <param name="connectedEmployeeId"></param>
        /// <returns></returns>
        public List<int> GetJobsIdsFromPrivilege(int connectedEmployeeId)
        {
            return CheckConnectedEmployeePrivilegeJob(connectedEmployeeId).Select(x => x.Id).ToList();
        }
    }
}
