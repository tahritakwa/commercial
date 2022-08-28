using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterDbSettings
    {
        public MasterDbSettings()
        {
            MasterCompany = new HashSet<MasterCompany>();
        }

        public int Id { get; set; }
        public string Server { get; set; }
        public string UserId { get; set; }
        public string UserPassword { get; set; }

        public virtual ICollection<MasterCompany> MasterCompany { get; set; }
    }
}