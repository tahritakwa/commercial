using ViewModels.DTO.Models;

namespace ViewModels.DTO.Shared
{

    public class ReducedBankAccountDataViewModel
    {
        public int Id { get; set; }
        public string BankName { get; set; }
        public string Rib { get; set; }
        public string Iban { get; set; }
        public string Bic { get; set; }
        public string Agency { get; set; }
        public string Code { get; set; }
        public string Entitled { get; set; }
        public string Email { get; set; }
        public string Telephone { get; set; }
        public string Fax { get; set; }
        public double CurrentBalance { get; set; }
        public double InitialBalance { get; set; }
        public int? TypeAccount { get; set; }
        public int Precision { get; set; }
        public string CodeCurrency { get; set; }
        public string CurrencyDescription { get; set; }
        public string BankAttachmentUrl { get; set; }
        public string CountryNameFr { get; set; }
        public string CountryNameEn { get; set; }
        public string CityName { get; set; }
        public string ZipCode { get; set; }
        public string Locality { get; set; }
        public FileInfoViewModel BankLogoFileInfo { get; set; }
    }
}
