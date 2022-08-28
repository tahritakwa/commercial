using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Administration
{
    public class CurrencyRateViewModel : GenericViewModel
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public double Coefficient { get; set; }
        public double Rate { get; set; }
        public int? IdCurrency { get; set; }
        public CurrencyViewModel IdCurrencyNavigation { get; set; }
        public List<DocumentViewModel> Document { get; set; }
        public int IdDocument { get; set; }
        public string CodeDocument { get; set; }
        public int DocumentStatus { get; set; }
        public string DocumentType { get; set; }

    }
}
