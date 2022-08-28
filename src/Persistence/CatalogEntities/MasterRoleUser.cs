using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterRoleUser
    {
        public int IdMasterUser { get; set; }
        public int IdRole { get; set; }
        public int Id { get; set; }
        public bool IsDeleted { get; set; }
        public int? IdMasterCompany { get; set; }

        public virtual MasterCompany IdMasterCompanyNavigation { get; set; }
        public virtual MasterUser IdMasterUserNavigation { get; set; }
        public virtual MasterRole IdRoleNavigation { get; set; }
    }
}