﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Nature
    {
        public Nature()
        {
            Item = new HashSet<Item>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public bool IsStockManaged { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public string UrlPicture { get; set; }

        public virtual ICollection<Item> Item { get; set; }
    }
}