using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceCandidacy : IService<CandidacyViewModel, Candidacy>
    {
        void PreSelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        void UnPreSelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        DataSourceResult<CandidacyViewModel> FromPreselectionToNextStep(PredicateFormatViewModel predicateModel);
        DataSourceResult<CandidacyViewModel> FromCandidacyToNextStep(PredicateFormatViewModel predicateModel);
        void SelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        void UnSelectionnedOneCandidacy(CandidacyViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        DataSourceResult<CandidacyViewModel> FromSelectionToNextStep(PredicateFormatViewModel predicateModel);
        DataSourceResult<CandidacyViewModel> FromOfferToNextStep(PredicateFormatViewModel predicateModel);
        int GenerateEmployeeFromCandidacy(CandidacyViewModel candidacy);
        DataSourceResult<CandidacyViewModel> GetCandidacyListInOfferStepWithSpecificPredicat(PredicateFormatViewModel predicateModel);
        DataSourceResult<CandidacyViewModel> GetCandidacyListInDoneStepWithSpecificPredicat(PredicateFormatViewModel predicateModel);
        DataSourceResult<CandidacyViewModel> GetCandidacyListInSelectionStepWithSpecificPredicat(PredicateFormatViewModel predicateModel);
        EmailViewModel generateRejectedEmailByCandidacy(CandidacyViewModel candidacy, string lang, string userMail);
        void GetCandidacyFromDrupal(string connectionString, SmtpSettings smtpSettings, string apiRelativePath);

    }
}
