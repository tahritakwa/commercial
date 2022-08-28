using System.Net;
using System.Net.Http;


namespace Utils.Utilities.DataUtilities
{
    public static class ResponseJson
    {
        public static HttpResponseMessage Success => new HttpResponseMessage(HttpStatusCode.Accepted);

        public static HttpResponseMessage Failed => new HttpResponseMessage(HttpStatusCode.Forbidden);

        public static HttpResponseMessage BadRequest => new HttpResponseMessage(HttpStatusCode.BadRequest);
    }
}
