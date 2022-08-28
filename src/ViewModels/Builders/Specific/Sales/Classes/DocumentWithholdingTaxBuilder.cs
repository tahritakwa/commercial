using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class DocumentWithholdingTaxBuilder : GenericBuilder<DocumentWithholdingTaxViewModel, DocumentWithholdingTax>, IDocumentWithholdingTaxBuilder
    {
        public override DocumentWithholdingTax BuildModel(DocumentWithholdingTaxViewModel viewModel)
        {
            var entity = base.BuildModel(viewModel);
            entity.IdWithholdingTaxNavigation = null;
            entity.IdDocumentNavigation = null;
            return entity;

        }
    }
}
