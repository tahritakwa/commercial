﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class LoanInstallment
    {
        public LoanInstallment()
        {
            PayslipDetails = new HashSet<PayslipDetails>();
            SessionLoanInstallment = new HashSet<SessionLoanInstallment>();
        }

        public int Id { get; set; }
        public int State { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public double Amount { get; set; }
        public int IdLoan { get; set; }
        public DateTime Month { get; set; }

        public virtual Loan IdLoanNavigation { get; set; }
        public virtual ICollection<PayslipDetails> PayslipDetails { get; set; }
        public virtual ICollection<SessionLoanInstallment> SessionLoanInstallment { get; set; }
    }
}