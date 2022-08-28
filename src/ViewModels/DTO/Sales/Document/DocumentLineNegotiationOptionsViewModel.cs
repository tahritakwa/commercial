using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentLineNegotiationOptionsViewModel
    {
        public int Id { get; set; }
        public int IdDocumentLine { get; set; }
        public double? Price { get; set; }
        public double? Qty { get; set; }
        public bool IsFinal { get; set; }
        public bool IsAccepted { get; set; }
        public bool IsRejected { get; set; }
        public DateTime CreationDate { get; set; }
        public int IdUser { get; set; }
        public double? QteSupplier { get; set; }
        public double? PriceSupplier { get; set; }
        public int? IdItem { get; set; }
        public string CodeDocument { get; set; }
        public string DocumentTypeCode { get; set; }
        public int StatusDocument { get; set; }
        public int IdDocument { get; set; }


        public UserViewModel IdUserNavigation { get; set; }
        public DocumentLineViewModel IdDocumentLineNavigation { get; set; }
    }
}
