using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Reporting.Interfaces;
using Services.Specific.RH.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Reporting.Classes
{
    public class ServiceReviewReporting : Service<ReviewViewModel, Review>, IServiceReviewReporting
    {
        private readonly IServiceObjective _serviceObjective;
        private readonly IServiceReviewFormation _serviceReviewFormation;
        private readonly IServiceReviewSkills _serviceReviewSkills;
        private readonly IServiceQuestion _serviceQuestion;


        public ServiceReviewReporting (IRepository<Review> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IUnitOfWork unitOfWork,
           IReviewBuilder builder,
           IEntityAxisValuesBuilder builderEntityAxisValues,
           IServiceObjective serviceObjective,
           IServiceReviewFormation serviceReviewFormation,
           IServiceReviewSkills serviceReviewSkills,
           IServiceQuestion serviceQuestion,IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany,
            ICompanyBuilder companyBuilder, IMemoryCache memoryCache) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany, companyBuilder, memoryCache)
        {
            _serviceObjective = serviceObjective;
            _serviceReviewFormation = serviceReviewFormation;
            _serviceReviewSkills = serviceReviewSkills;
            _serviceQuestion = serviceQuestion;
        }

        public ReviewReportingInformationViewModel GetReviewForReport(int idReview)
        {
            ReviewReportingInformationViewModel reviewReport = new ReviewReportingInformationViewModel();
            Review reviewInfo = _entityRepo.GetSingleWithRelations(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation, x => x.IdManagerNavigation);
            reviewReport.ReviewInfo = reviewInfo != null ? _builder.BuildEntity(reviewInfo) : new ReviewViewModel();
            reviewReport.CompanyInfo = GetCurrentCompany();
            return reviewReport;
        }

        // past 
        public ICollection<ObjectiveViewModel> ReviewPastObjectiveForReport(int idReview)
        {
            ReviewViewModel currentReview = GetModelWithRelations(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation);
            return _serviceObjective.FindModelBy(x => x.IdReview != idReview && x.IdEmployee == currentReview.IdEmployeeCollaborator);           
        }
        public ICollection<ReviewFormationViewModel> ReviewPastReviewFormationForReport(int idReview)
        {
            ReviewViewModel currentReview = GetModelWithRelations(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation);
            return _serviceReviewFormation.GetModelsWithConditionsRelations(x => x.IdReview != idReview && x.IdEmployee == currentReview.IdEmployeeCollaborator ,
                x => x.IdFormationNavigation);
        }
        public ICollection<ReviewSkillsViewModel> ReviewPastReviewSkillsForReport(int idReview)
        {
            ReviewViewModel currentReview = GetModelWithRelations(x => x.Id == idReview, x => x.IdEmployeeCollaboratorNavigation);
            return _serviceReviewSkills.FindModelBy(x => x.IdReview != idReview && x.IdEmployee == currentReview.IdEmployeeCollaborator);
        }
        // future
        public ICollection<ObjectiveViewModel> ReviewFutureObjectiveForReport(int idReview)
        {
            return _serviceObjective.FindModelBy(x => x.IdReview == idReview);
        }
        public ICollection<ReviewFormationViewModel> ReviewFutureReviewFormationForReport(int idReview)
        {
            return _serviceReviewFormation.GetModelsWithConditionsRelations(x => x.IdReview == idReview, x => x.IdFormationNavigation);
        }        
        public ICollection<ReviewSkillsViewModel> ReviewFutureReviewSkillsForReport(int idReview)
        {
            return _serviceReviewSkills.FindModelBy(x => x.IdReview == idReview);
        }
    }
}
