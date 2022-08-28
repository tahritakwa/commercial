using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Payment;

namespace ViewModels.Builders.Specific.Payment.Classes
{
    public class SettlementDocumentWithholdingTaxBuilder : GenericBuilder<SettlementDocumentWithholdingTaxViewModel, SettlementDocumentWithholdingTax>, ISettlementDocumentWithholdingTaxBuilder
    {
        #region Fields
        private readonly IDocumentWithholdingTaxBuilder _documentWithholdingTaxBuilder;
        #endregion
        public SettlementDocumentWithholdingTaxBuilder(IDocumentWithholdingTaxBuilder documentWithholdingTaxBuilder)
        {
            _documentWithholdingTaxBuilder = documentWithholdingTaxBuilder;
        }
        #region Methodes
        public override SettlementDocumentWithholdingTaxViewModel BuildEntity(SettlementDocumentWithholdingTax entity)
        {
            SettlementDocumentWithholdingTaxViewModel model = base.BuildEntity(entity);
            if (entity.IdDocumentWithholdingTaxNavigation != null)
            {
                model.IdDocumentWithholdingTaxNavigation = _documentWithholdingTaxBuilder.BuildEntity(entity.IdDocumentWithholdingTaxNavigation);
            }
            return model;
        }
        #endregion
    }
}
