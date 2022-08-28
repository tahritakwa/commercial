using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Helpdesk;

namespace ViewModels.Builders.Specific.Helpdesk.Interfaces
{
    public interface IReducedClaimBuilder : IBuilder<ReducedClaimViewModel, Claim>
    {
    }
}
