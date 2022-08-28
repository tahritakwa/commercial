﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Active
    {
        public Active()
        {
            History = new HashSet<History>();
        }

        public int Id { get; set; }
        public string Label { get; set; }
        public int? DepreciationPeriod { get; set; }
        public DateTime? AcquisationDate { get; set; }
        public DateTime? ServiceDate { get; set; }
        public int? Status { get; set; }
        public int? IdDocumentLine { get; set; }
        public double? Value { get; set; }
        public int? IdCategory { get; set; }
        public string Code { get; set; }
        public string DeletedToken { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string NumSerie { get; set; }
        public string Description { get; set; }
        public int? IdWarehouse { get; set; }
        public string Ipaddress { get; set; }
        public string Macaddress { get; set; }
        public string HostName { get; set; }
        public string PhoneNumber { get; set; }

        public virtual Category IdCategoryNavigation { get; set; }
        public virtual DocumentLine IdDocumentLineNavigation { get; set; }
        public virtual Warehouse IdWarehouseNavigation { get; set; }
        public virtual ICollection<History> History { get; set; }
    }
}