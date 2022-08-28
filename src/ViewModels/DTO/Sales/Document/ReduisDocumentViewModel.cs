using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales.Document
{
    public class ReduisDocumentViewModel
    {
        public int CurrentDocumentId { set; get; }
        public string DocumentType { set; get; }
        public string DocumentAssociatedType { set; get; }
        public int IdTiers { get; set; }
        public DateTime DocumentDate { get; set; }
        public double DocumentOtherTaxe { get; set; }
        public ICollection<DocumentLineViewModel> DocumentLine { get; set; }
        public DocumentTotalPricesViewModel DocumentTotalPrices { get; set; }
        public bool? LinesOnlyForSpecificItem { get; set; }
        public bool? BlOnly { get; set; }
        public int? IdItem { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string serachCode { get; set; }
        public int? IdUser { get; set; }
    }

}
