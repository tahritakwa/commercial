using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{
    public class VehicleViewModel : GenericViewModel
    {
        public int? IdTiers { get; set; }
        public int? IdVehicleBrand { get; set; }
        public int? IdVehicleModel { get; set; }
        public int? IdVehicleEnergy { get; set; }
        public string RegistrationNumber { get; set; }
        public string ChassisNumber { get; set; }
        public string Power { get; set; }
        public string DeletedToken { get; set; }
        public string VehicleName { get; set; }
        public  TiersViewModel IdTiersNavigation { get; set; }
        public  VehicleBrandViewModel IdVehicleBrandNavigation { get; set; }
        public  VehicleEnergyViewModel IdVehicleEnergyNavigation { get; set; }
        public  ModelOfItemViewModel IdVehicleModelNavigation { get; set; }
    }
}
