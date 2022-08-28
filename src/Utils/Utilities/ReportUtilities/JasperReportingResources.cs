
using Newtonsoft.Json;
using System;
using Utils.Utilities.DataUtilities;

namespace Utils.Utilities.ReportUtilities
{
    /// <summary>
    /// Pour récupérer les informations d'un rapport
    /// </summary>
    public class JasperReportingResources
    {
        [JsonProperty("creationDate")]
        public DateTimeOffset CreationDate { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("label")]
        public string Label { get; set; }

        [JsonProperty("permissionMask")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long PermissionMask { get; set; }

        [JsonProperty("updateDate")]
        public DateTimeOffset UpdateDate { get; set; }

        [JsonProperty("uri")]
        public string Uri { get; set; }

        [JsonProperty("version")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long Version { get; set; }

        [JsonProperty("resourceType")]
        public string ResourceType { get; set; }
    }
}
