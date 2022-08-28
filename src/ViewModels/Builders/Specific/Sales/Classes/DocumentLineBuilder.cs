using Persistence.Entities;
using System.Linq;
using System.Text;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class DocumentLineBuilder : GenericBuilder<DocumentLineViewModel, DocumentLine>, IDocumentLineBuilder
    {
        private const string SA = "SA";
        private readonly ITiersBuilder _tiersBuilder;
        private readonly ITaxeBuilder _taxBuilder;
        private readonly IMeasureUnitBuilder _mesureUnitBuilder;
        public DocumentLineBuilder(ITiersBuilder tiersBuilder, ITaxeBuilder taxBuilder, IMeasureUnitBuilder mesureUnitBuilder)
        {

            _tiersBuilder = tiersBuilder;
            _taxBuilder = taxBuilder;
            _mesureUnitBuilder = mesureUnitBuilder;
        }
        public override DocumentLineViewModel BuildEntity(DocumentLine entity)
        {
            DocumentLineViewModel documentLineViewModel = base.BuildEntity(entity);
            StringBuilder ShelfAndStorage = new StringBuilder();
            if(entity.IdStorageNavigation != null)
            {
                ShelfAndStorage.Append(entity.IdStorageNavigation.IdShelfNavigation.Label);
                ShelfAndStorage.Append(entity.IdStorageNavigation.Label);
                documentLineViewModel.ShelfAndStorage = ShelfAndStorage.ToString();
            }
            if (entity != null)
            {
                if (entity.IdItemNavigation != null && entity.IdItemNavigation.IdUnitSalesNavigation != null)
                {
                    documentLineViewModel.MesureUnitLabel = entity.IdItemNavigation.IdUnitSalesNavigation.Label;
                }
                if(entity.IdItemNavigation != null && entity.IdItemNavigation.IdProductItemNavigation != null)
                {
                    documentLineViewModel.Marque = entity.IdItemNavigation.IdProductItemNavigation.LabelProduct;
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
                    documentLineViewModel.IdDocumentNavigation.IdTiersNavigation = _tiersBuilder.BuildEntity(entity.IdDocumentNavigation.IdTiersNavigation);
                }
                if (entity.DocumentLineTaxe != null && entity.DocumentLineTaxe.Any())
                {
                    documentLineViewModel.Taxe = entity.DocumentLineTaxe.Select(x => _taxBuilder.BuildEntity(x.IdTaxeNavigation)).ToList();
                }

                if (entity.IdItemNavigation != null)
                {
                    documentLineViewModel.RefDesignation = entity.IdItemNavigation.Code + " - " + entity.IdItemNavigation.Description;
                    if (entity.IdItemNavigation.IdUnitStockNavigation != null && documentLineViewModel.IdItemNavigation!=null)
                    {
                        documentLineViewModel.IdItemNavigation.IdUnitStockNavigation = _mesureUnitBuilder.BuildEntity(entity.IdItemNavigation.IdUnitStockNavigation);
                    }
                }
                else
                {
                    documentLineViewModel.RefDesignation = entity.Designation;
                }

                if (documentLineViewModel.StockMovement != null && documentLineViewModel.StockMovement.Any())
                {
                    if (documentLineViewModel.StockMovement.FirstOrDefault().Status == DocumentEnumerator.Reservation)
                    {
                        if (documentLineViewModel.AvailableQuantity >= documentLineViewModel.MovementQty)
                        {
                            documentLineViewModel.IsValidReservationFromProvisionalStock = false;
                        }
                        else
                        {
                            documentLineViewModel.IsValidReservationFromProvisionalStock = true;
                        }
                    }
                }

            }
            return documentLineViewModel;
        }

        public override DocumentLine BuildModel(DocumentLineViewModel model)
        {
            var entity = base.BuildModel(model);

            entity.IdWarehouseNavigation = null;
            entity.IdItemNavigation = null;
            entity.IdMeasureUnitNavigation = null;
            return entity;
        }
    }

}
