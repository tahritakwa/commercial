using ViewModels.DTO.Administration;

namespace ViewModels.DTO.ErpSettings
{
    public class EntityAxisValuesViewModel
    {
        public int Id { get; set; }
        public int? IdAxisValue { get; set; }
        public int? IdEntityItem { get; set; }
        public int? Entity { get; set; }
        public AxisValueViewModel IdAxisValueNavigation { get; set; }
    }
}
