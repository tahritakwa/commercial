﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class EvaluationCriteria
    {
        public EvaluationCriteria()
        {
            CriteriaMark = new HashSet<CriteriaMark>();
        }

        public int Id { get; set; }
        public string Label { get; set; }
        public int IdEvaluationCriteriaTheme { get; set; }
        public int? TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public string Description { get; set; }

        public virtual EvaluationCriteriaTheme IdEvaluationCriteriaThemeNavigation { get; set; }
        public virtual ICollection<CriteriaMark> CriteriaMark { get; set; }
    }
}