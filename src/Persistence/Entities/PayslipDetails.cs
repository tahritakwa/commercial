﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class PayslipDetails
    {
        public int Id { get; set; }
        public string Rule { get; set; }
        public double Gain { get; set; }
        public double Deduction { get; set; }
        public int Order { get; set; }
        public bool AppearsOnPaySlip { get; set; }
        public int IdPayslip { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public double NumberOfDays { get; set; }
        public int? IdSalaryRule { get; set; }
        public int? IdBonus { get; set; }
        public int? IdBenefitInKind { get; set; }
        public int? IdLoanInstallment { get; set; }
        public int? IdAdditionalHour { get; set; }

        public virtual BenefitInKind IdBenefitInKindNavigation { get; set; }
        public virtual Bonus IdBonusNavigation { get; set; }
        public virtual LoanInstallment IdLoanInstallmentNavigation { get; set; }
        public virtual Payslip IdPayslipNavigation { get; set; }
        public virtual SalaryRule IdSalaryRuleNavigation { get; set; }
    }
}