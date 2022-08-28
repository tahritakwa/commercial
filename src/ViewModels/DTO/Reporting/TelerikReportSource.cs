using Newtonsoft.Json;
using System;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class TelerikReportSource
    {
        [JsonProperty("parameterValues")]
        public dynamic Parameters { get; set; }
        [JsonProperty("report")]
        public string Report { get; set; }
    }
}
