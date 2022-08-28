using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Administration
{
    public class AxisMappingViewModel : GenericViewModel
    {
        public int IdAxis { get; set; }
        public string ColumnIndex { get; set; }

        public virtual AxisViewModel IdAxisNavigation { get; set; }

    }
}
