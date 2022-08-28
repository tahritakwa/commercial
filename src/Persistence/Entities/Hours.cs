﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Hours
    {
        public int Id { get; set; }
        public string Label { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public int IdPeriod { get; set; }
        public bool WorkTimeTable { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public virtual Period IdPeriodNavigation { get; set; }
    }
}