using System;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocPassengerCar
    {
        public int CarId { get; set; }
        public string CarName { set; get; }
        public DateTime? ConstructionStartInterval { set; get; }
        public DateTime? ConstructionEndInterval { set; get; }
        public decimal? PowerKW { set; get; }
        public decimal? PowerPS { set; get; }
        public decimal? CapacityTech { set; get; }
        public string BodyType { set; get; }
        public string[] TermsOfUse { set; get; }
        public string[] EngineCodeList { set; get; }
    }
}
