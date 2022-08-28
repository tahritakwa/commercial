using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class DocumentExpenseLineBuilder : GenericBuilder<DocumentExpenseLineViewModel, DocumentExpenseLine>, IDocumentExpenseLineBuilder
    {
        private readonly IExpenseBuilder _expenseBuilder;
        public DocumentExpenseLineBuilder(IExpenseBuilder expenseBuilder)
        {
            _expenseBuilder = expenseBuilder;
        }
        public override DocumentExpenseLineViewModel BuildEntity(DocumentExpenseLine entity)
        {
            var model = base.BuildEntity(entity);
            if (entity != null)
            {
                if (entity.IdExpenseNavigation != null)
                {
                    model.IdExpenseNavigation = _expenseBuilder.BuildEntity(entity.IdExpenseNavigation);
                }

            }
            return model;
        }
    }
}
