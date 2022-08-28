using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class CnssViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public double EmployerRate { get; set; }
        public double SalaryRate { get; set; }
        public double WorkAccidentQuota { get; set; }
        public string OperatingCode { get; set; }
        public string DeletedToken { get; set; }

        public ICollection<BonusViewModel> Bonus { get; set; }
        public ICollection<BenefitInKindViewModel> BenefitInKind { get; set; }
        public ICollection<ContractViewModel> Contract { get; set; }
        public ICollection<OfferViewModel> Offer { get; set; }
    }
}
