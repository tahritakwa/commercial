using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.B2B
{
    public class ResponseTokenFromBtoBViewModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public string token_type { get; set; }
        public string access_token { get; set; }
        public string refresh_token { get; set; }
    }
}
