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
    public class ServiceSessionLoanInstallment : Service<SessionLoanInstallmentViewModel, SessionLoanInstallment>, IServiceSessionLoanInstallment
    {

        public ServiceSessionLoanInstallment(IRepository<SessionLoanInstallment> entityRepo, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,
        ISessionLoanInstallmentBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues) : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
