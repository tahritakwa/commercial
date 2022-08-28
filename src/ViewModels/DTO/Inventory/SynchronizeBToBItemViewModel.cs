using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class SynchronizeBToBItemViewModel : GenericViewModel
    {
        public List<ItemB2bViewModel> ListOfItem { get; set; }
    }
}
