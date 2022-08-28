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
    public class ServiceEmployeeDocument : Service<EmployeeDocumentViewModel, EmployeeDocument>, IServiceEmployeeDocument
    {

        public ServiceEmployeeDocument(IRepository<EmployeeDocument> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IEntityAxisValuesBuilder builderEntityAxisValues,
            IEmployeeDocumentBuilder builder, IRepository<Entity> entityRepoEntity)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
           
        }
    }
}
