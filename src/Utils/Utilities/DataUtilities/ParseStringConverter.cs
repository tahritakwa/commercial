using Newtonsoft.Json;
using System;

namespace Utils.Utilities.DataUtilities
{
    internal class ParseStringConverter : JsonConverter
    {
        public override bool CanConvert(Type t)
        {
            var canConvert = false;
            if (t == typeof(bool) || t == typeof(bool?))
            {
                canConvert = true;
            }
            if (t == typeof(long) || t == typeof(long?))
            {
                canConvert = true;
            }
            if (t == typeof(double) || t == typeof(double?))
            {
                canConvert = true;
            }
            return canConvert;
        }

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            bool b;
            long l;
            double d;
            string s;
            if (bool.TryParse(value, out b))
            {
                return b;
            }
            if (long.TryParse(value, out l))
            {
                return l;
            }
            if (double.TryParse(value, out d))
            {
                return d;
            }

            throw new Exception("Cannot unmarshal type " + t.Name);
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            if (untypedValue.GetType() == typeof(bool) || untypedValue.GetType() == typeof(bool?))
            {
                var value = (bool)untypedValue;
                var boolString = value ? "true" : "false";
                serializer.Serialize(writer, boolString);
            }
            if (untypedValue.GetType() == typeof(long))
            {
                var value = (long)untypedValue;
                serializer.Serialize(writer, value.ToString());
            }
            if (untypedValue.GetType() == typeof(double))
            {
                var value = (double)untypedValue;
                serializer.Serialize(writer, value.ToString());
            }
            return;
        }
        public static readonly ParseStringConverter Singleton = new ParseStringConverter();
    }


}
