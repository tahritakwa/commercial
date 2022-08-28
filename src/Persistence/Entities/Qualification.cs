﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Qualification
    {
        public int Id { get; set; }
        public string University { get; set; }
        public string QualificationDescritpion { get; set; }
        public int? GraduationYear { get; set; }
        public int? IdQualificationCountry { get; set; }
        public int? IdQualificationType { get; set; }
        public int? IdEmployee { get; set; }
        public string QualificationAttached { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int? IdCandidate { get; set; }

        public virtual Candidate IdCandidateNavigation { get; set; }
        public virtual Employee IdEmployeeNavigation { get; set; }
        public virtual Country IdQualificationCountryNavigation { get; set; }
        public virtual QualificationType IdQualificationTypeNavigation { get; set; }
    }
}