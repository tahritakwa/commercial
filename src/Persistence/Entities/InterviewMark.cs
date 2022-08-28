﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class InterviewMark
    {
        public InterviewMark()
        {
            CriteriaMark = new HashSet<CriteriaMark>();
        }

        public int Id { get; set; }
        public double? Mark { get; set; }
        public bool IsRequired { get; set; }
        public int Status { get; set; }
        public int IdEmployee { get; set; }
        public int IdInterview { get; set; }
        public int? TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public int? InterviewerDecision { get; set; }
        public string StrongPoints { get; set; }
        public string Weaknesses { get; set; }
        public string OtherInformations { get; set; }

        public virtual Employee IdEmployeeNavigation { get; set; }
        public virtual Interview IdInterviewNavigation { get; set; }
        public virtual ICollection<CriteriaMark> CriteriaMark { get; set; }
    }
}