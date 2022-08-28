using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Sales
{
    public class SearchItemToGenerateDocViewModel
    {
        public int IdItem { get; set; }
        public int? IdDocument { get; set; }
        public int? IdTiers { get; set; }
        public int? IdUsedCurrency { get; set; }
        public int? IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public double QuantityForDocumentLine { get; set; }
        public int? IdWarehouse { get; set; }
        public bool IsValidReservationFromProvisionalStock { get; set; }
        public bool IsRestaurn { get; set; }
        public int? IdVehicle { get; set; }
    }
}
