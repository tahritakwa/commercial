using System.Collections.Generic;

namespace ViewModels.DTO.Sales.Document
{
    public class DeleteInvoiceFromPosViewModel
    {
        public DocumentViewModel Document { get; set; }
        public List<int> LinesToAsk { get; set; }
        public List<int> DeletedLines { get; set; }
        public List<string> DocToAsk { get; set; }
    }
    
}
