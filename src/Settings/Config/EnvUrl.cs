using System;

namespace Settings.Config
{
    public class EnvUrl
    {
        public EnvUrl()
        {

        }
        public EnvUrl(Uri BaseUrl, string checkPermissionJavaApi)
        {
            this.BaseUrl = BaseUrl;
            this.checkPermissionJavaApi = checkPermissionJavaApi;
        }
        public Uri BaseUrl { get; set; }
        public string checkPermissionJavaApi { get; set; }
    }
}
