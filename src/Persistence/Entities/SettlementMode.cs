﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class SettlementMode
    {
        public SettlementMode()
        {
            DetailsSettlementMode = new HashSet<DetailsSettlementMode>();
            Document = new HashSet<Document>();
            Project = new HashSet<Project>();
            Tiers = new HashSet<Tiers>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public virtual ICollection<DetailsSettlementMode> DetailsSettlementMode { get; set; }
        public virtual ICollection<Document> Document { get; set; }
        public virtual ICollection<Project> Project { get; set; }
        public virtual ICollection<Tiers> Tiers { get; set; }
    }
}