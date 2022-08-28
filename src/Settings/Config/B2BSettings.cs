namespace Settings.Config
{
    public class B2BSettings
    {
        public string EncryptionKey { get; set; }
        public string JWTAuthenticationValidIssuer { get; set; }
        public string JWTAuthenticationValidAudience { get; set; }
    }
}
