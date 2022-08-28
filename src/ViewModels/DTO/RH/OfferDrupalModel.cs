using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.RH
{
    public class OfferDrupalModel
    {
        public OfferDrupalModel()
        {
            Attributes = new Dictionary<string, Dictionary<string, bool>>()
            {{ "status", new Dictionary<string, bool>(){{ "value", false}}}};
            Type = "node--article";
        }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("attributes")]
        public IDictionary<string, Dictionary<string, bool>> Attributes { get; set; }


    }

}
