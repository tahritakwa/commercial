using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SessionContractBuilder : GenericBuilder<SessionContractViewModel, SessionContract>, ISessionContractBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IContractTypeBuilder _contractTypeBuilder;

        public SessionContractBuilder(IEmployeeBuilder employeeBuilder, IContractTypeBuilder contractTypeBuilder)
        {
            _employeeBuilder = employeeBuilder;
            _contractTypeBuilder = contractTypeBuilder;
        }

        public override SessionContractViewModel BuildEntity(SessionContract entity)
        {
            SessionContractViewModel sessionContractViewModel = base.BuildEntity(entity);
            if (entity.IdContractNavigation != null)
            {
                if (entity.IdContractNavigation.IdEmployeeNavigation != null)
                {
                    sessionContractViewModel.IdContractNavigation.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdContractNavigation.IdEmployeeNavigation);
                }
                if (entity.IdContractNavigation.IdContractTypeNavigation != null)
                {
                    sessionContractViewModel.IdContractNavigation.IdContractTypeNavigation = _contractTypeBuilder.BuildEntity(entity.IdContractNavigation.IdContractTypeNavigation);
                }
            }
            return sessionContractViewModel;
        }
    }
}
