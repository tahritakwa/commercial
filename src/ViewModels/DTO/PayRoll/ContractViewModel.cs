using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.PayRoll
{
    public class ContractViewModel : GenericViewModel
    {
        public string ContractReference { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public double? WorkingTime { get; set; }
        public string DeletedToken { get; set; }
        public int IdEmployee { get; set; }
        public int IdSalaryStructure { get; set; }
        public int IdCnss { get; set; }
        public int State { get; set; }
        public int IdContractType { get; set; }
        public string ContractAttached { get; set; }
        public bool? ThirteenthMonthBonus { get; set; }
        public double? MealVoucher { get; set; }
        public bool? AvailableCar { get; set; }
        public bool? AvailableHouse { get; set; }
        public int? CommissionType { get; set; }
        public double? CommissionValue { get; set; }
        public bool UpdatePayslipAndTimeSheets { get; set; }
        #region params used for Excel imports
        public string MatriculeEmployee { get; set; }
        public double BaseSalaryValue { get; set; }
        #endregion
        public IList<FileInfoViewModel> ContractFileInfo { get; set; }
        public CnssViewModel IdCnssNavigation { get; set; }
        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public SalaryStructureViewModel IdSalaryStructureNavigation { get; set; }
        public ContractTypeViewModel IdContractTypeNavigation { get; set; }
        public ICollection<AttendanceViewModel> Attendance { get; set; }
        public ICollection<BaseSalaryViewModel> BaseSalary { get; set; }
        public ICollection<ContractBonusViewModel> ContractBonus { get; set; }
        public ICollection<PayslipViewModel> Payslip { get; set; }
        public ICollection<SessionBonusViewModel> SessionBonus { get; set; }
        public ICollection<ContractBenefitInKindViewModel> ContractBenefitInKind { get; set; }
        public ICollection<SessionContractViewModel> SessionContract { get; set; }
        public ICollection<ContractAdvantageViewModel> ContractAdvantage { get; set; }
        public ICollection<SessionLoanInstallmentViewModel> SessionLoanInstallment { get; set; }
    }
}
