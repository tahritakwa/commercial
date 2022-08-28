using System;
using System.Collections.Generic;

namespace DataMapping.Models
{
    public partial class OemItem
    {
        public int Id { get; set; }
        public int IdItem { get; set; }
        public string OemNumber { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int? IdBrand { get; set; }

        public virtual VehicleBrand IdBrandNavigation { get; set; }
        public virtual Item IdItemNavigation { get; set; }
    }
}