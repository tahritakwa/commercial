using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Helpdesk;

namespace Services.Specific.Helpdesk.Interfaces
{
    public interface IServiceClaimStatus : IService<ClaimStatusViewModel, ClaimStatus>
    {
        ClaimStatusViewModel GetClaimStatusById(int id);
        ClaimStatusViewModel AddClaimStatus(ClaimStatusViewModel claimStatusViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        ClaimStatusViewModel UpdateClaimStatus(ClaimStatusViewModel claimStatusViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        DataSourceResult<ClaimStatusViewModel> GetClaimStatusList(PredicateFormatViewModel predicateModel);
        DataSourceResult<ClaimStatusViewModel> GetStatusDropdownForClaims(PredicateFormatViewModel model);
    }
}
