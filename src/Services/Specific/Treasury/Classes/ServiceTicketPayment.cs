

using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Treasury.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.Treasury;

namespace Services.Specific.Treasury.Classes
{
    public class ServiceTicketPayment : Service<TicketPaymentViewModel, TicketPayment>, IServiceTicketPayment
    {
        public ServiceTicketPayment(IRepository<TicketPayment> entityRepo, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
                     IUnitOfWork unitOfWork, ITicketPaymentBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

    }
}
