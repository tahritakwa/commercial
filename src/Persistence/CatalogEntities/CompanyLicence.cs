using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class CompanyLicence
    {
        public int Id { get; set; }
        public int IdMasterCompany { get; set; }
        public int NombreErpuser { get; set; }
        public int NombreB2buser { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime IntialDate { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }

        public virtual MasterCompany IdMasterCompanyNavigation { get; set; }
    }
}