using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.Administration
{
    public class ReducedCurrencyAndActivityAreaViewModel
    {
        public int IdCurrency { get; set; }
        public string CurrencyCode { get; set; }
        public string CurrencySymbole { get; set; }
        public string CurrencyDescription { get; set; }
        public int CurrencyPrecision { get; set; }
        public int ActivityArea { get; set; }
    }


}
