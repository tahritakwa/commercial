using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class ReducedCandidacyViewModel : GenericViewModel
    {
        public int State { get; set; }
        public CandidateViewModel IdCandidateNavigation { get; set; }
        public int IdCandidate { get; set; }
    }
}
