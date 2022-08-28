namespace ViewModels.DTO.Inventory
{
    public class FiltersItemDropdown
    {
        public bool isForSale { get; set; }
        public bool isForPurchase { get; set; }
        public int[] idTiers { get; set; }
        public int[] idItemToCharge { get; set; }
        public int? idWarehouse { get; set; }
        public int? idCustomer { get; set; }
        public string valueToSearch { get; set; }
        public int skip { get; set; }
        public int take { get; set; }
        public bool isForItemReplacement { get; set; }
        public int? idItemToIgnore { get; set; }
        public bool isAvailableInStock { get; set; }
        public bool isCentralOnly { get; set; }
        public bool? ignoreCharges { get; set; }
        public int? idVehicleBrand { get; set; }
        public int? idModel { get; set; }
        public int? idSubModel { get; set; }
        public string tierSearch { get; set; }
        public string referenceSearch { get; set; }
        public string designationSearch { get; set; }
        public string barCodeSearch { get; set; }
        public bool fromEcommerce { get; set; }
        public bool? isEcommerceOrNotOnly { get; set; }
        public bool isSelectOrDeselectAllEcommerce { get; set; }
        public bool isFromExportExcel { get; set; }
        public bool equals { get; set; }
        public bool constaines { get; set; }
        public bool isWharehouseFilterRequired { get; set; }
        public bool? isRestaurn { get; set; }
        public bool isOnlyStockManaged { get; set; }
        public int? idNature { get; set; }
        public double? minUnitHtSalesPrice { get; set; }
        public double? maxUnitHtSalesPrice { get; set; }
        public bool isForReappro { get; set; }
        public int? idStorage { get; set; }
        public int? id { get; set; }
        public bool hasTiers { get; set; }
        public int idSalesPrice { get; set; }
        public bool? isAdvancePaymentNature { get; set; }
        public bool isOnlyProductNature { get; set; }
        public bool isSubFinal{ get; set; }

    }
}
