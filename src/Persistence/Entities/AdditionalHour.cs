﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class AdditionalHour
    {
        public AdditionalHour()
        {
            AdditionalHourSlot = new HashSet<AdditionalHourSlot>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public bool Worked { get; set; }
        public double IncreasePercentage { get; set; }

        public virtual ICollection<AdditionalHourSlot> AdditionalHourSlot { get; set; }
    }
}