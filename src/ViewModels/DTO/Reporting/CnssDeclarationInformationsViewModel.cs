namespace ViewModels.DTO.Reporting
{
    public class CnssDeclarationInformationsViewModel
    {
        // Employer or company informations
        public string EmployerName { get; set; }
        public string EmployerAdress { get; set; }
        public string EmployerNumber { get; set; }
        public string CnssAffiliation { get; set; }
        public string Currency { get; set; }

        // Cnss declaration document informations
        public string BR { get; set; }
        public string Trimester { get; set; }
        public int Year { get; set; }
        public string ElaborationDate { get; set; }
        public double TotalAmount { get; set; }
        public string MatriculeFisc { get; set; }

        // Cnss informations
        public string ExploitationCode { get; set; }
    }
}
