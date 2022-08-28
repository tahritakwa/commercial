using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SessionLoanInstallmentBuilder : GenericBuilder<SessionLoanInstallmentViewModel, SessionLoanInstallment>, ISessionLoanInstallmentBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        //private readonly ISalaryStructureBuilder _salaryStructureBuilder;
        private readonly IContractTypeBuilder _contractTypeBuilder;

        public SessionLoanInstallmentBuilder(IEmployeeBuilder employeeBuilder,/* ISalaryStructureBuilder salaryStructureBuilder,*/ IContractTypeBuilder contractTypeBuilder)
        {
            _employeeBuilder = employeeBuilder;
            //_salaryStructureBuilder = salaryStructureBuilder;
            _contractTypeBuilder = contractTypeBuilder;
        }

        public override SessionLoanInstallmentViewModel BuildEntity(SessionLoanInstallment entity)
        {
            SessionLoanInstallmentViewModel sessionLoanInstallment = base.BuildEntity(entity);
            if (sessionLoanInstallment.IdContractNavigation != null)
            {
                sessionLoanInstallment.IdContractNavigation.IdEmployeeNavigation = _employeeBuilder.BuildEntity(entity.IdContractNavigation.IdEmployeeNavigation);
                //attendanceViewModel.IdContractNavigation.IdSalaryStructureNavigation = _salaryStructureBuilder.BuildEntity(entity.IdContractNavigation.IdSalaryStructureNavigation);
                sessionLoanInstallment.IdContractNavigation.IdContractTypeNavigation = _contractTypeBuilder.BuildEntity(entity.IdContractNavigation.IdContractTypeNavigation);
            }
            return sessionLoanInstallment;
        }
    }
}
