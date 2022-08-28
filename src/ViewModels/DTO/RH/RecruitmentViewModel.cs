using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class RecruitmentViewModel : GenericViewModel
    {
        public int? YearOfExperience { get; set; }
        public double? WorkingHoursPerDays { get; set; }
        public int Priority { get; set; }
        public string Description { get; set; }
        public int State { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime? ClosingDate { get; set; }
        public int IdQualificationType { get; set; }
        public int IdJob { get; set; }
        public int? IdEmployeeAuthor { get; set; }
        public int? IdEmployeeValidator { get; set; }
        public string DeletedToken { get; set; }
        public int? IdOffice { get; set; }

        public string RequestReason { get; set; }
        public int? ExpectedCandidateNumber { get; set; }
        public int RecruitedCandidateNumber { get; set; }
        public DateTime? StartDate { get; set; }
        public int? IdContractType { get; set; }
        public int? Type { get; set; }
        public int? RequestStatus { get; set; }
        public int Sex { get; set; }
        public string Code { get; set; }
        public int? OfferStatus { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string OfferPicture { get; set; }
        public string RecruitmentTypeCode { get; set; }

        public FileInfoViewModel PictureFileInfo { get; set; }

        public ContractTypeViewModel IdContractTypeNavigation { get; set; }
        public EmployeeViewModel IdEmployeeAuthorNavigation { get; set; }
        public  EmployeeViewModel IdEmployeeValidatorNavigation { get; set; }
        public  JobViewModel IdJobNavigation { get; set; }
        public  QualificationTypeViewModel IdQualificationTypeNavigation { get; set; }
        public  ICollection<CandidacyViewModel> Candidacy { get; set; }

        public OfficeViewModel IdOfficeNavigation { get; set; }

        public  ICollection<RecruitmentLanguageViewModel> RecruitmentLanguage { get; set; }
        public ICollection<RecruitmentSkillsViewModel> RecruitmentSkills { get; set; }
        public virtual IList<CommentViewModel> Comments { get; set; }
    }
}
