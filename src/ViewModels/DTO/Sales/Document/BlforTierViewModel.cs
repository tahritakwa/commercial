using ViewModels.DTO.Common;

namespace ViewModels.DTO.Sales.Document
{
    public class BlforTierViewModel
    {
        public int IdTiers { get; set; }
        public string CodeTier { get; set; }
        public string TierName { get; set; }
        public double HtAmount { get; set; }
        public int BlNumber { get; set; }
        public int InAssNumber { get; set; }
        public CurrencyDisplayObject formatOptions { get; set; }
        public int? IdSettlementMode { get; set; }
        public string SettlementModeCode { get; set; }
    }
    
}
