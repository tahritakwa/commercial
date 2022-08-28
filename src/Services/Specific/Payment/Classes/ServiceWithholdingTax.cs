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
    public class ServiceWithholdingTax : Service<WithholdingTaxViewModel, WithholdingTax>, IServiceWithholdingTax
    {
        public ServiceWithholdingTax(IRepository<WithholdingTax> entityRepo, IUnitOfWork unitOfWork,
           IWithholdingTaxBuilder withholdingTaxBuilder,  IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, withholdingTaxBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
