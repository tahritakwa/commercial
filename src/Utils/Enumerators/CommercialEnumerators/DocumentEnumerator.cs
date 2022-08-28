namespace Utils.Enumerators.CommercialEnumerators
{
    public static class DocumentEnumerator
    {
        public static string SalesOrder
        {
            get
            {
                return "O-SA";
            }
        }
        public static string PurchaseOrder
        {
            get
            {
                return "O-PU";
            }
        }
        public static string SalesDelivery
        {
            get
            {
                return "D-SA";
            }
        }
        public static string PurchaseDelivery
        {
            get
            {
                return "D-PU";
            }
        }
        public static string SalesInvoice
        {
            get
            {
                return "I-SA";
            }
        }
        public static string PurchaseInvoice
        {
            get
            {
                return "I-PU";
            }
        }
        public static string SalesQuotation
        {
            get
            {
                return "Q-SA";
            }
        }
        public static string PurchaseQuotation
        {
            get
            {
                return "Q-PU";
            }
        }
        public static string SalesAsset
        {
            get
            {
                return "A-SA";
            }
        }
        public static string PurchaseAsset
        {
            get
            {
                return "A-PU";
            }
        }
        public static string PurchaseRequest
        {
            get
            {
                return "RQ-PU";
            }
        }

        public static string PurchaseFinalOrder
        {
            get
            {
                return "FO-PU";
            }
        }

        public static string StockCalculationOperationReal
        {
            get
            {
                return "R";
            }
        }
        public static string StockCalculationOperationPrvisoir
        {
            get
            {
                return "P";
            }
        }

        public static string PurchaseBudget
        {
            get
            {
                return "B-PU";
            }
        }
        public static string InputMovement
        {
            get
            {
                return "IM";
            }
        }
        public static string OutputMovement
        {
            get
            {
                return "OM";
            }
        }
        public static string TransferMovement
        {
            get
            {
                return "TM";
            }
        }
        public static string TransferShelfStorage
        {
            get
            {
                return "TShSt";
            }
        }
        public static string InventoryMovement
        {
            get
            {
                return "INV";
            }
        }
        public static string Real
        {
            get
            {
                return "R";
            }
        }
        public static string Provisional
        {
            get
            {
                return "P";
            }
        }
        public static string Reservation
        {
            get
            {
                return "RSRV";
            }
        }
        public static string BS
        {
            get
            {
                return "BS-SA";
            }
        }
        public static string BE
        {
            get
            {
                return "BE-PU";
            }
        }
        public static string SalesInvoiceAsset
        {
            get
            {
                return "IA-SA";
            }
        }
    }
    public enum DocumentStatusEnumerator
    {
        Provisional = 1,
        Valid = 2,
        Balanced = 3,
        Refused = 4,
        ToOrder = 5,
        TotallySatisfied = 6,
        PartiallySatisfied = 7,
        NotSatisfied = 8,
        Transferred = 9,
        Received = 10,
        Printed = 11,
        Draft = 13,
        EditedAfterValidation = 14
    }
    public enum AccountingStatusEnumerator
    {
        Accounted = 1,
        NotAccounted = 2,
        All = 3
    }
    public enum InvoicingTypeEnumerator
    {
        Cash = 1,
        Term = 2,
        Other = 3,
        advancePayment = 4
    }

    public enum DocumentTypesEnumerator
    {
        SUPPLIER_ASSET = 1,
        CUSTOMER_ASSET = 2,
        BE = 3,
        PURCHASE_QUOTATION = 4,
        BS = 5,
        RECEIPT = 6,
        DELIVERY_FORM = 7,
        PURCHASE_FINAL_ORDER = 8,
        PURCHASE_INVOICE = 9,
        SALES_INVOICE = 10,
        PURCHASE_ORDER = 11,
        SALES_ORDER = 12,
        PRICE_REQUEST = 13,
        SALES_QUOTATION = 14,
        PURCHASE_REQUEST = 15,
        PURCHASE_TERMBILLING_INVOICE = 16,
        SALES_TERMBILLING_INVOICE = 17,
        PURCHASE_ASSET_INVOICE = 18,
        SALES_ASSET_INVOICE = 19,
        PURCHASE_CASH_INVOICE = 20,
        SALES_CASH_INVOICE = 21,
        ALL_ASSETS_FINACIAL = 22
    }

}
