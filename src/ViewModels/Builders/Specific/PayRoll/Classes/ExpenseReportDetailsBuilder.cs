using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ExpenseReportDetailsBuilder : GenericBuilder<ExpenseReportDetailsViewModel, ExpenseReportDetails>, IExpenseReportDetailsBuilder
    {
        public override ExpenseReportDetails BuildModel(ExpenseReportDetailsViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            ExpenseReportDetails entity = base.BuildModel(model);
            if (model.IdCurrencyNavigation != null)
            {
                entity.IdCurrencyNavigation = null;
            }
            if (model.IdExpenseReportDetailsTypeNavigation != null)
            {
                entity.IdExpenseReportDetailsTypeNavigation = null;
            }
            return entity;
        }
    }
}
