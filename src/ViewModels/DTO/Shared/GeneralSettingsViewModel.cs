using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class GeneralSettingsViewModel : GenericViewModel
    {
        public string Keys { get; set; }
        public string Field { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
    }
}
