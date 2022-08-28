using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterCompany
    {
        public MasterCompany()
        {
            CompanyLicence = new HashSet<CompanyLicence>();
            MasterRole = new HashSet<MasterRole>();
            MasterRoleUser = new HashSet<MasterRoleUser>();
            MasterUserCompany = new HashSet<MasterUserCompany>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public string DataBaseName { get; set; }
        public int? IdMasterDbSettings { get; set; }
        public string GarageDataBaseName { get; set; }
        public string DefaultLanguage { get; set; }

        public virtual MasterDbSettings IdMasterDbSettingsNavigation { get; set; }
        public virtual ICollection<CompanyLicence> CompanyLicence { get; set; }
        public virtual ICollection<MasterRole> MasterRole { get; set; }
        public virtual ICollection<MasterRoleUser> MasterRoleUser { get; set; }
        public virtual ICollection<MasterUserCompany> MasterUserCompany { get; set; }
    }
}