using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceSourceDeductionSessionEmployee : Service<SourceDeductionSessionEmployeeViewModel, SourceDeductionSessionEmployee>, IServiceSourceDeductionSessionEmployee
    {
        public ServiceSourceDeductionSessionEmployee(IRepository<SourceDeductionSessionEmployee> entityRepo,
            IUnitOfWork unitOfWork,
            ISourceDeductionSessionEmployeeBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            
        }
        
    }
}
