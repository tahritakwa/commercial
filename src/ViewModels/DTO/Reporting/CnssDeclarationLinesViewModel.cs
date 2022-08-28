namespace ViewModels.DTO.Reporting
{
    public class CnssDeclarationLinesViewModel
    {
        public int Id { get; set; }
        // Employee informations
        public string EmployeeCnssNumber { get; set; }
        public string EmployeeFullName { get; set; }
        public string EmployeeResignationNumber { get; set; }
        public string IdentityPiece { get; set; }
        public string Category { get; set; }
        // Lines informations
        public int PageNumber { get; set; }
        public int NumberOrder { get; set; }
        public double FirstMonthValue { get; set; }
        public double SecondMonthValue { get; set; }
        public double ThirdMonthValue { get; set; }
        public double Total { get; set; }
    }
}
