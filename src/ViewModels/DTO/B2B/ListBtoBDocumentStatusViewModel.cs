using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.B2B
{
    public class ListBtoBDocumentStatusViewModel
    {
        public List<BtoBDocumentStatusViewModel> orders { get; set; }
        public string company_code { get; set; }
        public string username { get; set; }
    }
}
