using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterPermission
    {
        public MasterPermission()
        {
            MasterRolePermission = new HashSet<MasterRolePermission>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public int? IdSubModule { get; set; }

        public virtual MasterSubModule IdSubModuleNavigation { get; set; }
        public virtual ICollection<MasterRolePermission> MasterRolePermission { get; set; }
    }
}