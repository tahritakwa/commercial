﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class TrainingRequiredSkills
    {
        public int Id { get; set; }
        public int IdTraining { get; set; }
        public int IdSkills { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public virtual Skills IdSkillsNavigation { get; set; }
        public virtual Training IdTrainingNavigation { get; set; }
    }
}