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
    public class ServicePaymentType : Service<PaymentTypeViewModel, PaymentType>, IServicePaymentType
    {


        public ServicePaymentType(IRepository<PaymentType> entityRepo, IUnitOfWork unitOfWork,
           IPaymentTypeBuilder PaymentTypeBuilder,
            IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, PaymentTypeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
