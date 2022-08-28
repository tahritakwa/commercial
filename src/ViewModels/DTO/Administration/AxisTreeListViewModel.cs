using ViewModels.DTO.ErpSettings;

namespace ViewModels.DTO.Administration
{
    public class AxisTreeListViewModel : TranslationViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string IdParent { get; set; }
        public string IdChildren { get; set; }

    }
}
