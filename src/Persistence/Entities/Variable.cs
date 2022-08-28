﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Variable
    {
        public Variable()
        {
            VariableValidityPeriod = new HashSet<VariableValidityPeriod>();
        }

        public int Id { get; set; }
        public string Description { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int IdRuleUniqueReference { get; set; }
        public string Name { get; set; }

        public virtual RuleUniqueReference IdRuleUniqueReferenceNavigation { get; set; }
        public virtual ICollection<VariableValidityPeriod> VariableValidityPeriod { get; set; }
    }
}