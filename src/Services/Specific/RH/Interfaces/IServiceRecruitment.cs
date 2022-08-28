using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceRecruitment : IService<RecruitmentViewModel, Recruitment>
    {
        void DoneRecruitment(int recruitmentId);
        DataSourceResult<RecruitmentViewModel> GetRecruitmentsList(PredicateFormatViewModel predicate, int IdCandidate, DateTime? endDate, DateTime? startDate);
        void ValidateRequest(RecruitmentViewModel recruitmentViewModel, IList<EntityAxisValuesViewModel> entityAxisValues, string userMail, SmtpSettings smtpSettings);
        void PublishJobOffer(RecruitmentViewModel recruitmentViewModel, IList<EntityAxisValuesViewModel> entityAxisValues, string userMail, SmtpSettings smtpSettings);

    }
}
