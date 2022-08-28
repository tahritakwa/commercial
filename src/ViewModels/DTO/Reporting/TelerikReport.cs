using Newtonsoft.Json;
using System;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class TelerikReport
    {
        [JsonProperty("ReportName")]
        public string ReportName { get; set; }
        [JsonProperty("ReportConnectionString")]
        public string ReportConnectionString { get; set; }
        [JsonProperty("Url")]
        public string Url { get; set; }
        [JsonProperty("User")]
        public string User { get; set; }
    }
}
