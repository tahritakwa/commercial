using System;
using System.Collections.Generic;

namespace Utils.Utilities.ReportUtilities
{
    [Serializable]
    public partial class JasperReportingResourcesLookup
    {
        public List<ResourceLookup> ResourceLookup { get; set; }
    }

    [Serializable]
    public partial class ResourceLookup
    {
        public long Version { get; set; }
        public long PermissionMask { get; set; }
        public DateTimeOffset CreationDate { get; set; }
        public DateTimeOffset UpdateDate { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string Uri { get; set; }
        public string ResourceType { get; set; }
    }
}
