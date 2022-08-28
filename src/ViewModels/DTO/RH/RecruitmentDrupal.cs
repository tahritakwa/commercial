
using Newtonsoft.Json;
using System.Collections.Generic;

namespace ViewModels.DTO.RH
{
    public class RecruitmentDrupal
    {
        public RecruitmentDrupal()
        {
            Type = new Dictionary<string, string>[] { new Dictionary<string, string>() { { "target_id", "article" } } };
            Title = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Body = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Field_yearofexperience = new Dictionary<string, int?>[] { new Dictionary<string, int?>() };
            Field_office = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Field_contract = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Field_diploma_type = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Field_gender = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Uuid = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Field_image = new Dictionary<string, string>[] { new Dictionary<string, string>() };
            Field_skills = new HashSet<Dictionary<string, string>>();
            Field_languages = new HashSet<Dictionary<string, string>>();


        }
        [JsonProperty("type")]
        public IDictionary<string, string>[] Type { get; set; }

        [JsonProperty("title")]
        public IDictionary<string, string>[] Title { get; set; }

        [JsonProperty("body")]
        public IDictionary<string, string>[] Body { get; set; }

        [JsonProperty("field_yearofexperience")]
        public IDictionary<string, int?>[] Field_yearofexperience { get; set; }

        [JsonProperty("field_office")]
        public IDictionary<string, string>[] Field_office { get; set; }

        [JsonProperty("field_contract")]
        public IDictionary<string, string>[] Field_contract { get; set; }

        [JsonProperty("field_diploma_type")]
        public IDictionary<string, string>[] Field_diploma_type { get; set; }

        [JsonProperty("field_gender")]
        public IDictionary<string, string>[] Field_gender { get; set; }
        
        [JsonProperty("uuid")]
        public IDictionary<string, string>[] Uuid { get; set; }

        [JsonProperty("field_image")]
        public IDictionary<string, string>[] Field_image { get; set; }

        [JsonProperty("field_skills")]
        public ICollection<Dictionary<string, string>> Field_skills { get; set; }

        [JsonProperty("field_languages")]
        public ICollection<Dictionary<string, string>> Field_languages { get; set; }



    }
}
