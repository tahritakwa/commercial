using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceJobEmployee : Service<JobEmployeeViewModel, JobEmployee>, IServiceJobEmployee
    {
        public ServiceJobEmployee(IRepository<JobEmployee> entityRepo,
            IUnitOfWork unitOfWork, IJobEmployeeBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityAxisValues> entityRepoEntityAxisValues )
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }

        /// <summary>
        /// Get employee list of job as string seprated by comas
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <returns></returns>
        public string GetEmployeeJobAsString(int idEmployee)
        {
            var employeeJobs = _entityRepo.GetAllWithConditionsRelations(x => x.IdEmployee == idEmployee, x => x.IdJobNavigation).ToList();
            string employeeJobString = employeeJobs.Any() ? string.Concat(employeeJobs.Select(x => string.Concat(x.IdJobNavigation.Designation, ","))) : string.Empty;
            if (!string.IsNullOrEmpty(employeeJobString))
            {
                employeeJobString = employeeJobString.Substring(NumberConstant.Zero, employeeJobString.Length - NumberConstant.One);
            }
            return employeeJobString;
        }
    }
}
