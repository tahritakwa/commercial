using Newtonsoft.Json;
using System.Net.Http;
using Utils.Enumerators;

namespace Utils.Utilities.DataUtilities
{
    /// <summary>
    /// Class ResponseData: will be used in the controller to define the format of return data
    /// </summary>
    public class ResponseData
    {
        /// <summary>
        /// flag
        /// </summary>
        public int flag { get; set; }
        /// <summary>
        /// The object of result data
        /// </summary>
        public dynamic objectData { get; set; }
        /// <summary>
        /// The list of result data
        /// </summary>
        public ListObject listObject { get; set; }
        /// <summary>
        /// The list of file data
        /// </summary>
        public byte[] dataFile { get; set; }

        public object Id { get; set; }
        /// <summary>
        /// A result messsage
        /// </summary>
        public HttpResponseMessage messsage { get; set; }
        public CustomStatusCode customStatusCode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }
}
