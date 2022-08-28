using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting
{
    public class VatDeclarationLinesViewModel
    {
        public string DocumentCode { get; set; }
        public string DocumentDate { get; set; }
        public string TiersName { get; set; }
        public double? VatAmount0 { get; set; }
        public double? BaseVatAmount0 { get; set; }
        public double? Base0 { get; set; }
        public double? VatAmount1 { get; set; }
        public double? BaseVatAmount1 { get; set; }
        public double? VatAmount2 { get; set; }
        public double? BaseVatAmount2 { get; set; }
        public double? VatAmount3 { get; set; }
        public double? BaseVatAmount3 { get; set; }
        public double? TotalHT { get; set; }
        public double? TotalVat { get; set; }
        public double? FiscalStamp { get; set; }
        public double? TotalTTC { get; set; }
        public string Currency { get; set; }
        public int Precision { get; set; }
        public double? VatAmountWithCurrency0 { get; set; }
        public double? BaseVatAmountWithCurrency0 { get; set; }
        public double? BaseWithCurrency0 { get; set; }
        public double? VatAmountWithCurrency1 { get; set; }
        public double? BaseVatAmountWithCurrency1 { get; set; }
        public double? VatAmountWithCurrency2 { get; set; }
        public double? BaseVatAmountWithCurrency2 { get; set; }
        public double? VatAmountWithCurrency3 { get; set; }
        public double? BaseVatAmountWithCurrency3 { get; set; }
        public double? TotalHTWithCurrency { get; set; }
        public double? TotalVatWithCurrency { get; set; }
        public double? TotalTTCWithCurrency { get; set; }
        public string TotalTTCString { get; set; }
    }
}
