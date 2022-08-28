﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class SalaryStructure
    {
        public SalaryStructure()
        {
            Contract = new HashSet<Contract>();
            InverseIdParentNavigation = new HashSet<SalaryStructure>();
            Offer = new HashSet<Offer>();
            SalaryStructureValidityPeriod = new HashSet<SalaryStructureValidityPeriod>();
        }

        public int Id { get; set; }
        public string SalaryStructureReference { get; set; }
        public string Name { get; set; }
        public int Order { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int? IdParent { get; set; }
        public string Description { get; set; }

        public virtual SalaryStructure IdParentNavigation { get; set; }
        public virtual ICollection<Contract> Contract { get; set; }
        public virtual ICollection<SalaryStructure> InverseIdParentNavigation { get; set; }
        public virtual ICollection<Offer> Offer { get; set; }
        public virtual ICollection<SalaryStructureValidityPeriod> SalaryStructureValidityPeriod { get; set; }
    }
}