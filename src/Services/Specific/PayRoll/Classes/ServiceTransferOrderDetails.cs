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
    public class ServiceTransferOrderDetails : Service<TransferOrderDetailsViewModel, TransferOrderDetails>, IServiceTransferOrderDetails
    {
        public ServiceTransferOrderDetails(IRepository<TransferOrderDetails> entityRepo, IUnitOfWork unitOfWork, ITransferOrderDetailsBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<Entity> entityRepoEntity, IRepository<User> entityRepoUser) 
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
