
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using Utils.Utilities.DataUtilities;

namespace Utils.Utilities.ReportUtilities
{
    /// <summary>
    /// To send export and execution requests
    /// </summary>
    public partial class JasperReportingQuery
    {
        [JsonProperty("reportUnitUri")]
        public string ReportUnitUri { get; set; }

        [JsonProperty("async")]
        [JsonConverter(typeof(ParseStringConverter))]
        public bool Async { get; set; }

        [JsonProperty("freshData")]
        [JsonConverter(typeof(ParseStringConverter))]
        public bool FreshData { get; set; }

        [JsonProperty("saveDataSnapshot")]
        [JsonConverter(typeof(ParseStringConverter))]
        public bool SaveDataSnapshot { get; set; }

        [JsonProperty("outputFormat")]
        public string OutputFormat { get; set; }

        [JsonProperty("interactive")]
        [JsonConverter(typeof(ParseStringConverter))]
        public bool Interactive { get; set; }

        [JsonProperty("ignorePagination")]
        [JsonConverter(typeof(ParseStringConverter))]
        public bool IgnorePagination { get; set; }

        [JsonProperty("pages")]
        public string Pages { get; set; }

        [JsonProperty("parameters")]
        public Parameters Parameters { get; set; }
    }


    public partial class JasperReportingQuery
    {
        public static JasperReportingQuery FromJson(string json) => JsonConvert.DeserializeObject<JasperReportingQuery>(json, JasperConverter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this JasperReportingQuery self) => JsonConvert.SerializeObject(self, JasperConverter.Settings);
    }

    internal static class JasperConverter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters =
            {
                JasperValueConverter.Singleton,
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }

    internal class JasperParseStringConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(bool) || t == typeof(bool?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            bool b;
            if (Boolean.TryParse(value, out b))
            {
                return b;
            }
            throw new Exception("Cannot unmarshal type bool");
        }
        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (bool)untypedValue;
            var boolString = value ? "true" : "false";
            serializer.Serialize(writer, boolString);
            return;
        }
        public static readonly ParseStringConverter Singleton = new ParseStringConverter();
    }

    internal class JasperValueConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Value) || t == typeof(Value?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            switch (reader.TokenType)
            {
                case JsonToken.String:
                case JsonToken.Date:
                    var stringValue = serializer.Deserialize<string>(reader);
                    return new Value { String = stringValue };
                case JsonToken.StartArray:
                    var arrayValue = serializer.Deserialize<List<string>>(reader);
                    return new Value { StringArray = arrayValue };
            }
            throw new Exception("Cannot unmarshal type Value");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            var value = (Value)untypedValue;
            if (value.String != null)
            {
                serializer.Serialize(writer, value.String);
                return;
            }
            if (value.StringArray != null)
            {
                serializer.Serialize(writer, value.StringArray);
                return;
            }
            throw new Exception("Cannot marshal type Value");
        }

        public static readonly JasperValueConverter Singleton = new JasperValueConverter();
    }
}
