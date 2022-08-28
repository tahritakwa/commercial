using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class EquivalentItemsViewModel : GenericViewModel
    {
        public int IdMasterItem { get; set; }
        public int IdItemToAffect { get; set; }
    }
}
