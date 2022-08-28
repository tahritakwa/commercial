using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class SalesInvoiceLogViewModel : GenericViewModel
    {
        public string Message { get; set; }
        public string DeletedToken { get; set; }
    }
}