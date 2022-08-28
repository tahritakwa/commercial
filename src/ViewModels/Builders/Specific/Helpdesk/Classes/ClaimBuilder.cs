using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Helpdesk;

namespace ViewModels.Builders.Specific.Helpdesk.Classes
{
    public class ClaimBuilder : GenericBuilder<ClaimViewModel, Claim>, IClaimBuilder
    {
        #region Fields
        private readonly IStockMovementBuilder _stockMovementBuilder;
        private readonly IClaimInteractionBuilder _claimInteractionBuilder;
        private readonly IItemBuilder _itemBuilder;
        private readonly IReducedDocumentLineBuilder _reducedDocumentLineBuilder;
        #endregion

        public ClaimBuilder(IStockMovementBuilder stockMovementBuilder, IClaimInteractionBuilder claimInteractionBuilder, IItemBuilder itemBuilder,
            IReducedDocumentLineBuilder reducedDocumentLineBuilder)
        {
            _stockMovementBuilder = stockMovementBuilder;
            _claimInteractionBuilder = claimInteractionBuilder;
            _itemBuilder = itemBuilder;
            _reducedDocumentLineBuilder = reducedDocumentLineBuilder;
        }
        #region Methodes

        public override Claim BuildModel(ClaimViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model != null && model.ClaimInteraction != null)
            {
                entity.ClaimInteraction = model.ClaimInteraction.Select(c => _claimInteractionBuilder.BuildModel(c)).ToList();
            }

            if (model != null && model.StockMovement != null)
            {
                entity.StockMovement = model.StockMovement.Select(c => _stockMovementBuilder.BuildModel(c)).ToList();
            }



            entity.ClaimTypeNavigation = null;
            entity.IdSalesAssetDocumentNavigation = null;
            entity.IdPurchaseAssetDocumentNavigation = null;
            entity.IdClaimStatusNavigation = null;
            entity.IdClientNavigation = null;
            entity.IdContactNavigation = null;
            entity.IdDeliveryDocumentNavigation = null;
            entity.IdDocumentLineNavigation = null;
            entity.IdDocumentNavigation = null;
            entity.IdFournisseurNavigation = null;
            entity.IdItemNavigation = null;
            entity.IdPurchaseDocumentNavigation = null;
            entity.IdReceiptDocumentNavigation = null;
            entity.IdSalesDocumentNavigation = null;
            entity.IdWarehouseNavigation = null;
            //entity.IdStockMovementOutNavigation = null;
            //entity.IdStockMovementInNavigation = null;


            return entity;
        }

        public override ClaimViewModel BuildEntity(Claim entity)
        {
            var claimdocument = base.BuildEntity(entity);



            if (entity != null && entity.IdItemNavigation != null)
            {
                claimdocument.IdItemNavigation = _itemBuilder.BuildEntity(entity.IdItemNavigation);
            }

            if (entity != null && entity.IdDocumentLineNavigation != null)
            {
                claimdocument.IdDocumentLineNavigation = _reducedDocumentLineBuilder.BuildEntity(entity.IdDocumentLineNavigation);
            }

            if (entity != null && entity.IdDocumentLineNavigation != null && entity.IdItemNavigation != null)
            {
                claimdocument.IdDocumentLineNavigation.RefDesignation = entity.IdItemNavigation.Code + " - " + entity.IdItemNavigation.Description;
            }

            if (entity != null && entity.ClaimInteraction != null && entity.ClaimInteraction.Count > 0)
            {
                claimdocument.ClaimInteraction = entity.ClaimInteraction.Select(c => _claimInteractionBuilder.BuildEntity(c)).ToList();
                claimdocument.ClaimInteraction.ToList().ForEach(x => x.IdClaimNavigation = null);
            }

            if (entity != null && entity.StockMovement != null && entity.StockMovement.Count > 0)
            {
                claimdocument.StockMovement = entity.StockMovement.Select(c => _stockMovementBuilder.BuildEntity(c)).ToList();
                claimdocument.StockMovement.ToList().ForEach(x => x.IdClaimNavigation = null);
            }

            //if (entity != null && entity.IdStockMovementOutNavigation != null)
            //{
            //    claimdocument.IdStockMovementOutNavigation = _stockMovementBuilder.BuildEntity(entity.IdStockMovementOutNavigation);
            //    claimdocument.IdStockMovementOutNavigation.IdClaimNavigation = null;
            //}

            //if (entity != null && entity.IdStockMovementInNavigation != null)
            //{
            //    claimdocument.IdStockMovementInNavigation = _stockMovementBuilder.BuildEntity(entity.IdStockMovementInNavigation);
            //    claimdocument.IdStockMovementInNavigation.IdClaimNavigation = null;
            //}

            return claimdocument;
        }
        #endregion
    }
}