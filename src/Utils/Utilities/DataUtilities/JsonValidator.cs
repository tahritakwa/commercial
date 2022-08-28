using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;

namespace Utils.Utilities.DataUtilities
{
    public static class JsonParser
    {
        /// <summary>
        /// Check If the json passed in param is valid 
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool ValidateJSON(string s)
        {
            try
            {
                JToken.Parse(s);
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// Get the parameters by deserializing string in arg
        /// </summary>
        /// <param name="jsonParameters"></param>
        /// <returns></returns>
        public static IDictionary<string, dynamic> GetParameters(string jsonParameters)
        {
            IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>();

            try
            {
                parameters = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(jsonParameters);
            }
            catch
            {
                // stringOfItemId is not a valid int to convert it
                throw new ArgumentOutOfRangeException("jsonParameters (" + jsonParameters + ") is not a valid json parameters");
            }

            return parameters;
        }
    }

}
