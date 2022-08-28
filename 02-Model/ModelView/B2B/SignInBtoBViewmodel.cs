using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.B2B
{
    public class SignInBtoBViewmodel
    {
        public int client_id { get; set; }
        public string client_secret { get; set; }
        public string grant_type { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string company_code { get; set; }
    }
}
