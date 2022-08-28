﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class DocumentTaxsResume
    {
        public int Id { get; set; }
        public int? IdTax { get; set; }
        public double? HtAmount { get; set; }
        public double? HtAmountWithCurrency { get; set; }
        public double? TaxAmount { get; set; }
        public double? TaxAmountWithCurrency { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public int IdDocument { get; set; }
        public double? DiscountAmount { get; set; }
        public double? DiscountAmountWithCurrency { get; set; }
        public double? ExcVatTaxAmount { get; set; }
        public double? ExcVatTaxAmountWithCurrency { get; set; }

        public virtual Document IdDocumentNavigation { get; set; }
        public virtual Taxe IdTaxNavigation { get; set; }
    }
}