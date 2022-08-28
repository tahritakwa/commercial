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
    public class ServiceExpenseReportDetailsType : Service<ExpenseReportDetailsTypeViewModel, ExpenseReportDetailsType>, IServiceExpenseReportDetailsType
    {
        public ServiceExpenseReportDetailsType(IRepository<ExpenseReportDetailsType> entityRepo, IUnitOfWork unitOfWork,
            IExpenseReportDetailsTypeBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues) 
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

    }
}
