﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class BankAgency
    {
        public BankAgency()
        {
            Contact = new HashSet<Contact>();
        }

        public int Id { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public string Label { get; set; }
        public int? IdBank { get; set; }

        public virtual Bank IdBankNavigation { get; set; }
        public virtual ICollection<Contact> Contact { get; set; }
    }
}