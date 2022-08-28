using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace ViewModels.DTO.ErpSettings
{
    public class RecaptchaResponseViewModel
    {
        [JsonProperty("success")]
        public bool Success { get; set; }

        [JsonProperty("error-codes")]
        public IEnumerable<string> ErrorCodes { get; set; }

        [JsonProperty("challenge_ts")]
        public DateTime ChallengeTs { get; set; }

        [JsonProperty("hostname")]
        public string Hostname { get; set; }
    }
}
