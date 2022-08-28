using System.Collections.Generic;

namespace Settings.Config
{
    public class CredentialsModel
    {
        public int IdUser { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public string Email { get; set; }
        public int? IdEmployee { get; set; }
        // For master
        public string LastConnectedCompany { get; set; }
        public string Language { get; set; }
        public string Message { get; set; }
        public int? IdTiers { get; set; }
        public int ActivityArea { get; set; }
    }
}
