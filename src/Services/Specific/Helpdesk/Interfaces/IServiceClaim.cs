using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Sales;
using ViewModels.DTO.SameClasse;

namespace Services.Specific.Helpdesk.Interfaces
{

    public interface IServiceClaim : IService<ClaimViewModel, Claim>
    {
        ClaimViewModel GetClaimById(int id);
        ClaimViewModel AddClaim(ClaimViewModel claimViewModelViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        ClaimViewModel UpdateClaim(ClaimViewModel claimViewModelViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        ClaimViewModel AddClaimTiersAsset(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        ClaimViewModel AddClaimTiersMovement(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        //ClaimViewModel AddClaimStockMovement(ClaimViewModel claimViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        DataSourceResult<ClaimViewModel> GetClaimList(PredicateFormatViewModel predicateModel);
        DocumentViewModel GetBLFromClaimItem(ClaimQueryViewModel model);
        bool VerifyExistingPurchaseDocument(ClaimQueryViewModel model);
        DocumentViewModel GetSIFromClaimItem(ClaimQueryViewModel model);
        DocumentViewModel GetBSFromClaimItem(ClaimQueryViewModel model);
        DataSourceResult<ReducedClaimViewModel> GetDropdownForClaims(PredicateFormatViewModel model);
        List<int> GetDocumentsIdsWithCondition(PredicateFormatViewModel predicate);
        void UpdateRelatedDocumentToClaim(ItemPriceViewModel itemPriceViewModel);
        void UpdateRelatedBSToClaim(ItemPriceViewModel itemPriceViewModel, string userMail);
    }

}
