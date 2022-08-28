using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class ReducedDocumentBuilder : GenericBuilder<ReducedDocumentViewModel, Document>, IReducedDocumentBuilder
    {
        #region Fields
        private readonly IReducedDocumentLineBuilder _reducedDocumentLineBuilder;
        private readonly IClaimBuilder _claimBuilder;
        #endregion
        public ReducedDocumentBuilder(IReducedDocumentLineBuilder reducedDocumentLineBuilder, IClaimBuilder claimBuilder)
        {
            _reducedDocumentLineBuilder = reducedDocumentLineBuilder;
            _claimBuilder = claimBuilder;
        }
        #region Methodes
        public override Document BuildModel(ReducedDocumentViewModel model)
        {
            var entity = base.BuildModel(model);
            if (model != null && model.DocumentLine != null)
            {
                entity.DocumentLine = model.DocumentLine.Select(c => _reducedDocumentLineBuilder.BuildModel(c)).ToList();
            }

            return entity;
        }

        public override ReducedDocumentViewModel BuildEntity(Document entity)
        {
            var document = base.BuildEntity(entity);
            if (entity != null && entity.DocumentLine != null)
            {
                document.DocumentLine = entity.DocumentLine.Select(c => _reducedDocumentLineBuilder.BuildEntity(c)).ToList();
            }

            if (entity != null && entity.ClaimIdSalesAssetDocumentNavigation != null && entity.ClaimIdSalesAssetDocumentNavigation.Count > 0)
            {
                document.ClaimIdAssetDocumentNavigation = entity.ClaimIdSalesAssetDocumentNavigation.Select(c => _claimBuilder.BuildEntity(c)).ToList();
            }

            if (entity != null && entity.ClaimIdPurchaseAssetDocumentNavigation != null && entity.ClaimIdPurchaseAssetDocumentNavigation.Count > 0)
            {
                document.ClaimIdAssetDocumentNavigation = entity.ClaimIdPurchaseAssetDocumentNavigation.Select(c => _claimBuilder.BuildEntity(c)).ToList();
            }

            return document;
        }


        #endregion
    }

}
