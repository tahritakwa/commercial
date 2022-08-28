using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServicePriceRequestDetail : Service<PriceRequestDetailViewModel, PriceRequestDetail>, IServicePriceRequestDetail
    {
        public ServicePriceRequestDetail(IRepository<PriceRequestDetail> entityRepo, IUnitOfWork unitOfWork,
          IPriceRequestDetailBuilder PriceRequestDetailBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, PriceRequestDetailBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

    }
}
