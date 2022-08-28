namespace ViewModels.DTO.Shared
{
    public class ReducedDataOfCompanyViewModel
    {
        public bool? AllowEditionItemDesignation { get; set; }
        public bool PurchaseAllowItemRelatedToSupplier { get; set; }
        public bool? WithholdingTax { get; set; }
        public double? FiscalStamp { get; set; }
        public bool? AllowRelationSupplierItems { get; set; }
        public bool? NoteIsRequired { get; set; }
    }
}
