using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterSubModule
    {
        public MasterSubModule()
        {
            MasterPermission = new HashSet<MasterPermission>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public int? IdModule { get; set; }

        public virtual MasterModule IdModuleNavigation { get; set; }
        public virtual ICollection<MasterPermission> MasterPermission { get; set; }
    }
}