﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class SalaryStructureValidityPeriodSalaryRule
    {
        public int Id { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int IdSalaryRule { get; set; }
        public int IdSalaryStructureValidityPeriod { get; set; }

        public virtual SalaryRule IdSalaryRuleNavigation { get; set; }
        public virtual SalaryStructureValidityPeriod IdSalaryStructureValidityPeriodNavigation { get; set; }
    }
}