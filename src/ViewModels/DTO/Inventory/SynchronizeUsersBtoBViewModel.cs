using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class SynchronizeCompanyViewModel : GenericViewModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string code { get; set; }
    }
}
