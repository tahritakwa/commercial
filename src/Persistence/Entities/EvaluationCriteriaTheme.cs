﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class EvaluationCriteriaTheme
    {
        public EvaluationCriteriaTheme()
        {
            EvaluationCriteria = new HashSet<EvaluationCriteria>();
        }

        public int Id { get; set; }
        public string Label { get; set; }
        public int? TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public string Description { get; set; }

        public virtual ICollection<EvaluationCriteria> EvaluationCriteria { get; set; }
    }
}