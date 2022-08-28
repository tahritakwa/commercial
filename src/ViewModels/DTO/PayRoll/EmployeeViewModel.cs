using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Utils.Constants;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Payment;
using ViewModels.DTO.RH;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeViewModel : GenericViewModel
    {
        [Required(ErrorMessage = "An Employee Gendre is required")]
        public int Sex { get; set; }
        [Required(ErrorMessage = "An Employee FirstName is required")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "An Employee LastName is required")]
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string ReverseFullName { get; set; }
        [EmailAddress]
        [Key]
        [Required(ErrorMessage = "An Employee Email is required")]
        public string Email { get; set; }
        [Key]
        [Required(ErrorMessage = "An Employee Matricule is required")]
        public string Matricule { get; set; }
        public string AddressLine1 { get; set; }
        public string AddressLine2 { get; set; }
        public string AddressLine3 { get; set; }
        public string AddressLine4 { get; set; }
        public string AddressLine5 { get; set; }
        public string PersonalEmail { get; set; }
        public int? IdCountry { get; set; }
        public int? IdCity { get; set; }
        public string ZipCode { get; set; }
        public string PersonalPhone { get; set; }
        public string ProfessionalPhone { get; set; }
        public string Picture { get; set; }
        public DateTime? BirthDate { get; set; }
        public string BirthPlace { get; set; }
        public string PseudoSkype { get; set; }
        public string Facebook { get; set; }
        public string Linkedin { get; set; }
        public string SocialSecurityNumber { get; set; }
        public int? ChildrenNumber { get; set; }
        public int? IdCitizenship { get; set; }
        public string DeletedToken { get; set; }
        public int? IdGrade { get; set; }
        public int? IdUpperHierarchy { get; set; }
        public int? Echelon { get; set; }
        public string WorkingLicenseNumber { get; set; }
        [Required(ErrorMessage = "An Employee HiringDate is required")]
        public DateTime HiringDate { get; set; }
        public DateTime? ResignationDate { get; set; }
        public DateTime? ResignationDepositDate { get; set; }
        public string Category { get; set; }
        public string Cin { get; set; }
        public bool? FamilyLeader { get; set; }
        public string CinAttached { get; set; }
        public double? HomeLoan { get; set; }
        public int? ChildrenNoScholar { get; set; }
        public int? ChildrenDisabled { get; set; }
        public bool IsForeign { get; set; }
        public int? DependentParent { get; set; }
        public string Rib { get; set; }
        public int? IdPaymentType { get; set; }
        public int? IdOffice { get; set; }
        public string Notes { get; set; }
        public string SharedDocumentsPassword { get; set; }
        public string HierarchyLevel { get; set; }
        public int? MaritalStatus { get; set; }
        public int Status { get; set; }
        public bool? IsResigned { get; set; }
        public int? IdBank { get; set; }
        public bool ResignedFromExitEmployee { get; set; }
        public bool IsAlreadyAnInterviewer { get; set; }
        public FileInfoViewModel PictureFileInfo { get; set; }
        public IList<FileInfoViewModel> CinFileInfo { get; set; }
        public CityViewModel IdCityNavigation { get; set; }
        public CountryViewModel IdCountryNavigation { get; set; }
        public CountryViewModel IdCitizenshipNavigation { get; set; }
        public GradeViewModel IdGradeNavigation { get; set; }
        public EmployeeViewModel IdUpperHierarchyNavigation { get; set; }
        public virtual BankViewModel IdBankNavigation { get; set; }
        public ICollection<CnssDeclarationDetailsViewModel> CnssDeclarationDetails { get; set; }
        public ICollection<ContractViewModel> Contract { get; set; }
        public ICollection<DocumentViewModel> Document { get; set; }
        public ICollection<DocumentRequestViewModel> DocumentRequest { get; set; }
        public ICollection<EmployeeDocumentViewModel> EmployeeDocument { get; set; }
        public ICollection<EmployeeSkillsViewModel> EmployeeSkills { get; set; }
        public ICollection<ExpenseReportViewModel> ExpenseReport { get; set; }
        public ICollection<EmployeeViewModel> InverseIdUpperHierarchyNavigation { get; set; }
        public ICollection<JobEmployeeViewModel> JobEmployee { get; set; }
        public ICollection<LeaveViewModel> Leave { get; set; }
        public ICollection<ParentInChargeViewModel> ParentInCharge { get; set; }
        public ICollection<PayslipViewModel> Payslip { get; set; }
        public ICollection<QualificationViewModel> Qualification { get; set; }
        public ICollection<TeamViewModel> Team { get; set; }
        public ICollection<UserViewModel> User { get; set; }
        public ICollection<CandidateViewModel> Candidate { get; set; }
        public ICollection<RecruitmentViewModel> RecruitmentIdEmployeeAuthorNavigation { get; set; }
        public ICollection<RecruitmentViewModel> RecruitmentIdEmployeeValidatorNavigation { get; set; }
        public ICollection<EmployeeProjectViewModel> EmployeeProject { get; set; }
        public ICollection<EmployeeTeamViewModel> EmployeeTeam { get; set; }
        public PaymentTypeViewModel IdPaymentTypeNavigation { get; set; }
        public virtual ICollection<ReviewViewModel> ReviewIdEmployeeCollaboratorNavigation { get; set; }
        public virtual ICollection<ReviewViewModel> ReviewIdManagerNavigation { get; set; }
        public ICollection<ReviewSkillsViewModel> ReviewSkills { get; set; }
        public ICollection<OfficeViewModel> Office { get; set; }
        public ICollection<MobilityRequestViewModel> MobilityRequest { get; set; }
        public OfficeViewModel IdOfficeNavigation { get; set; }
        public ICollection<EmployeeTrainingSessionViewModel> EmployeeTrainingSession { get; set; }
        public ICollection<BillingEmployeeViewModel> BillingEmployee { get; set; }
        public ICollection<TransferOrderDetailsViewModel> TransferOrderDetails { get; set; }
        public ICollection<ExitEmployeeViewModel> EmployeeExit { get; set; }
        public ICollection<TimeSheetViewModel> TimeSheetIdEmployeeNavigation { get; set; }
        public ICollection<LeaveViewModel> LeaveIdEmployeeNavigation { get; set; }
        public ContractViewModel CurrentContract { get; set; }

        public EmployeeViewModel()
        {

        }

        /// <summary>
        /// Constructor for buil fake employee
        /// </summary>
        /// <param name="isFakeEmployee"></param>
        public EmployeeViewModel(bool isFakeEmployee)
        {
            if (isFakeEmployee)
            {
                Id = NumberConstant.Zero;
                FirstName = "Anonymous";
                LastName = "Employee";
                FullName = "Anonymous Employee";
                Email = "anonymous@anonymous.com";
            }
        }

        /// <summary>
        /// Constructor for build candidate
        /// </summary>
        /// <param name="candidate"></param>
        public EmployeeViewModel(CandidateViewModel candidate)
        {
            Id = NumberConstant.Zero;
            FirstName = candidate.FirstName;
            LastName = candidate.LastName;
            Email = candidate.Email;
            Sex = candidate.Sex;
            Cin = candidate.Cin;
            IdCitizenship = candidate.IdCitizenship;
            IdOffice = candidate.IdOffice;
            IsForeign = candidate.IsForeign;
            PersonalPhone = candidate.PersonalPhone;
            ProfessionalPhone = candidate.ProfessionalPhone;
            BirthDate = candidate.BirthDate;
            AddressLine1 = candidate.AddressLine1;
            AddressLine2 = candidate.AddressLine2;
            AddressLine3 = candidate.AddressLine3;
            AddressLine4 = candidate.AddressLine4;
            AddressLine5 = candidate.AddressLine5;
            Facebook = candidate.Facebook;
            Linkedin = candidate.LinkedIn;
        }
    }
}
