using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterRole
    {
        public MasterRole()
        {
            MasterRolePermission = new HashSet<MasterRolePermission>();
            MasterRoleUser = new HashSet<MasterRoleUser>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Label { get; set; }
        public int? IdCompany { get; set; }

        public virtual MasterCompany IdCompanyNavigation { get; set; }
        public virtual ICollection<MasterRolePermission> MasterRolePermission { get; set; }
        public virtual ICollection<MasterRoleUser> MasterRoleUser { get; set; }
    }
}