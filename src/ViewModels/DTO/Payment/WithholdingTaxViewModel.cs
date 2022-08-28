using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class WithholdingTaxViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Designation { get; set; }
        public double Percentage { get; set; }
        public int Type { get; set; }
        public virtual ICollection<DocumentWithholdingTaxViewModel> DocumentWithholdingTax { get; set; }
    }
}
