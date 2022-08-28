using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class ContractTypeViewModel : GlobalizationViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public string Label { get; set; }
        public int MinNoticePeriod { get; set; }
        public int MaxNoticePeriod { get; set; }
        public bool? CalendarNoticeDays { get; set; }
        public bool? HasEndDate { get; set; }
        public ICollection<ContractViewModel> Contract { get; set; }
        public ICollection<RecruitmentViewModel> Recruitment { get; set; }
        public ICollection<OfferViewModel> Offer { get; set; }

    }
}
