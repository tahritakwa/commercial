using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterModule
    {
        public MasterModule()
        {
            MasterSubModule = new HashSet<MasterSubModule>();
        }

        public int Id { get; set; }
        public string Code { get; set; }

        public virtual ICollection<MasterSubModule> MasterSubModule { get; set; }
    }
}