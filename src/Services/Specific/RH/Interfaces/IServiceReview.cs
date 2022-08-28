using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceReview : IService<ReviewViewModel, Review>
    {
        ReviewViewModel GetReviewWithHisNavigations(int id);
        void AddReviewForm(ReviewFormViewModel model, string userMail);
        DataSourceResult<ObjectiveViewModel> GetPastObjectiveList(int idReview);
        DataSourceResult<ReviewFormationViewModel> GetPastReviewFormationList(int idReview);
        void GetCloseEmployeeList(string connectionString, SmtpSettings smtpSettings);
        bool CanAccessReviewDetails(int idReview);
        EmployeeReviewPosition ConnectedEmployeePriveleges(int idReview);
        ReviewFormViewModel FetchReportInformation(int idReview);
        void CloseReview(ReviewFormViewModel review);
    }
}
