﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class AdditionalHourSlot
    {
        public int Id { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int IdAdditionalHour { get; set; }

        public virtual AdditionalHour IdAdditionalHourNavigation { get; set; }
    }
}