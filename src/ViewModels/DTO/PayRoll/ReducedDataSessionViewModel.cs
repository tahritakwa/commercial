using System;
using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class ReducedDataSessionViewModel
    {
        public int IdContract { get; set; }
        public int IdEmployee { get; set; }
        public int IdTimeSheet { get; set; }
        public string Code { get; set; }
        public string Matricule { get; set; }
        public int TimesheetStatus { get; set; }
        public int IdSelected { get; set; }
        public string FullName { get; set; }

    }

    public class ReturnedDataSessionViewModel
    {
        public int Total { get; set; }
        public bool PayDependOnTimesheet { get; set; }
        public ICollection<ReducedDataSessionViewModel> SessionContracts { get; set; }

    }

    public class ReturnedDataAttendanceViewModel
    {
        public int Total { get; set; }
        public int SessionState { get; set; }
        public DateTime SessionMonth { get; set; }
        public string SessionTitle { get; set; }
        public string SessionCode { get; set; }
        public ICollection<ReducedDataAttendanceViewModel> Attendances { get; set; }
    }

    public class ReducedDataAttendanceViewModel
    {
        public int IdContract { get; set; }
        public int IdSession { get; set; }
        public int IdAttendance { get; set; }
        public DateTime? AttendanceStartDate { get; set; }
        public DateTime? AttendanceEndDate { get; set; }
        public int IdEmployee { get; set; }
        public int? ContractState { get; set; }
        public string Code { get; set; }
        public string Matricule { get; set; }
        public string FullName { get; set; }
        public double NumberDaysWorked { get; set; }
        public double NumberDaysPaidLeave { get; set; }
        public double NumberDaysNonPaidLeave { get; set; }
        public double MaxNumberOfDaysAllowed { get; set; }
        public double AdditionalHourOne { get; set; }
        public double AdditionalHourTwo { get; set; }
        public double AdditionalHourThree { get; set; }
        public double AdditionalHourFour { get; set; }
    }

    public class ReturnedDataBonusViewModel
    {
        public int Total { get; set; }
        public ICollection<ReducedDataBonusViewModel> SessionBonus { get; set; }
    }

    public class ReducedDataBonusViewModel
    {
        public int IdSession { get; set; }
        public int IdContract { get; set; }
        public int IdEmployee { get; set; }
        public int IdSelected { get; set; }
        public string ContractCode { get; set; }
        public string Matricule { get; set; }
        public double Value { get; set; }
        public string FullName { get; set; }
    }

    public class ReturnedDataLoanViewModel
    {
        public int Total { get; set; }
        public ICollection<ReducedDataLoanInstallmentViewModel> SessionLoanInstallment { get; set; }
    }
    public class ReducedDataLoanInstallmentViewModel
    {
        public int IdContract { get; set; }
        public int IdLoanInstallment { get; set; }
        public string Code { get; set; }
        public string Matricule { get; set; }
        public double Value { get; set; }
        public int IdSelected { get; set; }
        public string FullName { get; set; }
        public int? CreditType { get; set; }
    }
}
