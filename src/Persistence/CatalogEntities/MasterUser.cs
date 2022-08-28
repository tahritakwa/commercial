using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class MasterUser
    {
        public MasterUser()
        {
            MasterRoleUser = new HashSet<MasterRoleUser>();
            MasterUserCompany = new HashSet<MasterUserCompany>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public string LastConnectedCompany { get; set; }
        public bool IsDeleted { get; set; }
        public int? TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public bool IsBtoB { get; set; }
        public bool? AccountNonExpired { get; set; }
        public bool? AccountNonLocked { get; set; }
        public bool? Enabled { get; set; }
        public bool? CredentialsNonExpired { get; set; }
        public string Language { get; set; }

        public virtual ICollection<MasterRoleUser> MasterRoleUser { get; set; }
        public virtual ICollection<MasterUserCompany> MasterUserCompany { get; set; }
    }
}