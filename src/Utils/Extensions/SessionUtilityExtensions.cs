using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace Utils.Extensions
{
    public static class SessionUtilityExtensions
    {
        public static void SetObject(this ISession session, string key, object value)
        {
            SessionExtensions.SetString(session, key, JsonConvert.SerializeObject(value));
        }

        public static T GetObject<T>(this ISession session, string key)
        {
            var value = session.GetString(key);
            return value == null ? default : JsonConvert.DeserializeObject<T>(value);
        }
    }
}
