using Persistence.Entities;
using System;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ExpenseReportBuilder: GenericBuilder<ExpenseReportViewModel, ExpenseReport>, IExpenseReportBuilder
    {
        private readonly IEmployeeBuilder _employeeBuilder;
        private readonly IExpenseReportDetailsBuilder _expenseReportDetailsBuilder;

        public ExpenseReportBuilder(IEmployeeBuilder employeeBuilder, IExpenseReportDetailsBuilder expenseReportDetailsBuilder)
        {
            _employeeBuilder = employeeBuilder;
            _expenseReportDetailsBuilder = expenseReportDetailsBuilder;
        }

        public override ExpenseReportViewModel BuildEntity(ExpenseReport entity)
        {
            ExpenseReportViewModel expenseReportViewModel = base.BuildEntity(entity);
            if (expenseReportViewModel.TreatedByNavigation != null && expenseReportViewModel.TreatedBy != null)
            {
                expenseReportViewModel.TreatedByNavigation = _employeeBuilder.BuildEntity(entity.TreatedByNavigation);
            }
            if(entity.ExpenseReportDetails!= null && entity.ExpenseReportDetails.Any())
            {
                expenseReportViewModel.ExpenseReportDetails = entity.ExpenseReportDetails.Select(x => _expenseReportDetailsBuilder.BuildEntity(x)).ToList();
            }
            return expenseReportViewModel;
        }
        public override ExpenseReport BuildModel(ExpenseReportViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            ExpenseReport entity = base.BuildModel(model);
            if (model.IdEmployeeNavigation != null)
            {
                entity.IdEmployeeNavigation = null;
            }
            return entity;
        }
    }
}
