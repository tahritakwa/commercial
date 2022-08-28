using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.B2B
{
    public class BtoBDocumentLineViewModel : GenericViewModel
    {
        public int IdDocument { get; set; }
        public int IdItem { get; set; }
        public int? idUser { get; set; }
        public int idLine { get; set; }
        public string Designation { get; set; }
        public double MovementQty { get; set; }
        public int? IdMeasureUnit { get; set; }
        public int? IdPrices { get; set; }
        public double? HtUnitAmount { get; set; }
        public double HtAmount { get; set; }
        public double? VatTaxAmount { get; set; }
        public double? VatTaxRate { get; set; }
        public double? HtTotalLine { get; set; }
        public double? TtcTotalLine { get; set; }
        public double? HtUnitAmountWithCurrency { get; set; }
        public double? HtAmountWithCurrency { get; set; }
        public double? TtcAmountWithCurrency { get; set; }
        public double? HtTotalLineWithCurrency { get; set; }
        public double? TtcTotalLineWithCurrency { get; set; }
        public double? VatTaxAmountWithCurrency { get; set; }
        public string DeletedToken { get; set; }
        public double? ExcVatTaxAmount { get; set; }
        public double? ExcVatTaxRate { get; set; }
        public double? ExcVatTaxAmountWithCurrency { get; set; }
        public string UserMail { get; set; }
        public BtoBDocumentViewModel IdDocumentNavigation { get; set; }
    }
}
