﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class TiersPrices
    {
        public int Id { get; set; }
        public int IdTiers { get; set; }
        public int IdPrices { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public virtual Prices IdPricesNavigation { get; set; }
        public virtual Tiers IdTiersNavigation { get; set; }
    }
}