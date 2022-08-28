using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Settings.Config;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;

namespace Persistence
{
    public class ActiveAccountHelper
    {
        public static string GetConnectedUserEmail()
        {
            var credential = GetConnectedUserCredential();
            if (credential != null)
            {
                return GetConnectedUserCredential().Email;
            }
            else
            {
                return "";
            }

        }

        public static CredentialsModel GetConnectedUserCredential()
        {
            if (AppHttpContext.Current != null)
            {
                AppHttpContext.Current.Request.Headers.TryGetValue("Authorization", out StringValues userMailValue);
                string jwt = userMailValue.First().Replace("Bearer ", string.Empty);
                JwtSecurityToken token = new JwtSecurityToken(jwt);
                return JsonConvert.DeserializeObject<CredentialsModel>(token.Payload["user"].ToString());
            }
            return null;

        }
    }
}
