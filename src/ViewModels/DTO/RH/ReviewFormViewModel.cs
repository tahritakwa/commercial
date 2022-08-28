using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class ReviewFormViewModel : GenericViewModel
    {
        public ICollection<ObjectiveViewModel> PastObjective;
        public ICollection<ObjectiveViewModel> FutureObjective;
        public ICollection<ReviewFormationViewModel> PastReviewFormation;
        public ICollection<ReviewFormationViewModel> FutureReviewFormation;
        public ICollection<ReviewSkillsViewModel> PastReviewSkills;
        public ICollection<ReviewSkillsViewModel> FutureReviewSkills;
        public ICollection<InterviewViewModel> Interview;
        public ReviewViewModel Review;
    }
}
