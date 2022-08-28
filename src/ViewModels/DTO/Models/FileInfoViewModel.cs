namespace ViewModels.DTO.Models
{
    public class FileInfoViewModel
    {
        public int? IdOfCarrierModel { get; set; }
        public string Name { get; set; }
        public string Extension { get; set; }
        public byte[] Data { get; set; }
        public string FileData { get; set; }
        public double Size { get; set; }
        public string FulPath { get; set; }
        public string FulPathReportingImage { get; set; }
    }
}
