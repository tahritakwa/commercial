using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{
    public class ServicePaymentStatus : Service<PaymentStatusViewModel, PaymentStatus>, IServicePaymentStatus
    {
        public ServicePaymentStatus(IRepository<PaymentStatus> entityRepo, IUnitOfWork unitOfWork,
           IPaymentStatusBuilder PaymentStatusBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, PaymentStatusBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
