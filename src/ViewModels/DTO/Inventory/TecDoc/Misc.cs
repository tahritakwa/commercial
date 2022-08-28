namespace ViewModels.DTO.Inventory.TecDoc
{
    public class Misc
    {
        public int articleStatusId { get; set; }
        public string articleStatusDescription { get; set; }
        public int articleStatusValidFromDate { get; set; }
        public int quantityPerPackage { get; set; }
        public bool isSelfServicePacking { get; set; }
        public bool hasMandatoryMaterialCertification { get; set; }
        public bool isRemanufacturedPart { get; set; }
        public bool isAccessory { get; set; }
        public int batchSize1 { get; set; }
        public int batchSize2 { get; set; }
    }
}
