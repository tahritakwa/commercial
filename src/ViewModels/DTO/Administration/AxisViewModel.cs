using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Administration
{
    public class AxisViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public virtual ICollection<AxisEntityViewModel> AxisEntity { get; set; }
        public virtual ICollection<AxisRelationShipViewModel> AxisRelationShipIdAxisNavigation { get; set; }
        public virtual ICollection<AxisRelationShipViewModel> AxisRelationShipIdAxisParentNavigation { get; set; }
        public virtual ICollection<AxisValueViewModel> AxisValue { get; set; }
        public virtual ICollection<AxisViewModel> AxisChildren { get; set; }
        public string Input { get; set; }
        public string Fr { get; set; }
        public string En { get; set; }

    }
}
