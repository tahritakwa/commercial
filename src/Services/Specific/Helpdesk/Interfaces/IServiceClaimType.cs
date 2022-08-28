using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Helpdesk;

namespace Services.Specific.Helpdesk.Interfaces
{
    public interface IServiceClaimType : IService<ClaimTypeViewModel, ClaimType>
    {
        //ClaimTypeViewModel GetClaimTypeByCode(string id);
        //ClaimTypeViewModel AddClaimType(ClaimTypeViewModel claimTypeViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        //ClaimTypeViewModel UpdateClaimType(ClaimTypeViewModel claimTypeViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        //DataSourceResult<ClaimTypeViewModel> GetClaimTypeList(PredicateFormatViewModel predicateModel);
        //IList<ClaimTypeViewModel> GetClaimType();
        //DataSourceResult<ClaimTypeViewModel> GetTypeDropdownForClaims(PredicateFormatViewModel model);
    }
}
