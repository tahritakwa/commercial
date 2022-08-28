using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Administration
{
    public class AxisRelationShipViewModel : GenericViewModel
    {
        public int IdAxis { get; set; }
        public int? IdAxisParent { get; set; }
        public virtual AxisViewModel IdAxisNavigation { get; set; }
        public virtual AxisViewModel IdAxisParentNavigation { get; set; }

    }
}
