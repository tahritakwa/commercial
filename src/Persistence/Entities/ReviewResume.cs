﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class ReviewResume
    {
        public int Id { get; set; }
        public int ResumeType { get; set; }
        public string Description { get; set; }
        public int IdReview { get; set; }
        public int? TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }

        public virtual Review IdReviewNavigation { get; set; }
    }
}