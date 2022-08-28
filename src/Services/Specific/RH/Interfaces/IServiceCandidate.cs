using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceCandidate : IService<CandidateViewModel, Candidate>
    {
        DataSourceResult<CandidateViewModel> GetAvailableCandidates();
    }
}
