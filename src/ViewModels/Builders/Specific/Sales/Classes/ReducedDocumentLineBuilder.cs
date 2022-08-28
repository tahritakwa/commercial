using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class ReducedDocumentLineBuilder : GenericBuilder<ReducedDocumentLineViewModel, DocumentLine>, IReducedDocumentLineBuilder
    {
        private const string SA = "SA";
        private readonly IReducedTiersBuilder _reducedTiersBuilder;
        private readonly IReducedTaxeBuilder _taxBuilder;
        public ReducedDocumentLineBuilder(IReducedTiersBuilder reducedTiersBuilder, IReducedTaxeBuilder taxBuilder)
        {
            _reducedTiersBuilder = reducedTiersBuilder;
            _taxBuilder = taxBuilder;
        }
        public override ReducedDocumentLineViewModel BuildEntity(DocumentLine entity)
        {
            ReducedDocumentLineViewModel documentLineViewModel = base.BuildEntity(entity);
            if (entity.IdItemNavigation != null && entity.IdItemNavigation.IdUnitSalesNavigation != null)
            {
                documentLineViewModel.MesureUnitLabel = entity.IdItemNavigation.IdUnitSalesNavigation.Label;
            }
            if (entity.IdDocumentNavigation != null && entity.IdDocumentNavigation.IdUsedCurrencyNavigation != null)
            {
                documentLineViewModel.SymboleCurrency = entity.IdDocumentNavigation.IdUsedCurrencyNavigation.Symbole;
                if (entity.IdDocumentNavigation.DocumentTypeCode.Contains(SA))
                {
                    documentLineViewModel.CurrencyPrecision = entity.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision;
                }
                else
                {
                    documentLineViewModel.CurrencyPrecision = entity.IdDocumentNavigation.IdUsedCurrencyNavigation.Precision;
                }
            }
            if (entity.IdDocumentNavigation != null && entity.IdDocumentNavigation.IdTiersNavigation != null)
            {
                documentLineViewModel.IdDocumentNavigation.IdTiersNavigation = _reducedTiersBuilder.BuildEntity(entity.IdDocumentNavigation.IdTiersNavigation);
            }


            if (entity.IdItemNavigation != null)
            {
                documentLineViewModel.RefDesignation = entity.IdItemNavigation.Code + " - " + entity.IdItemNavigation.Description;
            }
            else
            {
                documentLineViewModel.RefDesignation = entity.Designation;
            }

            if (entity.DocumentLineTaxe != null && entity.DocumentLineTaxe.Any())
            {
                documentLineViewModel.Taxe = entity.DocumentLineTaxe.Select(x => _taxBuilder.BuildEntity(x.IdTaxeNavigation)).ToList();
            }
            return documentLineViewModel;
        }

        public override DocumentLine BuildModel(ReducedDocumentLineViewModel model)
        {
            var entity = base.BuildModel(model);

            entity.IdWarehouseNavigation = null;
            entity.IdItemNavigation = null;
            entity.IdMeasureUnitNavigation = null;
            return entity;
        }
    }

}
