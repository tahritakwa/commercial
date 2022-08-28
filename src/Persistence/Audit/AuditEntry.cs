using System.Collections.Generic;

namespace Persistence.Audit
{
    public class AuditEntry
    {
        public string UserName { get; set; }
        public string CodeCompany { get; set; }
        public IList<AuditValues> AuditValues { get; set; }
    }
}
