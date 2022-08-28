using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceExitEmployeePayLineSalaryRule : Service<ExitEmployeePayLineSalaryRuleViewModel, ExitEmployeePayLineSalaryRule>, IServiceExitEmployeePayLineSalaryRule
    {
        private readonly IRepository<Contract> _entityRepoContract;
        private readonly IServiceSalaryStructure _serviceSalaryStructure;
        private readonly IServiceSalaryStructureValidityPeriodSalaryRule _serviceSalaryStructureValidityPeriodSalaryRule;
        private readonly IRepository<PayslipDetails> _entityRepoPayslipDetails;
        private readonly IServicePayslip _servicePayslip;

        public ServiceExitEmployeePayLineSalaryRule(IRepository<ExitEmployeePayLineSalaryRule> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IExitEmployeePayLineSalaryRuleBuilder builder,
           IRepository<Contract> entityRepoContract,
           IRepository<PayslipDetails> entityRepoPayslipDetails,
           IServiceSalaryStructureValidityPeriodSalaryRule serviceSalaryStructureValidityPeriodSalaryRule,
           IServiceSalaryStructure serviceSalaryStructure,
           IEntityAxisValuesBuilder builderEntityAxisValues, IServicePayslip servicePayslip)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoContract = entityRepoContract;
            _serviceSalaryStructure = serviceSalaryStructure;
            _serviceSalaryStructureValidityPeriodSalaryRule = serviceSalaryStructureValidityPeriodSalaryRule;
            _entityRepoPayslipDetails = entityRepoPayslipDetails;
            _servicePayslip = servicePayslip;
        }

        /// <summary>
        /// collect the payslip details for each month
        /// </summary>
        /// <param name="model"></param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public void GetResumeForExitEmployee(ExitEmployeePayLineViewModel model, Contract contract, DateTime month)
        {
            // Get salaryStructure
            SalaryStructureViewModel salaryStructureViewModel = _serviceSalaryStructure.GetStructureSalaryByIdContract(contract.Id);
            salaryStructureViewModel.SalaryRules = _serviceSalaryStructureValidityPeriodSalaryRule.GetSalaryStructureHierarchyRules(salaryStructureViewModel, month.AddDays(NumberConstant.Two));
            List<int> listIdSalaryRules = salaryStructureViewModel.SalaryRules.Select(x => x.Id).ToList();
            //get paslip details
            IQueryable<PayslipDetails> payslipDetailsQuery = _entityRepoPayslipDetails.GetAllAsNoTracking()
                .Include(m => m.IdPayslipNavigation)
                .Where(m => m.IdPayslipNavigation.IdContract == contract.Id &&
                    m.IdSalaryRule.HasValue && listIdSalaryRules.Any(x => x == m.IdSalaryRule.Value) &&
                    m.IdPayslipNavigation.Month.Date.Equals(month.FirstDateOfMonth()));
            List<PayslipDetails> payslipDetails = payslipDetailsQuery.Where(x => contract.Id == x.IdPayslipNavigation.IdContract).ToList();
            foreach (var salaryRule in salaryStructureViewModel.SalaryRules)
            {
                PayslipDetails payslipDetail = payslipDetails.FirstOrDefault(m => m.IdSalaryRule == salaryRule.Id
                && m.IdPayslipNavigation.IdContract == contract.Id);
                double amount = payslipDetail is null ? NumberConstant.Zero :
                    payslipDetail.Gain > NumberConstant.Zero ? _servicePayslip.PayrollRound(payslipDetail.Gain) : _servicePayslip.PayrollRound(payslipDetail.Deduction);
                ExitEmployeePayLineSalaryRuleViewModel lineSalaryRule = new ExitEmployeePayLineSalaryRuleViewModel
                {
                    IdExitEmployeePayLine = model.Id,
                };
                lineSalaryRule.IdSalaryRule = salaryRule.Id;
                lineSalaryRule.Value = amount;
                model.ExitEmployeePayLineSalaryRule.Add(lineSalaryRule);
            }
        }
    }
}
