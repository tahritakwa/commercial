using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class ReviewResumeViewModel : GenericViewModel
    {
        public int ResumeType { get; set; }
        public string Description { get; set; }
        public int IdReview { get; set; }
        public string DeletedToken { get; set; }

        public ReviewViewModel IdReviewNavigation { get; set; }
    }
}
