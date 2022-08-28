using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Administration
{
    public class AxisValueRelationShipViewModel : GenericViewModel
    {
        public int IdAxisValue { get; set; }
        public int IdAxisValueParent { get; set; }
        public virtual AxisValueViewModel IdAxisValueNavigation { get; set; }
        public virtual AxisValueViewModel IdAxisValueParentNavigation { get; set; }

    }
}
