using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.RH
{
    public class RecruitmentPictureDrupalModel
    {
        public RecruitmentPictureDrupalModel()
        {
            Filename = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Uri = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Data = new Dictionary<string, byte[]>[] { new Dictionary<string, byte[]>() };
            Links = new Dictionary<string, Dictionary<string, string>>()
            {{ "type", new Dictionary<string, string>(){{"href", "http://localhost/drupal/rest/type/file/image"}}}};
            Type = new Dictionary<string, string>[] { new Dictionary<string, string>() { { "target_id", "image" } } };
        }
        [JsonProperty("_links")]
        public IDictionary<string, Dictionary<string, string>> Links { get; set; }
        [JsonProperty("type")]
        public IDictionary<string, string>[] Type { get; set; }
        [JsonProperty("filename")]
        public IDictionary<string, string>[] Filename { get; set; }
        [JsonProperty("uri")]
        public IDictionary<string, string>[] Uri { get; set; }
        [JsonProperty("data")]
        public IDictionary<string, byte[]>[] Data { get; set; }

    }
}
