using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class VehicleEnergyViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public string DeletedToken { get; set; }
        public  ICollection<VehicleViewModel> Vehicle { get; set; }
    }
}
