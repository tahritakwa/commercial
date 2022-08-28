namespace Web.TokenProvider
{
    public class Oauth2
    {
        public string ApiName { get; set; } // define api name
        public string ClientId { get; set; }//define the client id
        public string ClientSecrets { get; set; } //define the client secret name
        public string Key { get; set; } //token name file
        public string TokenType { get; set; }//token type
        public string AccessDeniedPath { get; set; } //Access denied path
        public string LoginPath { get; set; } //unauthorize path
        public string ServerUrl { get; set; } //Authorization server url


    }
}
