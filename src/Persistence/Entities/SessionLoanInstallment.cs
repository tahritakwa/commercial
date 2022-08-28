﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class SessionLoanInstallment
    {
        public int Id { get; set; }
        public int IdSession { get; set; }
        public int IdLoanInstallment { get; set; }
        public int IdContract { get; set; }
        public double Value { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public virtual Contract IdContractNavigation { get; set; }
        public virtual LoanInstallment IdLoanInstallmentNavigation { get; set; }
        public virtual Session IdSessionNavigation { get; set; }
    }
}