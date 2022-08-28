using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class FinancialCommitmentBuilder : GenericBuilder<FinancialCommitmentViewModel, FinancialCommitment>, IFinancialCommitmentBuilder
    {
        #region Fields

        private readonly ITiersBuilder _tiersBuilder;
        private readonly IDocumentWithholdingTaxBuilder _documentWithholdingTaxBuilder;
        #endregion
        public FinancialCommitmentBuilder(ITiersBuilder tiersBuilder, IDocumentWithholdingTaxBuilder documentWithholdingTaxBuilder)
        {
            _tiersBuilder = tiersBuilder;
            _documentWithholdingTaxBuilder = documentWithholdingTaxBuilder;
        }
        #region Mthodes
        public override FinancialCommitmentViewModel BuildEntity(FinancialCommitment entity)
        {
            var model = base.BuildEntity(entity);
            if (entity != null)
            {
                if (entity.IdDocumentNavigation != null)
                {
                    if (entity.IdDocumentNavigation.IdTiersNavigation != null)
                    {
                        model.IdDocumentNavigation.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.IdDocumentNavigation.IdTiersNavigation);
                    }
                    if (entity.IdDocumentNavigation.DocumentWithholdingTax != null)
                    {
                        model.IdDocumentNavigation.DocumentWithholdingTax = entity.IdDocumentNavigation.DocumentWithholdingTax.Select(s => _documentWithholdingTaxBuilder.BuildEntity(s)).ToList();
                    }
                }
            }
            return model;
        }
        public override FinancialCommitment BuildModel(FinancialCommitmentViewModel model)
        {
            model.IdDocumentNavigation = null;
            var entity = base.BuildModel(model);
            return entity;
        }
        #endregion
    }
}
