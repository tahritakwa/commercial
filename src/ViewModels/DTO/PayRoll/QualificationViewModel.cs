using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class QualificationViewModel : GenericViewModel
    {
        public string University { get; set; }
        public string QualificationDescritpion { get; set; }
        public DateTime? GraduationYearDate { get; set; }
        public int? IdQualificationCountry { get; set; }
        public int? IdQualificationType { get; set; }
        public int? IdEmployee { get; set; }
        public string QualificationAttached { get; set; }
        public IList<FileInfoViewModel> QualificationFileInfo { get; set; }
        public string DeletedToken { get; set; }
        public int? IdCandidate { get; set; }

        public CountryViewModel IdQualificationCountryNavigation { get; set; }
        public QualificationTypeViewModel IdQualificationTypeNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public CandidateViewModel IdCandidateNavigation { get; set; }
    }
}
