using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{

    public class CounterViewModel : GenericViewModel
    {
        public string CounterName { get; set; }
        public string Prefix { get; set; }
        public long? Value { get; set; }
    }
}
