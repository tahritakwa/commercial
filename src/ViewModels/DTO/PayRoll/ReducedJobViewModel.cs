using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ReducedJobViewModel : GenericViewModel
    {
        public string FunctionSheet { get; set; }
        public int? IdUpperJob { get; set; }
        public string Text { get; set; }
        public string Designation { get; set; }

    }
}
