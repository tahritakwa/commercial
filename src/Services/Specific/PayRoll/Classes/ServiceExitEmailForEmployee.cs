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
    public class ServiceExitEmailForEmployee : Service<ExitEmailForEmployeeViewModel, ExitEmailForEmployee>, IServiceExitEmailForEmployee
    {
        public ServiceExitEmailForEmployee(IRepository<ExitEmailForEmployee> entityRepo,
               IRepository<EntityAxisValues> entityRepoEntityAxisValues,
               IUnitOfWork unitOfWork,
               IExitEmailForEmployeeBuilder builder,
               IOptions<AppSettings> appSettings,
                IRepository<Company> entityRepoCompany,
               IEntityAxisValuesBuilder builderEntityAxisValues) :
                base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
           


        }
    }
}
