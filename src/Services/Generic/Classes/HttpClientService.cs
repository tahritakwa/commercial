using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity>
        where TModel : class where TEntity : class 
    {          
        /// <summary>
        ///Communicate with the Drupal and return the Drupal's response in ResponseData 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="apiRelativePath"></param>
        /// <param name="mediaType"></param>
        /// <param name="method"></param>
        /// <returns></returns>
        public async Task<object> DrupalConnection(object model, string apiRelativePath, string mediaType , HttpMethod method)
        {
            using (HttpClient httpClient = new HttpClient())
            {
                try
                {

                    httpClient.BaseAddress = _appSettings.DrupalUrl;
                    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(mediaType));
                    // Set Authorization of Drupal
                    string _auth = string.Format("{0}:{1}", "demo@spark-it.fr", "00000000");
                    string _enc = Convert.ToBase64String(Encoding.ASCII.GetBytes(_auth));
                    string _cred = string.Format("{0} {1}", "Basic", _enc);
                    httpClient.DefaultRequestHeaders.Add("Authorization", _cred);
                    httpClient.DefaultRequestHeaders.Add("Origin", _appSettings.BaseUrl.ToString());
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(apiRelativePath, UriKind.Relative),
                        Method = method,
                        Content = new StringContent(JsonConvert.SerializeObject(model), Encoding.UTF8, mediaType)
                    };
                    HttpResponseMessage response = await httpClient.SendAsync(httpRequestMessage).ConfigureAwait(continueOnCapturedContext: false);
                    object responseData = JsonConvert.DeserializeObject(response.Content.ReadAsStringAsync().Result);
                    return responseData;
                }
                catch
                {
                    return null;
                }
            }
        }
    }
}

