using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class DocumentLinePricesViewModel : GenericViewModel
    {
        public int? IdPrices { get; set; }
        public int? IdDocumentLine { get; set; }
        public string DeletedToken { get; set; }

        public DocumentLineViewModel IdDocumentLineNavigation { get; set; }
        public PricesViewModel IdPricesNavigation { get; set; }
    }
}
