namespace ViewModels.DTO.Inventory.TecDoc
{
    public class VehicleDetails
    {
        public string BrakeSystem { get; set; }
        public int CarId { get; set; }
        public int CcmTech { get; set; }
        public string ConstructionType { get; set; }
        public int Cylinder { get; set; }
        public int CylinderCapacityCcm { get; set; }
        public int cylinderCapacityLiter { get; set; }
        public string FuelType { get; set; }
        public string fuelTypeProcess { get; set; }
        public string ImpulsionType { get; set; }
        public int ManuId { get; set; }
        public string ManuName { get; set; }
        public int ModId { get; set; }
        public string ModelName { get; set; }
        public string MotorType { get; set; }
        public int PowerHpFrom { get; set; }
        public int PowerHpTo { get; set; }
        public int PowerKwFrom { get; set; }
        public int PowerKwTo { get; set; }
        public string TypeName { get; set; }
        public int TypeNumber { get; set; }
        public int Valves { get; set; }
        public int YearOfConstrFrom { get; set; }
        public int YearOfConstrTo { get; set; }
        public int RmiTypeId { get; set; }
    }
}
