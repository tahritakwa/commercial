using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ReviewResumeBuilder : GenericBuilder<ReviewResumeViewModel, ReviewResume>, IReviewResumeBuilder
    {
    }
}
