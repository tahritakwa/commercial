using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class ReducedCandidateViewModel : GenericViewModel
    {
        public int Sex { get; set; }
        public string FullName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }

    }
}
