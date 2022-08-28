using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class UserBToBViewModel : GenericViewModel
    {
        public List<UserViewModel> Users { get; set; }

    }
}
