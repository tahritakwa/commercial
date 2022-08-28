using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class AdditionalHourViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public bool Worked { get; set; }
        public double IncreasePercentage { get; set; }
        public virtual ICollection<AdditionalHourSlotViewModel> AdditionalHourSlot { get; set; }
    }
}
