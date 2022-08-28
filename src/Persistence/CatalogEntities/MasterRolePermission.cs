using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterRolePermission
    {
        public int IdRole { get; set; }
        public int IdPermission { get; set; }
        public int Id { get; set; }
        public bool IsDeleted { get; set; }

        public virtual MasterPermission IdPermissionNavigation { get; set; }
        public virtual MasterRole IdRoleNavigation { get; set; }
    }
}