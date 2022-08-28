using System;
using System.Collections.Generic;

namespace Persistence.CatalogEntities
{
    public partial class OauthClientDetails
    {
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string ResourceIds { get; set; }
        public string Scope { get; set; }
        public string AuthorizedGrantTypes { get; set; }
        public string WebServerRedirectUri { get; set; }
        public string Authorities { get; set; }
        public int? AccessTokenValidity { get; set; }
        public int? RefreshTokenValidity { get; set; }
        public string AdditionalInformation { get; set; }
        public string Autoapprove { get; set; }
    }
}