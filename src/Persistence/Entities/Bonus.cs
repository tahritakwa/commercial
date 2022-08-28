﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Bonus
    {
        public Bonus()
        {
            BonusValidityPeriod = new HashSet<BonusValidityPeriod>();
            ContractBonus = new HashSet<ContractBonus>();
            OfferBonus = new HashSet<OfferBonus>();
            PayslipDetails = new HashSet<PayslipDetails>();
            SessionBonus = new HashSet<SessionBonus>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsFixe { get; set; }
        public bool IsTaxable { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int IdCnss { get; set; }
        public bool DependNumberDaysWorked { get; set; }

        public virtual Cnss IdCnssNavigation { get; set; }
        public virtual ICollection<BonusValidityPeriod> BonusValidityPeriod { get; set; }
        public virtual ICollection<ContractBonus> ContractBonus { get; set; }
        public virtual ICollection<OfferBonus> OfferBonus { get; set; }
        public virtual ICollection<PayslipDetails> PayslipDetails { get; set; }
        public virtual ICollection<SessionBonus> SessionBonus { get; set; }
    }
}