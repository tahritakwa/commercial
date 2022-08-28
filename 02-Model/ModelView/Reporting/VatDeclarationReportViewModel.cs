using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.Reporting
{
    public class VatDeclarationReportViewModel
    {
        public string DocumentCode { get; set; }
        public string DocumentDate { get; set; }
        public string TiersName { get; set; }
        public string VatAmountString0 { get; set; }
        public string BaseVatAmountString0 { get; set; }
        public string BaseString0 { get; set; }
        public string VatAmountString1 { get; set; }
        public string BaseVatAmountString1 { get; set; }
        public string VatAmountString2 { get; set; }
        public string BaseVatAmountString2 { get; set; }
        public string VatAmountString3 { get; set; }
        public string BaseVatAmountString3 { get; set; }
        public string TotalHTString { get; set; }
        public string TotalVatString { get; set; }
        public string FiscalStampString { get; set; }
        public string TotalTTCString { get; set; }
        public string Currency { get; set; }
        public int Precision { get; set; }
        public int IdCurrency { get; set; }
        public string VatAmount { get; set; }
        public string VatAmountString4 { get; set; }
        public string BaseVatAmountString4 { get; set; }
        public string NameVat0 { get; set; }
        public string NameVat1 { get; set; }
        public string NameVat2 { get; set; }
        public string NameVat3 { get; set; }
        public string NameVat4 { get; set; }
        public bool HasBase0 { get; set; }
        public bool HasVatAmount { get; set; }
}
}
