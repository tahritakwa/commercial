using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class PayslipBuilder : GenericBuilder<PayslipViewModel, Payslip>, IPayslipBuilder
    {
        private readonly ISalaryStructureBuilder _salaryStructureBuilder;
        private readonly IContractTypeBuilder _contractTypeBuilder;

        public PayslipBuilder(ISalaryStructureBuilder salaryStructureBuilder, IContractTypeBuilder contractTypeBuilder)
        {
            _salaryStructureBuilder = salaryStructureBuilder;
            _contractTypeBuilder = contractTypeBuilder;
        }

        public override PayslipViewModel BuildEntity(Payslip entity)
        {
            if(entity == null)
            {
                throw new ArgumentException("");
            }
            PayslipViewModel payslipViewModel = base.BuildEntity(entity);
            if (entity.IdContractNavigation != null)
            {
                if (entity.IdContractNavigation.IdSalaryStructureNavigation != null)
                {
                    payslipViewModel.IdContractNavigation.IdSalaryStructureNavigation = _salaryStructureBuilder.BuildEntity(entity.IdContractNavigation.IdSalaryStructureNavigation);
                }
                if (entity.IdContractNavigation.IdContractTypeNavigation != null)
                {
                    payslipViewModel.IdContractNavigation.IdContractTypeNavigation = _contractTypeBuilder.BuildEntity(entity.IdContractNavigation.IdContractTypeNavigation);
                }
            }
            return payslipViewModel;
        }
    }
}
