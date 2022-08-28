using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class CandidateViewModel : GenericViewModel
    {
        public int Sex { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Cin { get; set; }
        public string LinkedIn { get; set; }
        public bool IsForeign { get; set; }
        public int? IdEmployee { get; set; }
        public string DeletedToken { get; set; }
        public int? IdCitizenship { get; set; }
        public DateTime CreationDate { get; set; }
        public int? IdCreationUser { get; set; }
        public int? IdOffice { get; set; }
        public DateTime? BirthDate { get; set; }
        public string AddressLine1 { get; set; }
        public string AddressLine2 { get; set; }
        public string AddressLine3 { get; set; }
        public string AddressLine4 { get; set; }
        public string AddressLine5 { get; set; }
        public string Facebook { get; set; }
        public string PersonalPhone { get; set; }
        public string ProfessionalPhone { get; set; }
        public string Code { get; set; }

        public CountryViewModel IdCitizenshipNavigation { get; set; }
        public UserViewModel IdCreationUserNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ICollection<CandidacyViewModel> Candidacy { get; set; }
        public ICollection<CurriculumVitaeViewModel> CurriculumVitae { get; set; }
        public ICollection<QualificationViewModel> Qualification { get; set; }
    }
}
