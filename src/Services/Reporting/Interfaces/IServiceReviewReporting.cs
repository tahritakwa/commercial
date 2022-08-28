using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.RH;

namespace Services.Reporting.Interfaces
{
    public interface IServiceReviewReporting : IService<ReviewViewModel, Review>
    {
        ReviewReportingInformationViewModel GetReviewForReport(int idReview);
        ICollection<ObjectiveViewModel> ReviewPastObjectiveForReport(int idReview);
        ICollection<ReviewFormationViewModel> ReviewPastReviewFormationForReport(int idReview);
        ICollection<ReviewSkillsViewModel> ReviewPastReviewSkillsForReport(int idReview);
        ICollection<ObjectiveViewModel> ReviewFutureObjectiveForReport(int idReview);
        ICollection<ReviewFormationViewModel> ReviewFutureReviewFormationForReport(int idReview);
        ICollection<ReviewSkillsViewModel> ReviewFutureReviewSkillsForReport(int idReview);
    }
}
