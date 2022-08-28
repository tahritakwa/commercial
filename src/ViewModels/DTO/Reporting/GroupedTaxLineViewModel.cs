using System;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class GroupedTaxLineViewModel
    {

        public string MontantHT { get; set; } 
        public string TotalRemise { get; set; } 
        public string BaseTVA { get; set; }
        public string TauxTVA { get; set; }
        public string MontantTVA { get; set; } 
    }
}
