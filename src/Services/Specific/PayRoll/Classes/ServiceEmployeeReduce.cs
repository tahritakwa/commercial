using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public partial class ServiceEmployeeReduce: Service<EmployeeViewModel, Employee>, IServiceEmployeeReduce
    {
        public ServiceEmployeeReduce(IRepository<Employee> entityRepo, IUnitOfWork unitOfWork,
           IEmployeeBuilder employeeBuilder,
           IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
           IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Entity> entityRepoEntity,
            IRepository<Codification> entityRepoCodification)
             : base(entityRepo, unitOfWork, employeeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, 
                   appSettings, entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {

        }

    }
}
