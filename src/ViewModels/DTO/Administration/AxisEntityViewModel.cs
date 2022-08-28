using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Administration
{
    public class AxisEntityViewModel : GenericViewModel
    {
        public int IdAxis { get; set; }
        public int IdTableEntity { get; set; }
        public bool? IsRequired { get; set; }
        public virtual AxisViewModel IdAxisNavigation { get; set; }
        public virtual EntityViewModel IdTableEntityNavigation { get; set; }

    }
}
