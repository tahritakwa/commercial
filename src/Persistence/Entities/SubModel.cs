﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class SubModel
    {
        public SubModel()
        {
            ItemVehicleBrandModelSubModel = new HashSet<ItemVehicleBrandModelSubModel>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public int IdModel { get; set; }
        public string DeletedToken { get; set; }
        public bool IsDeleted { get; set; }
        public string UrlPicture { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public virtual ModelOfItem IdModelNavigation { get; set; }
        public virtual ICollection<ItemVehicleBrandModelSubModel> ItemVehicleBrandModelSubModel { get; set; }
    }
}