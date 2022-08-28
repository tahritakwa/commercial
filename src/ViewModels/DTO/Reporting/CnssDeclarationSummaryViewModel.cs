namespace ViewModels.DTO.Reporting
{
    public class CnssDeclarationSummaryViewModel
    {
        // Second section informations
        public double SocialSecurityRate { get; set; }
        public double SocialSecurityAmount { get; set; }
        public double WorkAccidentRate { get; set; }
        public double WorkAccidentAmount { get; set; }
        public double Total { get; set; }

        // Third section informations
        public int NumberOfDaysLate { get; set; }
        public double AmountOfLatePenalties { get; set; }
        public double AmountToBePaid { get; set; }

        public CnssDeclarationInformationsViewModel CnssDeclarationInformationsViewModel { get; set; }
    }
}
