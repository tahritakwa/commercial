namespace Settings.Config
{
    public class ECommerceConfig
    {
        public DbSettings DbSettings { get; set; }
        public string URLListClient { get; set; }
        public string URLIsPremuimClient { get; set; }
        public string URLMouvementQte { get; set; }
        public string synchronizeAllProductsDetailsUrl { get; set; }
        public string GetAddedProductsFromEcommerceUrl { get; set; }
        public string DeleteProductsOfEcommerceAfterUpdateInStarkUrl { get; set; }
        public string AddAndUpdateProductsUrl { get; set; }
        public string GetFailedSalesDeliveryCountAsync { get; set; }
        public string AddProductsUrl { get; set; }
        public string AddPartialShipment { get; set; }
        public string AddInvoice { get; set; }
        public string AddCategory { get; set; }
        public string UpdateCategory { get; set; }
        public string UpdateProductStock { get; set; }
        public string URLEcommerceBL { get; set; }
        public string URLEcommerceConfirmationBL { get; set; }
        public string AddPictureForProduct { get; set; }
        public string BaseEcommerceURL { get; set; }
        public int FrequencyByMinuteForExecuteJobForEcommerceSendPriceQuantity { get; set; }
        public int FrequencyByMinuteForExecuteJobForEcommerceGetBLs { get; set; }
        public int FrequencyByMinuteForExecuteJobForEcommerceGetAddOrEditProducts { get; set; }
        public string BasicAuthentification { get; set; }

        public ECommerceConfig()
        {

        }
    }
}