using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterUserCompany
    {
        public int Id { get; set; }
        public int IdMasterUser { get; set; }
        public int IdMasterCompany { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public bool? IsActif { get; set; }

        public virtual MasterCompany IdMasterCompanyNavigation { get; set; }
        public virtual MasterUser IdMasterUserNavigation { get; set; }
    }
}