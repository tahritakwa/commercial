using System.IO;

namespace Utils.Constants.PayrollConstants
{
    public static class PayRollConstant
    {
        public static string Salary
        {
            get { return "Salary"; }
        }
        public static string Employer
        {
            get { return "Employer"; }
        }
        public static string IdEmployee
        {
            get { return "IdEmployee"; }
        }
        public static string CreationDate
        {
            get { return "CreationDate"; }
        }
        public static string NumberOfAffected
        {
            get { return "NumberOfAffected"; }
        }
        public static string Status
        {
            get { return "Status"; }
        }
        public static string ContributoryBonus
        {
            get { return "PRIME_COTISABLE"; }
        }
        public static string TaxableWages
        {
            get { return "SALAIRE IMPOSABLE"; }
        }
        public static string TaxableBonus
        {
            get { return "PRIME_IMPOSABLE"; }
        }
        public static string TotalBonus
        {
            get { return "TOTAL_PRIME"; }
        }
        public static string Totals
        {
            get { return "Totals"; }
        }
        public static string SubTotals
        {
            get { return "SubTotals"; }
        }
        public static string ReportName
        {
            get { return "Payslip.trdp"; }
        }
        public static string ReportTitle
        {
            get { return "BS-"; }
        }
        public static string PayslipErrorMessage
        {
            get { return "LACK_MESSAGE"; }
        }
        public static string MissBaseSalaryErrorMessage
        {
            get { return "Miss base salary"; }
        }
        public static string MissBonusValueErrorMessage
        {
            get { return "Miss bonus : "; }
        }
        public static string NumberFormat
        {
            get { return "#,0.000"; }
        }
        public static string MissConstantRateErrorMessage
        {
            get { return "Miss constant rate"; }
        }
        public static string MissConstantValueErrorMessage
        {
            get { return "Miss constant value"; }
        }
        public static string TransferOrderSalary
        {
            get { return "Salaire"; }
        }
        public static string ResignedEmployeeErrorMessage
        {
            get { return "EMPLOYEE_RESIGNED"; }
        }
        public static string Cdi
        {
            get { return "CDI"; }
        }
        public static string Sivp
        {
            get { return "SIVP"; }
        }
        public static string ContractType
        {
            get { return "CONTRACT_TYPE"; }
        }
        public static string Base
        {
            get { return "BASE"; }
        }
        public static string Brut
        {
            get { return "BRUT"; }
        }
        public static string Cnss
        {
            get { return "CNSS"; }
        }
        public static string Net
        {
            get { return "NET"; }
        }
        public static string Irpp
        {
            get { return "IRPP"; }
        }
        public static string RetenueIrpp
        {
            get { return "Retenue IRPP"; }
        }
        public static string Css
        {
            get { return "CSS"; }
        }
        public static string SocialSolidarityContribution
        {
            get { return "Contribution sociale solidaire"; }
        }
        public static string Netapayer
        {
            get { return "NETAPAYER"; }
        }
        public static string BlankSpace
        {
            get { return " "; }
        }
        public static string Empty
        {
            get { return ""; }
        }
        public static string Totaux
        {
            get { return "Totaux"; }
        }
        public static string Transfer
        {
            get { return "VIR"; }
        }
        public static string Ds
        {
            get { return "DS"; }
        }
        public static string Point
        {
            get { return "."; }
        }
        public static string PdfExtension
        {
            get { return "Pdf"; }
        }
        public static string Separator
        {
            get { return "-"; }
        }
        public static string Length
        {
            get { return "Length"; }
        }
        public static char CharSpace
        {
            get { return ' '; }
        }
        public static string PayRollFileRootPath
        {
            get { return Path.Combine("PayRoll", "Leave", " ").Trim(); }
        }
        public static string FRIST_HOUR_LABEL
        {
            get { return "FRIST_HOUR_LABEL"; }
        }
        public static string SECOND_HOUR_LABEL
        {
            get { return "SECOND_HOUR_LABEL"; }
        }
        public static string CURRENT_HOUR_LABEL
        {
            get { return "CURRENT_HOUR_LABEL"; }
        }
        public static string PREVIOUS_PERIOD
        {
            get { return "PreviousPeriod"; }
        }
        public static string NEXT_PERIOD
        {
            get { return "NextPeriod"; }
        }
        public static string VALIDATE_EXPENSEREPORT
        {
            get { return "VALIDATE-EXPENSEREPORT"; }
        }
        public static string VALIDATE_DOCUMENTREQUEST
        {
            get { return "VALIDATE-DOCUMENTREQUEST"; }
        }
        public static string FIRST_SEANCE
        {
            get { return "FIRST_SEANCE"; }
        }
        public static string SECOND_SEANCE
        {
            get { return "SECOND_SEANCE"; }
        }
        public static string START_DATE
        {
            get { return "START_DATE"; }
        }
        public static string END_DATE
        {
            get { return "END_DATE"; }
        }
        public static string DAY
        {
            get { return "DAY"; }
        }
        public static string LevelSeparator
        {
            get { return ":"; }
        }
        public static string Single
        {
            get { return "Célibataire"; }
        }
        public static string Married
        {
            get { return "Marié(e)"; }
        }
        public static string Divorced
        {
            get { return "Divorcé(e)"; }
        }
        public static string Widower
        {
            get { return "Veuf"; }
        }
        public static string Widow
        {
            get { return "Veuve"; }
        }
        public static string Loan
        {
            get { return "Prêt"; }
        }
        public static string GENERATED_PAYSLIP_ERROR
        {
            get { return "GENERATED_PAYSLIP_ERROR"; }
        }
        public static string SALARY_RULE_ORDER
        {
            get { return "SALARY_RULE_ORDER"; }
        }
        public static string LEAVE_TYPE
        {
            get { return "LEAVE_TYPE"; }
        }
        public static string WithTeamMembers
        {
            get { return "WithTeamMembers"; }
        }
        public static string NEGATIVE_SALARY
        {
            get { return "NEGATIVE_SALARY"; }
        }
        public static string Name
        {
            get { return "Name"; }
        }
        public static string Advance
        {
            get { return "Avance"; }
        }
        public static string FirstAdditionalHourCode
        {
            get { return "HSUP1"; }
        }
        public static string SecondAdditionalHourCode
        {
            get { return "HSUP2"; }
        }
        public static string ThirdAdditionalHourCode
        {
            get { return "HSUP3"; }
        }
        public static string FourthAdditionalHourCode
        {
            get { return "HSUP4"; }
        }
        public static string NetToPay
        {
            get { return "NetToPay"; }
        }
        public static string InterviewType
        {
            get { return "INTERVIEW_TYPE"; }
        }
        public static string Code
        {
            get { return "Code"; }
        }
        public static string Value
        {
            get { return "Value"; }
        }
    }
}
