﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class UserPrivilege
    {
        public int Id { get; set; }
        public int IdUser { get; set; }
        public int IdPrivilege { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public bool? SameLevelWithHierarchy { get; set; }
        public bool? SameLevelWithoutHierarchy { get; set; }
        public bool? SubLevel { get; set; }
        public bool? SuperiorLevelWithHierarchy { get; set; }
        public bool? SuperiorLevelWithoutHierarchy { get; set; }
        public bool? Management { get; set; }

        public virtual Privilege IdPrivilegeNavigation { get; set; }
        public virtual User IdUserNavigation { get; set; }
    }
}