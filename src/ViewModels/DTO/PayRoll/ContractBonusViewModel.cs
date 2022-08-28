using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ContractBonusViewModel : GenericViewModel
    {
        public int IdBonus { get; set; }
        public int IdContract { get; set; }
        public DateTime ValidityStartDate { get; set; }
        public DateTime? ValidityEndDate { get; set; }
        public double? Value { get; set; }
        public string DeletedToken { get; set; }
        public int? State { get; set; }
        public bool CoversWholeMonth { get; set; }
        public BonusViewModel IdBonusNavigation { get; set; }
        public ContractViewModel IdContractNavigation { get; set; }

    }
}
