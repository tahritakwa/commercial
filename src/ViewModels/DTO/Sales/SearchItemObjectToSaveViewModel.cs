using System;
using System.Collections.Generic;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace ViewModels.DTO.Sales
{
    public class SearchItemObjectToSaveViewModel
    {
        public int? Id { get; set; }
        public SearchItemSupplierViewModel SearchItemSupplierViewModel { get; set; }
        public int IdCashier { get; set; }
        public UserViewModel IdCashierNavigation { get; set; }
        public DateTime? Date { get; set; }
        public int IdTiers { get; set; }
        public string selectedMethod { get; set; }
        public string TiersName { get; set; }
        public List<PropertyNameAndValue> SearchItemSupplierList { get; set; }
    }
}
