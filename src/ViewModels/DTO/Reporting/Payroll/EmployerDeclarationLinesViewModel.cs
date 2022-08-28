using System;

namespace ViewModels.DTO.Reporting.Payroll
{
    public class EmployerDeclarationLinesViewModel
    {
        public DateTime WorkTime { get; set; }
        public int? ChildrenNumber { get; set; }
        public int? MaritalStatus { get; set; }
        public string LastAddress { get; set; }
        public string Job { get; set; }
        public string FullName { get; set; }
        public string IdentityPieceNumber { get; set; }
        public string IdentifierOfIdentityPiece { get; set; }
        public string Matricule { get; set; }
        public double NetToPay { get; set; }
        public double Css { get; set; }
        public double ReducedAmountTwentyPerCent { get; set; }
        public double ReducedAmount { get; set; }
        public double RetainedReinvested { get; set; }
        public double GrossTaxable { get; set; }
        public double NaturalAdvantage { get; set; }
        public double TaxableWages { get; set; }
    }
}
