using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class PriceRequestViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Reference { get; set; }
        public DateTime DocumentDate { get; set; }
        public DateTime CreationDate { get; set; }
        public string DeletedToken { get; set; }
        public List<string> SupplierName { get; set; }
        public string Suppliers { get; set; }

        public ICollection<PriceRequestDetailViewModel> PriceRequestDetail { get; set; }
        public ICollection<DocumentViewModel> Document { get; set; }

        public IList<int> IdDocuments { get; set; }
    }
}
