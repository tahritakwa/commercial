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
    public class ServicePaymentMethod : Service<PaymentMethodViewModel, PaymentMethod>, IServicePaymentMethod
    {
        public ServicePaymentMethod(IRepository<PaymentMethod> entityRepo, IUnitOfWork unitOfWork,
           IPaymentMethodBuilder PaymentMethodBuilder,
            IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, PaymentMethodBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
