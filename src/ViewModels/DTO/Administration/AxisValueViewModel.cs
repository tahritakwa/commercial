using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Administration
{
    public class AxisValueViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public int IdAxis { get; set; }
        public List<int> AxisValuesParent { get; set; }
        public virtual ICollection<AxisValueRelationShipViewModel> AxisValueRelationShipIdAxisValueNavigation { get; set; }
        public virtual ICollection<AxisValueRelationShipViewModel> AxisValueRelationShipIdAxisValueParentNavigation { get; set; }
        public virtual AxisViewModel IdAxisNavigation { get; set; }

    }
}
