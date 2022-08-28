using Microsoft.EntityFrameworkCore.ChangeTracking;
using System.Collections.Generic;

namespace Persistence.Audit
{
    public class AuditValues
    {
        public string ServiceName { get; set; }
        public string TableName { get; set; }
        public string RequestType { get; set; }
        public List<PropertyEntry> TemporaryProperties { get; set;  } = new List<PropertyEntry>();
        public Dictionary<string, object> KeyValues { get; } = new Dictionary<string, object>();
        public Dictionary<string, object> Values { get; } = new Dictionary<string, object>();
    }
}
