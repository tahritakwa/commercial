using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class SynchronizeClientUserBToBViewModel : GenericViewModel
    {
        public List<ClientBToBViewModel> Clients { get; set; }
    }
}
