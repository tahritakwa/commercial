﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class PaymentMethod
    {
        public PaymentMethod()
        {
            DetailsSettlementMode = new HashSet<DetailsSettlementMode>();
            Document = new HashSet<Document>();
            FinancialCommitment = new HashSet<FinancialCommitment>();
            ReceiptSpent = new HashSet<ReceiptSpent>();
            Settlement = new HashSet<Settlement>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string MethodName { get; set; }
        public string Description { get; set; }
        public bool AuthorizedForExpenses { get; set; }
        public bool AuthorizedForRecipes { get; set; }
        public bool Immediate { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public int? IdPaymentType { get; set; }
        public int? PaymentMethodInt1 { get; set; }
        public int? PaymentMethodInt2 { get; set; }
        public int? PaymentMethodInt3 { get; set; }
        public int? PaymentMethodInt4 { get; set; }
        public int? PaymentMethodInt5 { get; set; }
        public int? PaymentMethodInt6 { get; set; }
        public int? PaymentMethodInt7 { get; set; }
        public int? PaymentMethodInt8 { get; set; }
        public int? PaymentMethodInt9 { get; set; }
        public int? PaymentMethodInt10 { get; set; }
        public bool? PaymentMethodBit1 { get; set; }
        public bool? PaymentMethodBit2 { get; set; }
        public bool? PaymentMethodBit3 { get; set; }
        public bool? PaymentMethodBit4 { get; set; }
        public bool? PaymentMethodBit5 { get; set; }
        public bool? PaymentMethodBit6 { get; set; }
        public bool? PaymentMethodBit7 { get; set; }
        public bool? PaymentMethodBit8 { get; set; }
        public bool? PaymentMethodBit9 { get; set; }
        public bool? PaymentMethodBit10 { get; set; }
        public double? PaymentMethodFloat1 { get; set; }
        public double? PaymentMethodFloat2 { get; set; }
        public double? PaymentMethodFloat3 { get; set; }
        public double? PaymentMethodFloat4 { get; set; }
        public double? PaymentMethodFloat5 { get; set; }
        public double? PaymentMethodFloat6 { get; set; }
        public double? PaymentMethodFloat7 { get; set; }
        public double? PaymentMethodFloat8 { get; set; }
        public double? PaymentMethodFloat9 { get; set; }
        public double? PaymentMethodFloat10 { get; set; }
        public string PaymentMethodVarchar1 { get; set; }
        public string PaymentMethodVarchar2 { get; set; }
        public string PaymentMethodVarchar3 { get; set; }
        public string PaymentMethodVarchar4 { get; set; }
        public string PaymentMethodVarchar5 { get; set; }
        public string PaymentMethodVarchar6 { get; set; }
        public string PaymentMethodVarchar7 { get; set; }
        public string PaymentMethodVarchar8 { get; set; }
        public string PaymentMethodVarchar9 { get; set; }
        public string PaymentMethodVarchar10 { get; set; }
        public DateTime? PaymentMethodDate1 { get; set; }
        public DateTime? PaymentMethodDate2 { get; set; }
        public DateTime? PaymentMethodDate3 { get; set; }
        public DateTime? PaymentMethodDate4 { get; set; }
        public DateTime? PaymentMethodDate5 { get; set; }
        public DateTime? PaymentMethodDate6 { get; set; }
        public DateTime? PaymentMethodDate7 { get; set; }
        public DateTime? PaymentMethodDate8 { get; set; }
        public DateTime? PaymentMethodDate9 { get; set; }
        public DateTime? PaymentMethodDate10 { get; set; }
        public string DeletedToken { get; set; }
        public string Fr { get; set; }
        public string En { get; set; }

        public virtual PaymentType IdPaymentTypeNavigation { get; set; }
        public virtual ICollection<DetailsSettlementMode> DetailsSettlementMode { get; set; }
        public virtual ICollection<Document> Document { get; set; }
        public virtual ICollection<FinancialCommitment> FinancialCommitment { get; set; }
        public virtual ICollection<ReceiptSpent> ReceiptSpent { get; set; }
        public virtual ICollection<Settlement> Settlement { get; set; }
    }
}